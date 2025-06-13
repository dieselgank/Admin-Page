# Sistem Admin Page Input Data Pembelian

Sistem admin page sederhana yang dibuat dengan Node.js dan Express.js untuk manajemen data pembelian, produk, dan stok. Aplikasi ini memungkinkan admin toko untuk menginput transaksi pembelian dan membatalkan pembelian jika diperlukan.

## ✨ Fitur Utama

* **Manajemen Pembelian:** Input data pembelian baru dan batalkan transaksi yang ada.
* **Tampilan Sederhana:** Antarmuka yang mudah digunakan dengan EJS.

---

## Database

Sistem ini menggunakan database SQL untuk menyimpan data. Berikut adalah struktur tabel yang digunakan:

### 📊 **Tabel `Pembelian`**

Mencatat semua transaksi pembelian yang dilakukan.

| Field             | Type                          | Null | Key | Default           | Extra             |
|-------------------|-------------------------------|------|-----|-------------------|-------------------|
| id                | int                           | NO   | PRI | NULL              | auto_increment    |
| produk_id         | int                           | NO   | MUL | NULL              |                   |
| jumlah            | int                           | NO   |     | NULL              |                   |
| total_harga       | decimal(10,2)                 | NO   |     | NULL              |                   |
| status            | enum('BERHASIL','DIBATALKAN') | NO   |     | BERHASIL          |                   |
| tanggal_pembelian | timestamp                     | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |

### 📦 **Produk**

Menyimpan informasi detail mengenai produk yang dijual.

| Field       | Type          | Null | Key | Default           | Extra             |
|-------------|---------------|------|-----|-------------------|-------------------|
| id          | int           | NO   | PRI | NULL              | auto_increment    |
| nama_produk | varchar(255)  | NO   |     | NULL              |                   |
| harga       | decimal(10,2) | NO   |     | NULL              |                   |
| created_at  | timestamp     | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |

### 🛒 **Stock_Produk**

Mencatat jumlah stok yang tersedia untuk setiap produk.

| Field        | Type      | Null | Key | Default           | Extra                                         |
|--------------|-----------|------|-----|-------------------|-----------------------------------------------|
| id           | int       | NO   | PRI | NULL              | auto_increment                                |
| produk_id    | int       | NO   | UNI | NULL              |                                               |
| jumlah_stock | int       | NO   |     | 0                 |                                               |
| last_updated | timestamp | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |

---

## 🚀 Teknologi yang Digunakan

* **Backend:** Node.js, Express.js
* **View Engine:** EJS (Embedded JavaScript templates)
* **Database:** SQL (MySQL) 

---

## ⚙️ Instalasi & Konfigurasi

1.  **Clone repository ini:**
    ```bash
    git clone https://github.com/dieselgank/Admin-Page.git
    cd Admin-Page
    ```

2.  **Install dependencies:**
    ```bash
    npm install
    ```

3.  **Setup Database:**
    * Buat database baru di sistem SQL anda atau copy dari folder database di repository ini.
    * Import file `.sql` yang berisi struktur tabel dan data awal (jika ada).
    * Konfigurasi koneksi database di dalam file `.env`.

4.  **Jalankan aplikasi:**
    ```bash
    node app.js
    ```
    Aplikasi akan berjalan di `http://localhost:3000` (atau port lain yang Anda tentukan).

---

## 🖥️ Tampilan Aplikasi
![image](https://github.com/user-attachments/assets/4374bac7-5076-4d81-9369-51714ac0443e)
