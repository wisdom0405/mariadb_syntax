-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'wisdom','wisdom@naver.com',NULL,'seoug-su',15,NULL,'user',NULL,NULL,0),
(2,'wisdom2','wisdom2@naver.com','1234','seoul',30,NULL,'user',NULL,NULL,0),
(3,'wisdom33','wisdom33@naver.com','1234','busan',25,NULL,'user',NULL,NULL,0),
(4,'wisdom4','wisdom4@naver.com','1234','daegu',62,NULL,'user',NULL,NULL,0),
(5,NULL,'wisdom5@naver.com',NULL,NULL,40,NULL,'user',NULL,NULL,0),
(6,NULL,'hello@naver.com',NULL,NULL,24,NULL,'user',NULL,NULL,0),
(7,NULL,'morucar@naver.com',NULL,NULL,26,NULL,'user',NULL,NULL,0),
(8,NULL,'hamster@naver.com',NULL,NULL,54,NULL,'user',NULL,NULL,0),
(9,NULL,'hello@abc.com',NULL,NULL,18,NULL,'user','1999-04-05',NULL,0),
(10,NULL,'hi',NULL,NULL,23,NULL,'user',NULL,'1999-01-01 12:11:11',0),
(11,NULL,'hii@avc.com',NULL,NULL,27,NULL,'user',NULL,'2024-05-17 12:35:57',0),
(12,NULL,'hihi@avc.com',NULL,NULL,31,NULL,'admin',NULL,'2024-05-17 16:15:55',0),
(13,'kim','kim@naver.com',NULL,NULL,38,NULL,'user',NULL,'2024-05-20 15:38:52',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'super-hamster','about super-hamsters',NULL,NULL,'56592935-141f-11ef-bec8-84144d91111b',1000),
(3,'super-hamster3','about super-hamsters3',3,NULL,'56592a0c-141f-11ef-bec8-84144d91111b',2000),
(4,'super-hamster4','about super-hamsters4',4,NULL,'56592ab0-141f-11ef-bec8-84144d91111b',3000),
(5,'hi',NULL,NULL,'1999-01-01 12:11:11','56592afe-141f-11ef-bec8-84144d91111b',1500),
(6,'hi',NULL,NULL,'1999-01-01 12:11:11','56592b4a-141f-11ef-bec8-84144d91111b',6500),
(7,'hii',NULL,NULL,'2024-05-17 12:36:49','56592b7c-141f-11ef-bec8-84144d91111b',5700),
(8,'abc',NULL,NULL,'2024-05-17 16:30:32','5a65364b-141f-11ef-bec8-84144d91111b',1600),
(9,'hello world java',NULL,5,'2024-05-20 12:35:39','09e2f5c7-165a-11ef-bec8-84144d91111b',2500),
(10,'hello world java',NULL,5,'2024-05-20 12:35:40','0ab06d5b-165a-11ef-bec8-84144d91111b',5600),
(13,'ERAWE','2231',2,'2024-05-20 14:12:44','99f9a953-1667-11ef-bec8-84144d91111b',8000);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 17:19:13
