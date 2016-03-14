-- MySQL dump 10.11
--
-- Host: localhost    Database: app_market_en
-- ------------------------------------------------------
-- Server version	5.0.88-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_backup`
--

DROP TABLE IF EXISTS `app_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_backup` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `box_mac` varchar(17) NOT NULL,
  `app_ids` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_backup`
--

LOCK TABLES `app_backup` WRITE;
/*!40000 ALTER TABLE `app_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_backup_history`
--

DROP TABLE IF EXISTS `app_backup_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_backup_history` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `sta_year` int(4) NOT NULL,
  `sta_month` int(2) NOT NULL,
  `sta_day` int(2) NOT NULL,
  `sta_hour` int(2) NOT NULL,
  `box_mac` varchar(17) character set utf8 NOT NULL,
  `opcode` int(2) NOT NULL,
  `app_ids` text character set utf8,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_backup_history`
--

LOCK TABLES `app_backup_history` WRITE;
/*!40000 ALTER TABLE `app_backup_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_backup_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_category`
--

DROP TABLE IF EXISTS `app_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_category` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `category_name` varchar(120) collate utf8_bin default '',
  `parent_id` int(11) default NULL,
  `category_icon_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `category_icon_id` (`category_icon_id`),
  KEY `FKF6E7495C34CC721E` (`parent_id`),
  KEY `FKF6E7495CF61905C8` (`category_icon_id`),
  CONSTRAINT `FKF6E7495CF61905C8` FOREIGN KEY (`category_icon_id`) REFERENCES `category_icon` (`id`),
  CONSTRAINT `app_category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `app_category` (`id`),
  CONSTRAINT `app_category_ibfk_2` FOREIGN KEY (`category_icon_id`) REFERENCES `category_icon` (`id`),
  CONSTRAINT `FKF6E7495C34CC721E` FOREIGN KEY (`parent_id`) REFERENCES `app_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_category`
--

LOCK TABLES `app_category` WRITE;
/*!40000 ALTER TABLE `app_category` DISABLE KEYS */;
INSERT INTO `app_category` VALUES (1,'2014-03-31 16:00:00','Entertainment',NULL,NULL),(2,'2014-03-31 16:00:00','Video',1,2),(3,'2014-03-31 16:00:00','Music',1,3),(4,'2014-03-31 16:00:00','Health',1,4),(5,'2014-03-31 16:00:00','Parent&Child',1,5),(6,'2014-03-31 16:00:00','Game',NULL,NULL),(7,'2014-03-31 16:00:00','Relax',6,7),(8,'2014-03-31 16:00:00','Cards',6,8),(9,'2014-03-31 16:00:00','Action',6,9),(10,'2014-03-31 16:00:00','Other',6,10),(11,'2014-03-31 16:00:00','Life',NULL,NULL),(12,'2014-03-31 16:00:00','Tools',11,12),(13,'2014-03-31 16:00:00','Enducation',11,13),(14,'2014-03-31 16:00:00','Consult',11,14),(15,'2014-03-31 16:00:00','News',11,15);
/*!40000 ALTER TABLE `app_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_change_details`
--

DROP TABLE IF EXISTS `app_change_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_change_details` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `change_field` varchar(40) collate utf8_bin NOT NULL,
  `change_details` varchar(512) collate utf8_bin NOT NULL,
  `history_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `history_id` (`history_id`),
  KEY `FKA25E4A919C92651A` (`history_id`),
  CONSTRAINT `FKA25E4A919C92651A` FOREIGN KEY (`history_id`) REFERENCES `app_change_history` (`id`),
  CONSTRAINT `app_change_details_ibfk_1` FOREIGN KEY (`history_id`) REFERENCES `app_change_history` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_change_details`
--

LOCK TABLES `app_change_details` WRITE;
/*!40000 ALTER TABLE `app_change_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_change_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_change_history`
--

DROP TABLE IF EXISTS `app_change_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_change_history` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `app_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`),
  KEY `user_id` (`user_id`),
  KEY `FK7CC53CE3493A45AB` (`user_id`),
  KEY `FK7CC53CE3FAA33B0D` (`app_id`),
  CONSTRAINT `FK7CC53CE3FAA33B0D` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_change_history_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_change_history_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`),
  CONSTRAINT `FK7CC53CE3493A45AB` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_change_history`
--

LOCK TABLES `app_change_history` WRITE;
/*!40000 ALTER TABLE `app_change_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_change_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_download_history`
--

DROP TABLE IF EXISTS `app_download_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_download_history` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `sta_year` int(4) NOT NULL,
  `sta_month` int(2) NOT NULL,
  `sta_day` int(2) NOT NULL,
  `sta_hour` int(2) NOT NULL,
  `box_mac` varchar(17) collate utf8_bin NOT NULL,
  `app_id` int(11) default NULL,
  `app_father_category_id` int(11) default NULL,
  `app_category_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `history_year_index` (`sta_year`),
  KEY `history_month_index` (`sta_month`),
  KEY `history_hour_index` (`sta_hour`),
  KEY `history_app_index` (`app_id`),
  KEY `history_father_category_index` (`app_father_category_id`),
  KEY `history_category_index` (`app_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_download_history`
--

LOCK TABLES `app_download_history` WRITE;
/*!40000 ALTER TABLE `app_download_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_download_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_file`
--

DROP TABLE IF EXISTS `app_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_file` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `upload_filename` varchar(100) collate utf8_bin default '',
  `actual_filename` varchar(20) collate utf8_bin default '',
  `actual_filepath` varchar(20) collate utf8_bin default '',
  `upload_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_file`
--

LOCK TABLES `app_file` WRITE;
/*!40000 ALTER TABLE `app_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_icon`
--

DROP TABLE IF EXISTS `app_icon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_icon` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `upload_filename` varchar(100) collate utf8_bin default '',
  `actual_filename` varchar(20) collate utf8_bin default '',
  `actual_filepath` varchar(20) collate utf8_bin default '',
  `upload_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_icon`
--

LOCK TABLES `app_icon` WRITE;
/*!40000 ALTER TABLE `app_icon` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_icon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_must`
--

DROP TABLE IF EXISTS `app_must`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_must` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `install` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  `app_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`),
  KEY `FK4598BD67FAA33B0D` (`app_id`),
  CONSTRAINT `FK4598BD67FAA33B0D` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_must_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_must`
--

LOCK TABLES `app_must` WRITE;
/*!40000 ALTER TABLE `app_must` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_must` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_poster`
--

DROP TABLE IF EXISTS `app_poster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_poster` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `upload_filename` varchar(100) collate utf8_bin default '',
  `actual_filename` varchar(20) collate utf8_bin default '',
  `actual_filepath` varchar(20) collate utf8_bin default '',
  `upload_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_poster`
--

LOCK TABLES `app_poster` WRITE;
/*!40000 ALTER TABLE `app_poster` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_poster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_topic`
--

DROP TABLE IF EXISTS `app_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_topic` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `topic_name` varchar(120) collate utf8_bin default '',
  `topic_icon_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `topic_icon_id` (`topic_icon_id`),
  KEY `FK6DDECD91CDB654F9` (`topic_icon_id`),
  CONSTRAINT `FK6DDECD91CDB654F9` FOREIGN KEY (`topic_icon_id`) REFERENCES `category_icon` (`id`),
  CONSTRAINT `app_topic_ibfk_1` FOREIGN KEY (`topic_icon_id`) REFERENCES `category_icon` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_topic`
--

LOCK TABLES `app_topic` WRITE;
/*!40000 ALTER TABLE `app_topic` DISABLE KEYS */;
INSERT INTO `app_topic` VALUES (1,'2014-03-31 16:00:00','TV Shopping',16),(2,'2014-03-31 16:00:00','Build Figure',17),(3,'2014-03-31 16:00:00','Examination&Euducation',18),(4,'2014-03-31 16:00:00','Delicious Food',19),(5,'2014-03-31 16:00:00','Travelling',20),(6,'2014-03-31 16:00:00','Speed&Furious',21),(7,'2014-03-31 16:00:00','Football',22),(8,'2014-03-31 16:00:00','Famliy KTV',23),(9,'2014-03-31 16:00:00','Victory of the War',24),(10,'2014-03-31 16:00:00','Clothes',25);
/*!40000 ALTER TABLE `app_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_topic_link`
--

DROP TABLE IF EXISTS `app_topic_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_topic_link` (
  `id` int(11) NOT NULL auto_increment,
  `app_id` int(11) default NULL,
  `topic_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`),
  KEY `topic_id` (`topic_id`),
  KEY `FK5B356DE8290B8D0A` (`topic_id`),
  KEY `FK5B356DE8FAA33B0D` (`app_id`),
  CONSTRAINT `FK5B356DE8FAA33B0D` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_topic_link_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `app_topic_link_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `app_topic` (`id`),
  CONSTRAINT `FK5B356DE8290B8D0A` FOREIGN KEY (`topic_id`) REFERENCES `app_topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_topic_link`
--

LOCK TABLES `app_topic_link` WRITE;
/*!40000 ALTER TABLE `app_topic_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_topic_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boot_image`
--

DROP TABLE IF EXISTS `boot_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boot_image` (
  `id` int(11) NOT NULL auto_increment,
  `actual_filename` varchar(20) collate utf8_bin default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boot_image`
--

LOCK TABLES `boot_image` WRITE;
/*!40000 ALTER TABLE `boot_image` DISABLE KEYS */;
INSERT INTO `boot_image` VALUES (1,'initial.png');
/*!40000 ALTER TABLE `boot_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `box_page_recommend`
--

DROP TABLE IF EXISTS `box_page_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `box_page_recommend` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `page_number` int(4) NOT NULL,
  `recommend_position` int(11) NOT NULL,
  `recommend_app_id` int(11) default NULL,
  `recommend_tmp_app_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `recommend_app_id` (`recommend_app_id`),
  KEY `recommend_tmp_app_id` (`recommend_tmp_app_id`),
  KEY `FK37E5080051F51698` (`recommend_tmp_app_id`),
  KEY `FK37E508009C881BF0` (`recommend_app_id`),
  CONSTRAINT `FK37E508009C881BF0` FOREIGN KEY (`recommend_app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `box_page_recommend_ibfk_1` FOREIGN KEY (`recommend_app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `box_page_recommend_ibfk_2` FOREIGN KEY (`recommend_tmp_app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `FK37E5080051F51698` FOREIGN KEY (`recommend_tmp_app_id`) REFERENCES `market_app` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `box_page_recommend`
--

LOCK TABLES `box_page_recommend` WRITE;
/*!40000 ALTER TABLE `box_page_recommend` DISABLE KEYS */;
INSERT INTO `box_page_recommend` VALUES (1,'2014-03-31 16:00:00',1,1,NULL,NULL),(2,'2014-03-31 16:00:00',1,2,NULL,NULL),(3,'2014-03-31 16:00:00',1,3,NULL,NULL),(4,'2014-03-31 16:00:00',1,4,NULL,NULL),(5,'2014-03-31 16:00:00',1,5,NULL,NULL),(6,'2014-03-31 16:00:00',1,6,NULL,NULL),(7,'2014-03-31 16:00:00',1,7,NULL,NULL),(8,'2014-03-31 16:00:00',1,8,NULL,NULL),(9,'2014-03-31 16:00:00',1,9,NULL,NULL),(11,'2014-03-31 16:00:00',2,1,NULL,NULL),(12,'2014-03-31 16:00:00',2,2,NULL,NULL),(13,'2014-03-31 16:00:00',2,3,NULL,NULL),(14,'2014-03-31 16:00:00',2,4,NULL,NULL),(15,'2014-03-31 16:00:00',2,5,NULL,NULL),(16,'2014-03-31 16:00:00',2,6,NULL,NULL),(17,'2014-03-31 16:00:00',2,7,NULL,NULL),(18,'2014-03-31 16:00:00',2,8,NULL,NULL),(19,'2014-03-31 16:00:00',2,9,NULL,NULL),(21,'2014-03-31 16:00:00',3,1,NULL,NULL),(22,'2014-03-31 16:00:00',3,2,NULL,NULL),(23,'2014-03-31 16:00:00',3,3,NULL,NULL),(24,'2014-03-31 16:00:00',3,4,NULL,NULL),(25,'2014-03-31 16:00:00',3,5,NULL,NULL),(26,'2014-03-31 16:00:00',3,6,NULL,NULL),(27,'2014-03-31 16:00:00',3,7,NULL,NULL),(28,'2014-03-31 16:00:00',3,8,NULL,NULL),(29,'2014-03-31 16:00:00',3,9,NULL,NULL),(31,'2014-03-31 16:00:00',4,1,NULL,NULL),(32,'2014-03-31 16:00:00',4,2,NULL,NULL),(33,'2014-03-31 16:00:00',4,3,NULL,NULL),(34,'2014-03-31 16:00:00',4,4,NULL,NULL),(35,'2014-03-31 16:00:00',4,5,NULL,NULL),(36,'2014-03-31 16:00:00',4,6,NULL,NULL),(37,'2014-03-31 16:00:00',4,7,NULL,NULL),(38,'2014-03-31 16:00:00',4,8,NULL,NULL),(39,'2014-03-31 16:00:00',4,9,NULL,NULL),(41,'2014-03-31 16:00:00',1,10,NULL,NULL),(42,'2014-03-31 16:00:00',1,11,NULL,NULL),(43,'2014-03-31 16:00:00',1,12,NULL,NULL),(45,'2014-03-31 16:00:00',2,10,NULL,NULL),(46,'2014-03-31 16:00:00',2,11,NULL,NULL),(47,'2014-03-31 16:00:00',2,12,NULL,NULL),(49,'2014-03-31 16:00:00',3,10,NULL,NULL),(50,'2014-03-31 16:00:00',3,11,NULL,NULL),(51,'2014-03-31 16:00:00',3,12,NULL,NULL),(53,'2014-03-31 16:00:00',4,10,NULL,NULL),(54,'2014-03-31 16:00:00',4,11,NULL,NULL),(55,'2014-03-31 16:00:00',4,12,NULL,NULL);
/*!40000 ALTER TABLE `box_page_recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_icon`
--

DROP TABLE IF EXISTS `category_icon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_icon` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `upload_filename` varchar(100) collate utf8_bin default '',
  `actual_filename` varchar(20) collate utf8_bin default '',
  `actual_filepath` varchar(20) collate utf8_bin default '',
  `upload_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_icon`
--

LOCK TABLES `category_icon` WRITE;
/*!40000 ALTER TABLE `category_icon` DISABLE KEYS */;
INSERT INTO `category_icon` VALUES (2,'2014-03-31 16:00:00','icon_2.png','icon_2.png','','2014-04-01 00:00:00'),(3,'2014-03-31 16:00:00','icon_3.png','icon_3.png','','2014-04-01 00:00:00'),(4,'2014-03-31 16:00:00','icon_4.png','icon_4.png','','2014-04-01 00:00:00'),(5,'2014-03-31 16:00:00','icon_5.png','icon_5.png','','2014-04-01 00:00:00'),(7,'2014-03-31 16:00:00','icon_7.png','icon_7.png','','2014-04-01 00:00:00'),(8,'2014-03-31 16:00:00','icon_8.png','icon_8.png','','2014-04-01 00:00:00'),(9,'2014-03-31 16:00:00','icon_9.png','icon_9.png','','2014-04-01 00:00:00'),(10,'2014-03-31 16:00:00','icon_10.png','icon_10.png','','2014-04-01 00:00:00'),(12,'2014-03-31 16:00:00','icon_12.png','icon_12.png','','2014-04-01 00:00:00'),(13,'2014-03-31 16:00:00','icon_13.png','icon_13.png','','2014-04-01 00:00:00'),(14,'2014-03-31 16:00:00','icon_14.png','icon_14.png','','2014-04-01 00:00:00'),(15,'2014-03-31 16:00:00','icon_15.png','icon_15.png','','2014-04-01 00:00:00'),(16,'2014-03-31 16:00:00','icon_16.png','icon_16.png','','2014-04-01 00:00:00'),(17,'2014-03-31 16:00:00','icon_17.png','icon_17.png','','2014-04-01 00:00:00'),(18,'2014-03-31 16:00:00','icon_18.png','icon_18.png','','2014-04-01 00:00:00'),(19,'2014-03-31 16:00:00','icon_19.png','icon_19.png','','2014-04-01 00:00:00'),(20,'2014-03-31 16:00:00','icon_20.png','icon_20.png','','2014-04-01 00:00:00'),(21,'2014-03-31 16:00:00','icon_21.png','icon_21.png','','2014-04-01 00:00:00'),(22,'2014-03-31 16:00:00','icon_22.png','icon_22.png','','2014-04-01 00:00:00'),(23,'2014-03-31 16:00:00','icon_23.png','icon_23.png','','2014-04-01 00:00:00'),(24,'2014-03-31 16:00:00','icon_24.png','icon_24.png','','2014-04-01 00:00:00'),(25,'2014-03-31 16:00:00','icon_25.png','icon_25.png','','2014-04-01 00:00:00');
/*!40000 ALTER TABLE `category_icon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_version`
--

DROP TABLE IF EXISTS `client_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_version` (
  `id` int(11) NOT NULL auto_increment,
  `client_version` int(11) default '1',
  `begin_update` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_version`
--

LOCK TABLES `client_version` WRITE;
/*!40000 ALTER TABLE `client_version` DISABLE KEYS */;
INSERT INTO `client_version` VALUES (1,1,0);
/*!40000 ALTER TABLE `client_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `luncher_recommend`
--

DROP TABLE IF EXISTS `luncher_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `luncher_recommend` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `position` int(11) default '1',
  `app_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`),
  KEY `FK32C037D4FAA33B0D` (`app_id`),
  CONSTRAINT `FK32C037D4FAA33B0D` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`),
  CONSTRAINT `luncher_recommend_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `market_app` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luncher_recommend`
--

LOCK TABLES `luncher_recommend` WRITE;
/*!40000 ALTER TABLE `luncher_recommend` DISABLE KEYS */;
/*!40000 ALTER TABLE `luncher_recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_app`
--

DROP TABLE IF EXISTS `market_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_app` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `createtime` datetime default NULL,
  `app_key` varchar(10) collate utf8_bin default '',
  `app_name` varchar(120) collate utf8_bin default '',
  `app_description` text collate utf8_bin,
  `app_note` text collate utf8_bin,
  `app_version_int` int(11) default '1',
  `app_version` varchar(48) collate utf8_bin default '',
  `app_package` varchar(120) collate utf8_bin default '',
  `download_times` int(11) default '0',
  `app_size` varchar(48) collate utf8_bin default '',
  `app_status` varchar(10) collate utf8_bin default 'CREAETED',
  `app_scores` int(11) default '8',
  `app_recommend` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  `app_pinying_short` varchar(20) collate utf8_bin default '',
  `app_pinying_full` varchar(40) collate utf8_bin default '',
  `app_category_id` int(11) default NULL,
  `app_icon_id` int(11) default NULL,
  `app_file_id` int(11) default NULL,
  `app_poster_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `app_category_id` (`app_category_id`),
  KEY `app_icon_id` (`app_icon_id`),
  KEY `app_file_id` (`app_file_id`),
  KEY `app_poster_id` (`app_poster_id`),
  KEY `market_app_index_name` (`app_name`),
  KEY `market_app_index_key` (`app_key`),
  KEY `market_app_pinying_short` (`app_pinying_short`),
  KEY `market_app_pinying_full` (`app_pinying_full`),
  KEY `FK429CBF9E26791C2C` (`app_category_id`),
  KEY `FK429CBF9E11DA0F4C` (`app_icon_id`),
  KEY `FK429CBF9E7D34CC6C` (`app_file_id`),
  KEY `FK429CBF9EDACC2A4C` (`app_poster_id`),
  CONSTRAINT `FK429CBF9EDACC2A4C` FOREIGN KEY (`app_poster_id`) REFERENCES `app_poster` (`id`),
  CONSTRAINT `FK429CBF9E11DA0F4C` FOREIGN KEY (`app_icon_id`) REFERENCES `app_icon` (`id`),
  CONSTRAINT `FK429CBF9E26791C2C` FOREIGN KEY (`app_category_id`) REFERENCES `app_category` (`id`),
  CONSTRAINT `FK429CBF9E7D34CC6C` FOREIGN KEY (`app_file_id`) REFERENCES `app_file` (`id`),
  CONSTRAINT `market_app_ibfk_1` FOREIGN KEY (`app_category_id`) REFERENCES `app_category` (`id`),
  CONSTRAINT `market_app_ibfk_2` FOREIGN KEY (`app_icon_id`) REFERENCES `app_icon` (`id`),
  CONSTRAINT `market_app_ibfk_3` FOREIGN KEY (`app_file_id`) REFERENCES `app_file` (`id`),
  CONSTRAINT `market_app_ibfk_4` FOREIGN KEY (`app_poster_id`) REFERENCES `app_poster` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_app`
--

LOCK TABLES `market_app` WRITE;
/*!40000 ALTER TABLE `market_app` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multip_host`
--

DROP TABLE IF EXISTS `multip_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multip_host` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `host_name` varchar(240) collate utf8_bin default '',
  `host_enabled` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multip_host`
--

LOCK TABLES `multip_host` WRITE;
/*!40000 ALTER TABLE `multip_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `multip_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommend_record`
--

DROP TABLE IF EXISTS `recommend_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recommend_record` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `user_id` int(11) default '-1',
  `user_name` varchar(40) collate utf8_bin default '',
  `commit` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommend_record`
--

LOCK TABLES `recommend_record` WRITE;
/*!40000 ALTER TABLE `recommend_record` DISABLE KEYS */;
INSERT INTO `recommend_record` VALUES (1,'2010-12-31 16:00:00',-1,'',1);
/*!40000 ALTER TABLE `recommend_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_client`
--

DROP TABLE IF EXISTS `system_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_client` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `mac_from` varchar(17) collate utf8_bin default '',
  `mac_to` varchar(17) collate utf8_bin default '',
  `client_note` text collate utf8_bin,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_client`
--

LOCK TABLES `system_client` WRITE;
/*!40000 ALTER TABLE `system_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_role`
--

DROP TABLE IF EXISTS `system_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_role` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `role_type` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `FKA47ECC86493A45AB` (`user_id`),
  CONSTRAINT `FKA47ECC86493A45AB` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`),
  CONSTRAINT `system_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `system_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role`
--

LOCK TABLES `system_role` WRITE;
/*!40000 ALTER TABLE `system_role` DISABLE KEYS */;
INSERT INTO `system_role` VALUES (1,'2010-12-31 16:00:00','ROLE_ADMIN',1);
/*!40000 ALTER TABLE `system_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_user`
--

DROP TABLE IF EXISTS `system_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_user` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `name` varchar(120) collate utf8_bin default NULL,
  `contactway` varchar(255) collate utf8_bin default '',
  `username` varchar(48) collate utf8_bin default '',
  `password` varchar(48) collate utf8_bin default '',
  `enabled` tinyint(1) default '0' COMMENT '1 for YES or 0 for NO',
  PRIMARY KEY  (`id`),
  KEY `system_user_index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_user`
--

LOCK TABLES `system_user` WRITE;
/*!40000 ALTER TABLE `system_user` DISABLE KEYS */;
INSERT INTO `system_user` VALUES (1,'2014-03-31 16:00:00','Admin','Admin','chappadmin','chappadmin',1);
/*!40000 ALTER TABLE `system_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-11 18:22:35
