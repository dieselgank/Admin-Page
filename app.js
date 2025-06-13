require("dotenv").config();
const express = require("express");
const mysql = require("mysql2/promise");
const bodyParser = require("body-parser");

const app = express();
const port = 3000;

// Setup Middleware
app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({ extended: true }));

// Konfigurasi koneksi database
const dbConfig = {
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
};

const pool = mysql.createPool(dbConfig);

// Rute utama (GET /): Menampilkan halaman admin
app.get("/", async (req, res) => {
  try {
    const [produk] = await pool.query(
      "SELECT p.id, p.nama_produk, s.jumlah_stock FROM Produk p JOIN Stock_Produk s ON p.id = s.produk_id ORDER BY p.nama_produk"
    );
    const [pembelian] = await pool.query(`
            SELECT pem.id, pro.nama_produk, pem.jumlah, pem.total_harga, pem.status, DATE_FORMAT(pem.tanggal_pembelian, '%d-%m-%Y %H:%i') as tanggal
            FROM Pembelian pem
            JOIN Produk pro ON pem.produk_id = pro.id
            ORDER BY pem.tanggal_pembelian DESC
        `);
    res.render("admin", { produk, pembelian });
  } catch (error) {
    console.error(error);
    res.status(500).send("Terjadi kesalahan pada server");
  }
});

// Rute untuk menambah pembelian (POST /pembelian)
app.post("/pembelian", async (req, res) => {
  const { produk_id, jumlah } = req.body;
  const conn = await pool.getConnection();

  try {
    await conn.beginTransaction();

    // 1. Dapatkan harga produk dan stok saat ini
    const [produk] = await conn.query(
      "SELECT harga, jumlah_stock FROM Produk JOIN Stock_Produk ON Produk.id = Stock_Produk.produk_id WHERE Produk.id = ? FOR UPDATE",
      [produk_id]
    );

    if (produk.length === 0) throw new Error("Produk tidak ditemukan");

    const { harga, jumlah_stock } = produk[0];
    const jumlahBeli = parseInt(jumlah, 10);

    if (jumlah_stock < jumlahBeli) throw new Error("Stok tidak mencukupi");

    // 2. Kurangi stok
    const stokBaru = jumlah_stock - jumlahBeli;
    await conn.query(
      "UPDATE Stock_Produk SET jumlah_stock = ? WHERE produk_id = ?",
      [stokBaru, produk_id]
    );

    // 3. Masukkan ke tabel pembelian
    const totalHarga = harga * jumlahBeli;
    await conn.query(
      "INSERT INTO Pembelian (produk_id, jumlah, total_harga) VALUES (?, ?, ?)",
      [produk_id, jumlahBeli, totalHarga]
    );

    await conn.commit();
    res.redirect("/");
  } catch (error) {
    await conn.rollback();
    console.error(error);
    res.status(500).send(error.message || "Gagal memproses pembelian");
  } finally {
    conn.release();
  }
});

// Rute untuk membatalkan pembelian (POST /pembelian/cancel/:id)
app.post("/pembelian/cancel/:id", async (req, res) => {
  const { id } = req.params;
  const conn = await pool.getConnection();

  try {
    await conn.beginTransaction();

    // 1. Dapatkan data pembelian yang akan dibatalkan
    const [pembelian] = await conn.query(
      'SELECT * FROM Pembelian WHERE id = ? AND status = "BERHASIL" FOR UPDATE',
      [id]
    );

    if (pembelian.length === 0)
      throw new Error("Pembelian tidak ditemukan atau sudah dibatalkan");

    const { produk_id, jumlah } = pembelian[0];

    // 2. Update status pembelian menjadi 'DIBATALKAN'
    await conn.query(
      'UPDATE Pembelian SET status = "DIBATALKAN" WHERE id = ?',
      [id]
    );

    // 3. Kembalikan jumlah stok
    await conn.query(
      "UPDATE Stock_Produk SET jumlah_stock = jumlah_stock + ? WHERE produk_id = ?",
      [jumlah, produk_id]
    );

    await conn.commit();
    res.redirect("/");
  } catch (error) {
    await conn.rollback();
    console.error(error);
    res.status(500).send(error.message || "Gagal membatalkan pembelian");
  } finally {
    conn.release();
  }
});

app.listen(port, () => {
  console.log(`Server admin berjalan di http://localhost:${port}`);
});
