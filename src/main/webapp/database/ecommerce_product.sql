-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `sub_category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_category_id` (`sub_category_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (91,'Áo thun nam tay ngắn đắp vải trang trí. Regular','',1),(93,'Áo thun nam tay ngắn hình thêu. Regular','',1),(94,'Áo thun nam ngắn tay S Cafe có thêu. Fitted','',1),(95,'Áo thun tay ngắn nam.Relax','',1),(96,'Áo thun nam tay ngắn hình in. Regular','',1),(97,' Áo thun tay ngắn nam có thêu. Regular','',1),(98,' Áo thun tay ngắn có in. Loose','',1),(99,'Áo thun nam tay ngắn. Fitted','',1),(100,'Áo thun tay ngắn nam có in. Loose','',1),(101,'Áo thun nam ngắn tay S Cafe thêu. Loose','',1),(102,' Áo thun nam carbon. FITTED','',1),(103,' Áo Thun Nam Carbon Dập Nổi . FITTED','',1),(104,' Áo thun nam carbon. FITTED','',1),(105,' Áo thun tay ngắn nhãn trang trí. LOOSE','',1),(106,'Áo polo nam. Fitted','',2),(107,'Áo polo nam trang trí cổ premium. Fitted','',2),(108,' Áo Polo tay raglan phối màu. FITTED','',2),(109,' Áo polo phối bo sườn. Fitted','',2),(110,'Áo polo sọc ngang nhãn trang trí. Boxy','',2),(111,' Áo polo phối cổ tay.Loose','',2),(112,' Áo Polo nam phối sọc. FITTED','',2),(113,'Áo polo active .Regular','',2),(114,' Áo sơ mi tay dài nam. Fitted','',3),(115,'Áo sơ mi nam dài tay flannel. Oversize','',3),(116,'Áo sơ mi dài tay nam Flannel thêu. Loose','',3),(117,' Áo sơ mi dài tay nam Flannel túi đắp. Regular','',3),(118,' Áo sơ mi tay ngắn in. Regular','',3),(119,'Áo sơ mi tay ngắn oxford. Fitted','',3),(120,' Áo sơ mi sọc ngắn tay. Fitted','',3),(121,' Áo sơ mi denim nam. Loose','',3),(122,' Áo sơ mi jean sọc. Oversize','',3),(123,' Áo sơ mi nam denim. Regular','',3),(124,'Áo sơ mi nam ngắn tay. Loose','',3),(125,'Áo sơ mi tay ngắn có túi. Loose','',3),(126,' Áo sơ mi jean unisex. Loose','',3),(127,' Áo sơ mi nam ngắn tay. Oversize','',3),(128,'Áo sơ mi jean tay ngắn nam. Loose','',3),(129,' Quần jeans nam. Slim','',5),(130,' Quần jeans nam. Straight','',5),(131,' Quần denim nam. Wide leg','',5),(132,' Quần jean nam diễu thân .Straight','',5),(133,' Quần jean nam trơn.Slim','',5),(134,' Quần Jeans nam.Slim cropped','',5),(135,'Quần denim lưng liền. Cocoon','',5),(136,'Quần denim nam. Straight cropped','',5),(137,'Quần jean trơn.Straight crop','',5),(138,' Quần Jean nam vải twill.Slim','',5),(139,' Quần jean nam garment dye. Straight cropped','',5),(140,' Quần jeans nam dài. Flared','',5),(141,'Quần jeans nam trơn. Slimfit','',5),(142,' Quần dài khaki. Wide leg','',6),(143,' Quần khaki nam dài. Slim cropped','',6),(144,' Quần khaki dài. slim cropped','',6),(145,' Quần khaki nam dài. Slim','',6),(146,' Quần cargo nam. Wide leg','',6),(147,' Quần kaki nam. Wide leg','',6),(148,' Quần dài kaki. Slim crop','',6),(149,' Quần dài khaki. Straight crop','',6),(150,'Quần khaki dài gập ly. Slimcrop','',6),(151,' Quần dài chinos. Slim crop','',6),(152,'Quần dài khaki lưng thun. Relax','',6),(153,' Quần dài khaki thun lai. Slim crop','',6),(154,' Quần tây dài straight lưng thun. Straight','',8),(155,' Quần dài khaki. Wide leg','',8),(156,' Quần tây dài nam. Slim cropped','',8),(157,' Quần tây dài. Slim','',8),(158,' Quần tây nam dài. Slim cropped','',8),(159,' Quần tây nam dài. Slim','',8),(160,' Quần tây. Slim','',8),(161,' Quần dài vải phối chỉ. Slim','',8),(162,' Quần dài vải lưng thun điều chỉnh. Slim','',8),(163,' Quần dài vải lưng thun. Slim crop','',8),(164,' Quần dài vải gập ly. Slim','',8),(165,' Quần short jeans nam. Relax','',7),(166,' Quần short nam ống rộng. Loose','',7),(167,' Quần short jeans nam. Straight','',7),(168,' Quần short jeans nam. Straight','',7),(169,' Quần short nam. Relax','',7),(170,' Quần bơi nam họa tiết. Straight','',7),(171,' Quần short lưng chun. Relax','',7),(172,' Quần bơi in phối dây rút. Regular','',7),(173,' Quần short nỉ nam. Loose','',7),(174,' Quần shorts sọc dọc. Relax','',7),(175,' Quần shorts nỉ nhãn trang trí. Relax','',7),(176,' Quần short denim nam. Straight','',7);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-11 20:38:58
