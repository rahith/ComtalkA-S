CREATE DATABASE  IF NOT EXISTS `comtalkdev` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `comtalkdev`;
-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: comtalkdev
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.13.04.1

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
-- Table structure for table `ach`
--

DROP TABLE IF EXISTS `ach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ach` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `aba_routing` varchar(40) NOT NULL,
  `bank_account` varchar(60) NOT NULL,
  `account_type` int(11) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `account_name` varchar(100) NOT NULL,
  `gateway_key` varchar(100) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ach_i_2` (`user_id`),
  CONSTRAINT `ach_FK_1` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ach`
--

LOCK TABLES `ach` WRITE;
/*!40000 ALTER TABLE `ach` DISABLE KEYS */;
/*!40000 ALTER TABLE `ach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ageing_entity_step`
--

DROP TABLE IF EXISTS `ageing_entity_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ageing_entity_step` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `days` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ageing_entity_step_FK_1` (`status_id`),
  KEY `ageing_entity_step_FK_2` (`entity_id`),
  CONSTRAINT `ageing_entity_step_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `ageing_entity_step_FK_1` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ageing_entity_step`
--

LOCK TABLES `ageing_entity_step` WRITE;
/*!40000 ALTER TABLE `ageing_entity_step` DISABLE KEYS */;
INSERT INTO `ageing_entity_step` VALUES (100,10,1,0,0);
/*!40000 ALTER TABLE `ageing_entity_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_user`
--

DROP TABLE IF EXISTS `base_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `base_user` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `language_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `subscriber_status` int(11) DEFAULT '1',
  `currency_id` int(11) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_status_change` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_name` varchar(50) DEFAULT NULL,
  `failed_attempts` int(11) NOT NULL DEFAULT '0',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entity_id` (`entity_id`,`user_name`,`status_id`),
  KEY `ix_base_user_un` (`entity_id`,`user_name`),
  KEY `base_user_FK_1` (`status_id`),
  KEY `base_user_FK_2` (`subscriber_status`),
  KEY `base_user_FK_4` (`language_id`),
  KEY `base_user_FK_5` (`currency_id`),
  CONSTRAINT `base_user_FK_5` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `base_user_FK_1` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `base_user_FK_2` FOREIGN KEY (`subscriber_status`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `base_user_FK_3` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `base_user_FK_4` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_user`
--

LOCK TABLES `base_user` WRITE;
/*!40000 ALTER TABLE `base_user` DISABLE KEYS */;
INSERT INTO `base_user` VALUES (10,10,'0192023a7bbd73250516f069df18b500',0,1,1,9,1,'2013-09-13 15:40:17','2013-09-13 15:40:27','2013-09-13 15:40:27','ctadmin',0,0);
/*!40000 ALTER TABLE `base_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_process`
--

DROP TABLE IF EXISTS `billing_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_process` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `billing_date` datetime NOT NULL,
  `period_unit_id` int(11) NOT NULL,
  `period_value` int(11) NOT NULL,
  `is_review` int(11) NOT NULL,
  `paper_invoice_batch_id` int(11) DEFAULT NULL,
  `retries_to_do` int(11) NOT NULL DEFAULT '0',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_process_FK_1` (`period_unit_id`),
  KEY `billing_process_FK_2` (`entity_id`),
  KEY `billing_process_FK_3` (`paper_invoice_batch_id`),
  CONSTRAINT `billing_process_FK_3` FOREIGN KEY (`paper_invoice_batch_id`) REFERENCES `paper_invoice_batch` (`id`),
  CONSTRAINT `billing_process_FK_1` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `billing_process_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_process`
--

LOCK TABLES `billing_process` WRITE;
/*!40000 ALTER TABLE `billing_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_process_configuration`
--

DROP TABLE IF EXISTS `billing_process_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_process_configuration` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `next_run_date` datetime NOT NULL,
  `generate_report` smallint(6) NOT NULL,
  `retries` int(11) DEFAULT NULL,
  `days_for_retry` int(11) DEFAULT NULL,
  `days_for_report` int(11) DEFAULT NULL,
  `review_status` int(11) NOT NULL,
  `period_unit_id` int(11) NOT NULL,
  `period_value` int(11) NOT NULL,
  `due_date_unit_id` int(11) NOT NULL,
  `due_date_value` int(11) NOT NULL,
  `df_fm` smallint(6) DEFAULT NULL,
  `only_recurring` smallint(6) NOT NULL DEFAULT '1',
  `invoice_date_process` smallint(6) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  `auto_payment` smallint(6) NOT NULL DEFAULT '0',
  `maximum_periods` int(11) NOT NULL DEFAULT '1',
  `auto_payment_application` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `billing_process_configuration_FK_1` (`period_unit_id`),
  KEY `billing_process_configuration_FK_2` (`entity_id`),
  CONSTRAINT `billing_process_configuration_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `billing_process_configuration_FK_1` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_process_configuration`
--

LOCK TABLES `billing_process_configuration` WRITE;
/*!40000 ALTER TABLE `billing_process_configuration` DISABLE KEYS */;
INSERT INTO `billing_process_configuration` VALUES (100,10,'2013-10-13 00:00:00',1,0,1,3,1,2,1,1,1,NULL,1,0,0,1,1,1);
/*!40000 ALTER TABLE `billing_process_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blacklist`
--

DROP TABLE IF EXISTS `blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `credit_card` int(11) DEFAULT NULL,
  `credit_card_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `meta_field_value_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_blacklist_user_type` (`user_id`,`type`),
  KEY `ix_blacklist_entity_type` (`entity_id`,`type`),
  KEY `blacklist_FK_3` (`meta_field_value_id`),
  CONSTRAINT `blacklist_FK_3` FOREIGN KEY (`meta_field_value_id`) REFERENCES `meta_field_value` (`id`),
  CONSTRAINT `blacklist_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `blacklist_FK_2` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklist`
--

LOCK TABLES `blacklist` WRITE;
/*!40000 ALTER TABLE `blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `breadcrumb`
--

DROP TABLE IF EXISTS `breadcrumb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `breadcrumb` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `breadcrumb`
--

LOCK TABLES `breadcrumb` WRITE;
/*!40000 ALTER TABLE `breadcrumb` DISABLE KEYS */;
INSERT INTO `breadcrumb` VALUES (1,10,'customer','list',NULL,NULL,NULL,0),(2,10,'product','list',NULL,NULL,NULL,0),(3,10,'config','index',NULL,NULL,NULL,0),(4,10,'plugin','listCategories',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `breadcrumb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `organization_name` varchar(200) DEFAULT NULL,
  `street_addres1` varchar(100) DEFAULT NULL,
  `street_addres2` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(30) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `person_initial` varchar(5) DEFAULT NULL,
  `person_title` varchar(40) DEFAULT NULL,
  `phone_country_code` int(11) DEFAULT NULL,
  `phone_area_code` int(11) DEFAULT NULL,
  `phone_phone_number` varchar(20) DEFAULT NULL,
  `fax_country_code` int(11) DEFAULT NULL,
  `fax_area_code` int(11) DEFAULT NULL,
  `fax_phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `notification_include` smallint(6) DEFAULT '1',
  `user_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_contact_fname` (`first_name`),
  KEY `ix_contact_lname` (`last_name`),
  KEY `ix_contact_orgname` (`organization_name`),
  KEY `contact_i_del` (`deleted`),
  KEY `ix_contact_fname_lname` (`first_name`,`last_name`),
  KEY `ix_contact_address` (`street_addres1`,`city`,`postal_code`,`street_addres2`,`state_province`,`country_code`),
  KEY `ix_contact_phone` (`phone_phone_number`,`phone_area_code`,`phone_country_code`),
  KEY `ix_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (100,'COMTalk','Polperro A/S','Tronholmen 3','Randers S','Denmark','8960','DK','Mortensen','Mads',NULL,NULL,45,69,'906 902',NULL,NULL,NULL,'noc@comtalk.dk','2013-09-13 15:40:17',0,NULL,NULL,0),(101,'COMTalk','Polperro A/S','Tronholmen 3','Randers S','Denmark','8960','DK','Mortensen','Mads',NULL,NULL,45,69,'906 902',NULL,NULL,NULL,'noc@comtalk.dk','2013-09-13 15:40:25',0,NULL,10,0);
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_map`
--

DROP TABLE IF EXISTS `contact_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_map` (
  `id` int(11) NOT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `foreign_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_map_i_3` (`contact_id`),
  KEY `contact_map_i_1` (`table_id`,`foreign_id`,`type_id`),
  KEY `contact_map_FK_2` (`type_id`),
  CONSTRAINT `contact_map_FK_3` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `contact_map_FK_1` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`),
  CONSTRAINT `contact_map_FK_2` FOREIGN KEY (`type_id`) REFERENCES `contact_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_map`
--

LOCK TABLES `contact_map` WRITE;
/*!40000 ALTER TABLE `contact_map` DISABLE KEYS */;
INSERT INTO `contact_map` VALUES (678000,100,1,5,10,0),(678001,101,20,10,10,0);
/*!40000 ALTER TABLE `contact_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_type`
--

DROP TABLE IF EXISTS `contact_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_type` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `is_primary` smallint(6) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_type_FK_1` (`entity_id`),
  CONSTRAINT `contact_type_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_type`
--

LOCK TABLES `contact_type` WRITE;
/*!40000 ALTER TABLE `contact_type` DISABLE KEYS */;
INSERT INTO `contact_type` VALUES (1,NULL,NULL,0),(20,10,1,0);
/*!40000 ALTER TABLE `contact_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `code` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'AF'),(2,'AL'),(3,'DZ'),(4,'AS'),(5,'AD'),(6,'AO'),(7,'AI'),(8,'AQ'),(9,'AG'),(10,'AR'),(11,'AM'),(12,'AW'),(13,'AU'),(14,'AT'),(15,'AZ'),(16,'BS'),(17,'BH'),(18,'BD'),(19,'BB'),(20,'BY'),(21,'BE'),(22,'BZ'),(23,'BJ'),(24,'BM'),(25,'BT'),(26,'BO'),(27,'BA'),(28,'BW'),(29,'BV'),(30,'BR'),(31,'IO'),(32,'BN'),(33,'BG'),(34,'BF'),(35,'BI'),(36,'KH'),(37,'CM'),(38,'CA'),(39,'CV'),(40,'KY'),(41,'CF'),(42,'TD'),(43,'CL'),(44,'CN'),(45,'CX'),(46,'CC'),(47,'CO'),(48,'KM'),(49,'CG'),(50,'CK'),(51,'CR'),(52,'CI'),(53,'HR'),(54,'CU'),(55,'CY'),(56,'CZ'),(57,'CD'),(58,'DK'),(59,'DJ'),(60,'DM'),(61,'DO'),(62,'TP'),(63,'EC'),(64,'EG'),(65,'SV'),(66,'GQ'),(67,'ER'),(68,'EE'),(69,'ET'),(70,'FK'),(71,'FO'),(72,'FJ'),(73,'FI'),(74,'FR'),(75,'GF'),(76,'PF'),(77,'TF'),(78,'GA'),(79,'GM'),(80,'GE'),(81,'DE'),(82,'GH'),(83,'GI'),(84,'GR'),(85,'GL'),(86,'GD'),(87,'GP'),(88,'GU'),(89,'GT'),(90,'GN'),(91,'GW'),(92,'GY'),(93,'HT'),(94,'HM'),(95,'HN'),(96,'HK'),(97,'HU'),(98,'IS'),(99,'IN'),(100,'ID'),(101,'IR'),(102,'IQ'),(103,'IE'),(104,'IL'),(105,'IT'),(106,'JM'),(107,'JP'),(108,'JO'),(109,'KZ'),(110,'KE'),(111,'KI'),(112,'KR'),(113,'KW'),(114,'KG'),(115,'LA'),(116,'LV'),(117,'LB'),(118,'LS'),(119,'LR'),(120,'LY'),(121,'LI'),(122,'LT'),(123,'LU'),(124,'MO'),(125,'MK'),(126,'MG'),(127,'MW'),(128,'MY'),(129,'MV'),(130,'ML'),(131,'MT'),(132,'MH'),(133,'MQ'),(134,'MR'),(135,'MU'),(136,'YT'),(137,'MX'),(138,'FM'),(139,'MD'),(140,'MC'),(141,'MN'),(142,'MS'),(143,'MA'),(144,'MZ'),(145,'MM'),(146,'NA'),(147,'NR'),(148,'NP'),(149,'NL'),(150,'AN'),(151,'NC'),(152,'NZ'),(153,'NI'),(154,'NE'),(155,'NG'),(156,'NU'),(157,'NF'),(158,'KP'),(159,'MP'),(160,'NO'),(161,'OM'),(162,'PK'),(163,'PW'),(164,'PA'),(165,'PG'),(166,'PY'),(167,'PE'),(168,'PH'),(169,'PN'),(170,'PL'),(171,'PT'),(172,'PR'),(173,'QA'),(174,'RE'),(175,'RO'),(176,'RU'),(177,'RW'),(178,'WS'),(179,'SM'),(180,'ST'),(181,'SA'),(182,'SN'),(183,'YU'),(184,'SC'),(185,'SL'),(186,'SG'),(187,'SK'),(188,'SI'),(189,'SB'),(190,'SO'),(191,'ZA'),(192,'GS'),(193,'ES'),(194,'LK'),(195,'SH'),(196,'KN'),(197,'LC'),(198,'PM'),(199,'VC'),(200,'SD'),(201,'SR'),(202,'SJ'),(203,'SZ'),(204,'SE'),(205,'CH'),(206,'SY'),(207,'TW'),(208,'TJ'),(209,'TZ'),(210,'TH'),(211,'TG'),(212,'TK'),(213,'TO'),(214,'TT'),(215,'TN'),(216,'TR'),(217,'TM'),(218,'TC'),(219,'TV'),(220,'UG'),(221,'UA'),(222,'AE'),(223,'UK'),(224,'US'),(225,'UM'),(226,'UY'),(227,'UZ'),(228,'VU'),(229,'VA'),(230,'VE'),(231,'VN'),(232,'VG'),(233,'VI'),(234,'WF'),(235,'YE'),(236,'ZM'),(237,'ZW');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_card` (
  `id` int(11) NOT NULL,
  `cc_number` varchar(100) NOT NULL,
  `cc_number_plain` varchar(20) DEFAULT NULL,
  `cc_expiry` datetime NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `cc_type` int(11) NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `gateway_key` varchar(100) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_cc_number` (`cc_number_plain`),
  KEY `ix_cc_number_encrypted` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `id` int(11) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `code` varchar(3) NOT NULL,
  `country_code` varchar(2) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'US$','USD','US',1),(2,'C$','CAD','CA',0),(3,'&#8364;','EUR','EU',0),(4,'&#165;','JPY','JP',0),(5,'&#163;','GBP','UK',0),(6,'&#8361;','KRW','KR',0),(7,'Sf','CHF','CH',0),(8,'SeK','SEK','SE',0),(9,'S$','SGD','SG',0),(10,'M$','MYR','MY',0),(11,'$','AUD','AU',0);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_entity_map`
--

DROP TABLE IF EXISTS `currency_entity_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_entity_map` (
  `currency_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  KEY `currency_entity_map_i_2` (`currency_id`,`entity_id`),
  KEY `currency_entity_map_FK_1` (`entity_id`),
  CONSTRAINT `currency_entity_map_FK_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `currency_entity_map_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_entity_map`
--

LOCK TABLES `currency_entity_map` WRITE;
/*!40000 ALTER TABLE `currency_entity_map` DISABLE KEYS */;
INSERT INTO `currency_entity_map` VALUES (1,10);
/*!40000 ALTER TABLE `currency_entity_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_exchange`
--

DROP TABLE IF EXISTS `currency_exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_exchange` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `rate` decimal(22,10) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `valid_since` datetime NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `currency_exchange_FK_1` (`currency_id`),
  CONSTRAINT `currency_exchange_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_exchange`
--

LOCK TABLES `currency_exchange` WRITE;
/*!40000 ALTER TABLE `currency_exchange` DISABLE KEYS */;
INSERT INTO `currency_exchange` VALUES (1,0,2,1.3250000000,'2004-03-08 20:00:00','1970-01-01 00:00:00',1),(2,0,3,0.8118000000,'2004-03-08 20:00:00','1970-01-01 00:00:00',1),(3,0,4,111.4000000000,'2004-03-08 20:00:00','1970-01-01 00:00:00',1),(4,0,5,0.5479000000,'2004-03-08 20:00:00','1970-01-01 00:00:00',1),(5,0,6,1171.0000000000,'2004-03-08 20:00:00','1970-01-01 00:00:00',1),(6,0,7,1.2300000000,'2004-07-05 20:00:00','1970-01-01 00:00:00',1),(7,0,8,7.4700000000,'2004-07-05 20:00:00','1970-01-01 00:00:00',1),(10,0,9,1.6800000000,'2004-10-11 20:00:00','1970-01-01 00:00:00',1),(11,0,10,3.8000000000,'2004-10-11 20:00:00','1970-01-01 00:00:00',1),(12,0,11,1.2880000000,'2007-01-24 20:00:00','1970-01-01 00:00:00',1);
/*!40000 ALTER TABLE `currency_exchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `referral_fee_paid` smallint(6) DEFAULT NULL,
  `invoice_delivery_method_id` int(11) NOT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `auto_payment_type` int(11) DEFAULT NULL,
  `due_date_unit_id` int(11) DEFAULT NULL,
  `due_date_value` int(11) DEFAULT NULL,
  `df_fm` smallint(6) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_parent` smallint(6) DEFAULT NULL,
  `exclude_aging` smallint(6) NOT NULL DEFAULT '0',
  `invoice_child` smallint(6) DEFAULT NULL,
  `use_parent_pricing` bit(1) NOT NULL,
  `current_order_id` int(11) DEFAULT NULL,
  `balance_type` int(11) NOT NULL DEFAULT '1',
  `dynamic_balance` decimal(22,10) DEFAULT NULL,
  `credit_limit` decimal(22,10) DEFAULT NULL,
  `auto_recharge` decimal(22,10) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_i_2` (`user_id`),
  KEY `customer_FK_1` (`invoice_delivery_method_id`),
  KEY `customer_FK_2` (`partner_id`),
  CONSTRAINT `customer_FK_3` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `customer_FK_1` FOREIGN KEY (`invoice_delivery_method_id`) REFERENCES `invoice_delivery_method` (`id`),
  CONSTRAINT `customer_FK_2` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_meta_field_map`
--

DROP TABLE IF EXISTS `customer_meta_field_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_meta_field_map` (
  `customer_id` int(11) NOT NULL,
  `meta_field_value_id` int(11) NOT NULL,
  KEY `customer_meta_field_map_FK_1` (`customer_id`),
  KEY `customer_meta_field_map_FK_2` (`meta_field_value_id`),
  CONSTRAINT `customer_meta_field_map_FK_2` FOREIGN KEY (`meta_field_value_id`) REFERENCES `meta_field_value` (`id`),
  CONSTRAINT `customer_meta_field_map_FK_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_meta_field_map`
--

LOCK TABLES `customer_meta_field_map` WRITE;
/*!40000 ALTER TABLE `customer_meta_field_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_meta_field_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_price`
--

DROP TABLE IF EXISTS `customer_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_price` (
  `plan_item_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`plan_item_id`,`user_id`),
  KEY `customer_price_FK_2` (`user_id`),
  CONSTRAINT `customer_price_FK_2` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `customer_price_FK_1` FOREIGN KEY (`plan_item_id`) REFERENCES `plan_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_price`
--

LOCK TABLES `customer_price` WRITE;
/*!40000 ALTER TABLE `customer_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity`
--

DROP TABLE IF EXISTS `entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity` (
  `id` int(11) NOT NULL,
  `external_id` varchar(20) DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `language_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entity_FK_1` (`currency_id`),
  KEY `entity_FK_2` (`language_id`),
  CONSTRAINT `entity_FK_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `entity_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity`
--

LOCK TABLES `entity` WRITE;
/*!40000 ALTER TABLE `entity` DISABLE KEYS */;
INSERT INTO `entity` VALUES (10,NULL,'COMTALK','2013-09-13 15:41:49',1,1,1);
/*!40000 ALTER TABLE `entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_delivery_method_map`
--

DROP TABLE IF EXISTS `entity_delivery_method_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_delivery_method_map` (
  `method_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  KEY `entity_delivery_method_map_FK_1` (`entity_id`),
  KEY `entity_delivery_method_map_FK_2` (`method_id`),
  CONSTRAINT `entity_delivery_method_map_FK_2` FOREIGN KEY (`method_id`) REFERENCES `invoice_delivery_method` (`id`),
  CONSTRAINT `entity_delivery_method_map_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_delivery_method_map`
--

LOCK TABLES `entity_delivery_method_map` WRITE;
/*!40000 ALTER TABLE `entity_delivery_method_map` DISABLE KEYS */;
INSERT INTO `entity_delivery_method_map` VALUES (1,10),(2,10),(3,10);
/*!40000 ALTER TABLE `entity_delivery_method_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_payment_method_map`
--

DROP TABLE IF EXISTS `entity_payment_method_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_payment_method_map` (
  `entity_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  KEY `entity_payment_method_map_FK_1` (`payment_method_id`),
  KEY `entity_payment_method_map_FK_2` (`entity_id`),
  CONSTRAINT `entity_payment_method_map_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `entity_payment_method_map_FK_1` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_payment_method_map`
--

LOCK TABLES `entity_payment_method_map` WRITE;
/*!40000 ALTER TABLE `entity_payment_method_map` DISABLE KEYS */;
INSERT INTO `entity_payment_method_map` VALUES (10,1),(10,2),(10,3);
/*!40000 ALTER TABLE `entity_payment_method_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_report_map`
--

DROP TABLE IF EXISTS `entity_report_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_report_map` (
  `report_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`,`entity_id`),
  KEY `entity_report_map_FK_2` (`entity_id`),
  CONSTRAINT `entity_report_map_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `entity_report_map_FK_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_report_map`
--

LOCK TABLES `entity_report_map` WRITE;
/*!40000 ALTER TABLE `entity_report_map` DISABLE KEYS */;
INSERT INTO `entity_report_map` VALUES (1,10),(2,10),(3,10),(4,10),(5,10),(6,10),(7,10),(8,10),(9,10),(10,10),(11,10),(12,10);
/*!40000 ALTER TABLE `entity_report_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enumeration`
--

DROP TABLE IF EXISTS `enumeration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enumeration` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enumeration_FK_1` (`entity_id`),
  CONSTRAINT `enumeration_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enumeration`
--

LOCK TABLES `enumeration` WRITE;
/*!40000 ALTER TABLE `enumeration` DISABLE KEYS */;
/*!40000 ALTER TABLE `enumeration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enumeration_values`
--

DROP TABLE IF EXISTS `enumeration_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enumeration_values` (
  `id` int(11) NOT NULL,
  `enumeration_id` int(11) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enumeration_values_FK_1` (`enumeration_id`),
  CONSTRAINT `enumeration_values_FK_1` FOREIGN KEY (`enumeration_id`) REFERENCES `enumeration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enumeration_values`
--

LOCK TABLES `enumeration_values` WRITE;
/*!40000 ALTER TABLE `enumeration_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `enumeration_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log`
--

DROP TABLE IF EXISTS `event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_log` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `affected_user_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `foreign_id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `level_field` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `old_num` int(11) DEFAULT NULL,
  `old_str` varchar(1000) DEFAULT NULL,
  `old_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_el_main` (`module_id`,`message_id`,`create_datetime`),
  KEY `event_log_FK_2` (`entity_id`),
  KEY `event_log_FK_3` (`user_id`),
  KEY `event_log_FK_4` (`affected_user_id`),
  KEY `event_log_FK_5` (`table_id`),
  KEY `event_log_FK_6` (`message_id`),
  CONSTRAINT `event_log_FK_6` FOREIGN KEY (`message_id`) REFERENCES `event_log_message` (`id`),
  CONSTRAINT `event_log_FK_1` FOREIGN KEY (`module_id`) REFERENCES `event_log_module` (`id`),
  CONSTRAINT `event_log_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `event_log_FK_3` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `event_log_FK_4` FOREIGN KEY (`affected_user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `event_log_FK_5` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log`
--

LOCK TABLES `event_log` WRITE;
/*!40000 ALTER TABLE `event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log_message`
--

DROP TABLE IF EXISTS `event_log_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_log_message` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log_message`
--

LOCK TABLES `event_log_message` WRITE;
/*!40000 ALTER TABLE `event_log_message` DISABLE KEYS */;
INSERT INTO `event_log_message` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31),(32),(33),(34);
/*!40000 ALTER TABLE `event_log_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log_module`
--

DROP TABLE IF EXISTS `event_log_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_log_module` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log_module`
--

LOCK TABLES `event_log_module` WRITE;
/*!40000 ALTER TABLE `event_log_module` DISABLE KEYS */;
INSERT INTO `event_log_module` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15);
/*!40000 ALTER TABLE `event_log_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter`
--

DROP TABLE IF EXISTS `filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter` (
  `id` int(11) NOT NULL,
  `filter_set_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `constraint_type` varchar(255) NOT NULL,
  `field` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `visible` bit(1) NOT NULL,
  `integer_value` int(11) DEFAULT NULL,
  `string_value` varchar(255) DEFAULT NULL,
  `start_date_value` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date_value` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `boolean_value` bit(1) DEFAULT NULL,
  `decimal_value` decimal(22,10) DEFAULT NULL,
  `decimal_high_value` decimal(22,10) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_FK_1` (`filter_set_id`),
  CONSTRAINT `filter_FK_1` FOREIGN KEY (`filter_set_id`) REFERENCES `filter_set` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter`
--

LOCK TABLES `filter` WRITE;
/*!40000 ALTER TABLE `filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter_set`
--

DROP TABLE IF EXISTS `filter_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_set` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_set`
--

LOCK TABLES `filter_set` WRITE;
/*!40000 ALTER TABLE `filter_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `filter_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generic_status`
--

DROP TABLE IF EXISTS `generic_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `generic_status` (
  `id` int(11) NOT NULL,
  `dtype` varchar(40) NOT NULL,
  `status_value` int(11) NOT NULL,
  `can_login` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generic_status_FK_1` (`dtype`),
  CONSTRAINT `generic_status_FK_1` FOREIGN KEY (`dtype`) REFERENCES `generic_status_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generic_status`
--

LOCK TABLES `generic_status` WRITE;
/*!40000 ALTER TABLE `generic_status` DISABLE KEYS */;
INSERT INTO `generic_status` VALUES (1,'user_status',1,1),(2,'user_status',2,1),(3,'user_status',3,1),(4,'user_status',4,1),(5,'user_status',5,0),(6,'user_status',6,0),(7,'user_status',7,0),(8,'user_status',8,0),(9,'subscriber_status',1,NULL),(10,'subscriber_status',2,NULL),(11,'subscriber_status',3,NULL),(12,'subscriber_status',4,NULL),(13,'subscriber_status',5,NULL),(14,'subscriber_status',6,NULL),(15,'subscriber_status',7,NULL),(16,'order_status',1,NULL),(17,'order_status',2,NULL),(18,'order_status',3,NULL),(19,'order_status',4,NULL),(20,'order_line_provisioning_status',1,NULL),(21,'order_line_provisioning_status',2,NULL),(22,'order_line_provisioning_status',3,NULL),(23,'order_line_provisioning_status',4,NULL),(24,'order_line_provisioning_status',5,NULL),(25,'order_line_provisioning_status',6,NULL),(26,'invoice_status',1,NULL),(27,'invoice_status',2,NULL),(28,'invoice_status',3,NULL),(29,'mediation_record_status',1,NULL),(30,'mediation_record_status',2,NULL),(31,'mediation_record_status',3,NULL),(32,'mediation_record_status',4,NULL),(33,'process_run_status',1,NULL),(34,'process_run_status',2,NULL),(35,'process_run_status',3,NULL);
/*!40000 ALTER TABLE `generic_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generic_status_type`
--

DROP TABLE IF EXISTS `generic_status_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `generic_status_type` (
  `id` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generic_status_type`
--

LOCK TABLES `generic_status_type` WRITE;
/*!40000 ALTER TABLE `generic_status_type` DISABLE KEYS */;
INSERT INTO `generic_status_type` VALUES ('invoice_status'),('mediation_record_status'),('order_line_provisioning_status'),('order_status'),('process_run_status'),('subscriber_status'),('user_status');
/*!40000 ALTER TABLE `generic_status_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `international_description`
--

DROP TABLE IF EXISTS `international_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `international_description` (
  `table_id` int(11) NOT NULL,
  `foreign_id` int(11) NOT NULL,
  `psudo_column` varchar(20) NOT NULL,
  `language_id` int(11) NOT NULL,
  `content` varchar(4000) NOT NULL,
  PRIMARY KEY (`table_id`,`foreign_id`,`psudo_column`,`language_id`),
  KEY `international_description_i_2` (`table_id`,`foreign_id`,`language_id`),
  KEY `int_description_i_lan` (`language_id`),
  CONSTRAINT `international_description_FK_2` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`),
  CONSTRAINT `international_description_FK_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `international_description`
--

LOCK TABLES `international_description` WRITE;
/*!40000 ALTER TABLE `international_description` DISABLE KEYS */;
INSERT INTO `international_description` VALUES (4,1,'description',1,'United States Dollar'),(4,1,'description',2,'D�lares Norte Americanos'),(4,2,'description',1,'Canadian Dollar'),(4,2,'description',2,'D�lares Canadianos'),(4,3,'description',1,'Euro'),(4,3,'description',2,'Euro'),(4,4,'description',1,'Yen'),(4,4,'description',2,'Ien'),(4,5,'description',1,'Pound Sterling'),(4,5,'description',2,'Libras Estrelinas'),(4,6,'description',1,'Won'),(4,6,'description',2,'Won'),(4,7,'description',1,'Swiss Franc'),(4,7,'description',2,'Franco Su��o'),(4,8,'description',1,'Swedish Krona'),(4,8,'description',2,'Coroa Sueca'),(4,9,'description',1,'Singapore Dollar'),(4,9,'description',2,'D�lar da Singapura'),(4,10,'description',1,'Malaysian Ringgit'),(4,10,'description',2,'Ringgit Malasiano'),(4,11,'description',1,'Australian Dollar'),(4,11,'description',2,'D�lar Australiano'),(6,1,'description',1,'Month'),(6,1,'description',2,'M�s'),(6,2,'description',1,'Week'),(6,2,'description',2,'Semana'),(6,3,'description',1,'Day'),(6,3,'description',2,'Dia'),(6,4,'description',1,'Year'),(6,4,'description',2,'Ano'),(7,1,'description',1,'Email'),(7,1,'description',2,'Email'),(7,2,'description',1,'Paper'),(7,2,'description',2,'Papel'),(7,3,'description',1,'Email + Paper'),(7,3,'description',2,'Email + Papel'),(9,1,'description',1,'Active'),(9,1,'description',2,'Activo'),(9,2,'description',1,'Overdue'),(9,2,'description',2,'Em aberto'),(9,3,'description',1,'Overdue 2'),(9,3,'description',2,'Em aberto 2'),(9,4,'description',1,'Overdue 3'),(9,4,'description',2,'Em aberto 3'),(9,5,'description',1,'Suspended'),(9,5,'description',2,'Suspensa'),(9,6,'description',1,'Suspended 2'),(9,6,'description',2,'Suspensa 2'),(9,7,'description',1,'Suspended 3'),(9,7,'description',2,'Suspensa 3'),(9,8,'description',1,'Deleted'),(9,8,'description',2,'Eliminado'),(17,1,'description',1,'One time'),(17,1,'description',2,'Vez �nica'),(17,200,'description',1,'Monthly'),(18,1,'description',1,'Items'),(18,1,'description',2,'Items'),(18,2,'description',1,'Tax'),(18,2,'description',2,'Imposto'),(18,3,'description',1,'Penalty'),(18,3,'description',2,'Penalidade'),(19,1,'description',1,'pre paid'),(19,1,'description',2,'Pr� pago'),(19,2,'description',1,'post paid'),(19,2,'description',2,'P�s pago'),(20,1,'description',1,'Active'),(20,1,'description',2,'Activo'),(20,2,'description',1,'Finished'),(20,2,'description',2,'Terminado'),(20,3,'description',1,'Suspended'),(20,3,'description',2,'Suspenso'),(20,4,'description',1,'Suspended (auto)'),(20,4,'description',2,'Suspender (auto)'),(23,1,'description',1,'Item management and order line total calculation'),(23,2,'description',1,'Billing process: order filters'),(23,3,'description',1,'Billing process: invoice filters'),(23,4,'description',1,'Invoice presentation'),(23,5,'description',1,'Billing process: order periods calculation'),(23,6,'description',1,'Payment gateway integration'),(23,7,'description',1,'Notifications'),(23,8,'description',1,'Payment instrument selection'),(23,9,'description',1,'Penalties for overdue invoices'),(23,10,'description',1,'Alarms when a payment gateway is down'),(23,11,'description',1,'Subscription status manager'),(23,12,'description',1,'Parameters for asynchronous payment processing'),(23,13,'description',1,'Add one product to order'),(23,14,'description',1,'Product pricing'),(23,15,'description',1,'Mediation Reader'),(23,16,'description',1,'Mediation Processor'),(23,17,'description',1,'Generic internal events listener'),(23,18,'description',1,'External provisioning processor'),(23,19,'description',1,'Purchase validation against pre-paid balance / credit limit'),(23,20,'description',1,'Billing process: customer selection'),(23,21,'description',1,'Mediation Error Handler'),(23,22,'description',1,'Scheduled Plug-ins'),(23,23,'description',1,'Rules Generators'),(23,24,'description',1,'Ageing for customers with overdue invoices'),(24,1,'description',1,'Calculates the order total and the total for each line, considering the item prices, the quantity and if the prices are percentage or not.'),(24,1,'title',1,'Default order totals'),(24,2,'description',1,'Adds an additional line to the order with a percentage charge to represent the value added tax.'),(24,2,'title',1,'VAT'),(24,3,'description',1,'A very simple implementation that sets the due date of the invoice. The due date is calculated by just adding the period of time to the invoice date.'),(24,3,'title',1,'Invoice due date'),(24,4,'description',1,'This task will copy all the lines on the orders and invoices to the new invoice, considering the periods involved for each order, but not the fractions of periods. It will not copy the lines that are taxes. The quantity and total of each line will be multiplied by the amount of periods.'),(24,4,'title',1,'Default invoice composition.'),(24,5,'description',1,'Decides if an order should be included in an invoice for a given billing process.  This is done by taking the billing process time span, the order period, the active since/until, etc.'),(24,5,'title',1,'Standard Order Filter'),(24,6,'description',1,'Always returns true, meaning that the overdue invoice will be carried over to a new invoice.'),(24,6,'title',1,'Standard Invoice Filter'),(24,7,'description',1,'Calculates the start and end period to be included in an invoice. This is done by taking the billing process time span, the order period, the active since/until, etc.'),(24,7,'title',1,'Default Order Periods'),(24,8,'description',1,'Integration with the authorize.net payment gateway.'),(24,8,'title',1,'Authorize.net payment processor'),(24,9,'description',1,'Notifies a user by sending an email. It supports text and HTML emails'),(24,9,'title',1,'Standard Email Notification'),(24,10,'description',1,'Finds the information of a payment method available to a customer, given priority to credit card. In other words, it will return the credit car of a customer or the ACH information in that order.'),(24,10,'title',1,'Default payment information'),(24,11,'description',1,'Plug-in useful only for testing'),(24,11,'title',1,'Testing plug-in for partner payouts'),(24,12,'description',1,'Will generate a PDF version of an invoice.'),(24,12,'title',1,'PDF invoice notification'),(24,14,'description',1,'Returns always false, which makes jBilling to never carry over an invoice into another newer invoice.'),(24,14,'title',1,'No invoice carry over'),(24,15,'description',1,'Will create a new order with a penalty item. The item is taken as a parameter to the task.'),(24,15,'title',1,'Default interest task'),(24,16,'description',1,'Extends BasicOrderFilterTask, modifying the dates to make the order applicable a number of months before it would be by using the default filter.'),(24,16,'title',1,'Anticipated order filter'),(24,17,'description',1,'Extends BasicOrderPeriodTask, modifying the dates to make the order applicable a number of months before itd be by using the default task.'),(24,17,'title',1,'Anticipate order periods.'),(24,19,'description',1,'Extends the standard authorize.net payment processor to also send an email to the company after processing the payment.'),(24,19,'title',1,'Email & process authorize.net'),(24,20,'description',1,'Sends an email to the billing administrator as an alarm when a payment gateway is down.'),(24,20,'title',1,'Payment gateway down alarm'),(24,21,'description',1,'A test payment processor implementation to be able to test jBillings functions without using a real payment gateway.'),(24,21,'title',1,'Test payment processor'),(24,22,'description',1,'Allows a customer to be assigned a specific payment gateway. It checks a custom contact field to identify the gateway and then delegates the actual payment processing to another plugin.'),(24,22,'title',1,'Router payment processor based on Custom Fields'),(24,23,'description',1,'It determines how a payment event affects the subscription status of a user, considering its present status and a state machine.'),(24,23,'title',1,'Default subscription status manager'),(24,24,'description',1,'Integration with the ACH commerce payment gateway.'),(24,24,'title',1,'ACH Commerce payment processor'),(24,25,'description',1,'A dummy task that does not add any parameters for asynchronous payment processing. This is the default.'),(24,25,'title',1,'Standard asynchronous parameters'),(24,26,'description',1,'This plug-in adds parameters for asynchronous payment processing to have one processing message bean per payment processor. It is used in combination with the router payment processor plug-ins.'),(24,26,'title',1,'Router asynchronous parameters'),(24,28,'description',1,'It adds items to an order. If the item is already in the order, it only updates the quantity.'),(24,28,'title',1,'Standard Item Manager'),(24,29,'description',1,'This is a rules-based plug-in. It will do what the basic item manager does (actually calling it); but then it will execute external rules as well. These external rules have full control on changing the order that is getting new items.'),(24,29,'title',1,'Rules Item Manager'),(24,30,'description',1,'This is a rules-based plug-in. It calculates the total for an order line (typically this is the price multiplied by the quantity); allowing for the execution of external rules.'),(24,30,'title',1,'Rules Line Total'),(24,31,'description',1,'This is a rules-based plug-in. It gives a price to an item by executing external rules. You can then add logic externally for pricing. It is also integrated with the mediation process by having access to the mediation pricing data.'),(24,31,'title',1,'Rules Pricing'),(24,32,'description',1,'This is a reader for the mediation process. It reads records from a text file whose fields are separated by a character (or string).'),(24,32,'title',1,'Separator file reader'),(24,33,'description',1,'This is a rules-based plug-in (see chapter 7). It takes an event record from the mediation process and executes external rules to translate the record into billing meaningful data. This is at the core of the mediation component, see the ?Telecom Guide? document for more information.'),(24,33,'title',1,'Rules mediation processor'),(24,34,'description',1,'This is a reader for the mediation process. It reads records from a text file whose fields have fixed positions,and the record has a fixed length.'),(24,34,'title',1,'Fixed length file reader'),(24,35,'description',1,'This is exactly the same as the standard payment information task, the only difference is that it does not validate if the credit card is expired. Use this plug-in only if you want to submit payment with expired credit cards.'),(24,35,'title',1,'Payment information without validation'),(24,36,'description',1,'This plug-in is only used for testing purposes. Instead of sending an email (or other real notification); it simply stores the text to be sent in a file named emails_sent.txt.'),(24,36,'title',1,'Notification task for testing'),(24,37,'description',1,'This plugin takes into consideration the field cycle starts of orders to calculate fractional order periods.'),(24,37,'title',1,'Order periods calculator with pro rating.'),(24,38,'description',1,'When creating an invoice from an order, this plug-in will pro-rate any fraction of a period taking a day as the smallest billable unit.'),(24,38,'title',1,'Invoice composition task with pro-rating (day as fraction)'),(24,39,'description',1,'Integration with the Intraanuity payment gateway.'),(24,39,'title',1,'Payment process for the Intraanuity payment gateway'),(24,40,'description',1,'This plug-in will create a new order with a negative price to reflect a credit when an order is canceled within a period that has been already invoiced.'),(24,40,'title',1,'Automatic cancellation credit.'),(24,41,'description',1,'This plug-in will use external rules to determine if an order that is being canceled should create a new order with a penalty fee. This is typically used for early cancels of a contract.'),(24,41,'title',1,'Fees for early cancellation of a plan.'),(24,42,'description',1,'Used for blocking payments from reaching real payment processors. Typically configured as first payment processor in the processing chain.'),(24,42,'title',1,'Blacklist filter payment processor.'),(24,43,'description',1,'Causes users and their associated details (e.g., credit card number, phone number, etc.) to be blacklisted when their status becomes suspended or higher. '),(24,43,'title',1,'Blacklist user when their status becomes suspended or higher.'),(24,44,'description',1,'This is a reader for the mediation process. It reads records from a JDBC database source.'),(24,44,'title',1,'JDBC Mediation Reader.'),(24,45,'description',1,'This is a reader for the mediation process. It is an extension of the JDBC reader, allowing easy configuration of a MySQL database source.'),(24,45,'title',1,'MySQL Mediation Reader.'),(24,46,'description',1,'Responds to order related events. Runs rules to generate commands to send via JMS messages to the external provisioning module.'),(24,46,'title',1,'Provisioning commands rules task.'),(24,47,'description',1,'This plug-in is only used for testing purposes. It is a test external provisioning task for testing the provisioning modules.'),(24,47,'title',1,'Test external provisioning task.'),(24,48,'description',1,'An external provisioning plug-in for communicating with the Ericsson Customer Administration Interface (CAI).'),(24,48,'title',1,'CAI external provisioning task.'),(24,49,'description',1,'Delegates the actual payment processing to another plug-in based on the currency of the payment.'),(24,49,'title',1,'Currency Router payment processor'),(24,50,'description',1,'An external provisioning plug-in for communicating with the TeliaSonera MMSC.'),(24,50,'title',1,'MMSC external provisioning task.'),(24,51,'description',1,'This filter will only invoices with a positive balance to be carried over to the next invoice.'),(24,51,'title',1,'Filters out negative invoices for carry over.'),(24,52,'description',1,'It will generate a file with one line per invoice generated.'),(24,52,'title',1,'File invoice exporter.'),(24,53,'description',1,'It will call a package of rules when an internal event happens.'),(24,53,'title',1,'Rules caller on an event.'),(24,54,'description',1,'It will update the dynamic balance of a customer (pre-paid or credit limit) when events affecting the balance happen.'),(24,54,'title',1,'Dynamic balance manager'),(24,55,'description',1,'Used for real-time mediation, this plug-in will validate a call based on the current dynamic balance of a customer.'),(24,55,'title',1,'Balance validator based on the customer balance.'),(24,56,'description',1,'Used for real-time mediation, this plug-in will validate a call based on a package or rules'),(24,56,'title',1,'Balance validator based on rules.'),(24,57,'description',1,'Integration with the Payments Gateway payment processor.'),(24,57,'title',1,'Payment processor for Payments Gateway.'),(24,58,'description',1,'Saves the credit card information in the payment gateway, rather than the jBilling DB.'),(24,58,'title',1,'Credit cards are stored externally.'),(24,59,'description',1,'This is a rules-based plug-in compatible with the mediation module of jBilling 2.2.x. It will do what the basic item manager does (actually calling it); but then it will execute external rules as well. These external rules have full control on changing the order that is getting new items.'),(24,59,'title',1,'Rules Item Manager 2'),(24,60,'description',1,'This is a rules-based plug-in, compatible with the mediation process of jBilling 2.2.x and later. It calculates the total for an order line (typically this is the price multiplied by the quantity); allowing for the execution of external rules.'),(24,60,'title',1,'Rules Line Total - 2'),(24,61,'description',1,'This is a rules-based plug-in compatible with the mediation module of jBilling 2.2.x. It gives a price to an item by executing external rules. You can then add logic externally for pricing. It is also integrated with the mediation process by having access to the mediation pricing data.'),(24,61,'title',1,'Rules Pricing 2'),(24,63,'description',1,'A fake plug-in to test payments that would be stored externally.'),(24,63,'title',1,'Test payment processor for external storage.'),(24,64,'description',1,'Payment processor plug-in to integrate with RBS WorldPay'),(24,64,'title',1,'WorldPay integration'),(24,65,'description',1,'Payment processor plug-in to integrate with RBS WorldPay. It stores the credit card information (number, etc) in the gateway.'),(24,65,'title',1,'WorldPay integration with external storage'),(24,66,'description',1,'Monitors the balance of a customer and upon reaching a limit, it requests a real-time payment'),(24,66,'title',1,'Auto recharge'),(24,67,'description',1,'Payment processor for integration with the Beanstream payment gateway'),(24,67,'title',1,'Beanstream gateway integration'),(24,68,'description',1,'Payment processor for integration with the Sage payment gateway'),(24,68,'title',1,'Sage payments gateway integration'),(24,69,'description',1,'Called when the billing process runs to select which users to evaluate. This basic implementation simply returns every user not in suspended (or worse) status'),(24,69,'title',1,'Standard billing process users filter'),(24,70,'description',1,'Called when the billing process runs to select which users to evaluate. This only returns users with orders that have a next invoice date earlier than the billing process.'),(24,70,'title',1,'Selective billing process users filter'),(24,71,'description',1,'Event records with errors are saved to a file'),(24,71,'title',1,'Mediation file error handler'),(24,73,'description',1,'Event records with errors are saved to a database table'),(24,73,'title',1,'Mediation data base error handler'),(24,75,'description',1,'Submits payments to paypal as a payment gateway and stores credit card information in PayPal as well'),(24,75,'title',1,'Paypal integration with external storage'),(24,76,'description',1,'Submits payments to authorize.net as a payment gateway and stores credit card information in authorize.net as well'),(24,76,'title',1,'Authorize.net integration with external storage'),(24,77,'description',1,'Delegates the actual payment processing to another plug-in based on the payment method of the payment.'),(24,77,'title',1,'Payment method router payment processor'),(24,78,'description',1,'Generates rules dynamically based on a Velocity template.'),(24,78,'title',1,'Dynamic rules generator'),(24,79,'description',1,'A scheduled task to execute the Mediation Process.'),(24,79,'title',1,'Mediation Process Task'),(24,80,'description',1,'A scheduled task to execute the Billing Process.'),(24,80,'title',1,'Billing Process Task'),(24,87,'description',1,'Ages a user based on the number of days that the account is overdue.'),(24,87,'title',1,'Basic ageing'),(24,88,'description',1,'A scheduled task to execute the Ageing Process.'),(24,88,'title',1,'Ageing process task'),(24,89,'description',1,'Ages a user based on the number of business days (excluding holidays) that the account is overdue.'),(24,89,'title',1,'Business day ageing'),(24,90,'description',1,'A pluggable task of the type AbstractChargeTask to apply tax item to an Invoice with a facility of exempting an exempt item or an exemp customer.'),(24,90,'title',1,'Simple Tax Composition Task'),(24,91,'description',1,'A pluggable task of the type AbstractChargeTask to apply tax item to the Invoice if the Partner\'s country code is matching.'),(24,91,'title',1,'Country Tax Invoice Composition Task'),(24,92,'description',1,'A pluggable task of the type AbstractChargeTask to apply a Penalty to an Invoice having a due date beyond a configurable days period.'),(24,92,'title',1,'Payment Terms Penalty Task'),(24,93,'description',1,'This plug-in will create a new order with a fee if a recurring order is cancelled too early'),(24,93,'title',1,'Fees for early cancellation of a subscription'),(28,20,'description',1,'Primary'),(35,1,'description',1,'Cheque'),(35,1,'description',2,'Cheque'),(35,2,'description',1,'Visa'),(35,2,'description',2,'Visa'),(35,3,'description',1,'MasterCard'),(35,3,'description',2,'MasterCard'),(35,4,'description',1,'AMEX'),(35,4,'description',2,'AMEX'),(35,5,'description',1,'ACH'),(35,5,'description',2,'CCA'),(35,6,'description',1,'Discovery'),(35,6,'description',2,'Discovery'),(35,7,'description',1,'Diners'),(35,7,'description',2,'Diners'),(35,8,'description',1,'PayPal'),(35,8,'description',2,'PayPal'),(41,1,'description',1,'Successful'),(41,1,'description',2,'Com sucesso'),(41,2,'description',1,'Failed'),(41,2,'description',2,'Sem sucesso'),(41,3,'description',1,'Processor unavailable'),(41,3,'description',2,'Processador indispon�vel'),(41,4,'description',1,'Entered'),(41,4,'description',2,'Inserido'),(46,1,'description',1,'Billing Process'),(46,1,'description',2,'Processo de Factura��o'),(46,2,'description',1,'User maintenance'),(46,2,'description',2,'Manuten��o de Utilizador'),(46,3,'description',1,'Item maintenance'),(46,3,'description',2,'Item de manuten��o'),(46,4,'description',1,'Item type maintenance'),(46,4,'description',2,'Item tipo de manuten��o'),(46,5,'description',1,'Item user price maintenance'),(46,5,'description',2,'Item manuten��o de pre�o de utilizador'),(46,6,'description',1,'Promotion maintenance'),(46,6,'description',2,'Manuten��o de promo��o'),(46,7,'description',1,'Order maintenance'),(46,7,'description',2,'Manuten��o por ordem'),(46,8,'description',1,'Credit card maintenance'),(46,8,'description',2,'Manuten��o de cart�o de cr�dito'),(46,9,'description',1,'Invoice maintenance'),(46,9,'description',2,'Manuten��o de facturas'),(46,11,'description',1,'Pluggable tasks maintenance'),(46,11,'description',2,'Manuten��o de tarefas de plug-ins'),(47,1,'description',1,'A prepaid order has unbilled time before the billing process date'),(47,1,'description',2,'Uma ordem pr�-paga tem tempo n�o facturado anterior � data de factura��o'),(47,2,'description',1,'Order has no active time at the date of process.'),(47,2,'description',2,'A ordem n�o tem nenhum per�odo activo � data de processamento.'),(47,3,'description',1,'At least one complete period has to be billable.'),(47,3,'description',2,'Pelo menos um per�odo completo tem de ser factur�vel.'),(47,4,'description',1,'Already billed for the current date.'),(47,4,'description',2,'J� h� factura��o para o per�odo.'),(47,5,'description',1,'This order had to be maked for exclusion in the last process.'),(47,5,'description',2,'Esta ordem teve de ser marcada para exclus�o do �ltimo processo.'),(47,6,'description',1,'Pre-paid order is being process after its expiration.'),(47,6,'description',2,'Pre-paid order is being process after its expiration.'),(47,7,'description',1,'A row was marked as deleted.'),(47,7,'description',2,'A linha marcada foi eliminada.'),(47,8,'description',1,'A user password was changed.'),(47,8,'description',2,'A senha de utilizador foi alterada.'),(47,9,'description',1,'A row was updated.'),(47,9,'description',2,'Uma linha foi actualizada.'),(47,10,'description',1,'Running a billing process, but a review is found unapproved.'),(47,10,'description',2,'A correr um processo de factura��o, foi encontrada uma revis�o rejeitada.'),(47,11,'description',1,'Running a billing process, review is required but not present.'),(47,11,'description',2,'A correr um processo de factura��o, uma � necess�ria mas n�o encontrada.'),(47,12,'description',1,'A user status was changed.'),(47,12,'description',2,'Um status de utilizador foi alterado.'),(47,13,'description',1,'An order status was changed.'),(47,13,'description',2,'Um status de uma ordem foi alterado.'),(47,14,'description',1,'A user had to be aged, but there\'s no more steps configured.'),(47,14,'description',2,'Um utilizador foi inserido no processo de antiguidade, mas n�o h� mais passos configurados.'),(47,15,'description',1,'A partner has a payout ready, but no payment instrument.'),(47,15,'description',2,'Um parceiro tem um pagamento a receber, mas n�o tem instrumento de pagamento.'),(47,16,'description',1,'A purchase order as been manually applied to an invoice.'),(47,16,'description',2,'Uma ordem de compra foi aplicada manualmente a uma factura.'),(47,17,'description',1,'The order line has been updated'),(47,18,'description',1,'The order next billing date has been changed'),(47,19,'description',1,'Last API call to get the the user subscription status transitions'),(47,20,'description',1,'User subscription status has changed'),(47,21,'description',1,'User account is now locked'),(47,22,'description',1,'The order main subscription flag was changed'),(47,23,'description',1,'All the one-time orders the mediation found were in status finished'),(47,24,'description',1,'A valid payment method was not found. The payment request was cancelled'),(47,25,'description',1,'A new row has been created'),(47,26,'description',1,'An invoiced order was cancelled, a credit order was created'),(47,27,'description',1,'A user id was added to the blacklist'),(47,28,'description',1,'A user id was removed from the blacklist'),(47,29,'description',1,'Posted a provisioning command using a UUID'),(47,30,'description',1,'A command was posted for provisioning'),(47,31,'description',1,'The provisioning status of an order line has changed'),(47,32,'description',1,'User subscription status has NOT changed'),(47,33,'description',1,'The dynamic balance of a user has changed'),(47,34,'description',1,'The invoice if child flag has changed'),(50,1,'description',1,'Process payment with billing process'),(50,1,'description',2,'Processar pagamento com processo de factura��o'),(50,2,'description',1,'URL of CSS file'),(50,2,'description',2,'URL ou ficheiro CSS'),(50,3,'description',1,'URL of logo graphic'),(50,3,'description',2,'URL ou gr�fico de logotipo'),(50,4,'description',1,'Grace period'),(50,4,'description',2,'Per�odo de gra�a'),(50,4,'instruction',1,'Grace period in days before ageing a customer with an overdue invoice.'),(50,5,'description',1,'Partner percentage rate'),(50,5,'description',2,'Percentagem do parceiro'),(50,5,'instruction',1,'Partner default percentage commission rate. See the Partner section of the documentation.'),(50,6,'description',1,'Partner referral fee'),(50,6,'description',2,'Valor de refer�ncia do parceiro'),(50,6,'instruction',1,'Partner default flat fee to be paid as commission. See the Partner section of the documentation.'),(50,7,'description',1,'Partner one time payout'),(50,7,'description',2,'Parceiro pagamento �nico'),(50,7,'instruction',1,'Set to \'1\' to enable one-time payment for partners. If set, partners will only get paid once per customer. See the Partner section of the documentation.'),(50,8,'description',1,'Partner period unit payout'),(50,8,'description',2,'Parceiro unidade do per�odo de pagamento'),(50,8,'instruction',1,'Partner default payout period unit. See the Partner section of the documentation.'),(50,9,'description',1,'Partner period value payout'),(50,9,'description',2,'Parceiro valor do per�odo de pagamento'),(50,9,'instruction',1,'Partner default payout period value. See the Partner section of the documentation.'),(50,10,'description',1,'Partner automatic payout'),(50,10,'description',2,'Parceiro pagamento autom�tico'),(50,10,'instruction',1,'Set to \'1\' to enable batch payment payouts using the billing process and the configured payment processor. See the Partner section of the documentation.'),(50,11,'description',1,'User in charge of partners '),(50,11,'description',2,'Utilizador respons�vel pelos parceiros'),(50,11,'instruction',1,'Partner default assigned clerk id. See the Partner section of the documentation.'),(50,12,'description',1,'Partner fee currency'),(50,12,'description',2,'Parceiro moeda'),(50,12,'instruction',1,'Currency ID to use when paying partners. See the Partner section of the documentation.'),(50,13,'description',1,'Self delivery of paper invoices'),(50,13,'description',2,'Entrega pelo mesmo das facturas em papel'),(50,13,'instruction',1,'Set to \'1\' to e-mail invoices as the billing company. \'0\' to deliver invoices as jBilling.'),(50,14,'description',1,'Include customer notes in invoice'),(50,14,'description',2,'Incluir notas do cliente na factura'),(50,14,'instruction',1,'Set to \'1\' to show notes in invoices, \'0\' to disable.'),(50,15,'description',1,'Days before expiration for order notification'),(50,15,'description',2,'Dias antes da expira��o para notifica��o de ordens'),(50,15,'instruction',1,'Days before the orders \'active until\' date to send the 1st notification. Leave blank to disable.'),(50,16,'description',1,'Days before expiration for order notification 2'),(50,16,'description',2,'Dias antes da expira��o para notifica��o de ordens 2'),(50,16,'instruction',1,'Days before the orders \'active until\' date to send the 2nd notification. Leave blank to disable.'),(50,17,'description',1,'Days before expiration for order notification 3'),(50,17,'description',2,'Dias antes da expira��o para notifica��o de ordens 3'),(50,17,'instruction',1,'Days before the orders \'active until\' date to send the 3rd notification. Leave blank to disable.'),(50,18,'description',1,'Invoice number prefix'),(50,18,'description',2,'N�mero de prefixo da factura'),(50,18,'instruction',1,'Prefix value for generated invoice public numbers.'),(50,19,'description',1,'Next invoice number'),(50,19,'description',2,'Pr�ximo n�mero de factura'),(50,19,'instruction',1,'The current value for generated invoice public numbers. New invoices will be assigned a public number by incrementing this value.'),(50,20,'description',1,'Manual invoice deletion'),(50,20,'description',2,'Elimina��o manual de facturas'),(50,20,'instruction',1,'Set to \'1\' to allow invoices to be deleted, \'0\' to disable.'),(50,21,'description',1,'Use invoice reminders'),(50,21,'description',2,'Usar os lembretes de factura'),(50,21,'instruction',1,'Set to \'1\' to allow invoice reminder notifications, \'0\' to disable.'),(50,22,'description',1,'Number of days after the invoice generation for the first reminder'),(50,22,'description',2,'N�mero de dias ap�s a gera��o da factura para o primeiro lembrete'),(50,23,'description',1,'Number of days for next reminder'),(50,23,'description',2,'N�mero de dias para o pr�ximo lembrete'),(50,24,'description',1,'Data Fattura Fine Mese'),(50,24,'description',2,'Data Factura Fim do M�s'),(50,24,'instruction',1,'Set to \'1\' to enable, \'0\' to disable.'),(50,25,'description',1,'Use overdue penalties (interest).'),(50,25,'instruction',1,'Set to \'1\' to enable the billing process to calculate interest on overdue payments, \'0\' to disable. Calculation of interest is handled by the selected penalty plug-in.'),(50,27,'description',1,'Use order anticipation.'),(50,27,'instruction',1,'Set to \'1\' to use the \'OrderFilterAnticipateTask\' to invoice a number of months in advance, \'0\' to disable. Plug-in must be configured separately.'),(50,28,'description',1,'Paypal account.'),(50,28,'instruction',1,'PayPal account name.'),(50,29,'description',1,'Paypal button URL.'),(50,29,'instruction',1,'A URL where the graphic of the PayPal button resides. The button is displayed to customers when they are making a payment. The default is usually the best option, except when another language is needed.'),(50,30,'description',1,'URL for HTTP ageing callback.'),(50,30,'instruction',1,'URL for the HTTP Callback to invoke when the ageing process changes a status of a user.'),(50,31,'description',1,'Use continuous invoice dates.'),(50,31,'instruction',1,'Default \'2000-01-01\'. If this preference is used, the system will make sure that all your invoices have their dates in a incremental way. Any invoice with a greater \'ID\' will also have a greater (or equal) date. In other words, a new invoice can not have an earlier date than an existing (older) invoice. To use this preference, set it as a string with the date where to start.'),(50,32,'description',1,'Attach PDF invoice to email notification.'),(50,32,'instruction',1,'Set to \'1\' to attach a PDF version of the invoice to all invoice notification e-mails. \'0\' to disable.'),(50,33,'description',1,'Force one order per invoice.'),(50,33,'instruction',1,'Set to \'1\' to show the \'include in separate invoice\' flag on an order. \'0\' to disable.'),(50,35,'description',1,'Add order Id to invoice lines.'),(50,35,'instruction',1,'Set to \'1\' to include the ID of the order in the description text of the resulting invoice line. \'0\' to disable. This can help to easily track which exact orders is responsible for a line in an invoice, considering that many orders can be included in a single invoice.'),(50,36,'description',1,'Allow customers to edit own contact information.'),(50,36,'instruction',1,'Set to \'1\' to allow customers to edit their own contact information. \'0\' to disable.'),(50,37,'description',1,'Hide (mask) credit card numbers.'),(50,37,'instruction',1,'Set to \'1\' to mask all credit card numbers. \'0\' to disable. When set, numbers are masked to all users, even administrators, and in all log files.'),(50,38,'description',1,'Link ageing to customer subscriber status.'),(50,38,'instruction',1,'Set to \'1\' to change the subscription status of a user when the user ages. \'0\' to disable.'),(50,39,'description',1,'Lock-out user after failed login attempts.'),(50,39,'instruction',1,'The number of retries to allow before locking the user account. A locked user account will have their password changed to the value of lockout_password in the jbilling.properties configuration file.'),(50,40,'description',1,'Expire user passwords after days.'),(50,40,'instruction',1,'If greater than zero, it represents the number of days that a password is valid. After those days, the password is expired and the user is forced to change it.'),(50,41,'description',1,'Use main-subscription orders.'),(50,41,'instruction',1,'Set to \'1\' to allow the usage of the \'main subscription\' flag for orders This flag is read only by the mediation process when determining where to place charges coming from external events.'),(50,42,'description',1,'Use pro-rating.'),(50,42,'instruction',1,'Set to \'1\' to allow the use of pro-rating to invoice fractions of a period. Shows the \'cycle\' attribute of an order. Note that you need to configure the corresponding plug-ins for this feature to be fully functional.'),(50,43,'description',1,'Use payment blacklist.'),(50,43,'instruction',1,'If the payment blacklist feature is used, this is set to the id of the configuration of the PaymentFilterTask plug-in. See the Blacklist section of the documentation.'),(50,44,'description',1,'Allow negative payments.'),(50,44,'instruction',1,'Set to \'1\' to allow negative payments. \'0\' to disable'),(50,45,'description',1,'Delay negative invoice payments.'),(50,45,'instruction',1,'Set to \'1\' to delay payment of negative invoice amounts, causing the balance to be carried over to the next invoice. Invoices that have had negative balances from other invoices transferred to them are allowed to immediately make a negative payment (credit) if needed. \'0\' to disable. Preference 44 & 46 are usually also enabled.'),(50,46,'description',1,'Allow invoice without orders.'),(50,46,'instruction',1,'Set to \'1\' to allow invoices with negative balances to generate a new invoice that isn\'t composed of any orders so that their balances will always get carried over to a new invoice for the credit to take place. \'0\' to disable. Preference 44 & 45 are usually also enabled.'),(50,47,'description',1,'Last read mediation record id.'),(50,47,'instruction',1,'ID of the last record read by the mediation process. This is used to determine what records are \'new\' and need to be read.'),(50,48,'description',1,'Use provisioning.'),(50,48,'instruction',1,'Set to \'1\' to allow the use of provisioning. \'0\' to disable.'),(50,49,'description',1,'Automatic customer recharge threshold.'),(50,49,'instruction',1,'The threshold value for automatic payments. Pre-paid users with an automatic recharge value set will generate an automatic payment whenever the account balance falls below this threshold. Note that you need to configure the AutoRechargeTask plug-in for this feature to be fully functional.'),(50,50,'description',1,'Invoice decimal rounding.'),(50,50,'instruction',1,'The number of decimal places to be shown on the invoice. Defaults to 2.'),(52,1,'description',1,'Invoice (email)'),(52,1,'description',2,'Factura (email)'),(52,2,'description',1,'User Reactivated'),(52,2,'description',2,'Utilizador Reactivado'),(52,3,'description',1,'User Overdue'),(52,3,'description',2,'Utilizador Em Atraso'),(52,4,'description',1,'User Overdue 2'),(52,4,'description',2,'Utilizador Em Atraso 2'),(52,5,'description',1,'User Overdue 3'),(52,5,'description',2,'Utilizador Em Atraso 3'),(52,6,'description',1,'User Suspended'),(52,6,'description',2,'Utilizador Suspenso'),(52,7,'description',1,'User Suspended 2'),(52,7,'description',2,'Utilizador Suspenso 2'),(52,8,'description',1,'User Suspended 3'),(52,8,'description',2,'Utilizador Suspenso 3'),(52,9,'description',1,'User Deleted'),(52,9,'description',2,'Utilizador Eliminado'),(52,10,'description',1,'Payout Remainder'),(52,10,'description',2,'Pagamento Remascente'),(52,11,'description',1,'Partner Payout'),(52,11,'description',2,'Parceiro Pagamento'),(52,12,'description',1,'Invoice (paper)'),(52,12,'description',2,'Factura (papel)'),(52,13,'description',1,'Order about to expire. Step 1'),(52,13,'description',2,'Ordem de compra a expirar. Passo 1'),(52,14,'description',1,'Order about to expire. Step 2'),(52,14,'description',2,'Ordem de compra a expirar. Passo 2'),(52,15,'description',1,'Order about to expire. Step 3'),(52,15,'description',2,'Ordem de compra a expirar. Passo 3'),(52,16,'description',1,'Payment (successful)'),(52,16,'description',2,'Payment (com sucesso)'),(52,17,'description',1,'Payment (failed)'),(52,17,'description',2,'Payment (sem sucesso)'),(52,19,'description',1,'Update Credit Card'),(52,19,'description',2,'Actualizar Cart�o de Cr�dito'),(52,20,'description',1,'Lost password'),(52,20,'description',2,'Senha esquecida'),(59,10,'description',1,'Create customer'),(59,11,'description',1,'Edit customer'),(59,12,'description',1,'Delete customer'),(59,13,'description',1,'Inspect customer'),(59,14,'description',1,'Blacklist customer'),(59,15,'description',1,'View customer details'),(59,16,'description',1,'Download customer CSV'),(59,17,'description',1,'View all customers'),(59,18,'description',1,'View customer sub-accounts'),(59,20,'description',1,'Create order'),(59,21,'description',1,'Edit order'),(59,22,'description',1,'Delete order'),(59,23,'description',1,'Generate invoice for order'),(59,24,'description',1,'View order details'),(59,25,'description',1,'Download order CSV'),(59,26,'description',1,'Edit line price'),(59,27,'description',1,'Edit line description'),(59,28,'description',1,'View all customers'),(59,29,'description',1,'View customer sub-accounts'),(59,30,'description',1,'Create payment'),(59,31,'description',1,'Edit payment'),(59,32,'description',1,'Delete payment'),(59,33,'description',1,'Link payment to invoice'),(59,34,'description',1,'View payment details'),(59,35,'description',1,'Download payment CSV'),(59,36,'description',1,'View all customers'),(59,37,'description',1,'View customer sub-accounts'),(59,40,'description',1,'Create product'),(59,41,'description',1,'Edit product'),(59,42,'description',1,'Delete product'),(59,43,'description',1,'View product details'),(59,44,'description',1,'Download payment CSV'),(59,50,'description',1,'Create product category'),(59,51,'description',1,'Edit product category'),(59,52,'description',1,'Delete product category'),(59,60,'description',1,'Create plan'),(59,61,'description',1,'Edit plan'),(59,62,'description',1,'Delete plan'),(59,63,'description',1,'View plan details'),(59,70,'description',1,'Delete invoice'),(59,71,'description',1,'Send invoice notification'),(59,72,'description',1,'View invoice details'),(59,73,'description',1,'Download invoice CSV'),(59,74,'description',1,'View all customers'),(59,75,'description',1,'View customer sub-accounts'),(59,80,'description',1,'Approve / Disapprove review'),(59,90,'description',1,'Show customer menu'),(59,91,'description',1,'Show invoices menu'),(59,92,'description',1,'Show order menu'),(59,93,'description',1,'Show payments & refunds menu'),(59,94,'description',1,'Show billing menu'),(59,95,'description',1,'Show mediation menu'),(59,96,'description',1,'Show reports menu'),(59,97,'description',1,'Show products menu'),(59,98,'description',1,'Show plans menu'),(59,99,'description',1,'Show configuration menu'),(59,100,'description',1,'Show partner menu'),(59,101,'description',1,'Create partner'),(59,102,'description',1,'Edit partner'),(59,103,'description',1,'Delete partner'),(59,104,'description',1,'View partner details'),(59,110,'description',1,'Switch to sub-account'),(59,111,'description',1,'Switch to any user'),(59,120,'description',1,'Web Service API access'),(60,1,'description',1,'An internal user with all the permissions'),(60,1,'description',2,'Um utilizador interno com todas as permiss�es'),(60,1,'title',1,'Internal'),(60,1,'title',2,'Interno'),(60,2,'description',1,'The super user of an entity'),(60,2,'description',2,'O super utilizador de uma entidade'),(60,2,'title',1,'Super user'),(60,2,'title',2,'Super utilizador'),(60,3,'description',1,'A billing clerk'),(60,3,'description',2,'Um operador de factura��o'),(60,3,'title',1,'Clerk'),(60,3,'title',2,'Operador'),(60,4,'description',1,'A partner that will bring customers'),(60,4,'description',2,'Um parceiro que vai angariar clientes'),(60,4,'title',1,'Partner'),(60,4,'title',2,'Parceiro'),(60,5,'description',1,'A customer that will query his/her account'),(60,5,'description',2,'Um cliente que vai fazer pesquisas na sua conta'),(60,5,'title',1,'Customer'),(60,5,'title',2,'Cliente'),(60,60,'description',1,'The super user of an entity'),(60,60,'title',1,'Super user'),(60,61,'description',1,'A billing clerk'),(60,61,'title',1,'Clerk'),(60,62,'description',1,'A customer that will query his/her account'),(60,62,'title',1,'Customer'),(60,63,'description',1,'A partner that will bring customers'),(60,63,'title',1,'Partner'),(64,1,'description',1,'Afghanistan'),(64,1,'description',2,'Afganist�o'),(64,2,'description',1,'Albania'),(64,2,'description',2,'Alb�nia'),(64,3,'description',1,'Algeria'),(64,3,'description',2,'Alg�ria'),(64,4,'description',1,'American Samoa'),(64,4,'description',2,'Samoa Americana'),(64,5,'description',1,'Andorra'),(64,5,'description',2,'Andorra'),(64,6,'description',1,'Angola'),(64,6,'description',2,'Angola'),(64,7,'description',1,'Anguilla'),(64,7,'description',2,'Anguilha'),(64,8,'description',1,'Antarctica'),(64,8,'description',2,'Ant�rtida'),(64,9,'description',1,'Antigua and Barbuda'),(64,9,'description',2,'Antigua e Barbuda'),(64,10,'description',1,'Argentina'),(64,10,'description',2,'Argentina'),(64,11,'description',1,'Armenia'),(64,11,'description',2,'Arm�nia'),(64,12,'description',1,'Aruba'),(64,12,'description',2,'Aruba'),(64,13,'description',1,'Australia'),(64,13,'description',2,'Austr�lia'),(64,14,'description',1,'Austria'),(64,14,'description',2,'�ustria'),(64,15,'description',1,'Azerbaijan'),(64,15,'description',2,'Azerbeij�o'),(64,16,'description',1,'Bahamas'),(64,16,'description',2,'Bahamas'),(64,17,'description',1,'Bahrain'),(64,17,'description',2,'Bahrain'),(64,18,'description',1,'Bangladesh'),(64,18,'description',2,'Bangladesh'),(64,19,'description',1,'Barbados'),(64,19,'description',2,'Barbados'),(64,20,'description',1,'Belarus'),(64,20,'description',2,'Belar�ssia'),(64,21,'description',1,'Belgium'),(64,21,'description',2,'B�lgica'),(64,22,'description',1,'Belize'),(64,22,'description',2,'Belize'),(64,23,'description',1,'Benin'),(64,23,'description',2,'Benin'),(64,24,'description',1,'Bermuda'),(64,24,'description',2,'Bermuda'),(64,25,'description',1,'Bhutan'),(64,25,'description',2,'But�o'),(64,26,'description',1,'Bolivia'),(64,26,'description',2,'Bol�via'),(64,27,'description',1,'Bosnia and Herzegovina'),(64,27,'description',2,'Bosnia e Herzegovina'),(64,28,'description',1,'Botswana'),(64,28,'description',2,'Botswana'),(64,29,'description',1,'Bouvet Island'),(64,29,'description',2,'Ilha Bouvet'),(64,30,'description',1,'Brazil'),(64,30,'description',2,'Brasil'),(64,31,'description',1,'British Indian Ocean Territory'),(64,31,'description',2,'Territ�rio Brit�nico do Oceano �ndico'),(64,32,'description',1,'Brunei'),(64,32,'description',2,'Brunei'),(64,33,'description',1,'Bulgaria'),(64,33,'description',2,'Bulg�ria'),(64,34,'description',1,'Burkina Faso'),(64,34,'description',2,'Burquina Faso'),(64,35,'description',1,'Burundi'),(64,35,'description',2,'Burundi'),(64,36,'description',1,'Cambodia'),(64,36,'description',2,'Cambodia'),(64,37,'description',1,'Cameroon'),(64,37,'description',2,'Camar�es'),(64,38,'description',1,'Canada'),(64,38,'description',2,'Canada'),(64,39,'description',1,'Cape Verde'),(64,39,'description',2,'Cabo Verde'),(64,40,'description',1,'Cayman Islands'),(64,40,'description',2,'Ilhas Caim�o'),(64,41,'description',1,'Central African Republic'),(64,41,'description',2,'Rep�blica Centro Africana'),(64,42,'description',1,'Chad'),(64,42,'description',2,'Chade'),(64,43,'description',1,'Chile'),(64,43,'description',2,'Chile'),(64,44,'description',1,'China'),(64,44,'description',2,'China'),(64,45,'description',1,'Christmas Island'),(64,45,'description',2,'Ilha Natal'),(64,46,'description',1,'Cocos - Keeling Islands'),(64,46,'description',2,'Ilha Cocos e Keeling'),(64,47,'description',1,'Colombia'),(64,47,'description',2,'Col�mbia'),(64,48,'description',1,'Comoros'),(64,48,'description',2,'Comoros'),(64,49,'description',1,'Congo'),(64,49,'description',2,'Congo'),(64,50,'description',1,'Cook Islands'),(64,50,'description',2,'Ilhas Cook'),(64,51,'description',1,'Costa Rica'),(64,51,'description',2,'Costa Rica'),(64,52,'description',1,'Cote d Ivoire'),(64,52,'description',2,'Costa do Marfim'),(64,53,'description',1,'Croatia'),(64,53,'description',2,'Cro�cia'),(64,54,'description',1,'Cuba'),(64,54,'description',2,'Cuba'),(64,55,'description',1,'Cyprus'),(64,55,'description',2,'Chipre'),(64,56,'description',1,'Czech Republic'),(64,56,'description',2,'Rep�blica Checa'),(64,57,'description',1,'Congo - DRC'),(64,57,'description',2,'Rep�blica Democr�tica do Congo'),(64,58,'description',1,'Denmark'),(64,58,'description',2,'Dinamarca'),(64,59,'description',1,'Djibouti'),(64,59,'description',2,'Djibouti'),(64,60,'description',1,'Dominica'),(64,60,'description',2,'Dominica'),(64,61,'description',1,'Dominican Republic'),(64,61,'description',2,'Rep�blica Dominicana'),(64,62,'description',1,'East Timor'),(64,62,'description',2,'Timor Leste'),(64,63,'description',1,'Ecuador'),(64,63,'description',2,'Ecuador'),(64,64,'description',1,'Egypt'),(64,64,'description',2,'Egipto'),(64,65,'description',1,'El Salvador'),(64,65,'description',2,'El Salvador'),(64,66,'description',1,'Equatorial Guinea'),(64,66,'description',2,'Guin� Equatorial'),(64,67,'description',1,'Eritrea'),(64,67,'description',2,'Eritreia'),(64,68,'description',1,'Estonia'),(64,68,'description',2,'Est�nia'),(64,69,'description',1,'Ethiopia'),(64,69,'description',2,'Etiopia'),(64,70,'description',1,'Malvinas Islands'),(64,70,'description',2,'Ilhas Malvinas'),(64,71,'description',1,'Faroe Islands'),(64,71,'description',2,'Ilhas Faro�'),(64,72,'description',1,'Fiji Islands'),(64,72,'description',2,'Ilhas Fiji'),(64,73,'description',1,'Finland'),(64,73,'description',2,'Finl�ndia'),(64,74,'description',1,'France'),(64,74,'description',2,'Fran�a'),(64,75,'description',1,'French Guiana'),(64,75,'description',2,'Guiana Francesa'),(64,76,'description',1,'French Polynesia'),(64,76,'description',2,'Polin�sia Francesa'),(64,77,'description',1,'French Southern and Antarctic Lands'),(64,77,'description',2,'Terras Ant�rticas e do Sul Francesas'),(64,78,'description',1,'Gabon'),(64,78,'description',2,'Gab�o'),(64,79,'description',1,'Gambia'),(64,79,'description',2,'G�mbia'),(64,80,'description',1,'Georgia'),(64,80,'description',2,'Georgia'),(64,81,'description',1,'Germany'),(64,81,'description',2,'Alemanha'),(64,82,'description',1,'Ghana'),(64,82,'description',2,'Gana'),(64,83,'description',1,'Gibraltar'),(64,83,'description',2,'Gibraltar'),(64,84,'description',1,'Greece'),(64,84,'description',2,'Gr�cia'),(64,85,'description',1,'Greenland'),(64,85,'description',2,'Gronel�ndia'),(64,86,'description',1,'Grenada'),(64,86,'description',2,'Granada'),(64,87,'description',1,'Guadeloupe'),(64,87,'description',2,'Guadalupe'),(64,88,'description',1,'Guam'),(64,88,'description',2,'Guantanamo'),(64,89,'description',1,'Guatemala'),(64,89,'description',2,'Guatemala'),(64,90,'description',1,'Guinea'),(64,90,'description',2,'Guin�'),(64,91,'description',1,'Guinea-Bissau'),(64,91,'description',2,'Guin�-Bissau'),(64,92,'description',1,'Guyana'),(64,92,'description',2,'Guiana'),(64,93,'description',1,'Haiti'),(64,93,'description',2,'Haiti'),(64,94,'description',1,'Heard Island and McDonald Islands'),(64,94,'description',2,'Ilhas Heard e McDonald'),(64,95,'description',1,'Honduras'),(64,95,'description',2,'Honduras'),(64,96,'description',1,'Hong Kong SAR'),(64,96,'description',2,'Hong Kong SAR'),(64,97,'description',1,'Hungary'),(64,97,'description',2,'Hungria'),(64,98,'description',1,'Iceland'),(64,98,'description',2,'Isl�ndia'),(64,99,'description',1,'India'),(64,99,'description',2,'�ndia'),(64,100,'description',1,'Indonesia'),(64,100,'description',2,'Indon�sia'),(64,101,'description',1,'Iran'),(64,101,'description',2,'Ir�o'),(64,102,'description',1,'Iraq'),(64,102,'description',2,'Iraque'),(64,103,'description',1,'Ireland'),(64,103,'description',2,'Irlanda'),(64,104,'description',1,'Israel'),(64,104,'description',2,'Israel'),(64,105,'description',1,'Italy'),(64,105,'description',2,'It�lia'),(64,106,'description',1,'Jamaica'),(64,106,'description',2,'Jamaica'),(64,107,'description',1,'Japan'),(64,107,'description',2,'Jap�o'),(64,108,'description',1,'Jordan'),(64,108,'description',2,'Jord�nia'),(64,109,'description',1,'Kazakhstan'),(64,109,'description',2,'Kazaquist�o'),(64,110,'description',1,'Kenya'),(64,110,'description',2,'K�nia'),(64,111,'description',1,'Kiribati'),(64,111,'description',2,'Kiribati'),(64,112,'description',1,'Korea'),(64,112,'description',2,'Coreia'),(64,113,'description',1,'Kuwait'),(64,113,'description',2,'Kuwait'),(64,114,'description',1,'Kyrgyzstan'),(64,114,'description',2,'Kirgist�o'),(64,115,'description',1,'Laos'),(64,115,'description',2,'Laos'),(64,116,'description',1,'Latvia'),(64,116,'description',2,'Latvia'),(64,117,'description',1,'Lebanon'),(64,117,'description',2,'L�bano'),(64,118,'description',1,'Lesotho'),(64,118,'description',2,'Lesoto'),(64,119,'description',1,'Liberia'),(64,119,'description',2,'Lib�ria'),(64,120,'description',1,'Libya'),(64,120,'description',2,'L�bia'),(64,121,'description',1,'Liechtenstein'),(64,121,'description',2,'Liechtenstein'),(64,122,'description',1,'Lithuania'),(64,122,'description',2,'Litu�nia'),(64,123,'description',1,'Luxembourg'),(64,123,'description',2,'Luxemburgo'),(64,124,'description',1,'Macao SAR'),(64,124,'description',2,'Macau SAR'),(64,125,'description',1,'Macedonia, Former Yugoslav Republic of'),(64,125,'description',2,'Maced�nia, Antiga Rep�blica Jugoslava da'),(64,126,'description',1,'Madagascar'),(64,126,'description',2,'Madag�scar'),(64,127,'description',1,'Malawi'),(64,127,'description',2,'Malaui'),(64,128,'description',1,'Malaysia'),(64,128,'description',2,'Mal�sia'),(64,129,'description',1,'Maldives'),(64,129,'description',2,'Maldivas'),(64,130,'description',1,'Mali'),(64,130,'description',2,'Mali'),(64,131,'description',1,'Malta'),(64,131,'description',2,'Malta'),(64,132,'description',1,'Marshall Islands'),(64,132,'description',2,'Ilhas Marshall'),(64,133,'description',1,'Martinique'),(64,133,'description',2,'Martinica'),(64,134,'description',1,'Mauritania'),(64,134,'description',2,'Maurit�nia'),(64,135,'description',1,'Mauritius'),(64,135,'description',2,'Maur�cias'),(64,136,'description',1,'Mayotte'),(64,136,'description',2,'Maiote'),(64,137,'description',1,'Mexico'),(64,137,'description',2,'M�xico'),(64,138,'description',1,'Micronesia'),(64,138,'description',2,'Micron�sia'),(64,139,'description',1,'Moldova'),(64,139,'description',2,'Moldova'),(64,140,'description',1,'Monaco'),(64,140,'description',2,'M�naco'),(64,141,'description',1,'Mongolia'),(64,141,'description',2,'Mong�lia'),(64,142,'description',1,'Montserrat'),(64,142,'description',2,'Monserrate'),(64,143,'description',1,'Morocco'),(64,143,'description',2,'Marrocos'),(64,144,'description',1,'Mozambique'),(64,144,'description',2,'Mo�ambique'),(64,145,'description',1,'Myanmar'),(64,145,'description',2,'Mianmar'),(64,146,'description',1,'Namibia'),(64,146,'description',2,'Nam�bia'),(64,147,'description',1,'Nauru'),(64,147,'description',2,'Nauru'),(64,148,'description',1,'Nepal'),(64,148,'description',2,'Nepal'),(64,149,'description',1,'Netherlands'),(64,149,'description',2,'Holanda'),(64,150,'description',1,'Netherlands Antilles'),(64,150,'description',2,'Antilhas Holandesas'),(64,151,'description',1,'New Caledonia'),(64,151,'description',2,'Nova Caled�nia'),(64,152,'description',1,'New Zealand'),(64,152,'description',2,'Nova Zel�ndia'),(64,153,'description',1,'Nicaragua'),(64,153,'description',2,'Nicar�gua'),(64,154,'description',1,'Niger'),(64,154,'description',2,'Niger'),(64,155,'description',1,'Nigeria'),(64,155,'description',2,'Nig�ria'),(64,156,'description',1,'Niue'),(64,156,'description',2,'Niue'),(64,157,'description',1,'Norfolk Island'),(64,157,'description',2,'Ilhas Norfolk'),(64,158,'description',1,'North Korea'),(64,158,'description',2,'Coreia do Norte'),(64,159,'description',1,'Northern Mariana Islands'),(64,159,'description',2,'Ilhas Mariana do Norte'),(64,160,'description',1,'Norway'),(64,160,'description',2,'Noruega'),(64,161,'description',1,'Oman'),(64,161,'description',2,'Oman'),(64,162,'description',1,'Pakistan'),(64,162,'description',2,'Pakist�o'),(64,163,'description',1,'Palau'),(64,163,'description',2,'Palau'),(64,164,'description',1,'Panama'),(64,164,'description',2,'Panama'),(64,165,'description',1,'Papua New Guinea'),(64,165,'description',2,'Papua Nova Guin�'),(64,166,'description',1,'Paraguay'),(64,166,'description',2,'Paraguai'),(64,167,'description',1,'Peru'),(64,167,'description',2,'Per�'),(64,168,'description',1,'Philippines'),(64,168,'description',2,'Filipinas'),(64,169,'description',1,'Pitcairn Islands'),(64,169,'description',2,'Ilhas Pitcairn'),(64,170,'description',1,'Poland'),(64,170,'description',2,'Pol�nia'),(64,171,'description',1,'Portugal'),(64,171,'description',2,'Portugal'),(64,172,'description',1,'Puerto Rico'),(64,172,'description',2,'Porto Rico'),(64,173,'description',1,'Qatar'),(64,173,'description',2,'Qatar'),(64,174,'description',1,'Reunion'),(64,174,'description',2,'Reuni�o'),(64,175,'description',1,'Romania'),(64,175,'description',2,'Rom�nia'),(64,176,'description',1,'Russia'),(64,176,'description',2,'R�ssia'),(64,177,'description',1,'Rwanda'),(64,177,'description',2,'Rwanda'),(64,178,'description',1,'Samoa'),(64,178,'description',2,'Samoa'),(64,179,'description',1,'San Marino'),(64,179,'description',2,'S�o Marino'),(64,180,'description',1,'Sao Tome and Principe'),(64,180,'description',2,'S�o Tom� e Princepe'),(64,181,'description',1,'Saudi Arabia'),(64,181,'description',2,'Ar�bia Saudita'),(64,182,'description',1,'Senegal'),(64,182,'description',2,'Senegal'),(64,183,'description',1,'Serbia and Montenegro'),(64,183,'description',2,'S�rvia e Montenegro'),(64,184,'description',1,'Seychelles'),(64,184,'description',2,'Seychelles'),(64,185,'description',1,'Sierra Leone'),(64,185,'description',2,'Serra Leoa'),(64,186,'description',1,'Singapore'),(64,186,'description',2,'Singapure'),(64,187,'description',1,'Slovakia'),(64,187,'description',2,'Eslov�quia'),(64,188,'description',1,'Slovenia'),(64,188,'description',2,'Eslov�nia'),(64,189,'description',1,'Solomon Islands'),(64,189,'description',2,'Ilhas Salom�o'),(64,190,'description',1,'Somalia'),(64,190,'description',2,'Som�lia'),(64,191,'description',1,'South Africa'),(64,191,'description',2,'�frica do Sul'),(64,192,'description',1,'South Georgia and the South Sandwich Islands'),(64,192,'description',2,'Georgia do Sul e Ilhas Sandwich South'),(64,193,'description',1,'Spain'),(64,193,'description',2,'Espanha'),(64,194,'description',1,'Sri Lanka'),(64,194,'description',2,'Sri Lanka'),(64,195,'description',1,'St. Helena'),(64,195,'description',2,'Sta. Helena'),(64,196,'description',1,'St. Kitts and Nevis'),(64,196,'description',2,'Sta. Kitts e Nevis'),(64,197,'description',1,'St. Lucia'),(64,197,'description',2,'Sta. Lucia'),(64,198,'description',1,'St. Pierre and Miquelon'),(64,198,'description',2,'Sta. Pierre e Miquelon'),(64,199,'description',1,'St. Vincent and the Grenadines'),(64,199,'description',2,'Sto. Vicente e Grenadines'),(64,200,'description',1,'Sudan'),(64,200,'description',2,'Sud�o'),(64,201,'description',1,'Suriname'),(64,201,'description',2,'Suriname'),(64,202,'description',1,'Svalbard and Jan Mayen'),(64,202,'description',2,'Svalbard e Jan Mayen'),(64,203,'description',1,'Swaziland'),(64,203,'description',2,'Swazil�ndia'),(64,204,'description',1,'Sweden'),(64,204,'description',2,'Su�cia'),(64,205,'description',1,'Switzerland'),(64,205,'description',2,'Su��a'),(64,206,'description',1,'Syria'),(64,206,'description',2,'S�ria'),(64,207,'description',1,'Taiwan'),(64,207,'description',2,'Taiwan'),(64,208,'description',1,'Tajikistan'),(64,208,'description',2,'Tajikist�o'),(64,209,'description',1,'Tanzania'),(64,209,'description',2,'Tanz�nia'),(64,210,'description',1,'Thailand'),(64,210,'description',2,'Thail�ndia'),(64,211,'description',1,'Togo'),(64,211,'description',2,'Togo'),(64,212,'description',1,'Tokelau'),(64,212,'description',2,'Tokelau'),(64,213,'description',1,'Tonga'),(64,213,'description',2,'Tonga'),(64,214,'description',1,'Trinidad and Tobago'),(64,214,'description',2,'Trinidade e Tobago'),(64,215,'description',1,'Tunisia'),(64,215,'description',2,'Tun�sia'),(64,216,'description',1,'Turkey'),(64,216,'description',2,'Turquia'),(64,217,'description',1,'Turkmenistan'),(64,217,'description',2,'Turkmenist�o'),(64,218,'description',1,'Turks and Caicos Islands'),(64,218,'description',2,'Ilhas Turks e Caicos'),(64,219,'description',1,'Tuvalu'),(64,219,'description',2,'Tuvalu'),(64,220,'description',1,'Uganda'),(64,220,'description',2,'Uganda'),(64,221,'description',1,'Ukraine'),(64,221,'description',2,'Ucr�nia'),(64,222,'description',1,'United Arab Emirates'),(64,222,'description',2,'Emiados �rabes Unidos'),(64,223,'description',1,'United Kingdom'),(64,223,'description',2,'Reino Unido'),(64,224,'description',1,'United States'),(64,224,'description',2,'Estados Unidos'),(64,225,'description',1,'United States Minor Outlying Islands'),(64,225,'description',2,'Estados Unidos e Ilhas Menores Circundantes'),(64,226,'description',1,'Uruguay'),(64,226,'description',2,'Uruguai'),(64,227,'description',1,'Uzbekistan'),(64,227,'description',2,'Uzbekist�o'),(64,228,'description',1,'Vanuatu'),(64,228,'description',2,'Vanuatu'),(64,229,'description',1,'Vatican City'),(64,229,'description',2,'Cidade do Vaticano'),(64,230,'description',1,'Venezuela'),(64,230,'description',2,'Venezuela'),(64,231,'description',1,'Viet Nam'),(64,231,'description',2,'Vietname'),(64,232,'description',1,'Virgin Islands - British'),(64,232,'description',2,'Ilhas Virgens Brit�nicas'),(64,233,'description',1,'Virgin Islands'),(64,233,'description',2,'Ilhas Virgens'),(64,234,'description',1,'Wallis and Futuna'),(64,234,'description',2,'Wallis and Futuna'),(64,235,'description',1,'Yemen'),(64,235,'description',2,'Yemen'),(64,236,'description',1,'Zambia'),(64,236,'description',2,'Z�mbia'),(64,237,'description',1,'Zimbabwe'),(64,237,'description',2,'Zimbabwe'),(69,100,'welcome_message',1,'<div> <br/> <p style=font-size:19px; font-weight: bold;>Welcome to [COMTalk] Billing!</p> <br/> <p style=font-size:14px; text-align=left; padding-left: 15;>From here, you can review your latest invoice and get it paid instantly. You can also view all your previous invoices and payments, and set up the system for automatic payment with your credit card.</p> <p style=font-size:14px; text-align=left; padding-left: 15;>What would you like to do today? </p> <ul style=font-size:13px; text-align=left; padding-left: 25;> <li >To submit a credit card payment, follow the link on the left bar.</li> <li >To view a list of your invoices, click on the ï¿½Invoicesï¿½ menu option. The first invoice on the list is your latest invoice. Click on it to see its details.</li> <li>To view a list of your payments, click on the ï¿½Paymentsï¿½ menu option. The first payment on the list is your latest payment. Click on it to see its details.</li> <li>To provide a credit card to enable automatic payment, click on the menu option Account, and then on Edit Credit Card.</li> </ul> </div>'),(81,1,'description',1,'Active'),(81,2,'description',1,'Pending Unsubscription'),(81,3,'description',1,'Unsubscribed'),(81,4,'description',1,'Pending Expiration'),(81,5,'description',1,'Expired'),(81,6,'description',1,'Nonsubscriber'),(81,7,'description',1,'Discontinued'),(88,1,'description',1,'Active'),(88,2,'description',1,'Inactive'),(88,3,'description',1,'Pending Active'),(88,4,'description',1,'Pending Inactive'),(88,5,'description',1,'Failed'),(88,6,'description',1,'Unavailable'),(89,1,'description',1,'None'),(89,2,'description',1,'Pre-paid balance'),(89,3,'description',1,'Credit limit'),(90,1,'description',1,'Paid'),(90,2,'description',1,'Unpaid'),(90,3,'description',1,'Carried'),(91,1,'description',1,'Done and billable'),(91,2,'description',1,'Done and not billable'),(91,3,'description',1,'Error detected'),(91,4,'description',1,'Error declared'),(92,1,'description',1,'Running'),(92,2,'description',1,'Finished: successful'),(92,3,'description',1,'Finished: failed'),(100,1,'description',1,'Total amount invoiced grouped by period.'),(100,2,'description',1,'Detailed balance ageing report. Shows the age of outstanding customer balances.'),(100,3,'description',1,'Number of users subscribed to a specific product.'),(100,4,'description',1,'Total payment amount received grouped by period.'),(100,5,'description',1,'Number of customers created within a period.'),(100,6,'description',1,'Total revenue (sum of received payments) per customer.'),(100,7,'description',1,'Simple accounts receivable report showing current account balances.'),(100,8,'description',1,'General ledger details of all invoiced charges for the given day.'),(100,9,'description',1,'General ledger summary of all invoiced charges for the given day, grouped by item type.'),(100,10,'description',1,'Plan pricing history for all plan products and start dates.'),(100,11,'description',1,'Total invoiced per customer grouped by product category.'),(100,12,'description',1,'Total invoiced per customer over years grouped by year.'),(101,1,'description',1,'Invoice Reports'),(101,2,'description',1,'Order Reports'),(101,3,'description',1,'Payment Reports'),(101,4,'description',1,'Customer Reports'),(104,1,'description',1,'Invoices'),(104,2,'description',1,'Orders'),(104,3,'description',1,'Payments'),(104,4,'description',1,'Users');
/*!40000 ALTER TABLE `international_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `billing_process_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `delegated_invoice_id` int(11) DEFAULT NULL,
  `due_date` datetime NOT NULL,
  `total` decimal(22,10) NOT NULL,
  `payment_attempts` int(11) NOT NULL DEFAULT '0',
  `balance` decimal(22,10) DEFAULT NULL,
  `carried_balance` decimal(22,10) NOT NULL,
  `in_process_payment` smallint(6) NOT NULL DEFAULT '1',
  `is_review` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `paper_invoice_batch_id` int(11) DEFAULT NULL,
  `customer_notes` varchar(1000) DEFAULT NULL,
  `public_number` varchar(40) DEFAULT NULL,
  `last_reminder` datetime DEFAULT NULL,
  `overdue_step` int(11) DEFAULT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_invoice_user_id` (`user_id`,`deleted`),
  KEY `ix_invoice_date` (`create_datetime`),
  KEY `ix_invoice_number` (`user_id`,`public_number`),
  KEY `ix_invoice_due_date` (`user_id`,`due_date`),
  KEY `ix_invoice_ts` (`create_timestamp`,`user_id`),
  KEY `ix_invoice_process` (`billing_process_id`),
  KEY `invoice_FK_2` (`paper_invoice_batch_id`),
  KEY `invoice_FK_3` (`currency_id`),
  KEY `invoice_FK_4` (`delegated_invoice_id`),
  KEY `invoice_FK_5` (`status_id`),
  CONSTRAINT `invoice_FK_5` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `invoice_FK_1` FOREIGN KEY (`billing_process_id`) REFERENCES `billing_process` (`id`),
  CONSTRAINT `invoice_FK_2` FOREIGN KEY (`paper_invoice_batch_id`) REFERENCES `paper_invoice_batch` (`id`),
  CONSTRAINT `invoice_FK_3` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `invoice_FK_4` FOREIGN KEY (`delegated_invoice_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_delivery_method`
--

DROP TABLE IF EXISTS `invoice_delivery_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_delivery_method` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_delivery_method`
--

LOCK TABLES `invoice_delivery_method` WRITE;
/*!40000 ALTER TABLE `invoice_delivery_method` DISABLE KEYS */;
INSERT INTO `invoice_delivery_method` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `invoice_delivery_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_line`
--

DROP TABLE IF EXISTS `invoice_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_line` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `amount` decimal(22,10) NOT NULL,
  `quantity` decimal(22,10) DEFAULT NULL,
  `price` decimal(22,10) DEFAULT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `item_id` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `source_user_id` int(11) DEFAULT NULL,
  `is_percentage` smallint(6) NOT NULL DEFAULT '0',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_invoice_line_invoice_id` (`invoice_id`),
  KEY `invoice_line_FK_2` (`item_id`),
  KEY `invoice_line_FK_3` (`type_id`),
  CONSTRAINT `invoice_line_FK_3` FOREIGN KEY (`type_id`) REFERENCES `invoice_line_type` (`id`),
  CONSTRAINT `invoice_line_FK_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `invoice_line_FK_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_line`
--

LOCK TABLES `invoice_line` WRITE;
/*!40000 ALTER TABLE `invoice_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_line_type`
--

DROP TABLE IF EXISTS `invoice_line_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_line_type` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  `order_position` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_line_type`
--

LOCK TABLES `invoice_line_type` WRITE;
/*!40000 ALTER TABLE `invoice_line_type` DISABLE KEYS */;
INSERT INTO `invoice_line_type` VALUES (1,'item recurring',2),(2,'tax',6),(3,'due invoice',1),(4,'interests',4),(5,'sub account',5),(6,'item one-time',3);
/*!40000 ALTER TABLE `invoice_line_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_meta_field_map`
--

DROP TABLE IF EXISTS `invoice_meta_field_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_meta_field_map` (
  `invoice_id` int(11) NOT NULL,
  `meta_field_value_id` int(11) NOT NULL,
  KEY `invoice_meta_field_map_FK_1` (`invoice_id`),
  KEY `invoice_meta_field_map_FK_2` (`meta_field_value_id`),
  CONSTRAINT `invoice_meta_field_map_FK_2` FOREIGN KEY (`meta_field_value_id`) REFERENCES `meta_field_value` (`id`),
  CONSTRAINT `invoice_meta_field_map_FK_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_meta_field_map`
--

LOCK TABLES `invoice_meta_field_map` WRITE;
/*!40000 ALTER TABLE `invoice_meta_field_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_meta_field_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `internal_number` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `percentage` decimal(22,10) DEFAULT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `has_decimals` smallint(6) NOT NULL DEFAULT '0',
  `gl_code` varchar(50) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_item_ent` (`entity_id`,`internal_number`),
  CONSTRAINT `item_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_meta_field_map`
--

DROP TABLE IF EXISTS `item_meta_field_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_meta_field_map` (
  `item_id` int(11) NOT NULL,
  `meta_field_value_id` int(11) NOT NULL,
  KEY `item_meta_field_map_FK_1` (`item_id`),
  KEY `item_meta_field_map_FK_2` (`meta_field_value_id`),
  CONSTRAINT `item_meta_field_map_FK_2` FOREIGN KEY (`meta_field_value_id`) REFERENCES `meta_field_value` (`id`),
  CONSTRAINT `item_meta_field_map_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_meta_field_map`
--

LOCK TABLES `item_meta_field_map` WRITE;
/*!40000 ALTER TABLE `item_meta_field_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_meta_field_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_price_timeline`
--

DROP TABLE IF EXISTS `item_price_timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_price_timeline` (
  `item_id` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `price_model_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`,`start_date`),
  UNIQUE KEY `price_model_id` (`price_model_id`),
  CONSTRAINT `item_price_timeline_FK_2` FOREIGN KEY (`price_model_id`) REFERENCES `price_model` (`id`),
  CONSTRAINT `item_price_timeline_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_price_timeline`
--

LOCK TABLES `item_price_timeline` WRITE;
/*!40000 ALTER TABLE `item_price_timeline` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_price_timeline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_type`
--

DROP TABLE IF EXISTS `item_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_type` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `internal` bit(1) NOT NULL,
  `order_line_type_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `item_type_FK_1` (`entity_id`),
  CONSTRAINT `item_type_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_type`
--

LOCK TABLES `item_type` WRITE;
/*!40000 ALTER TABLE `item_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_type_exclude_map`
--

DROP TABLE IF EXISTS `item_type_exclude_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_type_exclude_map` (
  `item_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  KEY `item_type_exclude_map_FK_1` (`item_id`),
  KEY `item_type_exclude_map_FK_2` (`type_id`),
  CONSTRAINT `item_type_exclude_map_FK_2` FOREIGN KEY (`type_id`) REFERENCES `item_type` (`id`),
  CONSTRAINT `item_type_exclude_map_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_type_exclude_map`
--

LOCK TABLES `item_type_exclude_map` WRITE;
/*!40000 ALTER TABLE `item_type_exclude_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_type_exclude_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_type_map`
--

DROP TABLE IF EXISTS `item_type_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_type_map` (
  `item_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  KEY `item_type_map_FK_1` (`item_id`),
  KEY `item_type_map_FK_2` (`type_id`),
  CONSTRAINT `item_type_map_FK_2` FOREIGN KEY (`type_id`) REFERENCES `item_type` (`id`),
  CONSTRAINT `item_type_map_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_type_map`
--

LOCK TABLES `item_type_map` WRITE;
/*!40000 ALTER TABLE `item_type_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_type_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbilling_seqs`
--

DROP TABLE IF EXISTS `jbilling_seqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jbilling_seqs` (
  `name` varchar(50) NOT NULL,
  `next_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jbilling_seqs`
--

LOCK TABLES `jbilling_seqs` WRITE;
/*!40000 ALTER TABLE `jbilling_seqs` DISABLE KEYS */;
INSERT INTO `jbilling_seqs` VALUES ('enumeration',1),('enumeration_values',1),('entity_delivery_method_map',4),('contact_field_type',10),('user_role_map',13),('entity_payment_method_map',26),('currency_entity_map',10),('user_credit_card_map',5),('permission_role_map',1),('permission_user',1),('contact_map',6781),('permission_type',9),('period_unit',5),('invoice_delivery_method',4),('user_status',9),('order_line_type',4),('order_billing_type',3),('order_status',5),('pluggable_task_type_category',22),('pluggable_task_type',91),('invoice_line_type',6),('currency',11),('payment_method',9),('payment_result',5),('event_log_module',10),('event_log_message',17),('preference_type',37),('notification_message_type',20),('role',7),('country',238),('permission',120),('currency_exchange',25),('pluggable_task_parameter',2),('billing_process_configuration',2),('order_period',3),('partner_range',1),('item_price',1),('partner',1),('entity',2),('contact_type',3),('promotion',1),('pluggable_task',3),('ach',1),('payment_info_cheque',1),('partner_payout',1),('process_run_total_pm',1),('payment_authorization',1),('billing_process',1),('process_run',1),('process_run_total',1),('paper_invoice_batch',1),('preference',2),('notification_message',2),('notification_message_section',2),('notification_message_line',2),('ageing_entity_step',2),('item_type',1),('item',1),('event_log',1),('purchase_order',1),('order_line',1),('invoice',1),('invoice_line',1),('order_process',1),('payment',1),('notification_message_arch',1),('notification_message_arch_line',1),('base_user',2),('customer',1),('contact',2),('contact_field',1),('credit_card',1),('language',2),('payment_invoice',1),('subscriber_status',7),('mediation_cfg',1),('mediation_process',1),('blacklist',1),('mediation_record_line',1),('generic_status',26),('order_line_provisioning_status',1),('balance_type',0),('mediation_record',0),('price_model',0),('price_model_attribute',0),('plan',0),('plan_item',0),('filter',0),('filter_set',0),('recent_item',0),('breadcrumb',5),('shortcut',0),('report',0),('report_type',0),('report_parameter',0),('plan_item_bundle',0);
/*!40000 ALTER TABLE `jbilling_seqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbilling_table`
--

DROP TABLE IF EXISTS `jbilling_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jbilling_table` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jbilling_table`
--

LOCK TABLES `jbilling_table` WRITE;
/*!40000 ALTER TABLE `jbilling_table` DISABLE KEYS */;
INSERT INTO `jbilling_table` VALUES (3,'language'),(4,'currency'),(5,'entity'),(6,'period_unit'),(7,'invoice_delivery_method'),(8,'entity_delivery_method_map'),(9,'user_status'),(10,'base_user'),(11,'partner'),(12,'customer'),(13,'item_type'),(14,'item'),(15,'item_price'),(17,'order_period'),(18,'order_line_type'),(19,'order_billing_type'),(20,'order_status'),(21,'purchase_order'),(22,'order_line'),(23,'pluggable_task_type_category'),(24,'pluggable_task_type'),(25,'pluggable_task'),(26,'pluggable_task_parameter'),(27,'contact'),(28,'contact_type'),(29,'contact_map'),(30,'invoice_line_type'),(31,'paper_invoice_batch'),(32,'billing_process'),(33,'process_run'),(34,'billing_process_configuration'),(35,'payment_method'),(36,'entity_payment_method_map'),(37,'process_run_total'),(38,'process_run_total_pm'),(39,'invoice'),(40,'invoice_line'),(41,'payment_result'),(42,'payment'),(43,'payment_info_cheque'),(44,'credit_card'),(45,'user_credit_card_map'),(46,'event_log_module'),(47,'event_log_message'),(48,'event_log'),(49,'order_process'),(50,'preference_type'),(51,'preference'),(52,'notification_message_type'),(53,'notification_message'),(54,'notification_message_section'),(55,'notification_message_line'),(56,'notification_message_arch'),(57,'notification_message_arch_line'),(58,'permission_type'),(59,'permission'),(60,'role'),(61,'permission_role_map'),(62,'user_role_map'),(64,'country'),(65,'promotion'),(66,'payment_authorization'),(67,'currency_exchange'),(68,'currency_entity_map'),(69,'ageing_entity_step'),(70,'partner_payout'),(75,'ach'),(76,'contact_field'),(79,'partner_range'),(80,'payment_invoice'),(81,'subscriber_status'),(82,'mediation_cfg'),(83,'mediation_process'),(85,'blacklist'),(86,'mediation_record_line'),(87,'generic_status'),(88,'order_line_provisioning_status'),(89,'balance_type'),(90,'invoice_status'),(91,'mediation_record_status'),(92,'process_run_status'),(95,'plan'),(96,'plan_item'),(97,'customer_price'),(99,'contact_field_type'),(100,'report'),(101,'report_type'),(102,'report_parameter'),(103,'plan_item_bundle'),(104,'notification_category'),(105,'enumeration'),(106,'enumeration_values');
/*!40000 ALTER TABLE `jbilling_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `id` int(11) NOT NULL,
  `code` varchar(2) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'en','English'),(2,'pt','Portugu�s');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_meta_field_values`
--

DROP TABLE IF EXISTS `list_meta_field_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list_meta_field_values` (
  `meta_field_value_id` int(11) NOT NULL,
  `list_value` varchar(255) DEFAULT NULL,
  KEY `list_meta_field_values_FK_1` (`meta_field_value_id`),
  CONSTRAINT `list_meta_field_values_FK_1` FOREIGN KEY (`meta_field_value_id`) REFERENCES `meta_field_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_meta_field_values`
--

LOCK TABLES `list_meta_field_values` WRITE;
/*!40000 ALTER TABLE `list_meta_field_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_meta_field_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediation_cfg`
--

DROP TABLE IF EXISTS `mediation_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mediation_cfg` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(50) NOT NULL,
  `order_value` int(11) NOT NULL,
  `pluggable_task_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mediation_cfg_FK_1` (`pluggable_task_id`),
  CONSTRAINT `mediation_cfg_FK_1` FOREIGN KEY (`pluggable_task_id`) REFERENCES `pluggable_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediation_cfg`
--

LOCK TABLES `mediation_cfg` WRITE;
/*!40000 ALTER TABLE `mediation_cfg` DISABLE KEYS */;
/*!40000 ALTER TABLE `mediation_cfg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediation_order_map`
--

DROP TABLE IF EXISTS `mediation_order_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mediation_order_map` (
  `mediation_process_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  KEY `mediation_order_map_FK_1` (`mediation_process_id`),
  KEY `mediation_order_map_FK_2` (`order_id`),
  CONSTRAINT `mediation_order_map_FK_2` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `mediation_order_map_FK_1` FOREIGN KEY (`mediation_process_id`) REFERENCES `mediation_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediation_order_map`
--

LOCK TABLES `mediation_order_map` WRITE;
/*!40000 ALTER TABLE `mediation_order_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `mediation_order_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediation_process`
--

DROP TABLE IF EXISTS `mediation_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mediation_process` (
  `id` int(11) NOT NULL,
  `configuration_id` int(11) NOT NULL,
  `start_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `orders_affected` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mediation_process_FK_1` (`configuration_id`),
  CONSTRAINT `mediation_process_FK_1` FOREIGN KEY (`configuration_id`) REFERENCES `mediation_cfg` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediation_process`
--

LOCK TABLES `mediation_process` WRITE;
/*!40000 ALTER TABLE `mediation_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `mediation_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediation_record`
--

DROP TABLE IF EXISTS `mediation_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mediation_record` (
  `id` int(11) NOT NULL,
  `id_key` varchar(100) NOT NULL,
  `start_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mediation_process_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mediation_record_i` (`id`,`status_id`),
  KEY `mediation_record_FK_1` (`mediation_process_id`),
  KEY `mediation_record_FK_2` (`status_id`),
  CONSTRAINT `mediation_record_FK_2` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `mediation_record_FK_1` FOREIGN KEY (`mediation_process_id`) REFERENCES `mediation_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediation_record`
--

LOCK TABLES `mediation_record` WRITE;
/*!40000 ALTER TABLE `mediation_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `mediation_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediation_record_line`
--

DROP TABLE IF EXISTS `mediation_record_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mediation_record_line` (
  `id` int(11) NOT NULL,
  `mediation_record_id` int(11) NOT NULL,
  `order_line_id` int(11) NOT NULL,
  `event_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `amount` decimal(22,10) NOT NULL,
  `quantity` decimal(22,10) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_mrl_order_line` (`order_line_id`),
  KEY `mediation_record_line_FK_1` (`mediation_record_id`),
  CONSTRAINT `mediation_record_line_FK_2` FOREIGN KEY (`order_line_id`) REFERENCES `order_line` (`id`),
  CONSTRAINT `mediation_record_line_FK_1` FOREIGN KEY (`mediation_record_id`) REFERENCES `mediation_record` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediation_record_line`
--

LOCK TABLES `mediation_record_line` WRITE;
/*!40000 ALTER TABLE `mediation_record_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `mediation_record_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_field_name`
--

DROP TABLE IF EXISTS `meta_field_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meta_field_name` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `entity_type` varchar(25) NOT NULL,
  `data_type` varchar(25) NOT NULL,
  `is_disabled` bit(1) DEFAULT NULL,
  `is_mandatory` bit(1) DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL,
  `default_value_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `meta_field_name_FK_1` (`default_value_id`),
  KEY `meta_field_name_FK_2` (`entity_id`),
  CONSTRAINT `meta_field_name_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `meta_field_name_FK_1` FOREIGN KEY (`default_value_id`) REFERENCES `meta_field_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_field_name`
--

LOCK TABLES `meta_field_name` WRITE;
/*!40000 ALTER TABLE `meta_field_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `meta_field_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_field_value`
--

DROP TABLE IF EXISTS `meta_field_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meta_field_value` (
  `id` int(11) NOT NULL,
  `meta_field_name_id` int(11) NOT NULL,
  `dtype` varchar(10) NOT NULL,
  `boolean_value` bit(1) DEFAULT NULL,
  `date_value` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `decimal_value` decimal(22,10) DEFAULT NULL,
  `integer_value` int(11) DEFAULT NULL,
  `string_value` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meta_field_value_FK_1` (`meta_field_name_id`),
  CONSTRAINT `meta_field_value_FK_1` FOREIGN KEY (`meta_field_name_id`) REFERENCES `meta_field_name` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_field_value`
--

LOCK TABLES `meta_field_value` WRITE;
/*!40000 ALTER TABLE `meta_field_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `meta_field_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_category`
--

DROP TABLE IF EXISTS `notification_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_category` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_category`
--

LOCK TABLES `notification_category` WRITE;
/*!40000 ALTER TABLE `notification_category` DISABLE KEYS */;
INSERT INTO `notification_category` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `notification_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_message`
--

DROP TABLE IF EXISTS `notification_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_message` (
  `id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `entity_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `use_flag` smallint(6) NOT NULL DEFAULT '1',
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_message_FK_1` (`language_id`),
  KEY `notification_message_FK_2` (`type_id`),
  KEY `notification_message_FK_3` (`entity_id`),
  CONSTRAINT `notification_message_FK_3` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `notification_message_FK_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `notification_message_FK_2` FOREIGN KEY (`type_id`) REFERENCES `notification_message_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_message`
--

LOCK TABLES `notification_message` WRITE;
/*!40000 ALTER TABLE `notification_message` DISABLE KEYS */;
INSERT INTO `notification_message` VALUES (100,1,10,1,1,0),(101,2,10,1,1,0),(102,3,10,1,1,0),(103,13,10,1,1,0),(104,16,10,1,1,0),(105,17,10,1,1,0),(106,18,10,1,1,0),(107,19,10,1,1,0);
/*!40000 ALTER TABLE `notification_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_message_arch`
--

DROP TABLE IF EXISTS `notification_message_arch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_message_arch` (
  `id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `result_message` varchar(200) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_message_arch`
--

LOCK TABLES `notification_message_arch` WRITE;
/*!40000 ALTER TABLE `notification_message_arch` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_message_arch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_message_arch_line`
--

DROP TABLE IF EXISTS `notification_message_arch_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_message_arch_line` (
  `id` int(11) NOT NULL,
  `message_archive_id` int(11) DEFAULT NULL,
  `section` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notif_mess_arch_line_FK_1` (`message_archive_id`),
  CONSTRAINT `notif_mess_arch_line_FK_1` FOREIGN KEY (`message_archive_id`) REFERENCES `notification_message_arch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_message_arch_line`
--

LOCK TABLES `notification_message_arch_line` WRITE;
/*!40000 ALTER TABLE `notification_message_arch_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_message_arch_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_message_line`
--

DROP TABLE IF EXISTS `notification_message_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_message_line` (
  `id` int(11) NOT NULL,
  `message_section_id` int(11) DEFAULT NULL,
  `content` varchar(1000) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_message_line_FK_1` (`message_section_id`),
  CONSTRAINT `notification_message_line_FK_1` FOREIGN KEY (`message_section_id`) REFERENCES `notification_message_section` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_message_line`
--

LOCK TABLES `notification_message_line` WRITE;
/*!40000 ALTER TABLE `notification_message_line` DISABLE KEYS */;
INSERT INTO `notification_message_line` VALUES (100,NULL,'Dear $first_name $last_name,\n\n This is to notify you that your latest invoice (number $number) is now available. The total amount due is: $total. You can view it by login in to:\n\n\" + Util.getSysProp(\"url\") + \"/billing/user/login.jsp?entityId=$company_id\n\nFor security reasons, your statement is password protected.\nTo login in, you will need your user name: $username and your account password: $password\n \n After logging in, please click on the menu option  ï¿½Listï¿½, to see all your invoices.  You can also see your payment history, your current purchase orders, as well as update your payment information and submit online payments.\n\n\nThank you for choosing $company_name, we appreciate your business,\n\nBilling Department\n$company_name',0),(101,101,'Billing Statement from $company_name',0),(102,NULL,'Dear $first_name $last_name,\n\n  This email is to notify you that we have received your latest payment and your account no longer has an overdue balance.\n\n  Thank you for keeping your account up to date,\n\n\nBilling Department\n$company_name',0),(103,103,'You account is now up to date',0),(104,NULL,'Dear $first_name $last_name,\n\nOur records show that you have an overdue balance on your account. Please submit a payment as soon as possible.\n\nBest regards,\n\nBilling Department\n$company_name',0),(105,105,'Overdue Balance',0),(106,NULL,'Dear $first_name $last_name,\n\nYour service with us will expire on $period_end. Please make sure to contact customer service for a renewal.\n\nRegards,\n\nBilling Department\n$company_name',0),(107,107,'Your service from $company_name is about to expire',0),(108,NULL,'Dear $first_name $last_name\n\n   We have received your payment made with $method for a total of $total.\n\n   Thank you, we appreciate your business,\n\nBilling Department\n$company_name',0),(109,109,'Thank you for your payment',0),(110,110,'Payment failed',0),(111,NULL,'Dear $first_name $last_name\n\n   A payment with $method was attempted for a total of $total, but it has been rejected by the payment processor.\nYou can update your payment information and submit an online payment by login into :\n\" + Util.getSysProp(\"url\") + \"/billing/user/login.jsp?entityId=$company_id\n\nFor security reasons, your statement is password protected.\nTo login in, you will need your user name: $username and your account password: $password\n\nThank you,\n\nBilling Department\n$company_name',0),(112,112,'Invoice remainder',0),(113,NULL,'Dear $first_name $last_name\n\n   This is a reminder that the invoice number $number remains unpaid. It was sent to you on $date, and its total is $total. Although you still have $days days to pay it (its due date is $dueDate), we would greatly appreciate if you can pay it at your earliest convenience.\n\nYours truly,\n\nBilling Department\n$company_name',0),(114,114,'It is time to update your credit card',0),(115,NULL,'Dear $first_name $last_name,\n\nWe want to remind you that the credit card that we have in our records for your account is about to expire. Its expiration date is $expiry_date.\n\nUpdating your credit card is easy. Just login into \" + Util.getSysProp(\"url\") + \"/billing/user/login.jsp?entityId=$company_id. using your user name: $username and password: $password. After logging in, click on \'Account\' and then \'Edit Credit Card\'. \nThank you for keeping your account up to date.\n\nBilling Department\n$company_name',0);
/*!40000 ALTER TABLE `notification_message_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_message_section`
--

DROP TABLE IF EXISTS `notification_message_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_message_section` (
  `id` int(11) NOT NULL,
  `message_id` int(11) DEFAULT NULL,
  `section` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_message_section_FK_1` (`message_id`),
  CONSTRAINT `notification_message_section_FK_1` FOREIGN KEY (`message_id`) REFERENCES `notification_message` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_message_section`
--

LOCK TABLES `notification_message_section` WRITE;
/*!40000 ALTER TABLE `notification_message_section` DISABLE KEYS */;
INSERT INTO `notification_message_section` VALUES (100,100,2,0),(101,100,1,0),(102,101,2,0),(103,101,1,0),(104,102,2,0),(105,102,1,0),(106,103,2,0),(107,103,1,0),(108,104,2,0),(109,104,1,0),(110,105,1,0),(111,105,2,0),(112,106,1,0),(113,106,2,0),(114,107,1,0),(115,107,2,0);
/*!40000 ALTER TABLE `notification_message_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_message_type`
--

DROP TABLE IF EXISTS `notification_message_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_message_type` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_message_type_FK_1` (`category_id`),
  CONSTRAINT `notification_message_type_FK_1` FOREIGN KEY (`category_id`) REFERENCES `notification_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_message_type`
--

LOCK TABLES `notification_message_type` WRITE;
/*!40000 ALTER TABLE `notification_message_type` DISABLE KEYS */;
INSERT INTO `notification_message_type` VALUES (1,1,1),(2,4,1),(3,4,1),(4,4,1),(5,4,1),(6,4,1),(7,4,1),(8,4,1),(9,4,1),(10,3,1),(11,3,1),(12,1,1),(13,2,1),(14,2,1),(15,2,1),(16,3,1),(17,3,1),(18,1,1),(19,4,1),(20,4,1);
/*!40000 ALTER TABLE `notification_message_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_billing_type`
--

DROP TABLE IF EXISTS `order_billing_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_billing_type` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_billing_type`
--

LOCK TABLES `order_billing_type` WRITE;
/*!40000 ALTER TABLE `order_billing_type` DISABLE KEYS */;
INSERT INTO `order_billing_type` VALUES (1),(2);
/*!40000 ALTER TABLE `order_billing_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_line`
--

DROP TABLE IF EXISTS `order_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_line` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `amount` decimal(22,10) NOT NULL,
  `quantity` decimal(22,10) DEFAULT NULL,
  `price` decimal(22,10) DEFAULT NULL,
  `item_price` smallint(6) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `use_item` bit(1) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `provisioning_status` int(11) DEFAULT NULL,
  `provisioning_request_id` varchar(50) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_line_order_id` (`order_id`),
  KEY `ix_order_line_item_id` (`item_id`),
  KEY `order_line_FK_3` (`type_id`),
  CONSTRAINT `order_line_FK_3` FOREIGN KEY (`type_id`) REFERENCES `order_line_type` (`id`),
  CONSTRAINT `order_line_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `order_line_FK_2` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_line`
--

LOCK TABLES `order_line` WRITE;
/*!40000 ALTER TABLE `order_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_line_type`
--

DROP TABLE IF EXISTS `order_line_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_line_type` (
  `id` int(11) NOT NULL,
  `editable` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_line_type`
--

LOCK TABLES `order_line_type` WRITE;
/*!40000 ALTER TABLE `order_line_type` DISABLE KEYS */;
INSERT INTO `order_line_type` VALUES (1,1),(2,0),(3,0);
/*!40000 ALTER TABLE `order_line_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_meta_field_map`
--

DROP TABLE IF EXISTS `order_meta_field_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_meta_field_map` (
  `order_id` int(11) NOT NULL,
  `meta_field_value_id` int(11) NOT NULL,
  KEY `order_meta_field_map_FK_1` (`order_id`),
  KEY `order_meta_field_map_FK_2` (`meta_field_value_id`),
  CONSTRAINT `order_meta_field_map_FK_2` FOREIGN KEY (`meta_field_value_id`) REFERENCES `meta_field_value` (`id`),
  CONSTRAINT `order_meta_field_map_FK_1` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_meta_field_map`
--

LOCK TABLES `order_meta_field_map` WRITE;
/*!40000 ALTER TABLE `order_meta_field_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_meta_field_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_period`
--

DROP TABLE IF EXISTS `order_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_period` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_period_FK_1` (`entity_id`),
  KEY `order_period_FK_2` (`unit_id`),
  CONSTRAINT `order_period_FK_2` FOREIGN KEY (`unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `order_period_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_period`
--

LOCK TABLES `order_period` WRITE;
/*!40000 ALTER TABLE `order_period` DISABLE KEYS */;
INSERT INTO `order_period` VALUES (1,NULL,NULL,NULL,1),(200,10,1,1,0);
/*!40000 ALTER TABLE `order_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_process`
--

DROP TABLE IF EXISTS `order_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_process` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `billing_process_id` int(11) DEFAULT NULL,
  `periods_included` int(11) DEFAULT NULL,
  `period_start` datetime DEFAULT NULL,
  `period_end` datetime DEFAULT NULL,
  `is_review` int(11) NOT NULL,
  `origin` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_uq_order_process_or_in` (`order_id`,`invoice_id`),
  KEY `ix_uq_order_process_or_bp` (`order_id`,`billing_process_id`),
  KEY `ix_order_process_in` (`invoice_id`),
  CONSTRAINT `order_process_FK_1` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_process`
--

LOCK TABLES `order_process` WRITE;
/*!40000 ALTER TABLE `order_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paper_invoice_batch`
--

DROP TABLE IF EXISTS `paper_invoice_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paper_invoice_batch` (
  `id` int(11) NOT NULL,
  `total_invoices` int(11) NOT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `is_self_managed` smallint(6) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paper_invoice_batch`
--

LOCK TABLES `paper_invoice_batch` WRITE;
/*!40000 ALTER TABLE `paper_invoice_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `paper_invoice_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner`
--

DROP TABLE IF EXISTS `partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `balance` decimal(22,10) NOT NULL,
  `total_payments` decimal(22,10) NOT NULL,
  `total_refunds` decimal(22,10) NOT NULL,
  `total_payouts` decimal(22,10) NOT NULL,
  `percentage_rate` decimal(22,10) DEFAULT NULL,
  `referral_fee` decimal(22,10) DEFAULT NULL,
  `fee_currency_id` int(11) DEFAULT NULL,
  `one_time` smallint(6) NOT NULL,
  `period_unit_id` int(11) NOT NULL,
  `period_value` int(11) NOT NULL,
  `next_payout_date` datetime NOT NULL,
  `due_payout` decimal(22,10) DEFAULT NULL,
  `automatic_process` smallint(6) NOT NULL,
  `related_clerk` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_i_3` (`user_id`),
  KEY `partner_FK_1` (`period_unit_id`),
  KEY `partner_FK_2` (`fee_currency_id`),
  KEY `partner_FK_3` (`related_clerk`),
  CONSTRAINT `partner_FK_4` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `partner_FK_1` FOREIGN KEY (`period_unit_id`) REFERENCES `period_unit` (`id`),
  CONSTRAINT `partner_FK_2` FOREIGN KEY (`fee_currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `partner_FK_3` FOREIGN KEY (`related_clerk`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner`
--

LOCK TABLES `partner` WRITE;
/*!40000 ALTER TABLE `partner` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_meta_field_map`
--

DROP TABLE IF EXISTS `partner_meta_field_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_meta_field_map` (
  `partner_id` int(11) NOT NULL,
  `meta_field_value_id` int(11) NOT NULL,
  KEY `partner_meta_field_map_FK_1` (`partner_id`),
  KEY `partner_meta_field_map_FK_2` (`meta_field_value_id`),
  CONSTRAINT `partner_meta_field_map_FK_2` FOREIGN KEY (`meta_field_value_id`) REFERENCES `meta_field_value` (`id`),
  CONSTRAINT `partner_meta_field_map_FK_1` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_meta_field_map`
--

LOCK TABLES `partner_meta_field_map` WRITE;
/*!40000 ALTER TABLE `partner_meta_field_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_meta_field_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_payout`
--

DROP TABLE IF EXISTS `partner_payout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_payout` (
  `id` int(11) NOT NULL,
  `starting_date` datetime NOT NULL,
  `ending_date` datetime NOT NULL,
  `payments_amount` decimal(22,10) NOT NULL,
  `refunds_amount` decimal(22,10) NOT NULL,
  `balance_left` decimal(22,10) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_payout_i_2` (`partner_id`),
  CONSTRAINT `partner_payout_FK_1` FOREIGN KEY (`partner_id`) REFERENCES `partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_payout`
--

LOCK TABLES `partner_payout` WRITE;
/*!40000 ALTER TABLE `partner_payout` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_payout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_range`
--

DROP TABLE IF EXISTS `partner_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner_range` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `percentage_rate` decimal(22,10) DEFAULT NULL,
  `referral_fee` decimal(22,10) DEFAULT NULL,
  `range_from` int(11) NOT NULL,
  `range_to` int(11) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_range_p` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_range`
--

LOCK TABLES `partner_range` WRITE;
/*!40000 ALTER TABLE `partner_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `result_id` int(11) DEFAULT NULL,
  `amount` decimal(22,10) NOT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `payment_date` datetime DEFAULT NULL,
  `method_id` int(11) NOT NULL,
  `credit_card_id` int(11) DEFAULT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `is_refund` smallint(6) NOT NULL DEFAULT '0',
  `is_preauth` smallint(6) NOT NULL DEFAULT '0',
  `payment_id` int(11) DEFAULT NULL,
  `currency_id` int(11) NOT NULL,
  `payout_id` int(11) DEFAULT NULL,
  `ach_id` int(11) DEFAULT NULL,
  `balance` decimal(22,10) DEFAULT NULL,
  `payment_period` int(11) DEFAULT NULL,
  `payment_notes` varchar(500) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_i_2` (`user_id`,`create_datetime`),
  KEY `payment_i_3` (`user_id`,`balance`),
  KEY `payment_FK_1` (`ach_id`),
  KEY `payment_FK_2` (`currency_id`),
  KEY `payment_FK_3` (`payment_id`),
  KEY `payment_FK_4` (`credit_card_id`),
  KEY `payment_FK_5` (`result_id`),
  KEY `payment_FK_6` (`method_id`),
  CONSTRAINT `payment_FK_6` FOREIGN KEY (`method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `payment_FK_1` FOREIGN KEY (`ach_id`) REFERENCES `ach` (`id`),
  CONSTRAINT `payment_FK_2` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `payment_FK_3` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `payment_FK_4` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`id`),
  CONSTRAINT `payment_FK_5` FOREIGN KEY (`result_id`) REFERENCES `payment_result` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_authorization`
--

DROP TABLE IF EXISTS `payment_authorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_authorization` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `processor` varchar(40) NOT NULL,
  `code1` varchar(40) NOT NULL,
  `code2` varchar(40) DEFAULT NULL,
  `code3` varchar(40) DEFAULT NULL,
  `approval_code` varchar(20) DEFAULT NULL,
  `avs` varchar(20) DEFAULT NULL,
  `transaction_id` varchar(40) DEFAULT NULL,
  `md5` varchar(100) DEFAULT NULL,
  `card_code` varchar(100) DEFAULT NULL,
  `create_datetime` datetime NOT NULL,
  `response_message` varchar(200) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `create_datetime` (`create_datetime`),
  KEY `transaction_id` (`transaction_id`),
  KEY `ix_pa_payment` (`payment_id`),
  CONSTRAINT `payment_authorization_FK_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_authorization`
--

LOCK TABLES `payment_authorization` WRITE;
/*!40000 ALTER TABLE `payment_authorization` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_authorization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_info_cheque`
--

DROP TABLE IF EXISTS `payment_info_cheque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_info_cheque` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `cheque_number` varchar(50) DEFAULT NULL,
  `cheque_date` datetime DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_info_cheque_FK_1` (`payment_id`),
  CONSTRAINT `payment_info_cheque_FK_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_info_cheque`
--

LOCK TABLES `payment_info_cheque` WRITE;
/*!40000 ALTER TABLE `payment_info_cheque` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_info_cheque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_invoice`
--

DROP TABLE IF EXISTS `payment_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_invoice` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `amount` decimal(22,10) DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_uq_payment_inv_map_pa_in` (`payment_id`,`invoice_id`),
  KEY `payment_invoice_FK_1` (`invoice_id`),
  CONSTRAINT `payment_invoice_FK_2` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `payment_invoice_FK_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_invoice`
--

LOCK TABLES `payment_invoice` WRITE;
/*!40000 ALTER TABLE `payment_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_meta_field_map`
--

DROP TABLE IF EXISTS `payment_meta_field_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_meta_field_map` (
  `payment_id` int(11) NOT NULL,
  `meta_field_value_id` int(11) NOT NULL,
  KEY `payment_meta_field_map_FK_1` (`payment_id`),
  KEY `payment_meta_field_map_FK_2` (`meta_field_value_id`),
  CONSTRAINT `payment_meta_field_map_FK_2` FOREIGN KEY (`meta_field_value_id`) REFERENCES `meta_field_value` (`id`),
  CONSTRAINT `payment_meta_field_map_FK_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_meta_field_map`
--

LOCK TABLES `payment_meta_field_map` WRITE;
/*!40000 ALTER TABLE `payment_meta_field_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_meta_field_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_method` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9);
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_result`
--

DROP TABLE IF EXISTS `payment_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_result` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_result`
--

LOCK TABLES `payment_result` WRITE;
/*!40000 ALTER TABLE `payment_result` DISABLE KEYS */;
INSERT INTO `payment_result` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `payment_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `period_unit`
--

DROP TABLE IF EXISTS `period_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `period_unit` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `period_unit`
--

LOCK TABLES `period_unit` WRITE;
/*!40000 ALTER TABLE `period_unit` DISABLE KEYS */;
INSERT INTO `period_unit` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `period_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `foreign_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_FK_1` (`type_id`),
  CONSTRAINT `permission_FK_1` FOREIGN KEY (`type_id`) REFERENCES `permission_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (10,1,NULL),(11,1,NULL),(12,1,NULL),(13,1,NULL),(14,1,NULL),(15,1,NULL),(16,1,NULL),(17,1,NULL),(18,1,NULL),(20,2,NULL),(21,2,NULL),(22,2,NULL),(23,2,NULL),(24,2,NULL),(25,2,NULL),(26,2,NULL),(27,2,NULL),(28,2,NULL),(29,2,NULL),(30,3,NULL),(31,3,NULL),(32,3,NULL),(33,3,NULL),(34,3,NULL),(35,3,NULL),(36,3,NULL),(37,3,NULL),(40,4,NULL),(41,4,NULL),(42,4,NULL),(43,4,NULL),(44,4,NULL),(50,5,NULL),(51,5,NULL),(52,5,NULL),(60,6,NULL),(61,6,NULL),(62,6,NULL),(63,6,NULL),(70,7,NULL),(71,7,NULL),(72,7,NULL),(73,7,NULL),(74,7,NULL),(75,7,NULL),(80,8,NULL),(90,9,NULL),(91,9,NULL),(92,9,NULL),(93,9,NULL),(94,9,NULL),(95,9,NULL),(96,9,NULL),(97,9,NULL),(98,9,NULL),(99,9,NULL),(100,10,NULL),(101,10,NULL),(102,10,NULL),(103,10,NULL),(104,10,NULL),(110,11,NULL),(111,11,NULL),(120,12,NULL);
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_role_map`
--

DROP TABLE IF EXISTS `permission_role_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role_map` (
  `permission_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  KEY `permission_role_map_i_2` (`permission_id`,`role_id`),
  KEY `permission_role_map_FK_1` (`role_id`),
  CONSTRAINT `permission_role_map_FK_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `permission_role_map_FK_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role_map`
--

LOCK TABLES `permission_role_map` WRITE;
/*!40000 ALTER TABLE `permission_role_map` DISABLE KEYS */;
INSERT INTO `permission_role_map` VALUES (10,2),(10,3),(10,4),(10,60),(10,61),(10,63),(11,2),(11,3),(11,4),(11,60),(11,61),(11,63),(12,2),(12,3),(12,60),(12,61),(13,2),(13,3),(13,60),(13,61),(14,2),(14,3),(14,60),(14,61),(15,2),(15,3),(15,4),(15,5),(15,60),(15,61),(15,62),(15,63),(16,2),(16,60),(17,2),(17,3),(17,60),(17,61),(18,5),(18,62),(20,2),(20,3),(20,4),(20,60),(20,61),(20,63),(21,2),(21,3),(21,4),(21,60),(21,61),(21,63),(22,2),(22,3),(22,60),(22,61),(23,2),(23,3),(23,60),(23,61),(24,2),(24,3),(24,4),(24,5),(24,60),(24,61),(24,62),(24,63),(25,2),(25,60),(26,2),(26,60),(27,2),(27,60),(28,2),(28,3),(28,4),(28,60),(28,61),(28,63),(29,5),(29,62),(30,2),(30,3),(30,4),(30,5),(30,60),(30,61),(30,62),(30,63),(31,2),(31,3),(31,60),(31,61),(32,2),(32,3),(32,60),(32,61),(33,2),(33,3),(33,60),(33,61),(34,2),(34,3),(34,4),(34,5),(34,60),(34,61),(34,62),(34,63),(35,2),(35,60),(36,2),(36,3),(36,4),(36,60),(36,61),(36,63),(37,5),(37,62),(40,2),(40,3),(40,60),(40,61),(41,2),(41,3),(41,60),(41,61),(42,2),(42,3),(42,60),(42,61),(43,2),(43,3),(43,60),(43,61),(44,2),(44,60),(50,2),(50,3),(50,60),(50,61),(51,2),(51,3),(51,60),(51,61),(52,2),(52,3),(52,60),(52,61),(60,2),(60,3),(60,60),(60,61),(61,2),(61,3),(61,60),(61,61),(62,2),(62,3),(62,60),(62,61),(63,2),(63,3),(63,60),(63,61),(70,2),(70,3),(70,60),(70,61),(71,2),(71,3),(71,60),(71,61),(72,2),(72,3),(72,4),(72,5),(72,60),(72,61),(72,62),(72,63),(73,2),(73,60),(74,2),(74,3),(74,4),(74,60),(74,61),(74,63),(75,5),(75,62),(80,2),(80,60),(90,2),(90,3),(90,4),(90,5),(90,60),(90,61),(90,62),(90,63),(91,2),(91,3),(91,4),(91,5),(91,60),(91,61),(91,62),(91,63),(92,2),(92,3),(92,4),(92,5),(92,60),(92,61),(92,62),(92,63),(93,2),(93,3),(93,4),(93,5),(93,60),(93,61),(93,62),(93,63),(94,2),(94,3),(94,60),(94,61),(95,2),(95,3),(95,60),(95,61),(96,2),(96,3),(96,60),(96,61),(97,2),(97,3),(97,60),(97,61),(98,2),(98,3),(98,60),(98,61),(99,2),(99,60),(100,2),(100,3),(100,60),(100,61),(101,2),(101,3),(101,60),(101,61),(102,2),(102,3),(102,60),(102,61),(103,2),(103,3),(103,60),(103,61),(104,2),(104,3),(104,60),(104,61),(111,2),(111,60),(120,2),(120,60);
/*!40000 ALTER TABLE `permission_role_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_type`
--

DROP TABLE IF EXISTS `permission_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_type` (
  `id` int(11) NOT NULL,
  `description` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_type`
--

LOCK TABLES `permission_type` WRITE;
/*!40000 ALTER TABLE `permission_type` DISABLE KEYS */;
INSERT INTO `permission_type` VALUES (1,'Customer'),(2,'Order'),(3,'Payment'),(4,'Product'),(5,'Product Category'),(6,'Plan'),(7,'Invoice'),(8,'Billing'),(9,'Menu'),(10,'Partner'),(11,'User Switching'),(12,'API');
/*!40000 ALTER TABLE `permission_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_user`
--

DROP TABLE IF EXISTS `permission_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_user` (
  `permission_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_grant` smallint(6) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_user_map_i_2` (`permission_id`,`user_id`),
  KEY `permission_user_FK_1` (`user_id`),
  CONSTRAINT `permission_user_FK_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `permission_user_FK_1` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_user`
--

LOCK TABLES `permission_user` WRITE;
/*!40000 ALTER TABLE `permission_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan`
--

DROP TABLE IF EXISTS `plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `period_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_FK_1` (`item_id`),
  KEY `plan_FK_2` (`period_id`),
  CONSTRAINT `plan_FK_2` FOREIGN KEY (`period_id`) REFERENCES `order_period` (`id`),
  CONSTRAINT `plan_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan`
--

LOCK TABLES `plan` WRITE;
/*!40000 ALTER TABLE `plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_item`
--

DROP TABLE IF EXISTS `plan_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_item` (
  `id` int(11) NOT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `item_id` int(11) NOT NULL,
  `plan_item_bundle_id` int(11) DEFAULT NULL,
  `precedence` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_item_precedence_i` (`precedence`),
  KEY `plan_item_item_id_i` (`item_id`),
  KEY `plan_item_FK_1` (`plan_id`),
  KEY `plan_item_FK_3` (`plan_item_bundle_id`),
  CONSTRAINT `plan_item_FK_3` FOREIGN KEY (`plan_item_bundle_id`) REFERENCES `plan_item_bundle` (`id`),
  CONSTRAINT `plan_item_FK_1` FOREIGN KEY (`plan_id`) REFERENCES `plan` (`id`),
  CONSTRAINT `plan_item_FK_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_item`
--

LOCK TABLES `plan_item` WRITE;
/*!40000 ALTER TABLE `plan_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_item_bundle`
--

DROP TABLE IF EXISTS `plan_item_bundle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_item_bundle` (
  `id` int(11) NOT NULL,
  `quantity` decimal(22,10) NOT NULL,
  `period_id` int(11) NOT NULL,
  `target_customer` varchar(20) NOT NULL,
  `add_if_exists` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_item_bundle_FK_1` (`period_id`),
  CONSTRAINT `plan_item_bundle_FK_1` FOREIGN KEY (`period_id`) REFERENCES `order_period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_item_bundle`
--

LOCK TABLES `plan_item_bundle` WRITE;
/*!40000 ALTER TABLE `plan_item_bundle` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_item_bundle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_item_price_timeline`
--

DROP TABLE IF EXISTS `plan_item_price_timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_item_price_timeline` (
  `plan_item_id` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `price_model_id` int(11) NOT NULL,
  PRIMARY KEY (`plan_item_id`,`start_date`),
  UNIQUE KEY `price_model_id` (`price_model_id`),
  CONSTRAINT `plan_item_price_timeline_FK_2` FOREIGN KEY (`price_model_id`) REFERENCES `price_model` (`id`),
  CONSTRAINT `plan_item_price_timeline_FK_1` FOREIGN KEY (`plan_item_id`) REFERENCES `plan_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_item_price_timeline`
--

LOCK TABLES `plan_item_price_timeline` WRITE;
/*!40000 ALTER TABLE `plan_item_price_timeline` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_item_price_timeline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluggable_task`
--

DROP TABLE IF EXISTS `pluggable_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluggable_task` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `processing_order` int(11) NOT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pluggable_task_FK_1` (`type_id`),
  KEY `pluggable_task_FK_2` (`entity_id`),
  CONSTRAINT `pluggable_task_FK_2` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`),
  CONSTRAINT `pluggable_task_FK_1` FOREIGN KEY (`type_id`) REFERENCES `pluggable_task_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluggable_task`
--

LOCK TABLES `pluggable_task` WRITE;
/*!40000 ALTER TABLE `pluggable_task` DISABLE KEYS */;
INSERT INTO `pluggable_task` VALUES (10,10,21,1,NULL,0),(11,10,9,1,NULL,0),(12,10,12,2,NULL,0),(13,10,1,1,NULL,0),(14,10,3,1,NULL,0),(15,10,4,2,NULL,0),(16,10,5,1,NULL,0),(17,10,6,1,NULL,0),(18,10,7,1,NULL,0),(19,10,10,1,NULL,0),(20,10,25,1,NULL,0),(21,10,28,1,NULL,0),(22,10,33,1,NULL,0),(23,10,54,1,NULL,0),(24,10,61,1,NULL,0),(25,10,82,1,NULL,0),(26,10,87,1,NULL,0),(27,10,88,2,NULL,0);
/*!40000 ALTER TABLE `pluggable_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluggable_task_parameter`
--

DROP TABLE IF EXISTS `pluggable_task_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluggable_task_parameter` (
  `id` int(11) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `int_value` int(11) DEFAULT NULL,
  `str_value` varchar(500) DEFAULT NULL,
  `float_value` decimal(22,10) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pluggable_task_parameter_FK_1` (`task_id`),
  CONSTRAINT `pluggable_task_parameter_FK_1` FOREIGN KEY (`task_id`) REFERENCES `pluggable_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluggable_task_parameter`
--

LOCK TABLES `pluggable_task_parameter` WRITE;
/*!40000 ALTER TABLE `pluggable_task_parameter` DISABLE KEYS */;
INSERT INTO `pluggable_task_parameter` VALUES (100,10,'all',NULL,'yes',NULL,0),(101,11,'smtp_server',NULL,'localhost',NULL,0),(102,11,'port',NULL,'25',NULL,0),(103,11,'ssl_auth',NULL,'false',NULL,0),(104,11,'tls',NULL,'false',NULL,0),(105,11,'username',NULL,'username',NULL,0),(106,11,'password',NULL,'password',NULL,0),(107,12,'design',NULL,'invoice_design',NULL,0);
/*!40000 ALTER TABLE `pluggable_task_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluggable_task_type`
--

DROP TABLE IF EXISTS `pluggable_task_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluggable_task_type` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `class_name` varchar(200) NOT NULL,
  `min_parameters` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pluggable_task_type_FK_1` (`category_id`),
  CONSTRAINT `pluggable_task_type_FK_1` FOREIGN KEY (`category_id`) REFERENCES `pluggable_task_type_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluggable_task_type`
--

LOCK TABLES `pluggable_task_type` WRITE;
/*!40000 ALTER TABLE `pluggable_task_type` DISABLE KEYS */;
INSERT INTO `pluggable_task_type` VALUES (1,1,'com.sapienter.jbilling.server.pluggableTask.BasicLineTotalTask',0),(2,1,'com.sapienter.jbilling.server.pluggableTask.GSTTaxTask',2),(3,4,'com.sapienter.jbilling.server.pluggableTask.CalculateDueDate',0),(4,4,'com.sapienter.jbilling.server.pluggableTask.BasicCompositionTask',0),(5,2,'com.sapienter.jbilling.server.pluggableTask.BasicOrderFilterTask',0),(6,3,'com.sapienter.jbilling.server.pluggableTask.BasicInvoiceFilterTask',0),(7,5,'com.sapienter.jbilling.server.pluggableTask.BasicOrderPeriodTask',0),(8,6,'com.sapienter.jbilling.server.pluggableTask.PaymentAuthorizeNetTask',2),(9,7,'com.sapienter.jbilling.server.pluggableTask.BasicEmailNotificationTask',6),(10,8,'com.sapienter.jbilling.server.pluggableTask.BasicPaymentInfoTask',0),(11,6,'com.sapienter.jbilling.server.pluggableTask.PaymentPartnerTestTask',0),(12,7,'com.sapienter.jbilling.server.pluggableTask.PaperInvoiceNotificationTask',1),(13,4,'com.sapienter.jbilling.server.pluggableTask.CalculateDueDateDfFm',0),(14,3,'com.sapienter.jbilling.server.pluggableTask.NoInvoiceFilterTask',0),(15,9,'com.sapienter.jbilling.server.pluggableTask.BasicPenaltyTask',1),(16,2,'com.sapienter.jbilling.server.pluggableTask.OrderFilterAnticipatedTask',0),(17,5,'com.sapienter.jbilling.server.pluggableTask.OrderPeriodAnticipateTask',0),(19,6,'com.sapienter.jbilling.server.pluggableTask.PaymentEmailAuthorizeNetTask',1),(20,10,'com.sapienter.jbilling.server.pluggableTask.ProcessorEmailAlarmTask',3),(21,6,'com.sapienter.jbilling.server.pluggableTask.PaymentFakeTask',0),(22,6,'com.sapienter.jbilling.server.payment.tasks.PaymentRouterCCFTask',2),(23,11,'com.sapienter.jbilling.server.user.tasks.BasicSubscriptionStatusManagerTask',0),(24,6,'com.sapienter.jbilling.server.user.tasks.PaymentACHCommerceTask',5),(25,12,'com.sapienter.jbilling.server.payment.tasks.NoAsyncParameters',0),(26,12,'com.sapienter.jbilling.server.payment.tasks.RouterAsyncParameters',0),(28,13,'com.sapienter.jbilling.server.item.tasks.BasicItemManager',0),(29,13,'com.sapienter.jbilling.server.item.tasks.RulesItemManager',0),(30,1,'com.sapienter.jbilling.server.order.task.RulesLineTotalTask',0),(31,14,'com.sapienter.jbilling.server.item.tasks.RulesPricingTask',0),(32,15,'com.sapienter.jbilling.server.mediation.task.SeparatorFileReader',2),(33,16,'com.sapienter.jbilling.server.mediation.task.RulesMediationTask',0),(34,15,'com.sapienter.jbilling.server.mediation.task.FixedFileReader',2),(35,8,'com.sapienter.jbilling.server.user.tasks.PaymentInfoNoValidateTask',0),(36,7,'com.sapienter.jbilling.server.notification.task.TestNotificationTask',0),(37,5,'com.sapienter.jbilling.server.process.task.ProRateOrderPeriodTask',0),(38,4,'com.sapienter.jbilling.server.process.task.DailyProRateCompositionTask',0),(39,6,'com.sapienter.jbilling.server.payment.tasks.PaymentAtlasTask',5),(40,17,'com.sapienter.jbilling.server.order.task.RefundOnCancelTask',0),(41,17,'com.sapienter.jbilling.server.order.task.CancellationFeeRulesTask',1),(42,6,'com.sapienter.jbilling.server.payment.tasks.PaymentFilterTask',0),(43,17,'com.sapienter.jbilling.server.payment.blacklist.tasks.BlacklistUserStatusTask',0),(44,15,'com.sapienter.jbilling.server.mediation.task.JDBCReader',0),(45,15,'com.sapienter.jbilling.server.mediation.task.MySQLReader',0),(46,17,'com.sapienter.jbilling.server.provisioning.task.ProvisioningCommandsRulesTask',0),(47,18,'com.sapienter.jbilling.server.provisioning.task.TestExternalProvisioningTask',0),(48,18,'com.sapienter.jbilling.server.provisioning.task.CAIProvisioningTask',2),(49,6,'com.sapienter.jbilling.server.payment.tasks.PaymentRouterCurrencyTask',2),(50,18,'com.sapienter.jbilling.server.provisioning.task.MMSCProvisioningTask',5),(51,3,'com.sapienter.jbilling.server.invoice.task.NegativeBalanceInvoiceFilterTask',0),(52,17,'com.sapienter.jbilling.server.invoice.task.FileInvoiceExportTask',1),(53,17,'com.sapienter.jbilling.server.system.event.task.InternalEventsRulesTask',0),(54,17,'com.sapienter.jbilling.server.user.balance.DynamicBalanceManagerTask',0),(55,19,'com.sapienter.jbilling.server.user.tasks.UserBalanceValidatePurchaseTask',0),(56,19,'com.sapienter.jbilling.server.user.tasks.RulesValidatePurchaseTask',0),(57,6,'com.sapienter.jbilling.server.payment.tasks.PaymentsGatewayTask',4),(58,17,'com.sapienter.jbilling.server.payment.tasks.SaveCreditCardExternallyTask',1),(59,13,'com.sapienter.jbilling.server.order.task.RulesItemManager2',0),(60,1,'com.sapienter.jbilling.server.order.task.RulesLineTotalTask2',0),(61,14,'com.sapienter.jbilling.server.item.tasks.RulesPricingTask2',0),(62,17,'com.sapienter.jbilling.server.payment.tasks.SaveCreditCardExternallyTask',1),(63,6,'com.sapienter.jbilling.server.pluggableTask.PaymentFakeExternalStorage',0),(64,6,'com.sapienter.jbilling.server.payment.tasks.PaymentWorldPayTask',3),(65,6,'com.sapienter.jbilling.server.payment.tasks.PaymentWorldPayExternalTask',3),(66,17,'com.sapienter.jbilling.server.user.tasks.AutoRechargeTask',0),(67,6,'com.sapienter.jbilling.server.payment.tasks.PaymentBeanstreamTask',3),(68,6,'com.sapienter.jbilling.server.payment.tasks.PaymentSageTask',2),(69,20,'com.sapienter.jbilling.server.process.task.BasicBillingProcessFilterTask',0),(70,20,'com.sapienter.jbilling.server.process.task.BillableUsersBillingProcessFilterTask',0),(71,21,'com.sapienter.jbilling.server.mediation.task.SaveToFileMediationErrorHandler',0),(73,21,'com.sapienter.jbilling.server.mediation.task.SaveToJDBCMediationErrorHandler',1),(75,6,'com.sapienter.jbilling.server.payment.tasks.PaymentPaypalExternalTask',3),(76,6,'com.sapienter.jbilling.server.payment.tasks.PaymentAuthorizeNetCIMTask',2),(77,6,'com.sapienter.jbilling.server.payment.tasks.PaymentMethodRouterTask',4),(78,23,'com.sapienter.jbilling.server.rule.task.VelocityRulesGeneratorTask',2),(79,14,'com.sapienter.jbilling.server.pricing.tasks.PriceModelPricingTask',0),(81,22,'com.sapienter.jbilling.server.mediation.task.MediationProcessTask',0),(82,22,'com.sapienter.jbilling.server.billing.task.BillingProcessTask',0),(83,22,'com.sapienter.jbilling.server.process.task.ScpUploadTask',4),(84,17,'com.sapienter.jbilling.server.payment.tasks.SaveACHExternallyTask',1),(85,20,'com.sapienter.jbilling.server.process.task.BillableUserOrdersBillingProcessFilterTask',0),(86,17,'com.sapienter.jbilling.server.item.tasks.PlanChangesExternalTask',0),(87,24,'com.sapienter.jbilling.server.process.task.BasicAgeingTask',0),(88,22,'com.sapienter.jbilling.server.process.task.AgeingProcessTask',0),(89,24,'com.sapienter.jbilling.server.process.task.BusinessDayAgeingTask',0),(90,4,'com.sapienter.jbilling.server.process.task.SimpleTaxCompositionTask',1),(91,4,'com.sapienter.jbilling.server.process.task.CountryTaxCompositionTask',2),(92,4,'com.sapienter.jbilling.server.process.task.PaymentTermPenaltyTask',2),(93,17,'com.sapienter.jbilling.server.order.task.CancellationFeeTask',2);
/*!40000 ALTER TABLE `pluggable_task_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pluggable_task_type_category`
--

DROP TABLE IF EXISTS `pluggable_task_type_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pluggable_task_type_category` (
  `id` int(11) NOT NULL,
  `interface_name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pluggable_task_type_category`
--

LOCK TABLES `pluggable_task_type_category` WRITE;
/*!40000 ALTER TABLE `pluggable_task_type_category` DISABLE KEYS */;
INSERT INTO `pluggable_task_type_category` VALUES (1,'com.sapienter.jbilling.server.pluggableTask.OrderProcessingTask'),(2,'com.sapienter.jbilling.server.pluggableTask.OrderFilterTask'),(3,'com.sapienter.jbilling.server.pluggableTask.InvoiceFilterTask'),(4,'com.sapienter.jbilling.server.pluggableTask.InvoiceCompositionTask'),(5,'com.sapienter.jbilling.server.pluggableTask.OrderPeriodTask'),(6,'com.sapienter.jbilling.server.pluggableTask.PaymentTask'),(7,'com.sapienter.jbilling.server.pluggableTask.NotificationTask'),(8,'com.sapienter.jbilling.server.pluggableTask.PaymentInfoTask'),(9,'com.sapienter.jbilling.server.pluggableTask.PenaltyTask'),(10,'com.sapienter.jbilling.server.pluggableTask.ProcessorAlarm'),(11,'com.sapienter.jbilling.server.user.tasks.ISubscriptionStatusManager'),(12,'com.sapienter.jbilling.server.payment.tasks.IAsyncPaymentParameters'),(13,'com.sapienter.jbilling.server.item.tasks.IItemPurchaseManager'),(14,'com.sapienter.jbilling.server.item.tasks.IPricing'),(15,'com.sapienter.jbilling.server.mediation.task.IMediationReader'),(16,'com.sapienter.jbilling.server.mediation.task.IMediationProcess'),(17,'com.sapienter.jbilling.server.system.event.task.IInternalEventsTask'),(18,'com.sapienter.jbilling.server.provisioning.task.IExternalProvisioning'),(19,'com.sapienter.jbilling.server.user.tasks.IValidatePurchaseTask'),(20,'com.sapienter.jbilling.server.process.task.IBillingProcessFilterTask'),(21,'com.sapienter.jbilling.server.mediation.task.IMediationErrorHandler'),(22,'com.sapienter.jbilling.server.process.task.IScheduledTask'),(23,'com.sapienter.jbilling.server.rule.task.IRulesGenerator'),(24,'com.sapienter.jbilling.server.process.task.IAgeingTask');
/*!40000 ALTER TABLE `pluggable_task_type_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preference`
--

DROP TABLE IF EXISTS `preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preference` (
  `id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `table_id` int(11) NOT NULL,
  `foreign_id` int(11) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `preference_FK_1` (`type_id`),
  KEY `preference_FK_2` (`table_id`),
  CONSTRAINT `preference_FK_2` FOREIGN KEY (`table_id`) REFERENCES `jbilling_table` (`id`),
  CONSTRAINT `preference_FK_1` FOREIGN KEY (`type_id`) REFERENCES `preference_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preference`
--

LOCK TABLES `preference` WRITE;
/*!40000 ALTER TABLE `preference` DISABLE KEYS */;
INSERT INTO `preference` VALUES (10,4,5,10,'5'),(11,14,5,10,'1');
/*!40000 ALTER TABLE `preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preference_type`
--

DROP TABLE IF EXISTS `preference_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preference_type` (
  `id` int(11) NOT NULL,
  `def_value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preference_type`
--

LOCK TABLES `preference_type` WRITE;
/*!40000 ALTER TABLE `preference_type` DISABLE KEYS */;
INSERT INTO `preference_type` VALUES (4,NULL),(5,NULL),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,NULL),(11,NULL),(12,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(17,NULL),(18,NULL),(19,'1'),(20,'1'),(21,'0'),(22,NULL),(23,NULL),(24,'0'),(25,'0'),(27,'0'),(28,NULL),(29,'https://www.paypal.com/en_US/i/btn/x-click-but6.gif'),(30,NULL),(31,'2000-01-01'),(32,'0'),(33,'0'),(35,'0'),(36,'1'),(37,'0'),(38,'1'),(39,'0'),(40,'0'),(41,'0'),(42,'0'),(43,'0'),(44,'0'),(45,'0'),(46,'0'),(47,'0'),(48,'1'),(49,NULL),(50,'2');
/*!40000 ALTER TABLE `preference_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_model`
--

DROP TABLE IF EXISTS `price_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_model` (
  `id` int(11) NOT NULL,
  `strategy_type` varchar(40) NOT NULL,
  `rate` decimal(22,10) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `next_model_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `price_model_FK_1` (`next_model_id`),
  CONSTRAINT `price_model_FK_1` FOREIGN KEY (`next_model_id`) REFERENCES `price_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_model`
--

LOCK TABLES `price_model` WRITE;
/*!40000 ALTER TABLE `price_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `price_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_model_attribute`
--

DROP TABLE IF EXISTS `price_model_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_model_attribute` (
  `price_model_id` int(11) NOT NULL,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`price_model_id`,`attribute_name`),
  CONSTRAINT `price_model_attribute_FK_1` FOREIGN KEY (`price_model_id`) REFERENCES `price_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_model_attribute`
--

LOCK TABLES `price_model_attribute` WRITE;
/*!40000 ALTER TABLE `price_model_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `price_model_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process_run`
--

DROP TABLE IF EXISTS `process_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_run` (
  `id` int(11) NOT NULL,
  `process_id` int(11) DEFAULT NULL,
  `run_date` datetime NOT NULL,
  `started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `finished` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `payment_finished` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invoices_generated` int(11) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_run_process_ix` (`process_id`),
  KEY `process_run_FK_2` (`status_id`),
  CONSTRAINT `process_run_FK_2` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `process_run_FK_1` FOREIGN KEY (`process_id`) REFERENCES `billing_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process_run`
--

LOCK TABLES `process_run` WRITE;
/*!40000 ALTER TABLE `process_run` DISABLE KEYS */;
/*!40000 ALTER TABLE `process_run` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process_run_total`
--

DROP TABLE IF EXISTS `process_run_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_run_total` (
  `id` int(11) NOT NULL,
  `process_run_id` int(11) DEFAULT NULL,
  `currency_id` int(11) NOT NULL,
  `total_invoiced` decimal(22,10) DEFAULT NULL,
  `total_paid` decimal(22,10) DEFAULT NULL,
  `total_not_paid` decimal(22,10) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_run_total_run_ix` (`process_run_id`),
  KEY `process_run_total_FK_1` (`currency_id`),
  CONSTRAINT `process_run_total_FK_2` FOREIGN KEY (`process_run_id`) REFERENCES `process_run` (`id`),
  CONSTRAINT `process_run_total_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process_run_total`
--

LOCK TABLES `process_run_total` WRITE;
/*!40000 ALTER TABLE `process_run_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `process_run_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process_run_total_pm`
--

DROP TABLE IF EXISTS `process_run_total_pm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_run_total_pm` (
  `id` int(11) NOT NULL,
  `process_run_total_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  `total` decimal(22,10) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_pm_index_total` (`process_run_total_id`),
  KEY `process_run_total_pm_FK_1` (`payment_method_id`),
  CONSTRAINT `process_run_total_pm_FK_1` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process_run_total_pm`
--

LOCK TABLES `process_run_total_pm` WRITE;
/*!40000 ALTER TABLE `process_run_total_pm` DISABLE KEYS */;
/*!40000 ALTER TABLE `process_run_total_pm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process_run_user`
--

DROP TABLE IF EXISTS `process_run_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_run_user` (
  `id` int(11) NOT NULL,
  `process_run_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_run_user_run_ix` (`process_run_id`,`user_id`),
  KEY `process_run_user_FK_1` (`user_id`),
  CONSTRAINT `process_run_user_FK_2` FOREIGN KEY (`process_run_id`) REFERENCES `process_run` (`id`),
  CONSTRAINT `process_run_user_FK_1` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `process_run_user`
--

LOCK TABLES `process_run_user` WRITE;
/*!40000 ALTER TABLE `process_run_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `process_run_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotion` (
  `id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `once` smallint(6) NOT NULL,
  `since` datetime DEFAULT NULL,
  `until` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_promotion_code` (`code`),
  KEY `promotion_FK_1` (`item_id`),
  CONSTRAINT `promotion_FK_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order`
--

DROP TABLE IF EXISTS `purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL,
  `billing_type_id` int(11) NOT NULL,
  `active_since` datetime DEFAULT NULL,
  `active_until` datetime DEFAULT NULL,
  `cycle_start` datetime DEFAULT NULL,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `next_billable_day` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT '0',
  `notify` smallint(6) DEFAULT NULL,
  `last_notified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `notification_step` int(11) DEFAULT NULL,
  `due_date_unit_id` int(11) DEFAULT NULL,
  `due_date_value` int(11) DEFAULT NULL,
  `df_fm` smallint(6) DEFAULT NULL,
  `anticipate_periods` int(11) DEFAULT NULL,
  `own_invoice` smallint(6) DEFAULT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `notes_in_invoice` smallint(6) DEFAULT NULL,
  `is_current` smallint(6) DEFAULT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_order_i_user` (`user_id`,`deleted`),
  KEY `purchase_order_i_notif` (`active_until`,`notification_step`),
  KEY `ix_purchase_order_date` (`user_id`,`create_datetime`),
  KEY `purchase_order_FK_1` (`currency_id`),
  KEY `purchase_order_FK_2` (`billing_type_id`),
  KEY `purchase_order_FK_3` (`period_id`),
  KEY `purchase_order_FK_5` (`created_by`),
  KEY `purchase_order_FK_6` (`status_id`),
  CONSTRAINT `purchase_order_FK_6` FOREIGN KEY (`status_id`) REFERENCES `generic_status` (`id`),
  CONSTRAINT `purchase_order_FK_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`),
  CONSTRAINT `purchase_order_FK_2` FOREIGN KEY (`billing_type_id`) REFERENCES `order_billing_type` (`id`),
  CONSTRAINT `purchase_order_FK_3` FOREIGN KEY (`period_id`) REFERENCES `order_period` (`id`),
  CONSTRAINT `purchase_order_FK_4` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `purchase_order_FK_5` FOREIGN KEY (`created_by`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order`
--

LOCK TABLES `purchase_order` WRITE;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate_card`
--

DROP TABLE IF EXISTS `rate_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rate_card` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `entity_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_name` (`table_name`),
  KEY `rate_card_FK_1` (`entity_id`),
  CONSTRAINT `rate_card_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate_card`
--

LOCK TABLES `rate_card` WRITE;
/*!40000 ALTER TABLE `rate_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `rate_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recent_item`
--

DROP TABLE IF EXISTS `recent_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recent_item` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `object_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recent_item`
--

LOCK TABLES `recent_item` WRITE;
/*!40000 ALTER TABLE `recent_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `recent_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `report_FK_1` (`type_id`),
  CONSTRAINT `report_FK_1` FOREIGN KEY (`type_id`) REFERENCES `report_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (1,1,'total_invoiced','total_invoiced.jasper',0),(2,1,'ageing_balance','ageing_balance.jasper',0),(3,2,'product_subscribers','product_subscribers.jasper',0),(4,3,'total_payments','total_payments.jasper',0),(5,4,'user_signups','user_signups.jasper',0),(6,4,'top_customers','top_customers.jasper',0),(7,1,'accounts_receivable','accounts_receivable.jasper',0),(8,1,'gl_detail','gl_detail.jasper',0),(9,1,'gl_summary','gl_summary.jasper',0),(10,4,'plan_history','plan_history.jasper',0),(11,4,'total_invoiced_per_customer','total_invoiced_per_customer.jasper',0),(12,4,'total_invoiced_per_customer_over_years','total_invoiced_per_customer_over_years.jasper',0);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_parameter`
--

DROP TABLE IF EXISTS `report_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_parameter` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `dtype` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `report_parameter_FK_1` (`report_id`),
  CONSTRAINT `report_parameter_FK_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_parameter`
--

LOCK TABLES `report_parameter` WRITE;
/*!40000 ALTER TABLE `report_parameter` DISABLE KEYS */;
INSERT INTO `report_parameter` VALUES (1,1,'date','start_date'),(2,1,'date','end_date'),(3,1,'integer','period'),(4,3,'integer','item_id'),(5,4,'date','start_date'),(6,4,'date','end_date'),(7,4,'integer','period'),(8,5,'date','start_date'),(9,5,'date','end_date'),(10,5,'integer','period'),(11,6,'date','start_date'),(12,6,'date','end_date'),(13,8,'date','date'),(14,9,'date','date'),(15,10,'integer','plan_id'),(16,10,'string','plan_code'),(17,10,'string','plan_description'),(18,11,'date','start_date'),(19,11,'date','end_date'),(20,12,'string','start_year'),(21,12,'string','end_year');
/*!40000 ALTER TABLE `report_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_type`
--

DROP TABLE IF EXISTS `report_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `OPTLOCK` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_type`
--

LOCK TABLES `report_type` WRITE;
/*!40000 ALTER TABLE `report_type` DISABLE KEYS */;
INSERT INTO `report_type` VALUES (1,'invoice',0),(2,'order',0),(3,'payment',0),(4,'user',0);
/*!40000 ALTER TABLE `report_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role_type_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_FK_1` (`entity_id`),
  CONSTRAINT `role_FK_1` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (2,2,NULL),(3,3,NULL),(4,4,NULL),(5,5,NULL),(60,2,10),(61,3,10),(62,5,10),(63,4,10);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortcut`
--

DROP TABLE IF EXISTS `shortcut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut`
--

LOCK TABLES `shortcut` WRITE;
/*!40000 ALTER TABLE `shortcut` DISABLE KEYS */;
/*!40000 ALTER TABLE `shortcut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_credit_card_map`
--

DROP TABLE IF EXISTS `user_credit_card_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_credit_card_map` (
  `user_id` int(11) DEFAULT NULL,
  `credit_card_id` int(11) DEFAULT NULL,
  KEY `user_credit_card_map_i_2` (`user_id`,`credit_card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_credit_card_map`
--

LOCK TABLES `user_credit_card_map` WRITE;
/*!40000 ALTER TABLE `user_credit_card_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_credit_card_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role_map`
--

DROP TABLE IF EXISTS `user_role_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role_map` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  KEY `user_role_map_i_2` (`user_id`,`role_id`),
  KEY `user_role_map_i_role` (`role_id`),
  CONSTRAINT `user_role_map_FK_2` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `user_role_map_FK_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role_map`
--

LOCK TABLES `user_role_map` WRITE;
/*!40000 ALTER TABLE `user_role_map` DISABLE KEYS */;
INSERT INTO `user_role_map` VALUES (10,60);
/*!40000 ALTER TABLE `user_role_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'comtalkdev'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-13 19:57:53
