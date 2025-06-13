-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: toko_db
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Pembelian`
--

DROP TABLE IF EXISTS `Pembelian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pembelian` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produk_id` int NOT NULL,
  `jumlah` int NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `status` enum('BERHASIL','DIBATALKAN') NOT NULL DEFAULT 'BERHASIL',
  `tanggal_pembelian` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `produk_id` (`produk_id`),
  CONSTRAINT `Pembelian_ibfk_1` FOREIGN KEY (`produk_id`) REFERENCES `Produk` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pembelian`
--

LOCK TABLES `Pembelian` WRITE;
/*!40000 ALTER TABLE `Pembelian` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pembelian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Produk`
--

DROP TABLE IF EXISTS `Produk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Produk` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_produk` varchar(255) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Produk`
--

LOCK TABLES `Produk` WRITE;
/*!40000 ALTER TABLE `Produk` DISABLE KEYS */;
INSERT INTO `Produk` VALUES (1,'Buku Tulis Sinar Dunia',5000.00,'2025-06-13 18:46:13'),(2,'Pulpen Pilot G2',25000.00,'2025-06-13 18:46:13'),(3,'Pensil 2B Faber-Castell',4000.00,'2025-06-13 18:46:13'),(4,'Penghapus Staedtler',3000.00,'2025-06-13 18:46:13'),(5,'Spidol Snowman Board Marker',8000.00,'2025-06-13 18:46:13'),(6,'Stabilo Boss Original',12000.00,'2025-06-13 18:46:13'),(7,'Lem Kertas UHU',7000.00,'2025-06-13 18:46:13'),(8,'Gunting Joyko',15000.00,'2025-06-13 18:46:13'),(9,'Stapler Kenko',20000.00,'2025-06-13 18:46:13'),(10,'Kertas HVS A4 80gr Rim',55000.00,'2025-06-13 18:46:13');
/*!40000 ALTER TABLE `Produk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stock_Produk`
--

DROP TABLE IF EXISTS `Stock_Produk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stock_Produk` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produk_id` int NOT NULL,
  `jumlah_stock` int NOT NULL DEFAULT '0',
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `produk_id` (`produk_id`),
  CONSTRAINT `Stock_Produk_ibfk_1` FOREIGN KEY (`produk_id`) REFERENCES `Produk` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stock_Produk`
--

LOCK TABLES `Stock_Produk` WRITE;
/*!40000 ALTER TABLE `Stock_Produk` DISABLE KEYS */;
INSERT INTO `Stock_Produk` VALUES (1,1,100,'2025-06-13 19:27:29'),(2,2,50,'2025-06-13 18:46:20'),(3,3,200,'2025-06-13 18:46:20'),(4,4,150,'2025-06-13 19:26:55'),(5,5,80,'2025-06-13 18:46:20'),(6,6,60,'2025-06-13 18:46:20'),(7,7,88,'2025-06-13 19:04:00'),(8,8,40,'2025-06-13 19:00:38'),(9,9,30,'2025-06-13 18:46:20'),(10,10,20,'2025-06-13 18:46:20');
/*!40000 ALTER TABLE `Stock_Produk` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-14  2:29:03
