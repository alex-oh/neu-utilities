CREATE DATABASE  IF NOT EXISTS `utilities` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `utilities`;
-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (x86_64)
--
-- Host: localhost    Database: utilities
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `building_id` int NOT NULL AUTO_INCREMENT,
  `building_name` varchar(64) DEFAULT NULL,
  `max_occupancy` int DEFAULT NULL,
  `hours_open` int DEFAULT NULL,
  `campus_id` int DEFAULT NULL,
  `total_water` int DEFAULT '0',
  `total_heat` int DEFAULT '0',
  `total_elec` int DEFAULT '0',
  PRIMARY KEY (`building_id`),
  KEY `campus_id` (`campus_id`),
  CONSTRAINT `building_ibfk_1` FOREIGN KEY (`campus_id`) REFERENCES `campus` (`campus_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (1,'Building A',100,12,1,2800,2700,4290),(2,'Building B',150,10,1,2430,2330,3980),(3,'Building C',200,14,2,2430,2400,3940),(4,'Building D',100,12,3,2430,2470,3860),(5,'Building E',150,10,4,0,0,0),(6,'Building F',200,14,4,0,0,0),(7,'Building G',120,12,1,0,0,0),(8,'Building H',180,10,2,0,0,0),(9,'Building I',220,14,3,0,0,0),(10,'Building J',110,12,4,0,0,0),(11,'Building K',160,10,1,0,0,0),(12,'Building L',230,14,2,0,0,0),(13,'Building M',130,12,3,0,0,0),(14,'Building N',170,10,4,0,0,0),(15,'Building O',240,14,1,0,0,0),(16,'Building P',140,12,2,0,0,0),(17,'Building Q',190,10,3,0,0,0),(18,'Building R',250,14,4,0,0,0),(19,'Building S',150,12,1,0,0,0),(20,'Building T',200,10,2,0,0,0);
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `campus_id` int NOT NULL,
  `campus_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`campus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
INSERT INTO `campus` VALUES (1,'Northeastern'),(2,'Vancouver'),(3,'Oakland'),(4,'Portland');
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dept_id` int NOT NULL,
  `dept_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `has_space`
--

DROP TABLE IF EXISTS `has_space`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has_space` (
  `dept_id` int NOT NULL,
  `building_id` int NOT NULL,
  PRIMARY KEY (`dept_id`,`building_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `has_space_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `has_space_ibfk_2` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `has_space`
--

LOCK TABLES `has_space` WRITE;
/*!40000 ALTER TABLE `has_space` DISABLE KEYS */;
/*!40000 ALTER TABLE `has_space` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `invoice_id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `payment_status` tinyint(1) DEFAULT NULL,
  `total_electricity_usage` int DEFAULT NULL,
  `total_water_usage` int DEFAULT NULL,
  `total_heat_usage` int DEFAULT NULL,
  `bill_amount` float DEFAULT NULL,
  `building_id` int DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,'2023-01-01',1,500,300,200,150.5,1),(2,'2023-02-05',0,450,280,210,145.2,2),(3,'2023-03-10',1,480,320,220,155.75,3),(4,'2023-04-15',1,520,290,230,160.8,4),(5,'2023-11-18',0,470,330,300,195.65,1),(6,'2023-12-23',1,560,350,310,200.7,2),(7,'2024-01-28',1,570,320,320,205.75,3),(8,'2024-02-02',0,480,340,330,210.8,4),(9,'2024-09-06',1,620,390,400,245.15,1),(10,'2024-10-11',1,630,360,410,250.2,2),(11,'2024-11-16',0,510,380,420,255.25,3),(12,'2024-12-21',1,640,400,430,260.3,4),(13,'2025-05-15',0,530,410,480,285.55,1),(14,'2025-06-20',1,680,430,490,290.6,2),(15,'2023-07-30',1,530,300,260,175.45,3),(16,'2023-08-03',0,460,320,270,180.5,4),(17,'2023-09-08',1,540,340,280,185.55,1),(18,'2023-10-13',1,550,310,290,190.6,2),(19,'2024-03-07',1,580,360,340,215.85,3),(20,'2024-04-12',1,590,330,350,220.9,4),(21,'2024-05-17',0,490,350,360,225.95,1),(22,'2024-06-22',1,600,370,370,230,2),(23,'2024-07-27',1,610,340,380,235.05,3),(24,'2024-08-01',0,500,370,390,240.1,4),(25,'2025-01-26',1,650,370,440,265.35,1),(26,'2025-03-05',1,660,410,460,275.45,3),(27,'2025-04-10',1,670,380,470,280.5,4),(28,'2023-05-20',0,490,310,240,165.25,1),(29,'2023-06-25',1,510,330,250,170.3,2);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updateBuildingUtilities` AFTER INSERT ON `invoice` FOR EACH ROW BEGIN

    DECLARE building_id_var INT;
    
    -- get the building id for the invoice to be added
    SELECT building_id INTO building_id_var
    FROM invoice
    WHERE invoice_id = NEW.invoice_id;
    
    -- update total water, electricity, and heating values for the building
    UPDATE building
    
    SET total_water = total_water + NEW.total_water_usage,
        total_heat = total_heat + NEW.total_heat_usage,
        total_elec = total_elec + NEW.total_electricity_usage
        
    WHERE building_id = building_id_var;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updateBuildingUtilitiesOnDelete` AFTER DELETE ON `invoice` FOR EACH ROW BEGIN

    DECLARE building_id_var INT;
    
    -- get the building id associated with an invoice to delete
    SELECT building_id INTO building_id_var
    FROM invoice
    WHERE invoice_id = OLD.invoice_id;
    
    -- update total water, electricity, and heating values for the building
    UPDATE building
    
    SET total_water = total_water - OLD.total_water_usage,
        total_heat = total_heat - OLD.total_heat_usage,
        total_elec = total_elec - OLD.total_electricity_usage
        
    WHERE building_id = building_id_var;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `maintains`
--

DROP TABLE IF EXISTS `maintains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintains` (
  `building_id` int NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`building_id`,`employee_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `maintains_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `maintains_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `worker` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintains`
--

LOCK TABLES `maintains` WRITE;
/*!40000 ALTER TABLE `maintains` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_task`
--

DROP TABLE IF EXISTS `maintenance_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_task` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `task_description` varchar(255) DEFAULT NULL,
  `task_date` date DEFAULT NULL,
  `building_id` int DEFAULT NULL,
  `completed` tinyint(1) DEFAULT NULL,
  `worker_id` int DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `worker_id` (`worker_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `maintenance_task_ibfk_1` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `maintenance_task_ibfk_2` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_task`
--

LOCK TABLES `maintenance_task` WRITE;
/*!40000 ALTER TABLE `maintenance_task` DISABLE KEYS */;
INSERT INTO `maintenance_task` VALUES (31,'Replace light bulbs in hallway','2024-04-17',1,0,1),(32,'Fix leaking faucet in restroom','2024-04-18',1,0,2),(33,'Repair broken window in office','2024-04-19',1,0,3),(34,'Unclog drain in kitchen','2024-04-17',2,0,4),(35,'Paint conference room walls','2024-04-18',2,0,5),(36,'Replace HVAC filter','2024-04-19',2,0,6),(37,'Clean carpets in lobby','2024-04-17',3,0,7),(38,'Fix broken chair in waiting area','2024-04-18',3,0,8),(39,'Install new security cameras','2024-04-19',3,0,9),(40,'Replace damaged floor tiles','2024-04-17',4,0,10),(41,'Fix electrical outlet in break room','2024-04-18',4,0,11),(42,'Repair roof leak','2024-04-19',4,0,12),(43,'Clean gutters','2024-04-17',5,0,13),(44,'Replace landscaping','2024-04-18',5,0,14),(45,'Repair fence','2024-04-19',5,0,15),(46,'Paint exterior walls','2024-04-17',1,0,16),(47,'Fix broken lock on entrance door','2024-04-18',1,0,17),(48,'Replace carpet in office','2024-04-19',1,0,18),(49,'Install new shelving units','2024-04-17',2,0,19),(50,'Repair HVAC system','2024-04-18',2,0,20),(51,'Replace ceiling tiles','2024-04-19',2,0,21),(52,'Fix broken window in lobby','2024-04-17',3,0,22),(53,'Install new lighting fixtures','2024-04-18',3,0,23),(54,'Paint exterior doors','2024-04-19',3,0,24),(55,'Replace damaged sidewalk','2024-04-17',4,0,25),(56,'Fix plumbing issue in restroom','2024-04-18',4,0,26),(57,'Repair elevator','2024-04-19',4,0,27),(58,'Clean graffiti off walls','2024-04-17',5,0,28),(59,'Replace damaged signage','2024-04-18',5,0,20),(60,'Fix broken sprinkler system','2024-04-19',5,0,10);
/*!40000 ALTER TABLE `maintenance_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manages`
--

DROP TABLE IF EXISTS `manages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manages` (
  `manager_id` int NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`manager_id`,`employee_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `manages_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `worker` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `manages_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `worker` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manages`
--

LOCK TABLES `manages` WRITE;
/*!40000 ALTER TABLE `manages` DISABLE KEYS */;
/*!40000 ALTER TABLE `manages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worker`
--

DROP TABLE IF EXISTS `worker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker` (
  `worker_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  PRIMARY KEY (`worker_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `worker_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `worker` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worker`
--

LOCK TABLES `worker` WRITE;
/*!40000 ALTER TABLE `worker` DISABLE KEYS */;
INSERT INTO `worker` VALUES (1,'John','Doe',50000,'2023-01-01',NULL),(2,'Jane','Smith',60000,'2023-02-15',1),(3,'Alice','Johnson',55000,'2023-03-20',1),(4,'Bob','Brown',52000,'2023-04-10',2),(5,'Charlie','Williams',53000,'2023-05-05',2),(6,'David','Jones',51000,'2023-06-20',1),(7,'Eve','Wilson',54000,'2023-07-15',3),(8,'Frank','Davis',58000,'2023-08-25',3),(9,'Grace','Miller',56000,'2023-09-30',2),(10,'Henry','Anderson',57000,'2023-10-10',1),(11,'Ivy','Thomas',59000,'2023-11-05',3),(12,'Jack','White',62000,'2023-12-15',2),(13,'Kelly','Martinez',63000,'2024-01-20',1),(14,'Liam','Lopez',64000,'2024-02-25',3),(15,'Mia','Garcia',65000,'2024-03-10',1),(16,'Noah','Rodriguez',66000,'2024-04-05',2),(17,'Olivia','Hernandez',67000,'2024-05-15',3),(18,'Peter','King',68000,'2024-06-20',1),(19,'Quinn','Scott',69000,'2024-07-25',2),(20,'Rose','Adams',70000,'2024-08-30',3),(21,'Sam','Evans',71000,'2024-09-10',1),(22,'Tina','Baker',72000,'2024-10-15',2),(23,'Uma','Nguyen',73000,'2024-11-20',3),(24,'Victor','Patel',74000,'2024-12-25',1),(25,'Wendy','Gonzalez',75000,'2025-01-30',2),(26,'Xavier','Chen',76000,'2025-02-10',3),(27,'Yara','Singh',77000,'2025-03-15',1),(28,'Zack','Lee',78000,'2025-04-20',2);
/*!40000 ALTER TABLE `worker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'utilities'
--

--
-- Dumping routines for database 'utilities'
--
/*!50003 DROP FUNCTION IF EXISTS `getNumWorkersAtBuilding` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getNumWorkersAtBuilding`(building_id_param INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN

    DECLARE numWorkers INT;
    
    SELECT COUNT(DISTINCT employee_id) INTO numWorkers
    FROM maintains
    WHERE building_id = building_id_param;
    
    RETURN numWorkers;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getOpenTickets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getOpenTickets`(building_id_param INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN

    DECLARE totalTickets INT;
    
    SELECT COUNT(*) INTO totalTickets
    FROM maintenance_task
    WHERE building_id = building_id_param
    AND completed = FALSE;
    
    RETURN totalTickets;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteBuilding` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteBuilding`(p_building_id INT)
BEGIN
    DELETE FROM building
    WHERE building_id = p_building_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteInvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteInvoice`(p_invoice_id INT)
BEGIN
    DELETE FROM invoice
    WHERE invoice_id = p_invoice_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getBuildingDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBuildingDetails`(p_building_id INT)
BEGIN

    SELECT b.*, c.campus_name, 
			IFNULL(total_tickets.total_open_tickets, 0) AS total_open_tickets
           
    FROM building b
    JOIN campus c ON b.campus_id = c.campus_id
    LEFT JOIN (
        SELECT building_id, COUNT(*) AS total_open_tickets
        FROM maintenance_task
        WHERE completed = FALSE
        GROUP BY building_id
    ) AS total_tickets ON b.building_id = total_tickets.building_id
    WHERE b.building_id = p_building_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getBuildMaintenanceWorkers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBuildMaintenanceWorkers`(building_id_param INT)
BEGIN

    SELECT w.worker_id, w.first_name, w.last_name
    FROM worker w
    JOIN maintains m ON w.worker_id = m.employee_id
    WHERE m.building_id = building_id_param;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCampusBuildings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCampusBuildings`(campus_id_p INT)
BEGIN

	SELECT b.building_id, b.building_name, c.campus_name
    FROM building b
    JOIN campus c ON b.campus_id = c.campus_id
    WHERE b.campus_id = campus_id_p;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCampusDepts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCampusDepts`(campus_id_param INT)
BEGIN

    SELECT d.dept_id, d.dept_name
    FROM department d
    JOIN has_space hs ON d.dept_id = hs.dept_id
    JOIN building b ON hs.building_id = b.building_id
    WHERE b.campus_id = campus_id_param;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDeptBuildings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDeptBuildings`(dept_id_param INT)
BEGIN

    SELECT b.building_id, b.building_name
    FROM building b
    JOIN has_space hs ON b.building_id = hs.building_id
    WHERE hs.dept_id = dept_id_param;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getFullBuildingDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFullBuildingDetails`()
BEGIN

    SELECT b.*, 
           IFNULL(total_tickets.total_open_tickets, 0) AS total_open_tickets,
           IFNULL(total_workers.total_maintenance_workers, 0) AS total_maintenance_workers
    FROM building b
    
    LEFT JOIN (
        SELECT building_id, COUNT(*) AS total_open_tickets
        FROM maintenance_task
        WHERE completed = FALSE
        GROUP BY building_id
    ) AS total_tickets ON b.building_id = total_tickets.building_id
    LEFT JOIN (
        SELECT building_id, COUNT(*) AS total_maintenance_workers
        FROM maintains
        GROUP BY building_id
    ) AS total_workers ON b.building_id = total_workers.building_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUtilityTotals` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUtilityTotals`(p_building_id INT)
BEGIN

    SELECT total_heat, total_water, total_elec
    FROM building
    WHERE building_id = p_building_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertBuilding` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertBuilding`(p_building_id INT, p_building_name VARCHAR(64), p_max_occupancy INT, p_hours_open INT,
    p_campus_id INT)
BEGIN

    DECLARE campus_exists INT;
    
    -- check. to see if a campus is in the database
    SELECT COUNT(*) INTO campus_exists
    FROM campus
    WHERE campus_id = p_campus_id;
    
    -- if the campus does not already exist do not allow a user to add a new one
    IF campus_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Please use an existing campus';
    END IF;
    
    -- insert the building into the building table if the user provides a valid campus
    INSERT INTO building (building_id, building_name, max_occupancy, hours_open, campus_id)
    VALUES (p_building_id, p_building_name, p_max_occupancy, p_hours_open, p_campus_id);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertInvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertInvoice`(p_date DATE, p_payment_status BOOLEAN, p_total_electricity_usage INT, p_total_water_usage INT,
    p_total_heat_usage INT, p_bill_amount FLOAT, p_building_id INT)
BEGIN

    INSERT INTO invoice (date, payment_status, total_electricity_usage, total_water_usage, total_heat_usage, bill_amount, building_id)
    VALUES (p_date, p_payment_status, p_total_electricity_usage, p_total_water_usage, p_total_heat_usage, p_bill_amount, p_building_id);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-17 21:05:38
