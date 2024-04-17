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
  `building_id` int NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (1,'Building A',100,12,1,50,75,100),(2,'Building B',150,10,1,0,0,0),(3,'Building C',200,14,2,0,0,0),(4,'Building D',100,12,3,0,0,0),(5,'Building E',150,10,4,0,0,0),(6,'Building F',200,14,4,0,0,0);
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
  `invoice_id` int NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,'2024-04-17',1,100,50,75,225.5,1);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

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
  `ticket_id` int NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_task`
--

LOCK TABLES `maintenance_task` WRITE;
/*!40000 ALTER TABLE `maintenance_task` DISABLE KEYS */;
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
  `worker_id` int NOT NULL,
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  PRIMARY KEY (`worker_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `worker_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `worker` (`worker_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worker`
--

LOCK TABLES `worker` WRITE;
/*!40000 ALTER TABLE `worker` DISABLE KEYS */;
/*!40000 ALTER TABLE `worker` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-16 22:38:20
