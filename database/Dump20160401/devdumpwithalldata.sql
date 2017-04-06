CREATE DATABASE  IF NOT EXISTS `psm` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `psm`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: ec2-52-48-101-197.eu-west-1.compute.amazonaws.com    Database: psm
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

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
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat` (
  `chatid` int(11) NOT NULL AUTO_INCREMENT,
  `issueid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `organizationid` int(11) NOT NULL,
  `pollingstationid` int(11) NOT NULL,
  `chatmessage` text NOT NULL,
  `attachtment_url` varchar(500) DEFAULT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chatid`)
) ENGINE=InnoDB AUTO_INCREMENT=479 DEFAULT CHARSET=utf8 COMMENT='Using for viewing chat messages in issues';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (397,452,102,12,205,'is this true?','null','2016-03-23 10:52:42'),(398,453,102,12,209,'hello','null','2016-03-23 11:06:49'),(399,452,107,12,205,'yes','null','2016-03-23 11:09:16'),(400,456,104,12,200,'Please have someone help cover a break?','null','2016-03-23 11:20:29'),(401,460,102,12,199,'check user can download file','/data/media/images.jpg','2016-03-24 06:06:29'),(402,460,102,12,199,'check user can download document','/data/media/bl paper.docx','2016-03-24 06:09:22'),(403,459,105,12,201,'chat 1','null','2016-03-24 06:10:57'),(404,459,105,12,201,'chat11','/data/media/1454495281-1454489283-3.jpg','2016-03-24 06:14:18'),(405,459,105,12,201,'chat12','null','2016-03-24 06:15:01'),(406,459,102,12,201,'chat 1 - reply em','null','2016-03-24 06:16:06'),(407,462,102,12,201,'chat 33','null','2016-03-24 06:29:39'),(408,462,105,12,201,'chat 44','/data/media/1454495281-1454489283-3.jpg','2016-03-24 07:24:09'),(409,468,102,12,205,'this is urgent','/data/media/1454495281-1454489283-3.jpg','2016-03-24 08:11:29'),(410,462,105,12,201,'chat 55','null','2016-03-24 08:56:15'),(411,459,102,12,201,'reply 2','null','2016-03-24 08:58:37'),(412,469,102,12,201,'chat 705/1','null','2016-03-24 09:04:40'),(413,470,105,12,201,'aaaaa','null','2016-03-24 09:37:04'),(414,472,102,12,201,'will replace a new one','null','2016-03-24 10:08:35'),(415,472,105,12,201,'This is critical','null','2016-03-24 10:10:00'),(416,472,102,12,201,'thank you !!!','null','2016-03-24 10:10:52'),(417,473,105,12,201,'Accessibility Common 1 Chat 1','null','2016-03-24 10:39:04'),(418,473,102,12,201,'Accessibility Common 1 Chat 2','null','2016-03-24 10:39:52'),(419,473,105,12,201,'Accessibility Common 1 chat 111','null','2016-03-24 11:03:04'),(420,473,105,12,201,'Accessibility common 1 chat 222','null','2016-03-24 11:03:58'),(421,473,102,12,201,'reply!!!!!!','null','2016-03-24 11:04:31'),(422,473,102,12,201,'reply 2!!!','null','2016-03-24 11:05:53'),(423,476,107,12,205,'hi','null','2016-03-24 12:22:50'),(424,476,107,12,205,'hii','null','2016-03-24 12:23:05'),(425,481,106,12,203,'hi','null','2016-03-24 15:12:30'),(426,481,106,12,203,'hi','null','2016-03-24 15:13:19'),(427,481,106,12,203,'hi','null','2016-03-24 15:13:27'),(428,481,106,12,203,'hi','null','2016-03-24 15:16:03'),(429,481,106,12,203,'hi','/data/media/Screenshot_2016-03-07-10-19-45.png','2016-03-24 15:18:31'),(430,481,102,12,203,'hello','null','2016-03-24 15:22:56'),(431,484,102,12,203,'hi','null','2016-03-24 15:58:49'),(432,479,102,12,203,'f','null','2016-03-24 16:02:06'),(433,485,107,12,205,'hello - test sc','null','2016-03-25 14:50:40'),(434,486,102,12,201,'chat 11','null','2016-03-28 08:23:35'),(435,487,105,12,202,'recheck','null','2016-03-28 08:25:46'),(436,490,102,12,201,'checked issue 13','null','2016-03-28 08:32:14'),(437,490,102,12,201,'check massage 1','null','2016-03-28 08:39:50'),(438,489,102,12,201,'check issue 2','null','2016-03-28 08:40:49'),(439,491,102,12,201,'test 1','null','2016-03-28 09:26:28'),(440,492,102,12,201,'notification alerts','null','2016-03-28 10:14:25'),(441,495,102,12,201,'rrrrrrrr','null','2016-03-28 11:23:38'),(442,495,102,12,201,'yy','null','2016-03-28 11:31:54'),(443,504,102,12,199,'SFSG','null','2016-03-29 07:26:31'),(444,503,102,12,199,'sgrsg','null','2016-03-29 07:29:22'),(445,499,102,12,201,'gyujiyg','null','2016-03-29 08:22:47'),(446,501,102,12,199,'test reslovew','null','2016-03-29 08:30:39'),(447,509,102,12,199,'dhdthtd','null','2016-03-29 08:59:41'),(448,508,103,12,199,'WWWWWWWWWWWWWWT','null','2016-03-29 09:00:47'),(449,500,102,12,199,'hhhhhhhhhhhhhhhh','null','2016-03-29 09:04:02'),(450,513,103,12,199,'ttttttttttttttttqqqqqqqqqqqqqqqqqqqqqqqqq','null','2016-03-29 09:14:20'),(451,513,103,12,199,'asdfasdsad','null','2016-03-29 09:15:11'),(452,512,103,12,199,'derrtttt','null','2016-03-29 09:16:30'),(453,510,103,12,199,'testtttttttttttttttttttttt','null','2016-03-29 09:17:48'),(454,509,103,12,199,'mmmmmmmmmmmmmmmm','null','2016-03-29 09:18:41'),(455,537,102,12,199,'dtyjyt','null','2016-03-29 11:05:16'),(456,536,102,12,199,'sruyj','null','2016-03-29 11:11:09'),(457,535,102,12,199,'xtrhyj','null','2016-03-29 11:12:06'),(458,534,102,12,199,'zfyjhfjh','null','2016-03-29 11:12:37'),(459,534,102,12,199,'xfhfnj','null','2016-03-29 11:13:06'),(460,533,102,12,199,'azrtjh','null','2016-03-29 11:13:38'),(461,532,102,12,199,'xfhgn','null','2016-03-29 12:11:11'),(462,531,102,12,199,'chjh','null','2016-03-29 12:12:07'),(463,530,102,12,199,'SYTU','null','2016-03-29 12:13:03'),(464,528,102,12,199,'xhgfkk','null','2016-03-29 12:13:53'),(465,527,102,12,199,'ddddddddd','null','2016-03-29 12:14:20'),(466,542,102,12,199,'dththj','null','2016-03-30 06:45:43'),(467,544,106,12,203,'hi','null','2016-03-30 10:37:59'),(468,544,106,12,203,'hi attach','/data/media/Screenshot_2016-03-07-10-19-45.png','2016-03-30 10:38:18'),(469,549,106,12,203,'hi','null','2016-03-31 11:24:38'),(470,549,106,12,203,'hii','/data/media/Screenshot_2016-03-07-10-25-31.png','2016-03-31 11:24:57'),(471,549,102,12,203,'hello','null','2016-03-31 11:25:52'),(472,552,105,12,201,'Accessibility Issue 1 Chat 1','null','2016-03-31 17:30:28'),(473,552,105,12,201,'Accessibility Issue 1 Chat 2','null','2016-03-31 17:31:07'),(474,552,102,12,201,'Accessibility Issue 1 Chat 3','null','2016-03-31 17:31:46'),(475,552,102,12,201,'Accessibility Issue 1 Chat 4','null','2016-03-31 17:34:08'),(476,552,105,12,201,'Accessibility Issue 1 Chat 5','null','2016-03-31 17:35:14'),(477,552,105,12,201,'Accessibility Issue 1 Chat 6','null','2016-03-31 17:45:49'),(478,557,128,16,233,'do not smoke here','null','2016-04-01 07:12:18');
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compliance_election`
--

DROP TABLE IF EXISTS `compliance_election`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compliance_election` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `election_id` int(11) NOT NULL,
  `list_id` int(11) NOT NULL,
  `iscomply` int(11) DEFAULT '0' COMMENT '0=not comply,1=comply',
  `sortorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comp_elfk1_idx` (`organization_id`),
  KEY `comp_elfk2_idx` (`election_id`),
  KEY `comp_elfk3_idx` (`list_id`),
  CONSTRAINT `comp_elfk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comp_elfk2` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comp_elfk3` FOREIGN KEY (`list_id`) REFERENCES `list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compliance_election`
--

LOCK TABLES `compliance_election` WRITE;
/*!40000 ALTER TABLE `compliance_election` DISABLE KEYS */;
/*!40000 ALTER TABLE `compliance_election` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counting_center`
--

DROP TABLE IF EXISTS `counting_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counting_center` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `latitude` varchar(45) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  `organization_id` int(11) NOT NULL,
  `election_id` int(11) NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `counting_center_organization_idx` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='Counting centers master table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counting_center`
--

LOCK TABLES `counting_center` WRITE;
/*!40000 ALTER TABLE `counting_center` DISABLE KEYS */;
INSERT INTO `counting_center` VALUES (1,'Counting 1','6.705520','79.909050',2,8,''),(2,'Counting 1','7.7904845','80.885915',3,4,''),(3,'Counting 1','7.7904845','80.885915',4,5,''),(4,'Counting 1','7.7904845','80.885915',5,6,''),(5,'Royal British Legion Hall','51.6769451','-0.6023963',6,9,''),(6,'Counting 1','51.605222','-0.638724',7,8,''),(7,'Counting 1','7.7904845','80.885915',8,7,''),(8,'Royal British Legion Hall','51.6769451','-0.6023963',9,10,''),(9,'s','','',10,12,'as'),(10,'df','','',10,13,'e'),(13,'Aberdeen Council','','',11,16,'AB10 1AB'),(14,'counting center','35.6490117','139.55164960000002',12,17,'address one'),(15,'counting','36.5677206','139.90335879999998',12,18,'address two'),(16,'ertyu','','',12,19,'dfghj'),(17,'rtyu','','',12,20,'fghj'),(18,'gh','','',12,21,'yuj'),(19,'vista station 1','53.4685097','-1.4931023000000323',12,22,'1, Acre Gate, High Green, Sheffield, S35 4FT'),(20,'chilosta station','53.44847249999999','-1.4817540999999892',12,23,'280A, Whitley Lane, Grenoside, Sheffield, S35 8RQ'),(21,'delete election','53.46140399999999','-1.4941056999999773',12,24,'2, Woodland Court, Burncross, Sheffield, S35 1TN'),(22,'remove election','53.46140399999999','-1.4941056999999773',12,25,'1, Woodland Court, Burncross, Sheffield, S35 1TN'),(23,'herish 1','53.46140399999999','-1.4941056999999773',12,26,'1, Woodland Court, Burncross, Sheffield, S35 1TN'),(24,'michol 1','53.4435969','-1.4981864000000087',12,27,'6, Woodside Lane, Grenoside, Sheffield, S35 8RW'),(25,'jira center','53.4385206','-1.498907700000018',12,28,'7, Blacksmith Lane, Grenoside, Sheffield, S35 8NB'),(26,'jira1','53.4385206','-1.498907700000018',12,29,'7, Blacksmith Lane, Grenoside, Sheffield, S35 8NB'),(27,'gimsa','53.4385206','-1.498907700000018',12,30,'7, Blacksmith Lane, Grenoside, Sheffield, S35 8NB'),(28,'incorre center','53.3571725','-1.3836148000000321',12,31,'14, Wolverley Road, Sheffield, S13 7EG'),(29,'Count Center1','40.0348476','-84.19725790000001',12,32,'123 Count Street'),(30,'woodland','53.46140399999999','-1.4941056999999773',12,33,'1,woodland court,burncross,sheffield,s35 1TN'),(31,'moratuwa','6.788070599999999','79.89128129999995',12,34,'moratuwa'),(32,'equal1','53.36360430000001','-1.3558063000000402',12,35,'19, Driver Street, Sheffield, S13 9WP'),(33,'Counting center name','36.5677206','139.90335879999998',12,36,'address'),(34,'Center 1','35.6490117','139.55164960000002',12,37,'Address 1'),(35,'csvup1','53.3635381','-1.3556631000000152',12,38,'13, Driver Street, Sheffield, S13 9WP'),(36,'edita1','53.3635573','-1.3557045999999673',12,39,'15, Driver Street, Sheffield, S13 9WP'),(37,'rowad1','53.3635266','-1.355810799999972',12,40,'17, Driver Street, Sheffield, S13 9WP'),(38,'edita1','53.3635381','-1.3556631000000152',12,41,'13, Driver Street, Sheffield, S13 9WP'),(39,'moratuwa','6.788070599999999','79.89128129999995',12,42,'moratuwa'),(40,'electra 1','53.3634676','-1.3556882000000314',12,43,'11, Driver Street, Sheffield, S13 9WP'),(41,'star 1','53.3635381','-1.3556631000000152',12,44,'13, Driver Street, Sheffield, S13 9WP'),(42,'Mitra1','6.788070599999999','79.89128129999995',12,45,'Moratuwa'),(43,'od','6.788070599999999','79.89128129999995',13,46,'moratuwa'),(44,'d','6.788070599999999','79.89128129999995',13,47,'moratuwa'),(45,'d','6.788070599999999','79.89128129999995',14,48,'moratuwa'),(46,'bb','6.788070599999999','79.89128129999995',14,49,'moratuwa'),(47,'reshta','53.3635266','-1.355810799999972',12,50,'17, Driver Street, Sheffield, S13 9WP'),(48,'Panadura','6.720229199999999','79.93046329999993',12,51,'Panadura'),(49,'reshat2','53.36360430000001','-1.3558063000000402',12,52,'19, Driver Street, Sheffield, S13 9WP'),(50,'No','-9.189967','-75.015152',15,53,'Pera'),(51,'ni','-9.189967','-75.015152',15,54,'peru'),(52,'allcrt1','53.3571725','-1.3836148000000321',12,55,'14, Wolverley Road, Sheffield, S13 7EG'),(53,'Mitra','6.788070599999999','79.89128129999995',12,56,'Moratuwa'),(54,'Mulleriyawa','6.9270786','79.86124300000006',12,57,'Colombo'),(55,'reshta03','53.36360430000001','-1.3558063000000402',12,58,'19, Driver Street, Sheffield, S13 9WP'),(56,'reshta04','53.3571725','-1.3836148000000321',12,59,'14, Wolverley Road, Sheffield, S13 7EG'),(57,'reshta05','53.3635266','-1.355810799999972',12,60,'17, Driver Street, Sheffield, S13 9WP'),(58,'Blue mountain','6.9270786','79.86124300000006',16,61,'Colombo'),(59,'vista 01','53.36360430000001','-1.3558063000000402',16,62,'19, Driver Street, Sheffield, S13 9WP'),(60,'dupreshat02','53.3571725','-1.3836148000000321',16,63,'14, Wolverley Road, Sheffield, S13 7EG'),(61,'Colombo','6.9270786','79.86124300000006',12,64,'Colombo'),(62,'incorrect01','53.36360430000001','-1.3558063000000402',16,65,'19, Driver Street, Sheffield, S13 9WP'),(63,'invalid1','53.3635266','-1.355810799999972',16,66,'17, Driver Street, Sheffield, S13 9WP');
/*!40000 ALTER TABLE `counting_center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csv_upload`
--

DROP TABLE IF EXISTS `csv_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csv_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `election_id` int(11) DEFAULT NULL,
  `uploaded_path` varchar(255) DEFAULT NULL,
  `report_path` varchar(255) DEFAULT NULL,
  `status` int(5) DEFAULT '0',
  `updatedon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csv_upload`
--

LOCK TABLES `csv_upload` WRITE;
/*!40000 ALTER TABLE `csv_upload` DISABLE KEYS */;
INSERT INTO `csv_upload` VALUES (1,12,-1,NULL,'/data/media/FileT_adbb3d6d-2c6b-4860-887b-5bae3dcd47f3.csv',2,'2016-03-31 10:49:23'),(2,13,46,NULL,'/data/media/StructureO_de3b82fe-b0e3-444a-8e7f-471e62fb1f4f.csv',2,'2016-03-31 17:30:26'),(3,13,-1,NULL,'/data/media/FileT_f806abcc-dd98-44e9-ba03-79945828bdbe.csv',2,'2016-03-31 17:33:22'),(4,13,47,NULL,'/data/media/StructureO_5487de2e-fe87-433e-812d-b035edf66fb5.csv',3,'2016-03-31 20:45:53'),(5,14,48,NULL,'/data/media/StructureO_8a046140-b13d-4c19-b8fb-60a324cf2c46.csv',2,'2016-03-31 21:50:55'),(6,14,-1,NULL,'/data/media/FileT_25d8bda4-8806-466c-970b-b4c91d1846a8.csv',2,'2016-04-01 04:03:57'),(7,12,45,NULL,'/data/media/StructureO_23365601-b444-4a20-bd51-fdafd7b38cb5.csv',2,'2016-04-01 04:17:57'),(8,12,44,NULL,'/data/media/StructureO_fcd8f379-d300-4ca3-a875-c21100ffbdff.csv',2,'2016-04-01 04:19:18'),(9,12,51,NULL,'/data/media/StructureO_a05ff54f-1cf0-4d11-b6b9-3d4428131925.csv',2,'2016-04-01 04:42:08'),(10,12,50,NULL,'/data/media/StructureO_c5e342a0-ddc1-4d19-856e-3259e9cde8e1.csv',2,'2016-04-01 04:43:14'),(11,12,17,NULL,'/data/media/StructureO_f0bc2229-9519-4685-94f1-d1c2af6637b3.csv',2,'2016-04-01 05:13:26'),(12,12,18,NULL,'/data/media/StructureO_3d56e332-0fe2-41cc-8f31-284ee7625f09.csv',2,'2016-04-01 05:16:11'),(13,12,55,NULL,'/data/media/StructureO_612f71e3-05ed-4602-877e-32f7f2ae296b.csv',3,'2016-04-01 05:35:15'),(14,12,56,NULL,'/data/media/StructureO_d970ea88-680d-439f-a2ed-f765b789c533.csv',2,'2016-04-01 05:41:22'),(15,12,57,NULL,'/data/media/StructureO_c4a65e36-5a9c-4791-aebf-8bcba983f460.csv',3,'2016-04-01 05:56:27'),(16,12,58,NULL,'/data/media/StructureO_a932624b-f3ba-4995-997a-5c2ee94454c7.csv',2,'2016-04-01 06:09:19'),(17,12,59,NULL,'/data/media/StructureO_c20ab06b-44ac-44c8-9ef4-232b0eeb4fb6.csv',3,'2016-04-01 06:16:50'),(18,12,60,NULL,'/data/media/StructureO_921acfdb-f7dc-47a8-851d-993e90b4fcb7.csv',3,'2016-04-01 06:28:08'),(19,16,62,NULL,'/data/media/StructureO_936ee63a-8395-44c1-a8f9-a868edd30894.csv',3,'2016-04-01 06:46:03'),(20,16,61,NULL,'/data/media/StructureO_f059f7d9-219e-4f13-bbd6-3a19b2ab44f0.csv',3,'2016-04-01 06:46:57'),(21,16,63,NULL,'/data/media/StructureO_7cc727f5-20d0-40a0-9c9c-c647352a0c19.csv',3,'2016-04-01 06:59:07'),(22,15,53,NULL,'/data/media/StructureT_b2731501-cc52-4ef9-ab56-deff10463d42.csv',2,'2016-04-01 07:05:45'),(23,16,65,NULL,'/data/media/StructureO_52633638-00a7-4ac7-bc2a-d5bef918144f.csv',3,'2016-04-01 07:17:04'),(24,16,66,NULL,'/data/media/StructureO_63f195eb-93ae-4f0a-b0bf-d281a926812c.csv',0,'2016-04-01 07:42:39'),(25,15,-1,NULL,'/data/media/FileT_e7ada69d-5747-4aad-aad7-430fb9f2f2da.csv',2,'2016-04-01 08:15:50'),(26,16,-1,NULL,'/data/media/FileT_f66f3f31-3f0d-4200-a34b-4128cf681a23.csv',3,'2016-04-01 09:27:28');
/*!40000 ALTER TABLE `csv_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `election`
--

DROP TABLE IF EXISTS `election`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `election_name` varchar(500) NOT NULL,
  `election_date_start` datetime NOT NULL,
  `election_date_end` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0=Not Started,1=Active,2=Closed,3=Cancelled',
  `ballotboxno` varchar(45) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL,
  `BPA_identifier` int(11) NOT NULL,
  `ballot_type_count` int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `elec_fk1_idx` (`organization_id`),
  KEY `elec_date_idx` (`election_date_start`),
  CONSTRAINT `elec_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election`
--

LOCK TABLES `election` WRITE;
/*!40000 ALTER TABLE `election` DISABLE KEYS */;
INSERT INTO `election` VALUES (1,2,'Police Comminisoner Election','2016-02-08 07:00:00','2016-02-08 22:00:00',0,NULL,0,0,1),(2,2,'Mayor Election','2016-02-08 07:00:00','2016-02-08 22:00:00',0,NULL,0,0,1),(3,2,'Presidential Election','2016-02-08 07:00:00','2016-02-08 22:00:00',0,NULL,0,0,1),(4,3,'Mayor Election','2016-02-24 07:00:00','2016-02-24 22:00:00',0,NULL,0,0,1),(5,4,'Mayor Election','2016-02-08 07:00:00','2016-02-08 22:00:00',0,NULL,0,0,1),(6,6,'Amersham Town Ward District By Election','2016-02-08 07:00:00','2016-02-08 20:00:00',0,NULL,0,0,1),(7,2,'Divisional Election','2016-02-08 07:00:00','2016-02-08 20:00:00',0,NULL,0,0,1),(8,2,'City Officer Election','2016-02-08 07:00:00','2016-02-08 20:00:00',0,NULL,0,0,1),(9,6,'Amersham Town Ward District By Election','2016-02-19 07:00:00','2016-02-19 22:00:00',1,NULL,0,0,1),(10,9,'Police Commissioner Election','2016-03-18 07:00:00','2016-03-18 22:00:00',0,NULL,0,0,1),(11,9,'City Officer Election','2016-03-18 07:00:00','2016-03-18 22:00:00',0,NULL,0,0,1),(12,10,'mayor','2016-03-23 07:00:00','2016-03-23 22:00:00',0,NULL,0,0,1),(13,10,'next ele','2016-03-19 20:00:00','2016-03-19 22:00:00',0,NULL,0,0,1),(17,12,'Test Election','2016-03-31 07:00:00','2016-03-31 14:00:00',0,NULL,0,1,1),(18,12,'new election','2016-03-31 07:00:00','2016-03-31 01:26:00',0,NULL,0,0,1),(22,12,'vista','2016-03-30 07:00:00','2016-03-30 10:00:00',0,NULL,0,0,1),(23,12,'chilosta election 1','2016-04-10 13:00:00','2016-04-10 17:00:00',0,NULL,1,1,1),(24,12,'delete election','2016-03-28 10:00:00','2016-03-28 16:00:00',0,NULL,1,1,1),(25,12,'remove election','2016-03-26 10:00:00','2016-03-26 16:00:00',0,NULL,0,1,1),(26,12,'herish','2016-03-25 08:00:00','2016-03-25 12:00:00',0,NULL,0,1,1),(27,12,'michol','2016-04-01 07:00:00','2016-04-01 22:00:00',0,NULL,0,1,1),(28,12,'jira','2016-03-25 15:00:00','2016-03-25 16:00:00',0,NULL,1,1,1),(29,12,'mira','2016-03-25 16:00:00','2016-03-25 17:00:00',0,NULL,1,1,1),(30,12,'gimsa','2016-03-25 15:30:00','2016-03-25 19:00:00',0,NULL,1,1,1),(31,12,'incorre','2016-03-25 15:30:00','2016-03-25 19:30:00',0,NULL,0,1,1),(32,12,'Some election','2016-07-01 07:00:00','2016-07-01 22:00:00',0,NULL,1,0,1),(33,12,'herish','2016-03-25 01:00:00','2016-03-25 18:00:00',0,NULL,0,1,1),(34,12,'vista2','2016-03-25 11:03:00','2016-03-25 22:00:00',0,NULL,0,1,1),(35,12,'equal elec','2016-03-30 07:00:00','2016-03-30 22:00:00',0,NULL,1,1,1),(36,12,'Election name','2016-07-01 07:00:00','2016-07-01 22:00:00',0,NULL,1,0,1),(37,12,'New Election Address','2016-12-11 17:59:00','2016-12-11 18:00:00',0,NULL,1,0,1),(38,12,'csvup1','2016-03-28 16:00:00','2016-03-28 17:00:00',0,NULL,0,1,1),(39,12,'edita','2016-03-28 15:00:00','2016-03-28 17:00:00',0,NULL,0,1,1),(40,12,'rowad','2016-03-28 15:00:00','2016-03-28 17:00:00',0,NULL,0,0,1),(41,12,'editacop','2016-03-29 05:00:00','2016-03-29 15:00:00',0,NULL,0,1,1),(42,12,'Test Election 2','2016-03-29 07:00:00','2016-03-29 14:00:00',0,NULL,0,0,1),(43,12,'elecra t1','2016-03-30 07:00:00','2016-03-30 11:00:00',0,NULL,0,0,1),(44,12,'star','2016-02-08 07:00:00','2016-02-08 11:00:00',0,NULL,0,0,1),(45,12,'divisional election1','2016-03-31 11:00:00','2016-03-31 14:00:00',0,NULL,0,0,1),(46,13,'sliitelection1','2016-03-31 20:00:00','2016-03-31 22:00:00',0,NULL,0,0,1),(47,13,'Sliitelection2','2016-03-31 22:00:00','2016-03-31 23:00:00',0,NULL,0,0,1),(48,14,'sliit2ele','2016-03-31 22:29:00','2016-03-31 23:59:00',0,NULL,0,0,1),(49,14,'sliit2ele2','2016-03-31 22:00:00','2016-03-31 23:00:00',0,NULL,0,0,1),(50,12,'reshta','2016-04-01 05:30:00','2016-04-01 08:30:00',0,NULL,0,0,1),(51,12,'April fool election','2016-04-01 07:00:00','2016-04-01 08:00:00',0,NULL,1,0,1),(52,12,'reshta2','2016-04-01 06:00:00','2016-04-01 10:00:00',0,NULL,0,0,1),(53,15,'sliit2ele','2016-04-01 07:00:00','2016-04-01 22:00:00',0,NULL,0,0,1),(54,15,'sliit2ele2','2016-04-01 08:00:00','2016-04-01 22:00:00',0,NULL,0,0,1),(55,12,'allcrt','2016-04-01 06:00:00','2016-04-01 20:00:00',0,NULL,0,0,1),(56,12,'April Fool Election2','2016-04-01 07:00:00','2016-04-01 08:00:00',0,NULL,0,0,1),(57,12,'April Fool election 3','2016-04-01 10:00:00','2016-04-01 12:00:00',0,NULL,0,0,1),(58,12,'reshta3','2016-04-01 07:00:00','2016-04-01 10:00:00',0,NULL,0,0,1),(59,12,'reshta4','2016-04-01 07:00:00','2016-04-01 08:00:00',0,NULL,0,0,1),(60,12,'reshta5','2016-04-01 07:00:00','2016-04-01 10:00:00',0,NULL,0,0,1),(61,16,'Royal election','2016-04-01 07:00:00','2016-04-01 09:30:00',0,NULL,0,0,1),(62,16,'vista 1','2016-04-01 07:00:00','2016-04-01 10:00:00',0,NULL,0,0,1),(63,16,'dupreshta2','2016-04-01 07:00:00','2016-04-01 21:00:00',0,NULL,0,0,1),(64,12,'we','2016-04-01 07:00:00','2016-04-01 21:00:00',0,NULL,1,0,1),(65,16,'incorrect 1','2016-04-01 07:00:00','2016-04-01 10:30:00',0,NULL,0,0,1),(66,16,'invalid1','2016-04-01 08:00:00','2016-04-01 11:00:00',0,NULL,0,0,1);
/*!40000 ALTER TABLE `election` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `election_close_stats`
--

DROP TABLE IF EXISTS `election_close_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_close_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `election_id` int(11) NOT NULL,
  `tot_ballots` int(11) NOT NULL,
  `tot_spolied_issued` int(11) NOT NULL,
  `tot_unused` int(11) NOT NULL,
  `tot_tend_ballots` int(11) NOT NULL,
  `tot_tend_spoiled` int(11) NOT NULL,
  `tot_tend_unused` int(11) NOT NULL,
  `updatedon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `polling_station_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `eleclost_fk1_idx` (`organization_id`),
  KEY `eleclost_fk2_idx` (`election_id`),
  KEY `eleclost_fk3_idx` (`polling_station_id`),
  CONSTRAINT `eleclost_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eleclost_fk2` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eleclost_fk3` FOREIGN KEY (`polling_station_id`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election_close_stats`
--

LOCK TABLES `election_close_stats` WRITE;
/*!40000 ALTER TABLE `election_close_stats` DISABLE KEYS */;
INSERT INTO `election_close_stats` VALUES (47,6,9,349,0,1351,0,0,10,'2016-02-19 23:26:14',171),(48,6,9,254,0,1246,0,0,10,'2016-02-19 23:26:35',172),(49,12,56,0,0,1,0,0,1,'2016-04-01 08:02:04',228),(50,16,61,0,0,1,0,0,1,'2016-04-01 08:13:12',233);
/*!40000 ALTER TABLE `election_close_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `election_stats`
--

DROP TABLE IF EXISTS `election_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `election_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `electionid` int(11) NOT NULL,
  `polling_station_id` int(11) NOT NULL,
  `ballotpaper` int(11) NOT NULL,
  `postalpack` int(11) NOT NULL,
  `postalpack_collected` int(11) NOT NULL,
  `spoilt_ballot` int(11) NOT NULL,
  `ten_ballot_papers` int(11) NOT NULL,
  `ten_spoilt_ballots` int(11) NOT NULL,
  `updatedon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `electstat_fk1_idx` (`organization_id`),
  KEY `electstat_fk2_idx` (`electionid`),
  KEY `elecstat_fk3_idx` (`polling_station_id`),
  CONSTRAINT `elecstat_fk3` FOREIGN KEY (`polling_station_id`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `electstat_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `electstat_fk2` FOREIGN KEY (`electionid`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2974 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election_stats`
--

LOCK TABLES `election_stats` WRITE;
/*!40000 ALTER TABLE `election_stats` DISABLE KEYS */;
INSERT INTO `election_stats` VALUES (1565,10,12,177,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1566,10,12,178,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1567,10,12,178,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1569,10,12,179,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1570,10,12,179,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1571,10,12,179,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1572,10,12,180,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1573,10,12,180,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1574,10,12,180,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1575,10,12,180,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1579,10,12,181,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1580,10,12,181,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1581,10,12,181,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1582,10,12,181,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1583,10,12,181,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1586,10,12,182,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1587,10,12,182,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1588,10,12,182,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1589,10,12,182,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1590,10,12,182,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1591,10,12,182,0,0,0,0,0,0,'2016-03-18 19:49:44'),(1593,10,12,181,154,45,45,54,0,0,'2016-03-18 20:15:12'),(1594,10,12,181,1325,55,0,45,0,0,'2016-03-18 21:15:12'),(1595,10,12,182,456,4,4,444,0,0,'2016-03-18 20:15:12'),(1596,10,12,182,555,10,1,12,0,0,'2016-03-18 21:15:12'),(1597,10,13,177,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1598,10,13,178,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1599,10,13,178,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1601,10,13,179,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1602,10,13,179,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1603,10,13,179,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1604,10,13,180,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1605,10,13,180,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1606,10,13,180,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1607,10,13,180,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1611,10,13,181,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1612,10,13,181,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1613,10,13,181,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1614,10,13,181,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1615,10,13,181,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1618,10,13,182,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1619,10,13,182,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1620,10,13,182,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1621,10,13,182,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1622,10,13,182,0,0,0,0,0,0,'2016-03-18 19:55:10'),(1623,10,13,182,0,0,0,0,0,0,'2016-03-18 19:55:10'),(2776,12,17,199,100,50,50,10,0,0,'2016-03-31 07:15:12'),(2777,12,17,199,0,0,0,0,0,0,'2016-03-31 10:15:12'),(2778,12,17,199,50,0,0,0,0,0,'2016-03-31 09:15:12'),(2779,12,17,199,0,0,0,0,0,0,'2016-03-31 14:15:12'),(2780,12,17,199,0,0,0,0,0,0,'2016-03-31 13:15:12'),(2781,12,17,199,0,0,0,0,0,0,'2016-03-31 16:15:12'),(2782,12,17,199,0,0,0,0,0,0,'2016-03-31 11:15:12'),(2783,12,17,199,0,0,0,0,0,0,'2016-03-31 12:15:12'),(2784,12,17,199,0,0,0,0,0,0,'2016-03-31 18:15:12'),(2785,12,17,199,0,0,0,0,0,0,'2016-03-31 20:15:12'),(2786,12,17,199,0,0,0,0,0,0,'2016-03-31 17:15:12'),(2787,12,17,199,0,0,0,0,0,0,'2016-03-31 19:15:12'),(2788,12,17,199,0,0,0,0,0,0,'2016-03-31 15:15:12'),(2789,12,17,199,0,0,0,0,0,0,'2016-03-31 10:58:22'),(2790,12,17,200,0,0,0,0,0,0,'2016-03-31 10:58:22'),(2791,12,17,201,0,0,0,0,0,0,'2016-03-31 10:58:22'),(2792,12,17,202,0,0,0,0,0,0,'2016-03-31 10:58:22'),(2793,12,17,203,100,0,0,0,0,0,'2016-03-31 10:58:22'),(2794,12,17,204,0,0,0,0,0,0,'2016-03-31 10:58:22'),(2796,12,18,205,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2797,12,18,206,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2798,12,18,207,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2799,12,18,208,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2800,12,18,209,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2801,12,18,210,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2802,12,18,211,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2803,12,18,212,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2804,12,18,213,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2805,12,18,214,0,0,0,0,0,0,'2016-03-31 10:58:26'),(2811,12,17,201,-9445,0,0,0,0,0,'2016-03-31 07:15:12'),(2812,12,17,201,11656,0,0,0,0,0,'2016-03-31 09:15:12'),(2813,12,17,201,0,0,0,0,0,0,'2016-03-31 11:15:12'),(2814,12,17,201,0,0,0,0,0,0,'2016-03-31 14:15:12'),(2815,12,17,201,0,0,0,0,0,0,'2016-03-31 13:15:12'),(2816,12,17,201,0,0,0,0,0,0,'2016-03-31 15:15:12'),(2817,12,17,201,0,0,0,0,0,0,'2016-03-31 17:15:12'),(2818,12,17,201,0,0,0,0,0,0,'2016-03-31 12:15:12'),(2819,12,17,201,0,0,0,0,0,0,'2016-03-31 08:15:12'),(2820,12,17,201,0,0,0,0,0,0,'2016-03-31 18:15:12'),(2821,12,17,201,0,0,0,0,0,0,'2016-03-31 16:15:12'),(2822,12,17,201,0,0,0,0,0,0,'2016-03-31 19:15:12'),(2823,12,17,201,0,0,0,0,0,0,'2016-03-31 20:15:12'),(2824,12,17,201,0,0,0,0,0,0,'2016-03-31 21:15:12'),(2825,12,17,203,100,0,0,0,0,0,'2016-03-31 07:15:12'),(2826,12,17,203,1000,0,0,0,0,0,'2016-03-31 08:15:12'),(2827,12,17,203,10,0,0,0,0,0,'2016-03-31 09:15:12'),(2828,12,17,203,100,0,0,0,0,0,'2016-03-31 11:15:12'),(2829,12,17,203,100,0,0,0,0,0,'2016-03-31 12:15:12'),(2830,13,46,216,0,0,0,0,0,0,'2016-03-31 17:30:26'),(2831,13,46,217,0,0,0,0,0,0,'2016-03-31 17:30:26'),(2832,13,46,217,0,0,0,0,0,0,'2016-03-31 17:30:26'),(2834,13,46,218,0,0,0,0,0,0,'2016-03-31 19:55:28'),(2835,13,46,218,0,0,0,0,0,0,'2016-03-31 19:55:28'),(2836,13,46,218,0,0,0,0,0,0,'2016-03-31 19:55:28'),(2837,13,46,219,0,0,0,0,0,0,'2016-03-31 19:55:28'),(2838,13,46,219,0,0,0,0,0,0,'2016-03-31 19:55:28'),(2839,13,46,219,0,0,0,0,0,0,'2016-03-31 19:55:28'),(2840,13,46,219,0,0,0,0,0,0,'2016-03-31 19:55:28'),(2844,13,47,218,0,0,0,0,0,0,'2016-03-31 20:45:53'),(2845,13,46,220,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2846,13,46,220,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2847,13,46,220,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2848,13,46,220,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2849,13,46,220,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2852,13,46,221,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2853,13,46,221,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2854,13,46,221,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2855,13,46,221,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2856,13,46,221,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2857,13,46,221,0,0,0,0,0,0,'2016-03-31 20:57:51'),(2859,13,47,216,0,0,0,0,0,0,'2016-03-31 20:59:28'),(2860,13,47,216,0,0,0,0,0,0,'2016-03-31 20:59:28'),(2862,13,47,222,0,0,0,0,0,0,'2016-03-31 21:00:58'),(2863,13,47,222,0,0,0,0,0,0,'2016-03-31 21:00:58'),(2864,13,47,222,0,0,0,0,0,0,'2016-03-31 21:00:58'),(2865,13,47,223,0,0,0,0,0,0,'2016-03-31 21:00:58'),(2866,13,47,223,0,0,0,0,0,0,'2016-03-31 21:00:58'),(2867,13,47,223,0,0,0,0,0,0,'2016-03-31 21:00:58'),(2868,13,47,223,0,0,0,0,0,0,'2016-03-31 21:00:58'),(2872,14,48,224,0,0,0,0,0,0,'2016-03-31 21:57:38'),(2873,14,48,225,0,0,0,0,0,0,'2016-03-31 21:57:38'),(2874,14,48,225,0,0,0,0,0,0,'2016-03-31 21:57:38'),(2876,14,48,226,0,0,0,0,0,0,'2016-04-01 03:59:21'),(2877,14,48,226,0,0,0,0,0,0,'2016-04-01 03:59:21'),(2878,14,48,226,0,0,0,0,0,0,'2016-04-01 03:59:21'),(2879,14,48,227,0,0,0,0,0,0,'2016-04-01 03:59:21'),(2880,14,48,227,0,0,0,0,0,0,'2016-04-01 03:59:21'),(2881,14,48,227,0,0,0,0,0,0,'2016-04-01 03:59:21'),(2882,14,48,227,0,0,0,0,0,0,'2016-04-01 03:59:21'),(2886,12,27,201,0,0,0,0,0,0,'2016-04-01 07:15:12'),(2887,12,27,201,0,0,0,8,0,0,'2016-04-01 11:15:12'),(2888,12,27,201,0,0,0,0,0,0,'2016-04-01 09:15:12'),(2889,12,27,201,0,0,0,0,0,0,'2016-04-01 10:15:12'),(2890,12,27,201,0,0,0,0,0,0,'2016-04-01 12:15:12'),(2891,12,27,201,0,0,0,0,0,0,'2016-04-01 13:15:12'),(2892,12,27,201,0,0,0,0,0,0,'2016-04-01 16:15:12'),(2893,12,27,201,0,0,0,0,0,0,'2016-04-01 14:15:12'),(2894,12,27,201,0,0,0,0,0,0,'2016-04-01 15:15:12'),(2895,12,27,201,0,0,0,0,0,0,'2016-04-01 17:15:12'),(2896,12,27,201,0,0,0,0,0,0,'2016-04-01 19:15:12'),(2897,12,27,201,0,0,0,0,0,0,'2016-04-01 18:15:12'),(2898,12,27,201,0,0,0,0,0,0,'2016-04-01 20:15:12'),(2899,12,27,201,0,0,0,0,0,0,'2016-04-01 21:15:12'),(2900,12,27,201,0,0,0,0,0,0,'2016-04-01 08:15:12'),(2901,12,51,228,0,0,0,0,0,0,'2016-04-01 04:42:08'),(2902,12,50,228,0,0,0,0,0,0,'2016-04-01 04:43:14'),(2903,12,17,228,0,0,0,0,0,0,'2016-04-01 05:13:26'),(2904,12,17,228,0,0,0,0,0,0,'2016-04-01 05:13:26'),(2905,12,17,228,0,0,0,0,0,0,'2016-04-01 05:13:26'),(2906,12,17,228,0,0,0,0,0,0,'2016-04-01 05:13:26'),(2907,12,17,228,0,0,0,0,0,0,'2016-04-01 05:13:26'),(2908,12,17,228,0,0,0,0,0,0,'2016-04-01 05:13:26'),(2909,12,17,228,0,0,0,0,0,0,'2016-04-01 05:13:26'),(2910,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2911,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2912,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2913,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2914,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2915,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2916,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2917,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2918,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2919,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2920,12,18,228,0,0,0,0,0,0,'2016-04-01 05:16:11'),(2925,12,55,229,0,0,0,0,0,0,'2016-04-01 05:35:15'),(2926,12,55,228,0,0,0,0,0,0,'2016-04-01 05:35:15'),(2927,12,55,228,0,0,0,0,0,0,'2016-04-01 05:35:15'),(2929,12,55,230,0,0,0,0,0,0,'2016-04-01 05:35:15'),(2930,12,55,230,0,0,0,0,0,0,'2016-04-01 05:35:15'),(2931,12,55,230,0,0,0,0,0,0,'2016-04-01 05:35:15'),(2932,12,56,228,0,0,0,0,0,0,'2016-04-01 05:41:22'),(2933,12,57,229,0,0,0,0,0,0,'2016-04-01 05:56:27'),(2934,12,57,228,0,0,0,0,0,0,'2016-04-01 05:56:27'),(2935,12,57,228,0,0,0,0,0,0,'2016-04-01 05:56:27'),(2937,12,58,228,0,0,0,0,0,0,'2016-04-01 06:09:19'),(2938,12,59,229,0,0,0,0,0,0,'2016-04-01 06:16:49'),(2939,12,59,228,0,0,0,0,0,0,'2016-04-01 06:16:49'),(2940,12,59,228,0,0,0,0,0,0,'2016-04-01 06:16:49'),(2942,12,59,230,0,0,0,0,0,0,'2016-04-01 06:16:49'),(2943,12,59,230,0,0,0,0,0,0,'2016-04-01 06:16:49'),(2944,12,59,230,0,0,0,0,0,0,'2016-04-01 06:16:49'),(2945,12,60,229,0,0,0,0,0,0,'2016-04-01 06:28:08'),(2946,12,60,228,0,0,0,0,0,0,'2016-04-01 06:28:08'),(2947,12,60,228,0,0,0,0,0,0,'2016-04-01 06:28:08'),(2949,16,62,231,0,0,0,0,0,0,'2016-04-01 06:46:03'),(2950,16,62,232,0,0,0,0,0,0,'2016-04-01 06:46:03'),(2951,16,62,232,0,0,0,0,0,0,'2016-04-01 06:46:03'),(2953,16,61,233,0,0,0,0,0,0,'2016-04-01 06:46:57'),(2954,16,61,234,0,0,0,0,0,0,'2016-04-01 06:46:57'),(2955,16,61,234,0,0,0,0,0,0,'2016-04-01 06:46:57'),(2957,16,63,231,0,0,0,0,0,0,'2016-04-01 06:59:07'),(2958,16,63,232,0,0,0,0,0,0,'2016-04-01 06:59:07'),(2959,16,63,232,0,0,0,0,0,0,'2016-04-01 06:59:07'),(2961,15,53,235,0,0,0,0,0,0,'2016-04-01 07:04:50'),(2962,15,53,236,0,0,0,0,0,0,'2016-04-01 07:05:26'),(2963,15,53,237,0,0,0,0,0,0,'2016-04-01 07:05:41'),(2964,16,65,231,0,0,0,0,0,0,'2016-04-01 07:17:04'),(2965,16,65,232,0,0,0,0,0,0,'2016-04-01 07:17:04'),(2966,16,65,232,0,0,0,0,0,0,'2016-04-01 07:17:04'),(2968,16,65,238,0,0,0,0,0,0,'2016-04-01 07:17:04'),(2969,16,65,238,0,0,0,0,0,0,'2016-04-01 07:17:04'),(2970,16,65,238,0,0,0,0,0,0,'2016-04-01 07:17:04'),(2971,12,50,228,1,0,0,0,0,0,'2016-04-01 05:15:12'),(2972,12,50,228,0,0,0,0,0,0,'2016-04-01 07:15:12'),(2973,12,50,228,0,0,0,0,0,0,'2016-04-01 06:15:12');
/*!40000 ALTER TABLE `election_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hierarchy`
--

DROP TABLE IF EXISTS `hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hierarchy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedon` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hier_fk1_idx` (`organization_id`),
  KEY `hier_fk1_idx1` (`parent_id`),
  CONSTRAINT `hier_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hierarchy`
--

LOCK TABLES `hierarchy` WRITE;
/*!40000 ALTER TABLE `hierarchy` DISABLE KEYS */;
INSERT INTO `hierarchy` VALUES (1,2,'Electorate',NULL,1,'2016-01-13 20:50:05',NULL),(2,2,'Ward',1,2,'2016-01-13 20:51:37',NULL),(3,2,'District',2,3,'2016-01-13 20:51:37',NULL),(4,2,'Place',3,4,'2016-01-13 20:51:37',NULL),(5,3,'Electorate',NULL,1,'2016-01-13 20:51:37',NULL),(6,3,'Ward',5,2,'2016-01-13 20:51:37',NULL),(7,3,'District',6,3,'2016-01-13 20:51:37',NULL),(8,3,'Place',7,4,'2016-01-13 20:51:37',NULL),(9,4,'Electorate',NULL,1,'2016-01-13 20:51:37',NULL),(10,4,'Ward',9,2,'2016-01-13 20:51:37',NULL),(11,4,'District',10,3,'2016-01-13 20:51:37',NULL),(12,4,'Place',11,4,'2016-01-13 20:51:37',NULL),(13,5,'polling district ',NULL,1,'2016-02-02 15:39:44',NULL),(14,5,'polling place',13,2,'2016-02-02 15:40:22',NULL),(15,5,'polling station',14,3,'2016-02-02 15:40:49',NULL),(16,6,'Ward',NULL,1,'2016-02-05 09:54:56',NULL),(17,6,'District',16,2,'2016-02-05 09:55:30',NULL),(18,6,'Place',17,3,'2016-02-05 09:56:00',NULL),(19,9,'Electorate',NULL,1,'2016-02-05 09:56:00',NULL),(20,9,'Ward',NULL,2,'2016-02-05 09:56:00',NULL),(21,9,'District',NULL,3,'2016-02-05 09:56:00',NULL),(22,9,'Place',NULL,4,'2016-02-05 09:56:00',NULL),(23,10,'Electorate',NULL,1,'2016-03-18 19:37:17',NULL),(24,10,'Ward',23,2,'2016-03-18 19:37:17',NULL),(25,10,'District',24,3,'2016-03-18 19:37:17',NULL),(26,10,'Place',25,4,'2016-03-18 19:37:17',NULL),(31,12,'Electorate',NULL,1,'2016-03-22 11:53:17',NULL),(32,12,'Ward',31,2,'2016-03-22 11:53:17',NULL),(33,12,'District',32,3,'2016-03-22 11:53:17',NULL),(34,12,'Place',33,4,'2016-03-22 11:53:17',NULL),(35,13,'Electorate',NULL,1,'2016-03-31 17:25:30',NULL),(36,13,'Ward',35,2,'2016-03-31 17:25:30',NULL),(37,13,'District',36,3,'2016-03-31 17:25:30',NULL),(38,13,'Place',37,4,'2016-03-31 17:25:30',NULL),(39,14,'Electorate',NULL,1,'2016-03-31 21:46:35',NULL),(40,14,'Ward',39,2,'2016-03-31 21:46:35',NULL),(41,14,'District',40,3,'2016-03-31 21:46:35',NULL),(42,14,'Place',41,4,'2016-03-31 21:46:35',NULL),(43,15,'Electorate',NULL,1,'2016-04-01 05:21:08',NULL),(44,15,'Ward',43,2,'2016-04-01 05:21:08',NULL),(45,15,'District',44,3,'2016-04-01 05:21:08',NULL),(46,15,'Place',45,4,'2016-04-01 05:21:08',NULL),(47,16,'Electorate',NULL,1,'2016-04-01 06:34:14',NULL),(48,16,'Ward',47,2,'2016-04-01 06:34:14',NULL),(49,16,'District',48,3,'2016-04-01 06:34:14',NULL),(50,16,'Place',49,4,'2016-04-01 06:34:14',NULL),(51,17,'Electorate',NULL,1,'2016-04-01 06:40:34',NULL),(52,17,'Ward',51,2,'2016-04-01 06:40:34',NULL),(53,17,'District',52,3,'2016-04-01 06:40:34',NULL),(54,17,'Place',53,4,'2016-04-01 06:40:34',NULL);
/*!40000 ALTER TABLE `hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hierarchy_value`
--

DROP TABLE IF EXISTS `hierarchy_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hierarchy_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `hierarchy_id` int(11) NOT NULL,
  `value` varchar(1000) NOT NULL,
  `geo_shape_url` varchar(500) DEFAULT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdatedon` timestamp NULL DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hei_val_fk1_idx` (`organization_id`),
  KEY `hei_val_fk2_idx` (`hierarchy_id`),
  KEY `hei_val_pid_idx` (`parent_id`),
  CONSTRAINT `hei_val_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `hei_val_fk2` FOREIGN KEY (`hierarchy_id`) REFERENCES `hierarchy` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=791 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hierarchy_value`
--

LOCK TABLES `hierarchy_value` WRITE;
/*!40000 ALTER TABLE `hierarchy_value` DISABLE KEYS */;
INSERT INTO `hierarchy_value` VALUES (1,2,1,'Electorate1',NULL,'2016-01-13 20:53:35',NULL,NULL),(2,2,2,'Ward 1',NULL,'2016-01-13 20:54:25',NULL,1),(3,2,3,'District 1',NULL,'2016-01-13 20:54:25',NULL,2),(4,2,4,'Place 1',NULL,'2016-01-13 20:54:25',NULL,3),(5,3,5,'Electorate1',NULL,'2016-01-21 13:48:05',NULL,NULL),(6,3,6,'Ward 1',NULL,'2016-01-21 13:48:05',NULL,5),(7,3,7,'District 1',NULL,'2016-01-21 13:48:06',NULL,6),(8,3,8,'Brickkiln Community Centre',NULL,'2016-01-21 13:48:06',NULL,7),(9,3,8,'Merridale Primari School',NULL,'2016-01-21 13:48:07',NULL,7),(10,4,9,'Electorate1',NULL,'2016-01-21 13:51:23',NULL,NULL),(11,4,10,'Ward 1',NULL,'2016-01-21 13:51:23',NULL,10),(12,4,11,'District 1',NULL,'2016-01-21 13:51:24',NULL,11),(13,4,12,'Lainshaw Primary School',NULL,'2016-01-21 13:51:24',NULL,12),(14,4,12,'Kilmaurs Primary School',NULL,'2016-01-21 13:51:25',NULL,12),(15,2,2,'Ward 2',NULL,'2016-01-13 20:54:25',NULL,1),(420,5,13,'DN0104',NULL,'2016-02-03 02:13:55',NULL,NULL),(421,5,13,'DN0108',NULL,'2016-02-03 02:13:55',NULL,NULL),(422,5,13,'DN0109',NULL,'2016-02-03 02:13:56',NULL,NULL),(423,5,13,'DN0209',NULL,'2016-02-03 02:13:56',NULL,NULL),(424,5,13,'DS0306',NULL,'2016-02-03 02:13:56',NULL,NULL),(425,5,13,'DN0301',NULL,'2016-02-03 02:13:56',NULL,NULL),(426,5,13,'DN0302',NULL,'2016-02-03 02:13:57',NULL,NULL),(427,5,13,'DN0303',NULL,'2016-02-03 02:13:57',NULL,NULL),(428,5,13,'DN0304',NULL,'2016-02-03 02:13:57',NULL,NULL),(429,5,13,'DN0305',NULL,'2016-02-03 02:13:57',NULL,NULL),(430,5,13,'DS0308',NULL,'2016-02-03 02:13:58',NULL,NULL),(431,5,13,'DN0307',NULL,'2016-02-03 02:13:58',NULL,NULL),(432,5,13,'DN0309',NULL,'2016-02-03 02:13:58',NULL,NULL),(433,5,13,'DN0310',NULL,'2016-02-03 02:13:58',NULL,NULL),(434,5,13,'DN0401',NULL,'2016-02-03 02:13:58',NULL,NULL),(435,5,13,'DN0402',NULL,'2016-02-03 02:13:59',NULL,NULL),(436,5,13,'DN0403',NULL,'2016-02-03 02:13:59',NULL,NULL),(437,5,13,'DN0404',NULL,'2016-02-03 02:13:59',NULL,NULL),(438,5,13,'DN0405',NULL,'2016-02-03 02:13:59',NULL,NULL),(439,5,13,'DN0406',NULL,'2016-02-03 02:14:00',NULL,NULL),(440,5,13,'DN0407',NULL,'2016-02-03 02:14:00',NULL,NULL),(441,5,13,'DN0408',NULL,'2016-02-03 02:14:00',NULL,NULL),(442,5,13,'DN0501',NULL,'2016-02-03 02:14:00',NULL,NULL),(443,5,13,'DN0502',NULL,'2016-02-03 02:14:01',NULL,NULL),(444,5,13,'DN0503',NULL,'2016-02-03 02:14:01',NULL,NULL),(445,5,13,'DN0504',NULL,'2016-02-03 02:14:01',NULL,NULL),(446,5,13,'DN0505',NULL,'2016-02-03 02:14:01',NULL,NULL),(447,5,13,'CN0506',NULL,'2016-02-03 02:14:04',NULL,NULL),(448,5,13,'CN0507',NULL,'2016-02-03 02:14:05',NULL,NULL),(449,5,13,'CN0508',NULL,'2016-02-03 02:14:06',NULL,NULL),(450,5,13,'CN0601',NULL,'2016-02-03 02:14:06',NULL,NULL),(451,5,13,'CN0602',NULL,'2016-02-03 02:14:07',NULL,NULL),(452,5,13,'CN0603',NULL,'2016-02-03 02:14:07',NULL,NULL),(453,5,13,'CN0604',NULL,'2016-02-03 02:14:08',NULL,NULL),(454,5,13,'CN0605',NULL,'2016-02-03 02:14:08',NULL,NULL),(455,5,13,'CN0606',NULL,'2016-02-03 02:14:09',NULL,NULL),(456,5,13,'CN0701',NULL,'2016-02-03 02:14:09',NULL,NULL),(457,5,13,'CN0702',NULL,'2016-02-03 02:14:10',NULL,NULL),(458,5,13,'CN0703',NULL,'2016-02-03 02:14:10',NULL,NULL),(459,5,13,'CN0704',NULL,'2016-02-03 02:14:10',NULL,NULL),(460,5,13,'CN0801',NULL,'2016-02-03 02:14:10',NULL,NULL),(461,5,13,'CN0802',NULL,'2016-02-03 02:14:11',NULL,NULL),(462,5,13,'CN0803',NULL,'2016-02-03 02:14:11',NULL,NULL),(463,5,13,'CN0805',NULL,'2016-02-03 02:14:12',NULL,NULL),(464,5,13,'CN0806',NULL,'2016-02-03 02:14:14',NULL,NULL),(465,5,13,'CN0807',NULL,'2016-02-03 02:14:15',NULL,NULL),(466,5,13,'CN0808',NULL,'2016-02-03 02:14:15',NULL,NULL),(467,5,13,'SN1003',NULL,'2016-02-03 02:14:15',NULL,NULL),(468,5,13,'CS0705',NULL,'2016-02-03 02:14:15',NULL,NULL),(469,5,13,'CS0706',NULL,'2016-02-03 02:14:15',NULL,NULL),(470,5,13,'CS0804',NULL,'2016-02-03 02:14:16',NULL,NULL),(471,5,13,'SS0901',NULL,'2016-02-03 02:14:16',NULL,NULL),(472,5,13,'SS0902',NULL,'2016-02-03 02:14:16',NULL,NULL),(473,5,13,'SS0903',NULL,'2016-02-03 02:14:16',NULL,NULL),(474,5,13,'SS0904',NULL,'2016-02-03 02:14:17',NULL,NULL),(475,5,13,'SS0905',NULL,'2016-02-03 02:14:17',NULL,NULL),(476,5,13,'SS0906',NULL,'2016-02-03 02:14:17',NULL,NULL),(477,5,13,'SN1002',NULL,'2016-02-03 02:14:17',NULL,NULL),(478,5,13,'SS1001',NULL,'2016-02-03 02:14:17',NULL,NULL),(479,5,13,'CN1005',NULL,'2016-02-03 02:14:18',NULL,NULL),(480,5,13,'CS1004',NULL,'2016-02-03 02:14:18',NULL,NULL),(481,5,13,'SS1006',NULL,'2016-02-03 02:14:18',NULL,NULL),(482,5,13,'SS1007',NULL,'2016-02-03 02:14:18',NULL,NULL),(483,5,13,'CS1008',NULL,'2016-02-03 02:14:19',NULL,NULL),(484,5,13,'CS1009',NULL,'2016-02-03 02:14:19',NULL,NULL),(485,5,13,'CS1010',NULL,'2016-02-03 02:14:19',NULL,NULL),(486,5,13,'SS1101',NULL,'2016-02-03 02:14:20',NULL,NULL),(487,5,13,'SS1102',NULL,'2016-02-03 02:14:20',NULL,NULL),(488,5,13,'SS1103',NULL,'2016-02-03 02:14:21',NULL,NULL),(489,5,13,'CS1104',NULL,'2016-02-03 02:14:21',NULL,NULL),(490,5,13,'SS1105',NULL,'2016-02-03 02:14:22',NULL,NULL),(491,5,13,'SS1106',NULL,'2016-02-03 02:14:26',NULL,NULL),(492,5,13,'SS1107',NULL,'2016-02-03 02:14:29',NULL,NULL),(493,5,13,'CS1108',NULL,'2016-02-03 02:14:29',NULL,NULL),(494,5,13,'CN1202',NULL,'2016-02-03 02:14:30',NULL,NULL),(495,5,13,'CS1201',NULL,'2016-02-03 02:14:30',NULL,NULL),(496,5,13,'CS1203',NULL,'2016-02-03 02:14:30',NULL,NULL),(497,5,13,'CS1204',NULL,'2016-02-03 02:14:30',NULL,NULL),(498,5,13,'CS1205',NULL,'2016-02-03 02:14:32',NULL,NULL),(499,5,13,'SS1206',NULL,'2016-02-03 02:14:32',NULL,NULL),(500,5,13,'SS1207',NULL,'2016-02-03 02:14:32',NULL,NULL),(501,5,13,'SS1208',NULL,'2016-02-03 02:14:33',NULL,NULL),(502,5,13,'SS1209',NULL,'2016-02-03 02:14:34',NULL,NULL),(503,5,13,'SS1301',NULL,'2016-02-03 02:14:35',NULL,NULL),(504,5,13,'SS1302',NULL,'2016-02-03 02:14:36',NULL,NULL),(505,5,13,'SS1303',NULL,'2016-02-03 02:14:39',NULL,NULL),(506,5,13,'SS1304',NULL,'2016-02-03 02:14:39',NULL,NULL),(507,5,13,'SS1305',NULL,'2016-02-03 02:14:39',NULL,NULL),(508,5,13,'SS1306',NULL,'2016-02-03 02:14:40',NULL,NULL),(509,5,13,'SS1307',NULL,'2016-02-03 02:14:40',NULL,NULL),(600,5,14,'DN0104-BEACON COMMUNITY CENTRE',NULL,'2016-02-03 02:41:07',NULL,420),(601,5,14,'DN0108-BRIMMOND SCHOOL',NULL,'2016-02-03 02:41:07',NULL,421),(602,5,14,'DN0109-DANESTONE CONGREGATIONAL CHURCH',NULL,'2016-02-03 02:41:07',NULL,422),(603,5,14,'DN0209-BALGOWNIE COMMUNITY CENTRE',NULL,'2016-02-03 02:41:08',NULL,423),(604,5,14,'DS0306-KINGSWELLS COMMUNITY CENTRE',NULL,'2016-02-03 02:41:08',NULL,424),(605,5,14,'DN0301-KINGSWELLS COMMUNITY CENTRE',NULL,'2016-02-03 02:41:08',NULL,425),(606,5,14,'DN0302-KINGSWELLS COMMUNITY CENTRE',NULL,'2016-02-03 02:41:08',NULL,426),(607,5,14,'DN0303-KINGSFORD PRIMARY SCHOOL',NULL,'2016-02-03 02:41:09',NULL,427),(608,5,14,'DN0304-SHEDDOCKSLEY COMMUNITY CENTRE',NULL,'2016-02-03 02:41:09',NULL,428),(609,5,14,'DN0305-MUIRFIELD PRIMARY SCHOOL',NULL,'2016-02-03 02:41:09',NULL,429),(610,5,14,'DS0308-SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-02-03 02:41:09',NULL,430),(611,5,14,'DN0307-SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-02-03 02:41:10',NULL,431),(612,5,14,'DN0309-SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-02-03 02:41:10',NULL,432),(613,5,14,'DN0310-SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-02-03 02:41:10',NULL,433),(614,5,14,'DN0401-HEATHRYBURN SCHOOL',NULL,'2016-02-03 02:41:10',NULL,434),(615,5,14,'DN0402-L P HENRY E RAE COMMUNITY CENTRE',NULL,'2016-02-03 02:41:10',NULL,435),(616,5,14,'DN0403-MANOR PARK PRIMARY SCHOOL',NULL,'2016-02-03 02:41:11',NULL,436),(617,5,14,'DN0404-NORTHFIELD COMMUNITY CENTRE',NULL,'2016-02-03 02:41:11',NULL,437),(618,5,14,'DN0405-NORTHFIELD COMMUNITY CENTRE',NULL,'2016-02-03 02:41:11',NULL,438),(619,5,14,'DN0406-CUMMINGS PARK COMMUNITY CENTRE',NULL,'2016-02-03 02:41:11',NULL,439),(620,5,14,'DN0407-MASTRICK COMMUNITY CENTRE',NULL,'2016-02-03 02:41:12',NULL,440),(621,5,14,'DN0408-QUARRYHILL PRIMARY SCHOOL',NULL,'2016-02-03 02:41:12',NULL,441),(622,5,14,'DN0501-HILTON COMMUNITY CENTRE',NULL,'2016-02-03 02:41:12',NULL,442),(623,5,14,'DN0502-HILTON COMMUNITY CENTRE',NULL,'2016-02-03 02:41:12',NULL,443),(624,5,14,'DN0503-WOODSIDE COMMUNITY CENTRE',NULL,'2016-02-03 02:41:13',NULL,444),(625,5,14,'DN0504-HIGH CHURCH HILTON',NULL,'2016-02-03 02:41:13',NULL,445),(626,5,14,'DN0505-HIGH CHURCH HILTON',NULL,'2016-02-03 02:41:13',NULL,446),(627,5,14,'CN0506-CAIRNCRY COMMUNITY CENTRE',NULL,'2016-02-03 02:41:13',NULL,447),(628,5,14,'CN0507-CAIRNCRY COMMUNITY CENTRE',NULL,'2016-02-03 02:41:13',NULL,448),(629,5,14,'CN0508-KITTYBREWSTER PRIMARY SCHOOL',NULL,'2016-02-03 02:41:14',NULL,449),(630,5,14,'CN0601-RIVERBANK PRIMARY SCHOOL',NULL,'2016-02-03 02:41:14',NULL,450),(631,5,14,'CN0602-SEATON PRIMARY SCHOOL',NULL,'2016-02-03 02:41:14',NULL,451),(632,5,14,'CN0603-SEATON PRIMARY SCHOOL',NULL,'2016-02-03 02:41:14',NULL,452),(633,5,14,'CN0604-POWIS GATEWAY COMMUNITY CENTRE',NULL,'2016-02-03 02:41:15',NULL,453),(634,5,14,'CN0605-ST MARY\'S CHURCH KING STREET',NULL,'2016-02-03 02:41:15',NULL,454),(635,5,14,'CN0606-PITTODRIE STADIUM SIR ALEX FERGUSON LOUNGE',NULL,'2016-02-03 02:41:16',NULL,455),(636,5,14,'CN0701-MIDSTOCKET PARISH CHURCH',NULL,'2016-02-03 02:41:16',NULL,456),(637,5,14,'CN0702-MIDSTOCKET PARISH CHURCH',NULL,'2016-02-03 02:41:17',NULL,457),(638,5,14,'CN0703-ASHGROVE CHILDREN\'S CENTRE',NULL,'2016-02-03 02:41:17',NULL,458),(639,5,14,'CN0704-SKENE SQUARE PRIMARY SCHOOL',NULL,'2016-02-03 02:41:18',NULL,459),(640,5,14,'CN0801-CATHERINE STREET COMMUNITY CENTRE',NULL,'2016-02-03 02:41:19',NULL,460),(641,5,14,'CN0802-SUNNYBANK PRIMARY SCHOOL',NULL,'2016-02-03 02:41:19',NULL,461),(642,5,14,'CN0803-CATHERINE STREET COMMUNITY CENTRE',NULL,'2016-02-03 02:41:19',NULL,462),(643,5,14,'CN0805-SEAMOUNT COURT-TENANT\'S ROOM',NULL,'2016-02-03 02:41:20',NULL,463),(644,5,14,'CN0806-HANOVER COMMUNITY CENTRE',NULL,'2016-02-03 02:41:20',NULL,464),(645,5,14,'CN0807-HANOVER COMMUNITY CENTRE',NULL,'2016-02-03 02:41:20',NULL,465),(646,5,14,'CN0808-ABERDEEN CITADEL (SALVATION ARMY BUILDING)',NULL,'2016-02-03 02:41:20',NULL,466),(647,5,14,'SN1003-FERNIELEA PRIMARY SCHOOL',NULL,'2016-02-03 02:41:21',NULL,467),(648,5,14,'CS0705-NEW LIFE INTERNATIONAL CHURCH',NULL,'2016-02-03 02:41:21',NULL,468),(649,5,14,'CS0706-ST MARY\'S CATHEDRAL HALL',NULL,'2016-02-03 02:41:21',NULL,469),(650,5,14,'CS0804-CATHERINE STREET COMMUNITY CENTRE',NULL,'2016-02-03 02:41:21',NULL,470),(651,5,14,'SS0901-ST PETER\'S HERITAGE CENTRE',NULL,'2016-02-03 02:41:22',NULL,471),(652,5,14,'SS0902-PETERCULTER SPORTS CENTRE',NULL,'2016-02-03 02:41:22',NULL,472),(653,5,14,'SS0903-MILLTIMBER COMMUNITY HALL',NULL,'2016-02-03 02:41:22',NULL,473),(654,5,14,'SS0904-ST DEVENICK\'S CHURCH HALL',NULL,'2016-02-03 02:41:22',NULL,474),(655,5,14,'SS0905-CULTS KIRK CENTRE',NULL,'2016-02-03 02:41:22',NULL,475),(656,5,14,'SS0906-CULTS KIRK CENTRE',NULL,'2016-02-03 02:41:23',NULL,476),(657,5,14,'SN1002-HAZLEHEAD PRIMARY SCHOOL',NULL,'2016-02-03 02:41:23',NULL,477),(658,5,14,'SS1001-HAZLEHEAD PRIMARY SCHOOL',NULL,'2016-02-03 02:41:23',NULL,478),(659,5,14,'CN1005-ST MARY\'S EPISCOPAL CHURCH',NULL,'2016-02-03 02:41:23',NULL,479),(660,5,14,'CS1004-ST MARY\'S EPISCOPAL CHURCH',NULL,'2016-02-03 02:41:24',NULL,480),(661,5,14,'SS1006-CRAIGIEBUCKLER CHURCH HALL',NULL,'2016-02-03 02:41:24',NULL,481),(662,5,14,'SS1007-AIRYHALL COMMUNITY CENTRE',NULL,'2016-02-03 02:41:24',NULL,482),(663,5,14,'CS1008-QUEEN\'S CROSS PARISH CHURCH',NULL,'2016-02-03 02:41:24',NULL,483),(664,5,14,'CS1009-HOLBURN WEST CHURCH',NULL,'2016-02-03 02:41:25',NULL,484),(665,5,14,'CS1010-HOLBURN WEST CHURCH',NULL,'2016-02-03 02:41:25',NULL,485),(666,5,14,'SS1101-SCHOOL-BRAESIDE PLACE',NULL,'2016-02-03 02:41:25',NULL,486),(667,5,14,'SS1102-MANNOFIELD CHURCH CENTENARY HALL',NULL,'2016-02-03 02:41:25',NULL,487),(668,5,14,'SS1103-MANNOFIELD CHURCH CENTENARY HALL',NULL,'2016-02-03 02:41:26',NULL,488),(669,5,14,'CS1104-RUTHRIESTON OUTDOOR SPORTS CENTRE-PAVILION',NULL,'2016-02-03 02:41:26',NULL,489),(670,5,14,'SS1105-ST FRANCIS CHURCH HALL',NULL,'2016-02-03 02:41:26',NULL,490),(671,5,14,'SS1106-KAIMHILL COMMUNITY CENTRE',NULL,'2016-02-03 02:41:26',NULL,491),(672,5,14,'SS1107-KAIMHILL COMMUNITY CENTRE',NULL,'2016-02-03 02:41:26',NULL,492),(673,5,14,'CS1108-RUTHRIESTON COMMUNITY CENTRE',NULL,'2016-02-03 02:41:27',NULL,493),(674,5,14,'CN1202-FERRYHILL COMMUNITY CENTRE',NULL,'2016-02-03 02:41:27',NULL,494),(675,5,14,'CS1201-FERRYHILL COMMUNITY CENTRE',NULL,'2016-02-03 02:41:27',NULL,495),(676,5,14,'CS1203-FERRYHILL COMMUNITY CENTRE',NULL,'2016-02-03 02:41:27',NULL,496),(677,5,14,'CS1204-SOUTH HOLBURN CHURCH',NULL,'2016-02-03 02:41:28',NULL,497),(678,5,14,'CS1205-FERRYHILL CHURCH HALL',NULL,'2016-02-03 02:41:28',NULL,498),(679,5,14,'SS1206-TORRY YOUTH AND LEISURE CENTRE',NULL,'2016-02-03 02:41:28',NULL,499),(680,5,14,'SS1207-OLD TORRY COMMUNITY CENTRE',NULL,'2016-02-03 02:41:28',NULL,500),(681,5,14,'SS1208-TULLOS SCHOOL',NULL,'2016-02-03 02:41:28',NULL,501),(682,5,14,'SS1209-BALNAGASK COMMUNITY CENTRE',NULL,'2016-02-03 02:41:29',NULL,502),(683,5,14,'SS1301-ABBOTSWELL PRIMARY SCHOOL',NULL,'2016-02-03 02:41:29',NULL,503),(684,5,14,'SS1302-KINCORTH COMMUNITY CENTRE',NULL,'2016-02-03 02:41:29',NULL,504),(685,5,14,'SS1303-ALTENS COMMUNITY CENTRE',NULL,'2016-02-03 02:41:29',NULL,505),(686,5,14,'SS1304-ABBOTSWELL PRIMARY SCHOOL',NULL,'2016-02-03 02:41:30',NULL,506),(687,5,14,'SS1305-KINCORTH COMMUNITY CENTRE',NULL,'2016-02-03 02:41:30',NULL,507),(688,5,14,'SS1306-LOIRSTON ANNEXE',NULL,'2016-02-03 02:41:31',NULL,508),(689,5,14,'SS1307-LOIRSTON ANNEXE',NULL,'2016-02-03 02:41:31',NULL,509),(690,2,3,'Cool District',NULL,'2016-02-04 06:57:24',NULL,2),(691,6,16,'Amersham Town',NULL,'2016-02-05 09:57:20',NULL,NULL),(692,6,17,'Amersham',NULL,'2016-02-05 09:58:27',NULL,691),(693,6,18,'Royal British Legion Hall',NULL,'2016-02-05 09:59:19',NULL,692),(694,2,4,'Place2',NULL,'2016-02-05 18:59:06',NULL,3),(695,9,19,'Electorate2',NULL,'2016-02-05 18:59:06',NULL,NULL),(696,9,20,'Ward2',NULL,'2016-02-05 18:59:06',NULL,695),(697,9,21,'District2',NULL,'2016-02-05 18:59:06',NULL,696),(698,9,22,'Place2',NULL,'2016-02-05 18:59:06',NULL,697),(699,10,23,'Aberdeen',NULL,'2016-03-18 19:49:43',NULL,NULL),(700,10,24,'Aberdeen South',NULL,'2016-03-18 19:49:44',NULL,699),(701,10,25,'KINGSWELLS SOUTH',NULL,'2016-03-18 19:49:44',NULL,700),(702,10,26,'KINGSWELLS COMMUNITY CENTRE',NULL,'2016-03-18 19:49:44',NULL,701),(703,10,25,'WOODEND',NULL,'2016-03-18 19:49:44',NULL,700),(704,10,26,'SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-03-18 19:49:44',NULL,703),(705,10,25,'GILCOMSTON NORTH',NULL,'2016-03-18 19:49:44',NULL,700),(706,10,26,'NEW LIFE INTERNATIONAL CHURCH',NULL,'2016-03-18 19:49:44',NULL,705),(707,10,25,'GILCOMSTON SOUTH',NULL,'2016-03-18 19:49:44',NULL,700),(708,10,26,'ST MARY\'S CATHEDRAL HALL',NULL,'2016-03-18 19:49:44',NULL,707),(731,12,31,'Aberdeen',NULL,'2016-03-22 11:55:20',NULL,NULL),(732,12,32,'Aberdeen South',NULL,'2016-03-22 11:55:20',NULL,731),(733,12,33,'KINGSWELLS SOUTH',NULL,'2016-03-22 11:55:20',NULL,732),(734,12,34,'KINGSWELLS COMMUNITY CENTRE',NULL,'2016-03-22 11:55:20',NULL,733),(735,12,33,'WOODEND',NULL,'2016-03-22 11:55:20',NULL,732),(736,12,34,'SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-03-22 11:55:20',NULL,735),(737,12,33,'GILCOMSTON NORTH',NULL,'2016-03-22 11:55:20',NULL,732),(738,12,34,'NEW LIFE INTERNATIONAL CHURCH',NULL,'2016-03-22 11:55:20',NULL,737),(739,12,33,'GILCOMSTON SOUTH',NULL,'2016-03-22 11:55:20',NULL,732),(740,12,34,'ST MARY\'S CATHEDRAL HALL',NULL,'2016-03-22 11:55:20',NULL,739),(741,12,33,'WOOLMANHILL',NULL,'2016-03-22 11:57:21',NULL,732),(742,12,34,'CATHERINE STREET COMMUNITY CENTRE',NULL,'2016-03-22 11:57:21',NULL,741),(743,12,33,'PETERCULTER WEST',NULL,'2016-03-22 11:57:21',NULL,732),(744,12,34,'ST PETER\'S HERITAGE CENTRE',NULL,'2016-03-22 11:57:21',NULL,743),(745,12,33,'PETERCULTER EAST',NULL,'2016-03-22 11:57:21',NULL,732),(746,12,34,'PETERCULTER SPORTS CENTRE',NULL,'2016-03-22 11:57:21',NULL,745),(747,12,33,'MILLTIMBER',NULL,'2016-03-22 11:57:21',NULL,732),(748,12,34,'MILLTIMBER COMMUNITY HALL',NULL,'2016-03-22 11:57:21',NULL,747),(749,12,33,'BIELDSIDE',NULL,'2016-03-22 11:57:21',NULL,732),(750,12,34,'ST DEVENICK\'S CHURCH HALL',NULL,'2016-03-22 11:57:21',NULL,749),(751,12,33,'CULTS WEST',NULL,'2016-03-22 11:57:21',NULL,732),(752,12,34,'CULTS KIRK CENTRE',NULL,'2016-03-22 11:57:21',NULL,751),(753,13,35,'Aberdeen',NULL,'2016-03-31 17:30:26',NULL,NULL),(754,13,36,'Aberdeen South',NULL,'2016-03-31 17:30:26',NULL,753),(755,13,37,'KINGSWELLS SOUTH',NULL,'2016-03-31 17:30:26',NULL,754),(756,13,38,'KINGSWELLS COMMUNITY CENTRE',NULL,'2016-03-31 17:30:26',NULL,755),(757,13,37,'WOODEND',NULL,'2016-03-31 17:30:26',NULL,754),(758,13,38,'SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-03-31 17:30:26',NULL,757),(759,13,36,'Aberdeen City Council',NULL,'2016-03-31 20:43:44',NULL,753),(760,13,37,'Aberdeen Donside Constituency',NULL,'2016-03-31 20:43:44',NULL,759),(761,13,38,'DYCE CHURCH HALL',NULL,'2016-03-31 20:43:44',NULL,760),(762,14,39,'Aberdeen',NULL,'2016-03-31 21:57:38',NULL,NULL),(763,14,40,'Aberdeen South',NULL,'2016-03-31 21:57:38',NULL,762),(764,14,41,'KINGSWELLS SOUTH',NULL,'2016-03-31 21:57:38',NULL,763),(765,14,42,'KINGSWELLS COMMUNITY CENTRE',NULL,'2016-03-31 21:57:38',NULL,764),(766,14,41,'WOODEND',NULL,'2016-03-31 21:57:38',NULL,763),(767,14,42,'SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-03-31 21:57:38',NULL,766),(768,15,43,'Sri Lanka',NULL,'2016-04-01 05:21:08',NULL,NULL),(769,15,44,'Aberdeen City Council',NULL,'2016-04-01 05:27:05',NULL,768),(770,15,45,'Aberdeen Donside Constituency',NULL,'2016-04-01 05:27:05',NULL,769),(771,15,46,'DYCE CHURCH HALL',NULL,'2016-04-01 05:27:05',NULL,770),(772,12,33,'WOODEND bridge',NULL,'2016-04-01 05:41:22',NULL,732),(773,12,33,'KINGSWELLS NORTH',NULL,'2016-04-01 05:56:27',NULL,732),(774,16,47,'Aberdeen',NULL,'2016-04-01 06:46:03',NULL,NULL),(775,16,48,'Aberdeen South',NULL,'2016-04-01 06:46:03',NULL,774),(776,16,49,'KINGSWELLS SOUTH',NULL,'2016-04-01 06:46:03',NULL,775),(777,16,50,'KINGSWELLS COMMUNITY CENTRE',NULL,'2016-04-01 06:46:03',NULL,776),(778,16,49,'WOODEND',NULL,'2016-04-01 06:46:03',NULL,775),(779,16,50,'SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-04-01 06:46:03',NULL,778),(780,16,47,'Aberdeen2',NULL,'2016-04-01 06:46:57',NULL,NULL),(781,16,48,'Aberdeen North',NULL,'2016-04-01 06:46:57',NULL,780),(782,16,49,'KINGSWELLS SOUTH HALL',NULL,'2016-04-01 06:46:57',NULL,781),(783,16,50,'QUEENS COMMUNITY HALL',NULL,'2016-04-01 06:46:57',NULL,782),(784,16,49,'WOODEND BRIDGE',NULL,'2016-04-01 06:46:57',NULL,781),(785,16,50,'RANDOM CHURCH',NULL,'2016-04-01 06:46:57',NULL,784),(786,15,46,'DYCE CHURCH - DR COX ROOM',NULL,'2016-04-01 07:05:26',NULL,770),(787,16,47,'newlanka',NULL,'2016-04-01 07:17:04',NULL,NULL),(788,16,48,'newlanka 1',NULL,'2016-04-01 07:17:04',NULL,787),(789,16,49,'lanka',NULL,'2016-04-01 07:17:04',NULL,788),(790,16,50,'colombo center',NULL,'2016-04-01 07:17:04',NULL,789);
/*!40000 ALTER TABLE `hierarchy_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue`
--

DROP TABLE IF EXISTS `issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `pollingstation_id` int(11) DEFAULT NULL,
  `electionid` int(11) DEFAULT NULL,
  `issue_list_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `priority` int(11) NOT NULL COMMENT '1=low,2=medium,3=high',
  `resolution_list_id` int(11) DEFAULT NULL,
  `resolution_desc` text,
  `status` int(11) NOT NULL COMMENT '0=open,1=resolved',
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `resolvedon` timestamp NULL DEFAULT NULL,
  `reportedby` varchar(115) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_fk1_idx` (`organization_id`),
  KEY `issue_fk2_idx` (`issue_list_id`),
  KEY `issue_fk3_idx` (`resolution_list_id`),
  KEY `issue_fk4_idx` (`electionid`),
  KEY `issue_fk5_idx` (`pollingstation_id`),
  CONSTRAINT `issue_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issue_fk2` FOREIGN KEY (`issue_list_id`) REFERENCES `list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issue_fk3` FOREIGN KEY (`resolution_list_id`) REFERENCES `list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issue_fk4` FOREIGN KEY (`electionid`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issue_fk5` FOREIGN KEY (`pollingstation_id`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=564 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue`
--

LOCK TABLES `issue` WRITE;
/*!40000 ALTER TABLE `issue` DISABLE KEYS */;
INSERT INTO `issue` VALUES (428,6,171,NULL,235,'The heater at other end of hall has cables that are too short. Is it possible to have two extension leads? Aaron',2,NULL,'Hi Aaron. Lesley is going to bring two extension leads with her on her first inspection. We\'ll let you know when Lesley is leaving.',3,'2016-02-18 09:06:57',NULL,'apercival'),(429,6,171,NULL,235,'TEST - everything ok',1,NULL,'OK thanks',1,'2016-02-18 10:01:53','2016-02-18 10:04:51','apercival'),(430,6,171,NULL,232,'Power cut at hall. notified office and assistance will be on the way.\n\nphoned office at 10:45 and spoke to Lesley.',2,NULL,'Contacted key holder - locating fuse box to check if power can be restored. Blankets and lights to be delivered at next inspection. time to be confirmed.',3,'2016-02-18 10:52:54',NULL,'apercival'),(431,6,171,NULL,232,'Heating/Powercut update\n\nall ok now. issue was the extension lead that tripped the power. Using the other lead',1,NULL,'Ok thanks. Lesley will bring another extension lead, torches and blankets.',1,'2016-02-18 11:13:53','2016-02-18 11:17:53','apercival'),(432,6,171,NULL,235,'Hello Lesley. I had inputted a 1 on my side as well as Richards by accident so there should only be 3 not 4.',2,NULL,'Perfect thanks Aaron',2,'2016-02-18 18:11:23',NULL,'apercival'),(546,12,203,NULL,440,'1',3,NULL,NULL,0,'2016-03-31 11:20:38',NULL,'McDonald'),(547,12,204,NULL,440,'1',3,NULL,NULL,0,'2016-03-31 11:20:38',NULL,'McDonald'),(548,12,203,NULL,443,'2',2,NULL,NULL,0,'2016-03-31 11:21:08',NULL,'McDonald'),(549,12,203,NULL,447,'r',3,NULL,'my mistake resolved.',1,'2016-03-31 11:22:57','2016-03-31 11:25:13','McDonald'),(550,12,203,NULL,441,'hui0',2,NULL,NULL,0,'2016-03-31 11:44:37',NULL,'McDonald'),(551,12,203,NULL,444,'gui',2,NULL,NULL,0,'2016-03-31 11:45:25',NULL,'McDonald'),(552,12,201,NULL,440,'Accessibility Issue 1',1,NULL,NULL,0,'2016-03-31 17:30:03',NULL,'Gow'),(553,12,199,NULL,440,'test1',2,NULL,NULL,0,'2016-04-01 04:14:36',NULL,'bruce'),(554,12,199,NULL,443,'test',1,NULL,NULL,0,'2016-04-01 06:46:36',NULL,'bruce'),(555,12,199,NULL,444,'jjjj',2,NULL,'ssd',1,'2016-04-01 06:47:11','2016-04-01 07:31:43','bruce'),(556,16,233,NULL,642,'Don\'t forget that today is April 1st',3,NULL,NULL,0,'2016-04-01 06:56:02',NULL,'star'),(557,16,233,NULL,644,'aaa',2,NULL,NULL,0,'2016-04-01 06:57:12',NULL,'star'),(558,16,234,NULL,641,'logistic',3,NULL,NULL,0,'2016-04-01 06:57:28',NULL,'star'),(559,16,231,NULL,640,'av time 1',1,NULL,NULL,0,'2016-04-01 08:05:06',NULL,'star'),(560,16,232,NULL,640,'av time 1',1,NULL,NULL,0,'2016-04-01 08:05:06',NULL,'star'),(561,16,233,NULL,640,'av time 1',1,NULL,NULL,0,'2016-04-01 08:05:06',NULL,'star'),(562,16,234,NULL,640,'av time 1',1,NULL,NULL,0,'2016-04-01 08:05:06',NULL,'star'),(563,16,238,NULL,640,'av time 1',1,NULL,NULL,0,'2016-04-01 08:05:06',NULL,'star');
/*!40000 ALTER TABLE `issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_assignment`
--

DROP TABLE IF EXISTS `issue_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `issue_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `assignon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `isuas_fk1_idx` (`organization_id`),
  KEY `isuas_fk2_idx` (`issue_id`),
  KEY `isuas_fk3_idx` (`user_id`),
  CONSTRAINT `isuas_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `isuas_fk2` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `isuas_fk3` FOREIGN KEY (`user_id`) REFERENCES `security`.`user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_assignment`
--

LOCK TABLES `issue_assignment` WRITE;
/*!40000 ALTER TABLE `issue_assignment` DISABLE KEYS */;
INSERT INTO `issue_assignment` VALUES (1,12,555,108,'2016-04-01 07:31:43');
/*!40000 ALTER TABLE `issue_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_comment`
--

DROP TABLE IF EXISTS `issue_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `issue_id` int(11) NOT NULL,
  `comment` text,
  `attachtment_url` varchar(1000) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `iscom_fk1_idx` (`issue_id`),
  KEY `iscom_fk2_idx` (`user_id`),
  KEY `iscom_fk2_idx1` (`organization_id`),
  CONSTRAINT `iscom_fk1` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `iscom_fk2` FOREIGN KEY (`user_id`) REFERENCES `security`.`user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_comment`
--

LOCK TABLES `issue_comment` WRITE;
/*!40000 ALTER TABLE `issue_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list`
--

DROP TABLE IF EXISTS `list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `list_category_id` int(11) NOT NULL,
  `list_internal_name` varchar(45) NOT NULL,
  `list_value` varchar(255) NOT NULL,
  `list_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `list_fk1_idx` (`organization_id`),
  KEY `list_fk2_idx` (`list_category_id`),
  CONSTRAINT `list_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `list_fk2` FOREIGN KEY (`list_category_id`) REFERENCES `list_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=739 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list`
--

LOCK TABLES `list` WRITE;
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` VALUES (1,2,2,'Low','Low',NULL),(2,2,2,'Medium','Medium',NULL),(3,2,2,'High','High',NULL),(6,2,3,'Staffing','Staffing',NULL),(7,2,3,'Accessibility','Accessibility',NULL),(15,2,3,'Logistics','Logistics',NULL),(16,2,3,'Security','Security',NULL),(17,2,3,'Ballot Papers','Ballot Papers',NULL),(18,2,3,'Health and Safety','Health and Safety',NULL),(19,2,3,'Problems with Register','Problems with Register',NULL),(20,2,3,'Postal and Proxy Voters','Postal and Proxy Voters',NULL),(21,2,3,'Other','Other',NULL),(53,4,10,'Low','Low',NULL),(54,4,10,'Medium','Medium',NULL),(55,4,10,'High','High',NULL),(56,4,13,'Polling Boxes Arrived','Polling Boxes Arrived',NULL),(57,4,13,'All Ballot Boxes Arrived','All Ballot Boxes Arrived',NULL),(58,9,11,'Staffing','Staffing',NULL),(59,9,11,'Accessibility','Accessibility',NULL),(60,4,13,'Signage to Polling Station Visible','Signage to Polling Station Visible',NULL),(61,4,13,'Low level booths and ballot boxes installed','Low level booths and ballot boxes installed',NULL),(62,4,13,'Hand held samples available','Hand held samples available',NULL),(63,4,13,'Polling Staff Arrived','Polling Staff Arrived',NULL),(64,4,13,'All Booths Ready','All Booths Ready',NULL),(65,4,13,'Polling Station Accessible to all voters','Polling Station Accessible to all voters',NULL),(66,4,13,'Large print ballot papers clearly visible','Large print ballot papers clearly visible',NULL),(67,9,11,'Logistics','Logistics',NULL),(68,9,11,'Security','Security',NULL),(69,9,11,'Ballot Papers','Ballot Papers',NULL),(70,9,11,'Health and Safety','Health and Safety',NULL),(71,9,11,'Problems with Register','Problems with Register',NULL),(72,9,11,'Postal and Proxy Voters','Postal and Proxy Voters',NULL),(73,9,11,'Other','Other',NULL),(74,2,18,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(75,2,18,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(76,2,18,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(77,2,18,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(78,2,18,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(79,2,18,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions? Is the ramp stable? If not, contact the elections office immediately. Are doormats flush with the floor? If not, remove them',6),(80,2,18,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(81,2,19,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(82,2,19,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(83,2,19,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(84,2,19,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(85,2,19,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(86,2,19,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(87,2,19,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(88,2,19,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(89,2,20,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed? Can a wheelchair user gain easy access to the ballot box(es)? Can a wheelchair user gain easy access to the polling booth?',1),(90,2,20,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(91,2,20,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(92,2,20,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(93,2,20,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(94,2,20,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(95,2,21,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(96,2,21,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(97,2,21,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(98,2,21,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(99,2,21,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(227,6,22,'Staffing','Staffing',NULL),(228,6,22,'Accessibility','Accessibility',NULL),(229,6,22,'Logistics','Logistics',NULL),(230,6,22,'Security','Security',NULL),(231,6,22,'Ballot Papers','Ballot Papers',NULL),(232,6,22,'Health and Safety','Health and Safety',NULL),(233,6,22,'Problems with Register','Problems with Register',NULL),(234,6,22,'Postal and Proxy Voters','Postal and Proxy Voters',NULL),(235,6,22,'Other','Other',NULL),(242,2,23,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(243,2,23,'Packet for marked register','Packet for marked register',2),(244,2,23,'Packet for certificates of employment','Packet for certificates of employment',3),(245,2,23,'Packet for various lists and declarations','Packet for various lists and declarations',4),(246,2,23,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(247,2,23,'Packet for CNL','Packet for CNL',6),(248,2,23,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(249,2,23,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(250,2,23,'Tactile voting device','Tactile voting device',9),(251,2,23,'Ballot box compactor','Ballot box compactor',10),(252,2,23,'Unused seals','Unused seals',11),(253,2,23,'Unused signs and notices etc.','Unused signs and notices etc.',12),(254,2,23,'Packet for ballot paper account','Packet for ballot paper account',13),(255,2,23,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(256,2,23,'Ballot Box(es)','Ballot Box(es)',15),(257,6,24,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(258,6,24,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(259,6,24,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(260,6,24,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(261,6,24,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(262,6,24,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions? Is the ramp stable? If not, contact the elections office immediately. Are doormats flush with the floor? If not, remove them',6),(263,6,24,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(264,6,25,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(265,6,25,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(266,6,25,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(267,6,25,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(268,6,25,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(269,6,25,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(270,6,25,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(271,6,25,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(272,6,26,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed? Can a wheelchair user gain easy access to the ballot box(es)? Can a wheelchair user gain easy access to the polling booth?',1),(273,6,26,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(274,6,26,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(275,6,26,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(276,6,26,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(277,6,26,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(278,6,27,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(279,6,27,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(280,6,27,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(281,6,27,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(282,6,27,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(283,6,29,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(284,6,29,'Packet for marked register','Packet for marked register',2),(285,6,29,'Packet for certificates of employment','Packet for certificates of employment',3),(286,6,29,'Packet for various lists and declarations','Packet for various lists and declarations',4),(287,6,29,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(288,6,29,'Packet for CNL','Packet for CNL',6),(289,6,29,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(290,6,29,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(291,6,29,'Tactile voting device','Tactile voting device',9),(292,6,29,'Ballot box compactor','Ballot box compactor',10),(293,6,29,'Unused seals','Unused seals',11),(294,6,29,'Unused signs and notices etc.','Unused signs and notices etc.',12),(295,6,29,'Packet for ballot paper account','Packet for ballot paper account',13),(296,6,29,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(297,6,29,'Ballot Box(es)','Ballot Box(es)',15),(298,9,30,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(299,9,30,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(300,9,30,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(301,9,30,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(302,9,30,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(303,9,30,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(304,9,30,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(305,9,31,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(306,9,31,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(307,9,31,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(308,9,31,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(309,9,31,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(310,9,31,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(311,9,31,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(312,9,31,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(313,9,32,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(314,9,32,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(315,9,32,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(316,9,32,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(317,9,32,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(318,9,32,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(319,9,33,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(320,9,33,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(321,9,33,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(322,9,33,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(323,9,33,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(324,9,34,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(325,9,34,'Packet for marked register','Packet for marked register',2),(326,9,34,'Packet for certificates of employment','Packet for certificates of employment',3),(327,9,34,'Packet for various lists and declarations','Packet for various lists and declarations',4),(328,9,34,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(329,9,34,'Packet for CNL','Packet for CNL',6),(330,9,34,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(331,9,34,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(332,9,34,'Tactile voting device','Tactile voting device',9),(333,9,34,'Ballot box compactor','Ballot box compactor',10),(334,9,34,'Unused seals','Unused seals',11),(335,9,34,'Unused signs and notices etc.','Unused signs and notices etc.',12),(336,9,34,'Packet for ballot paper account','Packet for ballot paper account',13),(337,9,34,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(338,9,34,'Ballot Box(es)','Ballot Box(es)',15),(339,10,35,'Staffing','Staffing',0),(340,10,35,'Accessibility','Accessibility',0),(341,10,35,'Logistics','Logistics',0),(342,10,35,'Security','Security',0),(343,10,35,'Ballot Papers','Ballot Papers',0),(344,10,35,'Health and Safety','Health and Safety',0),(345,10,35,'Problems with Register','Problems with Register',0),(346,10,35,'Postal and Proxy Voters','Postal and Proxy Voters',0),(347,10,35,'Other','Other',0),(348,10,37,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(349,10,37,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(350,10,37,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(351,10,37,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(352,10,37,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(353,10,37,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(354,10,37,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(355,10,38,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(356,10,38,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(357,10,38,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(358,10,38,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(359,10,38,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(360,10,38,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(361,10,38,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(362,10,38,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(363,10,39,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(364,10,39,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(365,10,39,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(366,10,39,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(367,10,39,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(368,10,39,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(369,10,40,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(370,10,40,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(371,10,40,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(372,10,40,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(373,10,40,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(374,10,41,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(375,10,41,'Packet for marked register','Packet for marked register',2),(376,10,41,'Packet for certificates of employment','Packet for certificates of employment',3),(377,10,41,'Packet for various lists and declarations','Packet for various lists and declarations',4),(378,10,41,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(379,10,41,'Packet for CNL','Packet for CNL',6),(380,10,41,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(381,10,41,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(382,10,41,'Tactile voting device','Tactile voting device',9),(383,10,41,'Ballot box compactor','Ballot box compactor',10),(384,10,41,'Unused seals','Unused seals',11),(385,10,41,'Unused signs and notices etc.','Unused signs and notices etc.',12),(386,10,41,'Packet for ballot paper account','Packet for ballot paper account',13),(387,10,41,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(388,10,41,'Ballot Box(es)','Ballot Box(es)',15),(439,12,49,'Staffing','Staffing',0),(440,12,49,'Accessibility','Accessibility',0),(441,12,49,'Logistics','Logistics',0),(442,12,49,'Security','Security',0),(443,12,49,'Ballot Papers','Ballot Papers',0),(444,12,49,'Health and Safety','Health and Safety',0),(445,12,49,'Problems with Register','Problems with Register',0),(446,12,49,'Postal and Proxy Voters','Postal and Proxy Voters',0),(447,12,49,'Other','Other',0),(448,12,51,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(449,12,51,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(450,12,51,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(451,12,51,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(452,12,51,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(453,12,51,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(454,12,51,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(455,12,52,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(456,12,52,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(457,12,52,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(458,12,52,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(459,12,52,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(460,12,52,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(461,12,52,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(462,12,52,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(463,12,53,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(464,12,53,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(465,12,53,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(466,12,53,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(467,12,53,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(468,12,53,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(469,12,54,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(470,12,54,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(471,12,54,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(472,12,54,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(473,12,54,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(474,12,55,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(475,12,55,'Packet for marked register','Packet for marked register',2),(476,12,55,'Packet for certificates of employment','Packet for certificates of employment',3),(477,12,55,'Packet for various lists and declarations','Packet for various lists and declarations',4),(478,12,55,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(479,12,55,'Packet for CNL','Packet for CNL',6),(480,12,55,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(481,12,55,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(482,12,55,'Tactile voting device','Tactile voting device',9),(483,12,55,'Ballot box compactor','Ballot box compactor',10),(484,12,55,'Unused seals','Unused seals',11),(485,12,55,'Unused signs and notices etc.','Unused signs and notices etc.',12),(486,12,55,'Packet for ballot paper account','Packet for ballot paper account',13),(487,12,55,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(488,12,55,'Ballot Box(es)','Ballot Box(es)',15),(489,13,56,'Staffing','Staffing',0),(490,13,56,'Accessibility','Accessibility',0),(491,13,56,'Logistics','Logistics',0),(492,13,56,'Security','Security',0),(493,13,56,'Ballot Papers','Ballot Papers',0),(494,13,56,'Health and Safety','Health and Safety',0),(495,13,56,'Problems with Register','Problems with Register',0),(496,13,56,'Postal and Proxy Voters','Postal and Proxy Voters',0),(497,13,56,'Other','Other',0),(498,13,58,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(499,13,58,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(500,13,58,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(501,13,58,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(502,13,58,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(503,13,58,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(504,13,58,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(505,13,59,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(506,13,59,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(507,13,59,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(508,13,59,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(509,13,59,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(510,13,59,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(511,13,59,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(512,13,59,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(513,13,60,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(514,13,60,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(515,13,60,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(516,13,60,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(517,13,60,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(518,13,60,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(519,13,61,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(520,13,61,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(521,13,61,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(522,13,61,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(523,13,61,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(524,13,62,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(525,13,62,'Packet for marked register','Packet for marked register',2),(526,13,62,'Packet for certificates of employment','Packet for certificates of employment',3),(527,13,62,'Packet for various lists and declarations','Packet for various lists and declarations',4),(528,13,62,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(529,13,62,'Packet for CNL','Packet for CNL',6),(530,13,62,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(531,13,62,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(532,13,62,'Tactile voting device','Tactile voting device',9),(533,13,62,'Ballot box compactor','Ballot box compactor',10),(534,13,62,'Unused seals','Unused seals',11),(535,13,62,'Unused signs and notices etc.','Unused signs and notices etc.',12),(536,13,62,'Packet for ballot paper account','Packet for ballot paper account',13),(537,13,62,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(538,13,62,'Ballot Box(es)','Ballot Box(es)',15),(539,14,63,'Staffing','Staffing',0),(540,14,63,'Accessibility','Accessibility',0),(541,14,63,'Logistics','Logistics',0),(542,14,63,'Security','Security',0),(543,14,63,'Ballot Papers','Ballot Papers',0),(544,14,63,'Health and Safety','Health and Safety',0),(545,14,63,'Problems with Register','Problems with Register',0),(546,14,63,'Postal and Proxy Voters','Postal and Proxy Voters',0),(547,14,63,'Other','Other',0),(548,14,65,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(549,14,65,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(550,14,65,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(551,14,65,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(552,14,65,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(553,14,65,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(554,14,65,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(555,14,66,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(556,14,66,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(557,14,66,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(558,14,66,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(559,14,66,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(560,14,66,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(561,14,66,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(562,14,66,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(563,14,67,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(564,14,67,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(565,14,67,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(566,14,67,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(567,14,67,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(568,14,67,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(569,14,68,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(570,14,68,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(571,14,68,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(572,14,68,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(573,14,68,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(574,14,69,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(575,14,69,'Packet for marked register','Packet for marked register',2),(576,14,69,'Packet for certificates of employment','Packet for certificates of employment',3),(577,14,69,'Packet for various lists and declarations','Packet for various lists and declarations',4),(578,14,69,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(579,14,69,'Packet for CNL','Packet for CNL',6),(580,14,69,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(581,14,69,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(582,14,69,'Tactile voting device','Tactile voting device',9),(583,14,69,'Ballot box compactor','Ballot box compactor',10),(584,14,69,'Unused seals','Unused seals',11),(585,14,69,'Unused signs and notices etc.','Unused signs and notices etc.',12),(586,14,69,'Packet for ballot paper account','Packet for ballot paper account',13),(587,14,69,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(588,14,69,'Ballot Box(es)','Ballot Box(es)',15),(589,15,70,'Staffing','Staffing',0),(590,15,70,'Accessibility','Accessibility',0),(591,15,70,'Logistics','Logistics',0),(592,15,70,'Security','Security',0),(593,15,70,'Ballot Papers','Ballot Papers',0),(594,15,70,'Health and Safety','Health and Safety',0),(595,15,70,'Problems with Register','Problems with Register',0),(596,15,70,'Postal and Proxy Voters','Postal and Proxy Voters',0),(597,15,70,'Other','Other',0),(598,15,72,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(599,15,72,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(600,15,72,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(601,15,72,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(602,15,72,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(603,15,72,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(604,15,72,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(605,15,73,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(606,15,73,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(607,15,73,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(608,15,73,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(609,15,73,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(610,15,73,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(611,15,73,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(612,15,73,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(613,15,74,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(614,15,74,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(615,15,74,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(616,15,74,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(617,15,74,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(618,15,74,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(619,15,75,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(620,15,75,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(621,15,75,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(622,15,75,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(623,15,75,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(624,15,76,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(625,15,76,'Packet for marked register','Packet for marked register',2),(626,15,76,'Packet for certificates of employment','Packet for certificates of employment',3),(627,15,76,'Packet for various lists and declarations','Packet for various lists and declarations',4),(628,15,76,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(629,15,76,'Packet for CNL','Packet for CNL',6),(630,15,76,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(631,15,76,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(632,15,76,'Tactile voting device','Tactile voting device',9),(633,15,76,'Ballot box compactor','Ballot box compactor',10),(634,15,76,'Unused seals','Unused seals',11),(635,15,76,'Unused signs and notices etc.','Unused signs and notices etc.',12),(636,15,76,'Packet for ballot paper account','Packet for ballot paper account',13),(637,15,76,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(638,15,76,'Ballot Box(es)','Ballot Box(es)',15),(639,16,77,'Staffing','Staffing',0),(640,16,77,'Accessibility','Accessibility',0),(641,16,77,'Logistics','Logistics',0),(642,16,77,'Security','Security',0),(643,16,77,'Ballot Papers','Ballot Papers',0),(644,16,77,'Health and Safety','Health and Safety',0),(645,16,77,'Problems with Register','Problems with Register',0),(646,16,77,'Postal and Proxy Voters','Postal and Proxy Voters',0),(647,16,77,'Other','Other',0),(648,16,79,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(649,16,79,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(650,16,79,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(651,16,79,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(652,16,79,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(653,16,79,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(654,16,79,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(655,16,80,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(656,16,80,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(657,16,80,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(658,16,80,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(659,16,80,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(660,16,80,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(661,16,80,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(662,16,80,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(663,16,81,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(664,16,81,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(665,16,81,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(666,16,81,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(667,16,81,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(668,16,81,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(669,16,82,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(670,16,82,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(671,16,82,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(672,16,82,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(673,16,82,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(674,16,83,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(675,16,83,'Packet for marked register','Packet for marked register',2),(676,16,83,'Packet for certificates of employment','Packet for certificates of employment',3),(677,16,83,'Packet for various lists and declarations','Packet for various lists and declarations',4),(678,16,83,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(679,16,83,'Packet for CNL','Packet for CNL',6),(680,16,83,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(681,16,83,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(682,16,83,'Tactile voting device','Tactile voting device',9),(683,16,83,'Ballot box compactor','Ballot box compactor',10),(684,16,83,'Unused seals','Unused seals',11),(685,16,83,'Unused signs and notices etc.','Unused signs and notices etc.',12),(686,16,83,'Packet for ballot paper account','Packet for ballot paper account',13),(687,16,83,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(688,16,83,'Ballot Box(es)','Ballot Box(es)',15),(689,17,84,'Staffing','Staffing',0),(690,17,84,'Accessibility','Accessibility',0),(691,17,84,'Logistics','Logistics',0),(692,17,84,'Security','Security',0),(693,17,84,'Ballot Papers','Ballot Papers',0),(694,17,84,'Health and Safety','Health and Safety',0),(695,17,84,'Problems with Register','Problems with Register',0),(696,17,84,'Postal and Proxy Voters','Postal and Proxy Voters',0),(697,17,84,'Other','Other',0),(698,17,86,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(699,17,86,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(700,17,86,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(701,17,86,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(702,17,86,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(703,17,86,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(704,17,86,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(705,17,87,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(706,17,87,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(707,17,87,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(708,17,87,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(709,17,87,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(710,17,87,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(711,17,87,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(712,17,87,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(713,17,88,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(714,17,88,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(715,17,88,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(716,17,88,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(717,17,88,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(718,17,88,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(719,17,89,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(720,17,89,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(721,17,89,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(722,17,89,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(723,17,89,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(724,17,90,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(725,17,90,'Packet for marked register','Packet for marked register',2),(726,17,90,'Packet for certificates of employment','Packet for certificates of employment',3),(727,17,90,'Packet for various lists and declarations','Packet for various lists and declarations',4),(728,17,90,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(729,17,90,'Packet for CNL','Packet for CNL',6),(730,17,90,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(731,17,90,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(732,17,90,'Tactile voting device','Tactile voting device',9),(733,17,90,'Ballot box compactor','Ballot box compactor',10),(734,17,90,'Unused seals','Unused seals',11),(735,17,90,'Unused signs and notices etc.','Unused signs and notices etc.',12),(736,17,90,'Packet for ballot paper account','Packet for ballot paper account',13),(737,17,90,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(738,17,90,'Ballot Box(es)','Ballot Box(es)',15);
/*!40000 ALTER TABLE `list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_category`
--

DROP TABLE IF EXISTS `list_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `list_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lst_cat_fk1_idx` (`organization_id`),
  KEY `lst_cat_name_idx` (`name`),
  CONSTRAINT `lst_cat_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_category`
--

LOCK TABLES `list_category` WRITE;
/*!40000 ALTER TABLE `list_category` DISABLE KEYS */;
INSERT INTO `list_category` VALUES (2,2,'issue_priority',NULL),(3,2,'issue',NULL),(4,2,'issue_resolution',NULL),(6,3,'issue_priority',NULL),(7,3,'issue',NULL),(8,3,'issue_resolution',NULL),(9,4,'prepoll_activity_General',1),(10,4,'issue_priority',NULL),(11,9,'issue',NULL),(12,9,'issue_resolution',NULL),(13,4,'prepoll_activity_Station_Readiness',2),(18,2,'prepoll_activity_Outside_the_polling_station',1),(19,2,'prepoll_activity_Inside_the_polling_station',2),(20,2,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(21,2,'prepoll_activity_Ballot_papers',4),(22,6,'issue',NULL),(23,2,'postpoll_activity',NULL),(24,6,'prepoll_activity_Outside_the_polling_station',1),(25,6,'prepoll_activity_Inside_the_polling_station',2),(26,6,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(27,6,'prepoll_activity_Ballot_papers',4),(29,6,'postpoll_activity',1),(30,9,'prepoll_activity_Outside_the_polling_station',1),(31,9,'prepoll_activity_Inside_the_polling_station',2),(32,9,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(33,9,'prepoll_activity_Ballot_papers',4),(34,9,'postpoll_activity',1),(35,10,'issue',NULL),(36,10,'issue_resolution',NULL),(37,10,'prepoll_activity_Outside_the_polling_station',1),(38,10,'prepoll_activity_Inside_the_polling_station',2),(39,10,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(40,10,'prepoll_activity_Ballot_papers',4),(41,10,'postpoll_activity',1),(49,12,'issue',NULL),(50,12,'issue_resolution',NULL),(51,12,'prepoll_activity_Outside_the_polling_station',1),(52,12,'prepoll_activity_Inside_the_polling_station',2),(53,12,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(54,12,'prepoll_activity_Ballot_papers',4),(55,12,'postpoll_activity',1),(56,13,'issue',NULL),(57,13,'issue_resolution',NULL),(58,13,'prepoll_activity_Outside_the_polling_station',1),(59,13,'prepoll_activity_Inside_the_polling_station',2),(60,13,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(61,13,'prepoll_activity_Ballot_papers',4),(62,13,'postpoll_activity',1),(63,14,'issue',NULL),(64,14,'issue_resolution',NULL),(65,14,'prepoll_activity_Outside_the_polling_station',1),(66,14,'prepoll_activity_Inside_the_polling_station',2),(67,14,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(68,14,'prepoll_activity_Ballot_papers',4),(69,14,'postpoll_activity',1),(70,15,'issue',NULL),(71,15,'issue_resolution',NULL),(72,15,'prepoll_activity_Outside_the_polling_station',1),(73,15,'prepoll_activity_Inside_the_polling_station',2),(74,15,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(75,15,'prepoll_activity_Ballot_papers',4),(76,15,'postpoll_activity',1),(77,16,'issue',NULL),(78,16,'issue_resolution',NULL),(79,16,'prepoll_activity_Outside_the_polling_station',1),(80,16,'prepoll_activity_Inside_the_polling_station',2),(81,16,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(82,16,'prepoll_activity_Ballot_papers',4),(83,16,'postpoll_activity',1),(84,17,'issue',NULL),(85,17,'issue_resolution',NULL),(86,17,'prepoll_activity_Outside_the_polling_station',1),(87,17,'prepoll_activity_Inside_the_polling_station',2),(88,17,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(89,17,'prepoll_activity_Ballot_papers',4),(90,17,'postpoll_activity',1);
/*!40000 ALTER TABLE `list_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `attachtment_url` varchar(500) DEFAULT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `not_fk1_idx` (`organization_id`),
  CONSTRAINT `not_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (333,6,'Hi AaronThere is no issue just sending you this as a test. Let me know if you receive this and hope all is ok.ThanksLesley','null','2016-02-18 07:39:27'),(334,6,'Test message to try notifications','null','2016-02-18 09:59:07'),(335,6,'Hi Aaron just got back to the office and Richard had 3 postals for me to bring back which I have done. There are 4 recorded on the system is that correct?ThanksLesley','null','2016-02-18 18:07:02'),(351,7,'Hi','null','2016-03-24 11:55:41'),(352,7,'Hello2','null','2016-03-24 11:56:12'),(353,7,'attached','/data/media/Screenshot_2016-03-07-10-25-31.png','2016-03-24 11:56:29'),(370,12,'hi','null','2016-03-31 11:10:15'),(371,12,'hi','null','2016-03-31 11:15:22'),(372,12,'hi private','/data/media/Screenshot_2016-03-07-10-19-45.png','2016-03-31 11:18:41');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_status`
--

DROP TABLE IF EXISTS `notification_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `notificationid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0=new,1=read',
  `akn_time` timestamp NULL DEFAULT NULL,
  `isprivate` int(11) DEFAULT '0' COMMENT '1=yes,0=no',
  PRIMARY KEY (`id`),
  KEY `notstat_fk1_idx` (`organization_id`),
  KEY `notstat_fk2_idx` (`notificationid`),
  KEY `notstat_fk3_idx` (`userid`),
  CONSTRAINT `notstat_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `notstat_fk2` FOREIGN KEY (`notificationid`) REFERENCES `notification` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `notstat_fk3` FOREIGN KEY (`userid`) REFERENCES `security`.`user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=694 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_status`
--

LOCK TABLES `notification_status` WRITE;
/*!40000 ALTER TABLE `notification_status` DISABLE KEYS */;
INSERT INTO `notification_status` VALUES (595,6,333,73,1,'2016-02-18 08:04:29',1),(596,6,333,76,0,NULL,1),(597,6,333,77,0,NULL,1),(598,6,333,78,0,NULL,1),(599,6,334,73,1,'2016-02-18 09:59:33',0),(600,6,334,74,0,NULL,0),(601,6,334,76,0,NULL,0),(602,6,334,77,0,NULL,0),(603,6,334,78,0,NULL,0),(604,6,335,73,1,'2016-02-18 18:09:01',1),(605,6,335,76,0,NULL,1),(606,6,335,77,0,NULL,1),(607,6,335,78,0,NULL,1),(682,12,370,103,0,NULL,0),(683,12,370,104,0,NULL,0),(684,12,370,105,0,NULL,0),(685,12,370,106,1,'2016-03-31 11:19:14',0),(686,12,370,107,0,NULL,0),(687,12,370,108,0,NULL,0),(688,12,370,109,0,NULL,0),(689,12,370,110,0,NULL,0),(690,12,370,111,0,NULL,0),(691,12,370,112,0,NULL,0),(692,12,371,104,0,NULL,0),(693,12,372,106,1,'2016-03-31 11:19:09',1);
/*!40000 ALTER TABLE `notification_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `open_close_election`
--

DROP TABLE IF EXISTS `open_close_election`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `open_close_election` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `election_id` int(11) DEFAULT NULL,
  `list_id` int(11) NOT NULL,
  `iscompleted` int(11) NOT NULL DEFAULT '0' COMMENT '0=no,1=yes',
  `polling_station_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bgcl_fk1_idx` (`organization_id`),
  KEY `bgcl_fk2_idx` (`election_id`),
  KEY `bgcl_fk3_idx` (`list_id`),
  KEY `bgcl_fk3_idx1` (`polling_station_id`),
  CONSTRAINT `bgcl_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bgcl_fk2` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bgcl_fk3` FOREIGN KEY (`list_id`) REFERENCES `list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5232 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_close_election`
--

LOCK TABLES `open_close_election` WRITE;
/*!40000 ALTER TABLE `open_close_election` DISABLE KEYS */;
INSERT INTO `open_close_election` VALUES (1688,6,9,257,1,171),(1689,6,9,258,1,171),(1690,6,9,259,1,171),(1691,6,9,260,1,171),(1692,6,9,261,1,171),(1693,6,9,262,1,171),(1694,6,9,263,1,171),(1695,6,9,264,1,171),(1696,6,9,265,1,171),(1697,6,9,266,1,171),(1698,6,9,267,1,171),(1699,6,9,268,1,171),(1700,6,9,269,1,171),(1701,6,9,270,1,171),(1702,6,9,271,1,171),(1703,6,9,272,1,171),(1704,6,9,273,1,171),(1705,6,9,274,1,171),(1706,6,9,275,1,171),(1707,6,9,276,1,171),(1708,6,9,277,1,171),(1709,6,9,278,1,171),(1710,6,9,279,1,171),(1711,6,9,280,1,171),(1712,6,9,281,1,171),(1713,6,9,282,1,171),(1714,6,9,257,1,172),(1715,6,9,259,1,172),(1716,6,9,258,1,172),(1717,6,9,260,1,172),(1718,6,9,261,1,172),(1719,6,9,262,1,172),(1720,6,9,263,1,172),(1721,6,9,264,1,172),(1722,6,9,265,1,172),(1723,6,9,266,1,172),(1724,6,9,268,1,172),(1725,6,9,267,1,172),(1726,6,9,269,1,172),(1727,6,9,270,1,172),(1728,6,9,271,1,172),(1729,6,9,272,1,172),(1730,6,9,274,1,172),(1731,6,9,273,1,172),(1732,6,9,275,1,172),(1733,6,9,276,1,172),(1734,6,9,277,1,172),(1735,6,9,278,1,172),(1736,6,9,279,1,172),(1737,6,9,280,1,172),(1738,6,9,281,1,172),(1739,6,9,282,1,172),(1740,6,9,284,1,171),(1741,6,9,283,1,171),(1742,6,9,285,1,171),(1743,6,9,286,1,171),(1744,6,9,287,1,171),(1745,6,9,288,1,171),(1746,6,9,289,1,171),(1747,6,9,290,1,171),(1748,6,9,291,1,171),(1749,6,9,292,1,171),(1750,6,9,293,1,171),(1751,6,9,294,1,171),(1752,6,9,295,1,171),(1753,6,9,296,1,171),(1754,6,9,297,1,171),(1755,6,9,284,1,172),(1756,6,9,283,1,172),(1757,6,9,285,1,172),(1758,6,9,286,1,172),(1759,6,9,287,1,172),(1760,6,9,288,1,172),(1761,6,9,289,1,172),(1762,6,9,290,1,172),(1763,6,9,291,1,172),(1764,6,9,293,1,172),(1765,6,9,292,1,172),(1766,6,9,294,1,172),(1767,6,9,295,1,172),(1768,6,9,296,1,172),(1769,6,9,297,1,172),(3386,12,26,449,1,201),(3389,12,26,448,1,201),(3392,12,26,452,1,201),(3395,12,26,451,1,201),(3398,12,26,450,1,201),(3401,12,26,453,1,201),(3404,12,26,454,1,201),(3407,12,26,457,1,201),(3410,12,26,458,1,201),(3413,12,26,455,1,201),(3416,12,26,456,1,201),(3419,12,26,459,1,201),(3422,12,26,462,1,201),(3425,12,26,461,1,201),(3428,12,26,460,1,201),(3431,12,26,464,1,201),(3434,12,26,465,1,201),(3437,12,26,463,1,201),(3440,12,26,467,1,201),(3443,12,26,466,1,201),(3446,12,26,469,1,201),(3449,12,26,470,1,201),(3452,12,26,468,1,201),(3455,12,26,471,1,201),(3458,12,26,473,1,201),(3461,12,26,472,1,201),(3464,12,28,448,1,205),(3465,12,29,448,1,205),(3466,12,34,448,1,205),(3471,12,28,449,1,205),(3472,12,29,449,1,205),(3473,12,34,449,1,205),(3478,12,28,451,1,205),(3479,12,29,451,1,205),(3480,12,34,451,1,205),(3485,12,28,450,1,205),(3486,12,29,450,1,205),(3487,12,34,450,1,205),(3492,12,28,452,1,205),(3493,12,29,452,1,205),(3494,12,34,452,1,205),(3499,12,28,454,1,205),(3500,12,29,454,1,205),(3501,12,34,454,1,205),(3506,12,28,453,1,205),(3507,12,29,453,1,205),(3508,12,34,453,1,205),(3513,12,28,456,1,205),(3514,12,29,456,1,205),(3515,12,34,456,1,205),(3520,12,28,457,1,205),(3521,12,29,457,1,205),(3522,12,34,457,1,205),(3527,12,28,455,1,205),(3528,12,29,455,1,205),(3529,12,34,455,1,205),(3534,12,28,458,1,205),(3535,12,29,458,1,205),(3536,12,34,458,1,205),(3541,12,28,459,1,205),(3542,12,29,459,1,205),(3543,12,34,459,1,205),(3548,12,28,461,1,205),(3549,12,29,461,1,205),(3550,12,34,461,1,205),(3555,12,28,460,1,205),(3556,12,29,460,1,205),(3557,12,34,460,1,205),(3562,12,28,462,1,205),(3563,12,29,462,1,205),(3564,12,34,462,1,205),(3569,12,28,465,1,205),(3570,12,29,465,1,205),(3571,12,34,465,1,205),(3576,12,28,463,1,205),(3577,12,29,463,1,205),(3578,12,34,463,1,205),(3583,12,28,464,1,205),(3584,12,29,464,1,205),(3585,12,34,464,1,205),(3590,12,28,468,1,205),(3591,12,29,468,1,205),(3592,12,34,468,1,205),(3597,12,28,467,1,205),(3598,12,29,467,1,205),(3599,12,34,467,1,205),(3604,12,28,466,1,205),(3605,12,29,466,1,205),(3606,12,34,466,1,205),(3611,12,28,471,1,205),(3612,12,29,471,1,205),(3613,12,34,471,1,205),(3618,12,28,469,1,205),(3619,12,29,469,1,205),(3620,12,34,469,1,205),(3625,12,28,473,1,205),(3626,12,29,473,1,205),(3627,12,34,473,1,205),(3632,12,28,470,1,205),(3633,12,29,470,1,205),(3634,12,34,470,1,205),(3639,12,28,472,1,205),(3640,12,29,472,1,205),(3641,12,34,472,1,205),(3646,12,26,451,1,203),(3648,12,30,451,1,203),(3653,12,26,449,1,203),(3655,12,30,449,1,203),(3660,12,26,448,1,203),(3662,12,30,448,1,203),(3667,12,26,450,1,203),(3669,12,30,450,1,203),(3674,12,26,453,1,203),(3676,12,30,453,1,203),(3681,12,26,452,1,203),(3683,12,30,452,1,203),(3688,12,26,455,1,203),(3690,12,30,455,1,203),(3695,12,26,458,1,203),(3697,12,30,458,1,203),(3702,12,26,454,1,203),(3704,12,30,454,1,203),(3709,12,26,456,1,203),(3711,12,30,456,1,203),(3716,12,26,457,1,203),(3718,12,30,457,1,203),(3723,12,26,459,1,203),(3725,12,30,459,1,203),(3730,12,26,460,1,203),(3732,12,30,460,1,203),(3737,12,26,461,1,203),(3739,12,30,461,1,203),(3744,12,26,462,1,203),(3746,12,30,462,1,203),(3751,12,26,464,1,203),(3753,12,30,464,1,203),(3758,12,26,463,1,203),(3760,12,30,463,1,203),(3765,12,26,465,1,203),(3767,12,30,465,1,203),(3772,12,26,467,1,203),(3774,12,30,467,1,203),(3779,12,26,466,1,203),(3781,12,30,466,1,203),(3786,12,26,469,1,203),(3788,12,30,469,1,203),(3793,12,26,468,1,203),(3795,12,30,468,1,203),(3800,12,26,471,1,203),(3802,12,30,471,1,203),(3807,12,26,470,1,203),(3809,12,30,470,1,203),(3814,12,26,472,1,203),(3816,12,30,472,1,203),(3821,12,26,473,1,203),(3823,12,30,473,1,203),(3828,12,28,474,1,205),(3829,12,29,474,1,205),(3830,12,34,474,1,205),(3835,12,28,475,1,205),(3836,12,29,475,1,205),(3837,12,34,475,1,205),(3842,12,28,476,1,205),(3843,12,29,476,1,205),(3844,12,34,476,1,205),(3849,12,28,479,1,205),(3850,12,29,479,1,205),(3851,12,34,479,1,205),(3856,12,28,478,1,205),(3857,12,29,478,1,205),(3858,12,34,478,1,205),(3863,12,28,477,1,205),(3864,12,29,477,1,205),(3865,12,34,477,1,205),(3870,12,28,484,1,205),(3871,12,29,484,1,205),(3872,12,34,484,1,205),(3877,12,28,480,1,205),(3878,12,29,480,1,205),(3879,12,34,480,1,205),(3884,12,28,483,1,205),(3885,12,29,483,1,205),(3886,12,34,483,1,205),(3891,12,28,481,1,205),(3892,12,29,481,1,205),(3893,12,34,481,1,205),(3898,12,28,482,1,205),(3899,12,29,482,1,205),(3900,12,34,482,1,205),(3905,12,28,486,1,205),(3906,12,29,486,1,205),(3907,12,34,486,1,205),(3912,12,28,485,1,205),(3913,12,29,485,1,205),(3914,12,34,485,1,205),(3919,12,28,488,1,205),(3920,12,29,488,1,205),(3921,12,34,488,1,205),(3926,12,28,487,1,205),(3927,12,29,487,1,205),(3928,12,34,487,1,205),(4011,12,22,448,0,199),(4012,12,35,448,0,199),(4014,12,22,449,0,199),(4015,12,35,449,0,199),(4017,12,22,450,0,199),(4018,12,35,450,0,199),(4020,12,22,451,0,199),(4021,12,35,451,0,199),(4023,12,22,452,0,199),(4024,12,35,452,0,199),(4026,12,22,453,0,199),(4027,12,35,453,0,199),(4029,12,22,454,0,199),(4030,12,35,454,0,199),(4032,12,22,455,0,199),(4033,12,35,455,0,199),(4035,12,22,456,0,199),(4036,12,35,456,0,199),(4038,12,22,457,0,199),(4039,12,35,457,0,199),(4041,12,22,459,0,199),(4042,12,35,459,0,199),(4044,12,22,458,0,199),(4045,12,35,458,0,199),(4047,12,22,460,0,199),(4048,12,35,460,0,199),(4050,12,22,461,0,199),(4051,12,35,461,0,199),(4053,12,22,463,0,199),(4054,12,35,463,0,199),(4056,12,22,462,0,199),(4057,12,35,462,0,199),(4059,12,22,464,0,199),(4060,12,35,464,0,199),(4062,12,22,465,0,199),(4063,12,35,465,0,199),(4065,12,22,466,0,199),(4066,12,35,466,0,199),(4068,12,22,467,0,199),(4069,12,35,467,0,199),(4071,12,22,468,0,199),(4072,12,35,468,0,199),(4074,12,22,469,0,199),(4075,12,35,469,0,199),(4077,12,22,470,0,199),(4078,12,35,470,0,199),(4080,12,22,471,0,199),(4081,12,35,471,0,199),(4083,12,22,472,0,199),(4084,12,35,472,0,199),(4086,12,22,473,0,199),(4087,12,35,473,0,199),(4192,12,17,448,0,201),(4193,12,17,449,0,201),(4194,12,17,453,0,201),(4195,12,17,451,0,201),(4196,12,17,450,0,201),(4197,12,17,454,0,201),(4198,12,17,452,0,201),(4199,12,17,456,0,201),(4200,12,17,457,0,201),(4201,12,17,455,0,201),(4202,12,17,460,0,201),(4203,12,17,458,0,201),(4204,12,17,459,0,201),(4205,12,17,462,0,201),(4206,12,17,461,0,201),(4207,12,17,464,1,201),(4208,12,17,466,1,201),(4209,12,17,463,1,201),(4210,12,17,465,1,201),(4211,12,17,467,1,201),(4212,12,17,468,1,201),(4213,12,17,469,0,201),(4214,12,17,470,0,201),(4215,12,17,472,0,201),(4216,12,17,471,0,201),(4217,12,17,473,0,201),(4218,12,17,450,0,202),(4219,12,17,448,0,202),(4220,12,17,452,0,202),(4221,12,17,451,0,202),(4222,12,17,453,0,202),(4223,12,17,455,1,202),(4224,12,17,454,0,202),(4225,12,17,449,0,202),(4226,12,17,458,1,202),(4227,12,17,461,1,202),(4228,12,17,457,1,202),(4229,12,17,456,1,202),(4230,12,17,459,1,202),(4231,12,17,462,1,202),(4232,12,17,460,1,202),(4233,12,17,463,1,202),(4234,12,17,464,1,202),(4235,12,17,466,1,202),(4236,12,17,467,1,202),(4237,12,17,468,1,202),(4238,12,17,469,0,202),(4239,12,17,465,1,202),(4240,12,17,473,0,202),(4241,12,17,471,0,202),(4242,12,17,470,0,202),(4243,12,17,472,0,202),(4244,12,17,450,1,203),(4245,12,17,448,1,203),(4246,12,17,452,1,203),(4247,12,17,449,1,203),(4248,12,17,451,1,203),(4249,12,17,454,1,203),(4250,12,17,453,1,203),(4251,12,17,455,1,203),(4252,12,17,456,1,203),(4253,12,17,457,1,203),(4254,12,17,459,1,203),(4255,12,17,458,1,203),(4256,12,17,460,1,203),(4257,12,17,461,1,203),(4258,12,17,464,1,203),(4259,12,17,466,1,203),(4260,12,17,463,1,203),(4261,12,17,465,1,203),(4262,12,17,468,1,203),(4263,12,17,467,1,203),(4264,12,17,462,1,203),(4265,12,17,470,1,203),(4266,12,17,469,1,203),(4267,12,17,471,1,203),(4268,12,17,472,1,203),(4269,12,17,473,1,203),(4270,12,17,449,1,199),(4271,12,17,451,1,199),(4272,12,17,448,1,199),(4273,12,17,450,1,199),(4274,12,17,453,1,199),(4275,12,17,457,1,199),(4276,12,17,452,1,199),(4277,12,17,454,1,199),(4278,12,17,455,1,199),(4279,12,17,458,1,199),(4280,12,17,456,1,199),(4281,12,17,461,1,199),(4282,12,17,459,1,199),(4283,12,17,460,1,199),(4284,12,17,464,1,199),(4285,12,17,462,1,199),(4286,12,17,467,1,199),(4287,12,17,466,1,199),(4288,12,17,463,1,199),(4289,12,17,465,1,199),(4290,12,17,468,1,199),(4291,12,17,469,1,199),(4292,12,17,472,1,199),(4293,12,17,473,1,199),(4294,12,17,470,1,199),(4295,12,17,471,1,199),(4296,12,27,448,0,201),(4297,12,27,449,0,201),(4298,12,27,450,0,201),(4299,12,27,451,0,201),(4300,12,27,452,0,201),(4301,12,27,453,0,201),(4302,12,27,454,0,201),(4303,12,27,455,0,201),(4304,12,27,456,0,201),(4305,12,27,457,0,201),(4306,12,27,458,0,201),(4307,12,27,459,0,201),(4308,12,27,460,0,201),(4309,12,27,461,0,201),(4310,12,27,462,0,201),(4311,12,27,463,1,201),(4312,12,27,464,1,201),(4313,12,27,465,1,201),(4314,12,27,466,1,201),(4315,12,27,467,1,201),(4316,12,27,468,1,201),(4317,12,27,469,0,201),(4318,12,27,470,0,201),(4319,12,27,471,0,201),(4320,12,27,472,0,201),(4321,12,27,473,0,201),(4322,12,27,448,0,202),(4323,12,27,449,0,202),(4324,12,27,450,0,202),(4325,12,27,451,0,202),(4326,12,27,452,0,202),(4327,12,27,453,0,202),(4328,12,27,454,0,202),(4329,12,27,455,1,202),(4330,12,27,456,1,202),(4331,12,27,457,1,202),(4332,12,27,458,1,202),(4333,12,27,459,1,202),(4334,12,27,460,1,202),(4335,12,27,461,1,202),(4336,12,27,462,1,202),(4337,12,27,463,1,202),(4338,12,27,464,1,202),(4339,12,27,465,1,202),(4340,12,27,466,1,202),(4341,12,27,467,1,202),(4342,12,27,468,1,202),(4343,12,27,469,0,202),(4344,12,27,470,0,202),(4345,12,27,471,0,202),(4346,12,27,472,0,202),(4347,12,27,473,0,202),(4348,12,27,448,0,215),(4349,12,27,449,0,215),(4350,12,27,450,0,215),(4351,12,27,451,0,215),(4352,12,27,452,0,215),(4353,12,27,453,0,215),(4354,12,27,454,0,215),(4355,12,27,455,0,215),(4356,12,27,456,0,215),(4357,12,27,457,0,215),(4358,12,27,458,0,215),(4359,12,27,459,0,215),(4360,12,27,460,0,215),(4361,12,27,461,0,215),(4362,12,27,462,0,215),(4363,12,27,463,1,215),(4364,12,27,464,1,215),(4365,12,27,465,1,215),(4366,12,27,466,1,215),(4367,12,27,467,1,215),(4368,12,27,468,1,215),(4369,12,27,469,1,215),(4370,12,27,470,1,215),(4371,12,27,471,1,215),(4372,12,27,472,1,215),(4373,12,27,473,1,215),(4374,16,61,649,1,233),(4375,16,61,651,1,233),(4376,16,61,648,1,233),(4377,16,61,650,1,233),(4378,16,61,653,1,233),(4379,16,61,655,0,233),(4380,16,61,652,1,233),(4381,16,61,654,1,233),(4382,16,61,656,0,233),(4383,16,61,657,0,233),(4384,16,61,658,0,233),(4385,16,61,660,0,233),(4386,16,61,659,0,233),(4387,16,61,661,0,233),(4388,16,61,667,1,233),(4389,16,61,662,0,233),(4390,16,61,665,1,233),(4391,16,61,664,1,233),(4392,16,61,666,1,233),(4393,16,61,663,1,233),(4394,16,61,669,0,233),(4395,16,61,668,1,233),(4396,16,61,671,0,233),(4397,16,61,672,0,233),(4398,16,61,670,0,233),(4399,16,61,673,0,233),(4400,12,51,448,0,228),(4401,12,50,448,0,228),(4402,12,55,448,0,228),(4403,12,56,448,0,228),(4404,12,57,448,0,228),(4405,12,58,448,0,228),(4406,12,59,448,0,228),(4407,12,60,448,0,228),(4415,12,51,449,0,228),(4416,12,50,449,0,228),(4417,12,55,449,0,228),(4418,12,56,449,0,228),(4419,12,57,449,0,228),(4420,12,58,449,0,228),(4421,12,59,449,0,228),(4422,12,60,449,0,228),(4430,12,51,453,0,228),(4431,12,50,453,0,228),(4432,12,55,453,0,228),(4433,12,56,453,0,228),(4434,12,57,453,0,228),(4435,12,58,453,0,228),(4436,12,59,453,0,228),(4437,12,60,453,0,228),(4445,12,51,450,0,228),(4446,12,50,450,0,228),(4447,12,55,450,0,228),(4448,12,56,450,0,228),(4449,12,57,450,0,228),(4450,12,58,450,0,228),(4451,12,59,450,0,228),(4452,12,60,450,0,228),(4460,12,51,452,0,228),(4461,12,50,452,0,228),(4462,12,55,452,0,228),(4463,12,56,452,0,228),(4464,12,57,452,0,228),(4465,12,58,452,0,228),(4466,12,59,452,0,228),(4467,12,60,452,0,228),(4475,12,51,454,0,228),(4476,12,50,454,0,228),(4477,12,55,454,0,228),(4478,12,56,454,0,228),(4479,12,57,454,0,228),(4480,12,58,454,0,228),(4481,12,59,454,0,228),(4482,12,60,454,0,228),(4490,12,51,451,0,228),(4491,12,50,451,0,228),(4492,12,55,451,0,228),(4493,12,56,451,0,228),(4494,12,57,451,0,228),(4495,12,58,451,0,228),(4496,12,59,451,0,228),(4497,12,60,451,0,228),(4505,12,51,455,0,228),(4506,12,50,455,0,228),(4507,12,55,455,0,228),(4508,12,56,455,0,228),(4509,12,57,455,0,228),(4510,12,58,455,0,228),(4511,12,59,455,0,228),(4512,12,60,455,0,228),(4520,12,51,457,0,228),(4521,12,50,457,0,228),(4522,12,55,457,0,228),(4523,12,56,457,0,228),(4524,12,57,457,0,228),(4525,12,58,457,0,228),(4526,12,59,457,0,228),(4527,12,60,457,0,228),(4535,12,51,458,0,228),(4536,12,50,458,0,228),(4537,12,55,458,0,228),(4538,12,56,458,0,228),(4539,12,57,458,0,228),(4540,12,58,458,0,228),(4541,12,59,458,0,228),(4542,12,60,458,0,228),(4550,12,51,459,0,228),(4551,12,50,459,0,228),(4552,12,55,459,0,228),(4553,12,56,459,0,228),(4554,12,57,459,0,228),(4555,12,58,459,0,228),(4556,12,59,459,0,228),(4557,12,60,459,0,228),(4565,12,51,461,0,228),(4566,12,50,461,0,228),(4567,12,55,461,0,228),(4568,12,56,461,0,228),(4569,12,57,461,0,228),(4570,12,58,461,0,228),(4571,12,59,461,0,228),(4572,12,60,461,0,228),(4580,12,51,460,0,228),(4581,12,50,460,0,228),(4582,12,55,460,0,228),(4583,12,56,460,0,228),(4584,12,57,460,0,228),(4585,12,58,460,0,228),(4586,12,59,460,0,228),(4587,12,60,460,0,228),(4595,12,51,462,0,228),(4596,12,50,462,0,228),(4597,12,55,462,0,228),(4598,12,56,462,0,228),(4599,12,57,462,0,228),(4600,12,58,462,0,228),(4601,12,59,462,0,228),(4602,12,60,462,0,228),(4610,12,51,456,0,228),(4611,12,50,456,0,228),(4612,12,55,456,0,228),(4613,12,56,456,0,228),(4614,12,57,456,0,228),(4615,12,58,456,0,228),(4616,12,59,456,0,228),(4617,12,60,456,0,228),(4625,12,51,464,0,228),(4626,12,50,464,0,228),(4627,12,55,464,0,228),(4628,12,56,464,0,228),(4629,12,57,464,0,228),(4630,12,58,464,0,228),(4631,12,59,464,0,228),(4632,12,60,464,0,228),(4640,12,51,465,0,228),(4641,12,50,465,0,228),(4642,12,55,465,0,228),(4643,12,56,465,0,228),(4644,12,57,465,0,228),(4645,12,58,465,0,228),(4646,12,59,465,0,228),(4647,12,60,465,0,228),(4655,12,51,466,0,228),(4656,12,50,466,0,228),(4657,12,55,466,0,228),(4658,12,56,466,0,228),(4659,12,57,466,0,228),(4660,12,58,466,0,228),(4661,12,59,466,0,228),(4662,12,60,466,0,228),(4670,12,51,467,0,228),(4671,12,50,467,0,228),(4672,12,55,467,0,228),(4673,12,56,467,0,228),(4674,12,57,467,0,228),(4675,12,58,467,0,228),(4676,12,59,467,0,228),(4677,12,60,467,0,228),(4685,12,51,468,0,228),(4686,12,50,468,0,228),(4687,12,55,468,0,228),(4688,12,56,468,0,228),(4689,12,57,468,0,228),(4690,12,58,468,0,228),(4691,12,59,468,0,228),(4692,12,60,468,0,228),(4700,12,51,463,0,228),(4701,12,50,463,0,228),(4702,12,55,463,0,228),(4703,12,56,463,0,228),(4704,12,57,463,0,228),(4705,12,58,463,0,228),(4706,12,59,463,0,228),(4707,12,60,463,0,228),(4715,12,51,469,0,228),(4716,12,50,469,0,228),(4717,12,55,469,0,228),(4718,12,56,469,0,228),(4719,12,57,469,0,228),(4720,12,58,469,0,228),(4721,12,59,469,0,228),(4722,12,60,469,0,228),(4730,12,51,470,0,228),(4731,12,50,470,0,228),(4732,12,55,470,0,228),(4733,12,56,470,0,228),(4734,12,57,470,0,228),(4735,12,58,470,0,228),(4736,12,59,470,0,228),(4737,12,60,470,0,228),(4745,12,51,471,0,228),(4746,12,50,471,0,228),(4747,12,55,471,0,228),(4748,12,56,471,0,228),(4749,12,57,471,0,228),(4750,12,58,471,0,228),(4751,12,59,471,0,228),(4752,12,60,471,0,228),(4760,12,51,473,0,228),(4761,12,50,473,0,228),(4762,12,55,473,0,228),(4763,12,56,473,0,228),(4764,12,57,473,0,228),(4765,12,58,473,0,228),(4766,12,59,473,0,228),(4767,12,60,473,0,228),(4775,12,51,472,0,228),(4776,12,50,472,0,228),(4777,12,55,472,0,228),(4778,12,56,472,0,228),(4779,12,57,472,0,228),(4780,12,58,472,0,228),(4781,12,59,472,0,228),(4782,12,60,472,0,228),(4790,12,55,448,0,229),(4791,12,57,448,0,229),(4792,12,59,448,0,229),(4793,12,60,448,0,229),(4797,12,55,450,0,229),(4798,12,57,450,0,229),(4799,12,59,450,0,229),(4800,12,60,450,0,229),(4804,12,55,449,0,229),(4805,12,57,449,0,229),(4806,12,59,449,0,229),(4807,12,60,449,0,229),(4811,12,55,451,0,229),(4812,12,57,451,0,229),(4813,12,59,451,0,229),(4814,12,60,451,0,229),(4818,12,55,454,0,229),(4819,12,57,454,0,229),(4820,12,59,454,0,229),(4821,12,60,454,0,229),(4825,12,55,452,0,229),(4826,12,57,452,0,229),(4827,12,59,452,0,229),(4828,12,60,452,0,229),(4832,12,55,453,0,229),(4833,12,57,453,0,229),(4834,12,59,453,0,229),(4835,12,60,453,0,229),(4839,12,55,457,0,229),(4840,12,57,457,0,229),(4841,12,59,457,0,229),(4842,12,60,457,0,229),(4846,12,55,455,0,229),(4847,12,57,455,0,229),(4848,12,59,455,0,229),(4849,12,60,455,0,229),(4853,12,55,456,0,229),(4854,12,57,456,0,229),(4855,12,59,456,0,229),(4856,12,60,456,0,229),(4860,12,55,458,0,229),(4861,12,57,458,0,229),(4862,12,59,458,0,229),(4863,12,60,458,0,229),(4867,12,55,460,0,229),(4868,12,57,460,0,229),(4869,12,59,460,0,229),(4870,12,60,460,0,229),(4874,12,55,459,0,229),(4875,12,57,459,0,229),(4876,12,59,459,0,229),(4877,12,60,459,0,229),(4881,12,55,461,0,229),(4882,12,57,461,0,229),(4883,12,59,461,0,229),(4884,12,60,461,0,229),(4888,12,55,463,0,229),(4889,12,57,463,0,229),(4890,12,59,463,0,229),(4891,12,60,463,0,229),(4895,12,55,464,0,229),(4896,12,57,464,0,229),(4897,12,59,464,0,229),(4898,12,60,464,0,229),(4902,12,55,462,0,229),(4903,12,57,462,0,229),(4904,12,59,462,0,229),(4905,12,60,462,0,229),(4909,12,55,465,0,229),(4910,12,57,465,0,229),(4911,12,59,465,0,229),(4912,12,60,465,0,229),(4916,12,55,467,0,229),(4917,12,57,467,0,229),(4918,12,59,467,0,229),(4919,12,60,467,0,229),(4923,12,55,466,0,229),(4924,12,57,466,0,229),(4925,12,59,466,0,229),(4926,12,60,466,0,229),(4930,12,55,470,0,229),(4931,12,57,470,0,229),(4932,12,59,470,0,229),(4933,12,60,470,0,229),(4937,12,55,468,0,229),(4938,12,57,468,0,229),(4939,12,59,468,0,229),(4940,12,60,468,0,229),(4944,12,55,469,0,229),(4945,12,57,469,0,229),(4946,12,59,469,0,229),(4947,12,60,469,0,229),(4951,12,55,472,0,229),(4952,12,57,472,0,229),(4953,12,59,472,0,229),(4954,12,60,472,0,229),(4958,12,55,473,0,229),(4959,12,57,473,0,229),(4960,12,59,473,0,229),(4961,12,60,473,0,229),(4965,12,55,471,0,229),(4966,12,57,471,0,229),(4967,12,59,471,0,229),(4968,12,60,471,0,229),(4972,12,55,449,0,230),(4973,12,59,449,0,230),(4975,12,55,450,0,230),(4976,12,59,450,0,230),(4978,12,55,448,0,230),(4979,12,59,448,0,230),(4981,12,55,451,0,230),(4982,12,59,451,0,230),(4984,12,55,452,0,230),(4985,12,59,452,0,230),(4987,12,55,453,0,230),(4988,12,59,453,0,230),(4990,12,55,454,0,230),(4991,12,59,454,0,230),(4993,12,55,455,0,230),(4994,12,59,455,0,230),(4996,12,55,456,0,230),(4997,12,59,456,0,230),(4999,12,55,458,0,230),(5000,12,59,458,0,230),(5002,12,55,457,0,230),(5003,12,59,457,0,230),(5005,12,55,461,0,230),(5006,12,59,461,0,230),(5008,12,55,460,0,230),(5009,12,59,460,0,230),(5011,12,55,459,0,230),(5012,12,59,459,0,230),(5014,12,55,462,0,230),(5015,12,59,462,0,230),(5017,12,55,464,0,230),(5018,12,59,464,0,230),(5020,12,55,463,0,230),(5021,12,59,463,0,230),(5023,12,55,466,0,230),(5024,12,59,466,0,230),(5026,12,55,467,0,230),(5027,12,59,467,0,230),(5029,12,55,465,0,230),(5030,12,59,465,0,230),(5032,12,55,468,0,230),(5033,12,59,468,0,230),(5035,12,55,470,0,230),(5036,12,59,470,0,230),(5038,12,55,469,0,230),(5039,12,59,469,0,230),(5041,12,55,472,0,230),(5042,12,59,472,0,230),(5044,12,55,471,0,230),(5045,12,59,471,0,230),(5047,12,55,473,0,230),(5048,12,59,473,0,230),(5050,16,62,648,1,231),(5051,16,63,648,1,231),(5052,16,65,648,1,231),(5053,16,62,649,1,231),(5054,16,63,649,1,231),(5055,16,65,649,1,231),(5056,16,62,651,1,231),(5057,16,63,651,1,231),(5058,16,65,651,1,231),(5059,16,62,650,1,231),(5060,16,63,650,1,231),(5061,16,65,650,1,231),(5062,16,62,653,1,231),(5063,16,63,653,1,231),(5064,16,65,653,1,231),(5065,16,62,652,1,231),(5066,16,63,652,1,231),(5067,16,65,652,1,231),(5068,16,62,654,1,231),(5069,16,63,654,1,231),(5070,16,65,654,1,231),(5071,16,62,659,1,231),(5072,16,63,659,1,231),(5073,16,65,659,1,231),(5074,16,62,658,1,231),(5075,16,63,658,1,231),(5076,16,65,658,1,231),(5077,16,62,657,1,231),(5078,16,63,657,1,231),(5079,16,65,657,1,231),(5080,16,62,656,1,231),(5081,16,63,656,1,231),(5082,16,65,656,1,231),(5083,16,62,655,1,231),(5084,16,63,655,1,231),(5085,16,65,655,1,231),(5086,16,62,660,1,231),(5087,16,63,660,1,231),(5088,16,65,660,1,231),(5089,16,62,663,1,231),(5090,16,63,663,1,231),(5091,16,65,663,1,231),(5092,16,62,664,1,231),(5093,16,63,664,1,231),(5094,16,65,664,1,231),(5095,16,62,661,1,231),(5096,16,63,661,1,231),(5097,16,65,661,1,231),(5098,16,62,662,1,231),(5099,16,63,662,1,231),(5100,16,65,662,1,231),(5101,16,62,666,1,231),(5102,16,63,666,1,231),(5103,16,65,666,1,231),(5104,16,62,667,1,231),(5105,16,63,667,1,231),(5106,16,65,667,1,231),(5107,16,62,668,1,231),(5108,16,63,668,1,231),(5109,16,65,668,1,231),(5110,16,62,665,1,231),(5111,16,63,665,1,231),(5112,16,65,665,1,231),(5113,16,62,669,1,231),(5114,16,63,669,1,231),(5115,16,65,669,1,231),(5116,16,62,671,1,231),(5117,16,63,671,1,231),(5118,16,65,671,1,231),(5119,16,62,670,1,231),(5120,16,63,670,1,231),(5121,16,65,670,1,231),(5122,16,62,672,1,231),(5123,16,63,672,1,231),(5124,16,65,672,1,231),(5125,16,62,673,1,231),(5126,16,63,673,1,231),(5127,16,65,673,1,231),(5128,16,62,650,1,232),(5129,16,63,650,1,232),(5130,16,65,650,1,232),(5131,16,62,648,1,232),(5132,16,63,648,1,232),(5133,16,65,648,1,232),(5134,16,62,649,1,232),(5135,16,63,649,1,232),(5136,16,65,649,1,232),(5137,16,62,651,1,232),(5138,16,63,651,1,232),(5139,16,65,651,1,232),(5140,16,62,652,1,232),(5141,16,63,652,1,232),(5142,16,65,652,1,232),(5143,16,62,653,1,232),(5144,16,63,653,1,232),(5145,16,65,653,1,232),(5146,16,62,654,1,232),(5147,16,63,654,1,232),(5148,16,65,654,1,232),(5149,16,62,655,1,232),(5150,16,63,655,1,232),(5151,16,65,655,1,232),(5152,16,62,656,1,232),(5153,16,63,656,1,232),(5154,16,65,656,1,232),(5155,16,62,657,1,232),(5156,16,63,657,1,232),(5157,16,65,657,1,232),(5158,16,62,658,1,232),(5159,16,63,658,1,232),(5160,16,65,658,1,232),(5161,16,62,660,1,232),(5162,16,63,660,1,232),(5163,16,65,660,1,232),(5164,16,62,659,1,232),(5165,16,63,659,1,232),(5166,16,65,659,1,232),(5167,16,62,661,1,232),(5168,16,63,661,1,232),(5169,16,65,661,1,232),(5170,16,62,663,1,232),(5171,16,63,663,1,232),(5172,16,65,663,1,232),(5173,16,62,662,1,232),(5174,16,63,662,1,232),(5175,16,65,662,1,232),(5176,16,62,664,1,232),(5177,16,63,664,1,232),(5178,16,65,664,1,232),(5179,16,62,665,1,232),(5180,16,63,665,1,232),(5181,16,65,665,1,232),(5182,16,62,667,1,232),(5183,16,63,667,1,232),(5184,16,65,667,1,232),(5185,16,62,670,1,232),(5186,16,63,670,1,232),(5187,16,65,670,1,232),(5188,16,62,666,1,232),(5189,16,63,666,1,232),(5190,16,65,666,1,232),(5191,16,62,668,1,232),(5192,16,63,668,1,232),(5193,16,65,668,1,232),(5194,16,62,672,1,232),(5195,16,63,672,1,232),(5196,16,65,672,1,232),(5197,16,62,671,1,232),(5198,16,63,671,1,232),(5199,16,65,671,1,232),(5200,16,62,669,1,232),(5201,16,63,669,1,232),(5202,16,65,669,1,232),(5203,16,62,673,1,232),(5204,16,63,673,1,232),(5205,16,65,673,1,232),(5206,16,65,648,1,238),(5207,16,65,649,1,238),(5208,16,65,650,1,238),(5209,16,65,651,1,238),(5210,16,65,656,1,238),(5211,16,65,657,1,238),(5212,16,65,654,1,238),(5213,16,65,653,1,238),(5214,16,65,655,1,238),(5215,16,65,652,1,238),(5216,16,65,661,1,238),(5217,16,65,658,1,238),(5218,16,65,659,1,238),(5219,16,65,662,1,238),(5220,16,65,665,1,238),(5221,16,65,660,1,238),(5222,16,65,664,1,238),(5223,16,65,671,1,238),(5224,16,65,668,1,238),(5225,16,65,663,1,238),(5226,16,65,670,1,238),(5227,16,65,672,1,238),(5228,16,65,669,1,238),(5229,16,65,667,1,238),(5230,16,65,666,1,238),(5231,16,65,673,1,238);
/*!40000 ALTER TABLE `open_close_election` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polling_station`
--

DROP TABLE IF EXISTS `polling_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `polling_station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `postcode` varchar(45) NOT NULL,
  `hierarchy_value_id` int(11) NOT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdatedon` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pols_fk_1_idx` (`organization_id`),
  KEY `pols_fk_2_idx` (`hierarchy_value_id`),
  CONSTRAINT `pols_fk_1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pols_fk_2` FOREIGN KEY (`hierarchy_value_id`) REFERENCES `hierarchy_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polling_station`
--

LOCK TABLES `polling_station` WRITE;
/*!40000 ALTER TABLE `polling_station` DISABLE KEYS */;
INSERT INTO `polling_station` VALUES (1,2,'Brickkiln Community Centre Station 1','Brickkiln Community Centre','1234',4,'2016-02-08 20:54:51',NULL),(2,2,'Brickkiln Community Centre Station 2','22,Derry Cold','KJUUU',4,'2016-02-08 12:46:25',NULL),(3,2,'Brickkiln Community Centre Station 3','Penn Christian Centre Station','1234',694,'2016-02-08 11:13:09',NULL),(4,2,'St Bartholomew`s Church Hall station 1','St Bartholomew`s Church Hal','1234',694,'2016-02-08 11:13:10',NULL),(5,2,'St Bartholomew`s Church Hall station 2','Christian Pentecostal Church Hall','1234',694,'2016-02-08 11:13:10',NULL),(6,3,'Brickkiln Community Centre Station 1','Brickkiln Community Centre Station 1','1234',6,'2016-02-08 13:53:16',NULL),(7,3,'Merridale Primary School Station 1','Merridale Primary School Station 1','1234',6,'2016-01-21 13:53:16',NULL),(8,4,'Lainshaw Primary School Station 1','Lainshaw Primary School Station 1','1234',13,'2016-01-21 13:53:16',NULL),(9,4,'Kilmaurs Primary School Station 1','Kilmaurs Primary School Station 1','1234',14,'2016-01-21 13:53:17',NULL),(10,3,'BEACON COMMUNITY CENTRE DN0104/1','','',6,'2016-02-01 09:08:38',NULL),(11,3,'BRIMMOND SCHOOL DN0108/1','','',5,'2016-02-01 09:08:39',NULL),(12,3,'BRIMMOND SCHOOL DN0108/2','','',6,'2016-02-01 09:08:40',NULL),(13,3,'DANESTONE CONGREGATIONAL CHURCH DN0109/1','','',7,'2016-02-01 09:08:41',NULL),(14,3,'BALGOWNIE COMMUNITY CENTRE DN0209/1','','',7,'2016-02-01 09:08:41',NULL),(15,3,'BALGOWNIE COMMUNITY CENTRE DN0209/2','','',7,'2016-02-01 09:08:42',NULL),(25,5,'DN0104/1','na','na',600,'2016-02-03 02:48:01',NULL),(26,5,'DN0108/1','na','na',601,'2016-02-03 02:48:01',NULL),(27,5,'DN0108/2','na','na',601,'2016-02-03 02:48:01',NULL),(28,5,'DN0109/1','na','na',602,'2016-02-03 02:48:01',NULL),(29,5,'DN0209/1','na','na',603,'2016-02-03 02:48:02',NULL),(30,5,'DN0209/2','na','na',603,'2016-02-03 02:48:02',NULL),(31,5,'DS0306/1','na','na',604,'2016-02-03 02:48:02',NULL),(32,5,'DN0301/1','na','na',605,'2016-02-03 02:48:02',NULL),(33,5,'DN0302/1','na','na',606,'2016-02-03 02:48:03',NULL),(34,5,'DN0302/2','na','na',606,'2016-02-03 02:48:03',NULL),(35,5,'DN0303/1','na','na',607,'2016-02-03 02:48:04',NULL),(36,5,'DN0303/2','na','na',607,'2016-02-03 02:48:04',NULL),(37,5,'DN0304/1','na','na',608,'2016-02-03 02:48:05',NULL),(38,5,'DN0304/2','na','na',608,'2016-02-03 02:48:05',NULL),(39,5,'DN0305/1','na','na',609,'2016-02-03 02:48:06',NULL),(40,5,'DN0305/2','na','na',609,'2016-02-03 02:48:07',NULL),(41,5,'DS0308/1','na','na',610,'2016-02-03 02:48:07',NULL),(42,5,'DN0307/1','na','na',611,'2016-02-03 02:48:07',NULL),(43,5,'DN0309/1','na','na',612,'2016-02-03 02:48:07',NULL),(44,5,'DN0310/1','na','na',613,'2016-02-03 02:48:08',NULL),(45,5,'DN0401/1','na','na',614,'2016-02-03 02:48:08',NULL),(46,5,'DN0401/2','na','na',614,'2016-02-03 02:48:08',NULL),(47,5,'DN0402/1','na','na',615,'2016-02-03 02:48:08',NULL),(48,5,'DN0403/1','na','na',616,'2016-02-03 02:48:09',NULL),(49,5,'DN0404/1','na','na',617,'2016-02-03 02:48:09',NULL),(50,5,'DN0404/2','na','na',617,'2016-02-03 02:48:09',NULL),(51,5,'DN0405/1','na','na',618,'2016-02-03 02:48:09',NULL),(52,5,'DN0406/1','na','na',619,'2016-02-03 02:48:10',NULL),(53,5,'DN0406/2','na','na',619,'2016-02-03 02:48:10',NULL),(54,5,'DN0407/1','na','na',620,'2016-02-03 02:48:10',NULL),(55,5,'DN0408/1','na','na',621,'2016-02-03 02:48:10',NULL),(56,5,'DN0408/2','na','na',621,'2016-02-03 02:48:10',NULL),(57,5,'DN0501/1','na','na',622,'2016-02-03 02:48:11',NULL),(58,5,'DN0501/2','na','na',622,'2016-02-03 02:48:11',NULL),(59,5,'DN0502/1','na','na',623,'2016-02-03 02:48:11',NULL),(60,5,'DN0503/1','na','na',624,'2016-02-03 02:48:11',NULL),(61,5,'DN0503/2','na','na',624,'2016-02-03 02:48:12',NULL),(62,5,'DN0504/1','na','na',625,'2016-02-03 02:48:12',NULL),(63,5,'DN0504/2','na','na',625,'2016-02-03 02:48:12',NULL),(64,5,'DN0505/1','na','na',626,'2016-02-03 02:48:12',NULL),(65,5,'CN0506/1','na','na',627,'2016-02-03 02:48:12',NULL),(66,5,'CN0506/2','na','na',627,'2016-02-03 02:48:13',NULL),(67,5,'CN0507/1','na','na',628,'2016-02-03 02:48:13',NULL),(68,5,'CN0508/1','na','na',629,'2016-02-03 02:48:13',NULL),(69,5,'CN0601/1','na','na',630,'2016-02-03 02:48:14',NULL),(70,5,'CN0601/2','na','na',630,'2016-02-03 02:48:14',NULL),(71,5,'CN0602/1','na','na',631,'2016-02-03 02:48:14',NULL),(72,5,'CN0603/1','na','na',632,'2016-02-03 02:48:15',NULL),(73,5,'CN0603/2','na','na',632,'2016-02-03 02:48:15',NULL),(74,5,'CN0604/1','na','na',633,'2016-02-03 02:48:15',NULL),(75,5,'CN0604/2','na','na',633,'2016-02-03 02:48:15',NULL),(76,5,'CN0605/1','na','na',634,'2016-02-03 02:48:16',NULL),(77,5,'CN0606/1','na','na',635,'2016-02-03 02:48:16',NULL),(78,5,'CN0606/2','na','na',635,'2016-02-03 02:48:16',NULL),(79,5,'CN0701/1','na','na',636,'2016-02-03 02:48:16',NULL),(80,5,'CN0702/1','na','na',637,'2016-02-03 02:48:17',NULL),(81,5,'CN0702/2','na','na',637,'2016-02-03 02:48:17',NULL),(82,5,'CN0703/1','na','na',638,'2016-02-03 02:48:17',NULL),(83,5,'CN0704/1','na','na',639,'2016-02-03 02:48:18',NULL),(84,5,'CN0704/2','na','na',639,'2016-02-03 02:48:18',NULL),(85,5,'CN0801/1','na','na',640,'2016-02-03 02:48:19',NULL),(86,5,'CN0802/1','na','na',641,'2016-02-03 02:48:19',NULL),(87,5,'CN0802/2','na','na',641,'2016-02-03 02:48:20',NULL),(88,5,'CN0803/1','na','na',642,'2016-02-03 02:48:21',NULL),(89,5,'CN0803/2','na','na',642,'2016-02-03 02:48:21',NULL),(90,5,'CN0805/1','na','na',643,'2016-02-03 02:48:22',NULL),(91,5,'CN0805/2','na','na',643,'2016-02-03 02:48:22',NULL),(92,5,'CN0806/1','na','na',644,'2016-02-03 02:48:22',NULL),(93,5,'CN0806/2','na','na',644,'2016-02-03 02:48:22',NULL),(94,5,'CN0807/1','na','na',645,'2016-02-03 02:48:22',NULL),(95,5,'CN0807/2','na','na',645,'2016-02-03 02:48:23',NULL),(96,5,'CN0808/1','na','na',646,'2016-02-03 02:48:23',NULL),(97,5,'CN0808/2','na','na',646,'2016-02-03 02:48:23',NULL),(98,5,'SN1003/1','na','na',647,'2016-02-03 02:48:23',NULL),(99,5,'CS0705/1','na','na',648,'2016-02-03 02:48:24',NULL),(100,5,'CS0705/2','na','na',648,'2016-02-03 02:48:24',NULL),(101,5,'CS0706/1','na','na',649,'2016-02-03 02:48:26',NULL),(102,5,'CS0706/2','na','na',649,'2016-02-03 02:48:26',NULL),(103,5,'CS0804/1','na','na',650,'2016-02-03 02:48:26',NULL),(104,5,'SS0901/1','na','na',651,'2016-02-03 02:48:26',NULL),(105,5,'SS0901/2','na','na',651,'2016-02-03 02:48:27',NULL),(106,5,'SS0902/1','na','na',652,'2016-02-03 02:48:27',NULL),(107,5,'SS0903/1','na','na',653,'2016-02-03 02:48:27',NULL),(108,5,'SS0903/2','na','na',653,'2016-02-03 02:48:27',NULL),(109,5,'SS0904/1','na','na',654,'2016-02-03 02:48:27',NULL),(110,5,'SS0904/2','na','na',654,'2016-02-03 02:48:28',NULL),(111,5,'SS0905/1','na','na',655,'2016-02-03 02:48:28',NULL),(112,5,'SS0905/2','na','na',655,'2016-02-03 02:48:28',NULL),(113,5,'SS0906/1','na','na',656,'2016-02-03 02:48:28',NULL),(114,5,'SS0906/2','na','na',656,'2016-02-03 02:48:29',NULL),(115,5,'SN1002/1','na','na',657,'2016-02-03 02:48:29',NULL),(116,5,'SS1001/1','na','na',658,'2016-02-03 02:48:29',NULL),(117,5,'SS1001/2','na','na',658,'2016-02-03 02:48:29',NULL),(118,5,'CN1005/1','na','na',659,'2016-02-03 02:48:30',NULL),(119,5,'CS1004/1','na','na',660,'2016-02-03 02:48:30',NULL),(120,5,'CS1004/2','na','na',660,'2016-02-03 02:48:31',NULL),(121,5,'SS1006/1','na','na',661,'2016-02-03 02:48:31',NULL),(122,5,'SS1007/1','na','na',662,'2016-02-03 02:48:31',NULL),(123,5,'SS1007/2','na','na',662,'2016-02-03 02:48:31',NULL),(124,5,'CS1008/1','na','na',663,'2016-02-03 02:48:32',NULL),(125,5,'CS1008/2','na','na',663,'2016-02-03 02:48:32',NULL),(126,5,'CS1009/1','na','na',664,'2016-02-03 02:48:33',NULL),(127,5,'CS1010/1','na','na',665,'2016-02-03 02:48:33',NULL),(128,5,'CS1010/2','na','na',665,'2016-02-03 02:48:34',NULL),(129,5,'SS1101/1','na','na',666,'2016-02-03 02:48:35',NULL),(130,5,'SS1101/2','na','na',666,'2016-02-03 02:48:35',NULL),(131,5,'SS1102/1','na','na',667,'2016-02-03 02:48:36',NULL),(132,5,'SS1103/1','na','na',668,'2016-02-03 02:48:36',NULL),(133,5,'SS1103/2','na','na',668,'2016-02-03 02:48:36',NULL),(134,5,'SS1103/2','na','na',669,'2016-02-03 02:48:37',NULL),(135,5,'CS1104/2','na','na',669,'2016-02-03 02:48:37',NULL),(136,5,'SS1105/1','na','na',670,'2016-02-03 02:48:37',NULL),(137,5,'SS1106/1','na','na',671,'2016-02-03 02:48:37',NULL),(138,5,'SS1106/2','na','na',671,'2016-02-03 02:48:38',NULL),(139,5,'SS1107/1','na','na',672,'2016-02-03 02:48:38',NULL),(140,5,'SS1107/2','na','na',672,'2016-02-03 02:48:38',NULL),(141,5,'CS1108/1','na','na',673,'2016-02-03 02:48:38',NULL),(142,5,'CN1202/1','na','na',674,'2016-02-03 02:48:39',NULL),(143,5,'CS1201/1','na','na',675,'2016-02-03 02:48:42',NULL),(144,5,'CS1201/2','na','na',675,'2016-02-03 02:48:42',NULL),(145,5,'CS1203/1','na','na',676,'2016-02-03 02:48:43',NULL),(146,5,'CS1203/2','na','na',676,'2016-02-03 02:48:43',NULL),(147,5,'CS1204/1','na','na',677,'2016-02-03 02:48:43',NULL),(148,5,'CS1204/2','na','na',677,'2016-02-03 02:48:43',NULL),(149,5,'CS1205/1','na','na',678,'2016-02-03 02:48:44',NULL),(150,5,'CS1205/2','na','na',678,'2016-02-03 02:48:44',NULL),(151,5,'SS1206/1','na','na',679,'2016-02-03 02:48:44',NULL),(152,5,'SS1206/2','na','na',679,'2016-02-03 02:48:44',NULL),(153,5,'SS1207/1','na','na',680,'2016-02-03 02:48:44',NULL),(154,5,'SS1207/2','na','na',680,'2016-02-03 02:48:45',NULL),(155,5,'SS1208/1','na','na',681,'2016-02-03 02:48:45',NULL),(156,5,'SS1208/2','na','na',681,'2016-02-03 02:48:45',NULL),(157,5,'SS1209/1','na','na',682,'2016-02-03 02:48:46',NULL),(158,5,'SS1301/1','na','na',683,'2016-02-03 02:48:46',NULL),(159,5,'SS1301/2','na','na',683,'2016-02-03 02:48:46',NULL),(160,5,'SS1302/1','na','na',684,'2016-02-03 02:48:46',NULL),(161,5,'SS1302/2','na','na',684,'2016-02-03 02:48:47',NULL),(162,5,'SS1303/1','na','na',685,'2016-02-03 02:48:47',NULL),(163,5,'SS1304/1','na','na',686,'2016-02-03 02:48:48',NULL),(164,5,'SS1304/2','na','na',686,'2016-02-03 02:48:48',NULL),(165,5,'SS1305/1','na','na',687,'2016-02-03 02:48:49',NULL),(166,5,'SS1306/1','na','na',688,'2016-02-03 02:48:50',NULL),(167,5,'SS1306/2','na','na',688,'2016-02-03 02:48:50',NULL),(168,5,'SS1306/3','na','na',688,'2016-02-03 02:48:51',NULL),(169,5,'SS1307/1','na','na',689,'2016-02-03 02:48:51',NULL),(170,5,'SS1307/2','na','na',689,'2016-02-03 02:48:51',NULL),(171,6,'Royal British Legion Hall Station 1 - RBLH01','','',693,'2016-02-05 10:00:58',NULL),(172,6,'Royal British Legion Hall Station 2 - RBLH02','','',693,'2016-02-05 10:01:35',NULL),(173,9,'Royal British Legion Hall Station 1 - RBLH01','','',696,'2016-02-05 10:01:35',NULL),(174,9,'Royal British Legion Hall Station 2 - RBLH01','','',697,'2016-02-05 10:01:35',NULL),(175,9,'Royal British Legion Hall Station 3 - RBLH01','','',698,'2016-02-05 10:01:35',NULL),(176,9,'Royal British Legion Hall Station 4 - RBLH01','','',695,'2016-02-05 10:01:35',NULL),(177,10,'DS0306/1','','',702,'2016-03-18 19:49:44',NULL),(178,10,'DS0308/1','','',704,'2016-03-18 19:49:44',NULL),(179,10,'CS0705/1','','',706,'2016-03-18 19:49:44',NULL),(180,10,'CS0705/2','','',706,'2016-03-18 19:49:44',NULL),(181,10,'CS0706/1','','',708,'2016-03-18 19:49:44',NULL),(182,10,'CS0706/2','','',708,'2016-03-18 19:49:44',NULL),(199,12,'DS0306/1','','',734,'2016-03-22 11:55:20',NULL),(200,12,'DS0308/1','','',736,'2016-03-22 11:55:20',NULL),(201,12,'CS0705/1','','',738,'2016-03-22 11:55:20',NULL),(202,12,'CS0705/2','','',738,'2016-03-22 11:55:20',NULL),(203,12,'CS0706/1','','',740,'2016-03-22 11:55:20',NULL),(204,12,'CS0706/2','','',740,'2016-03-22 11:55:20',NULL),(205,12,'CS0804/1','','',742,'2016-03-22 11:57:21',NULL),(206,12,'SS0901/1','','',744,'2016-03-22 11:57:21',NULL),(207,12,'SS0901/2','','',744,'2016-03-22 11:57:21',NULL),(208,12,'SS0902/1','','',746,'2016-03-22 11:57:21',NULL),(209,12,'SS0903/1','','',748,'2016-03-22 11:57:21',NULL),(210,12,'SS0903/2','','',748,'2016-03-22 11:57:21',NULL),(211,12,'SS0904/1','','',750,'2016-03-22 11:57:21',NULL),(212,12,'SS0904/2','','',750,'2016-03-22 11:57:21',NULL),(213,12,'SS0905/1','','',752,'2016-03-22 11:57:21',NULL),(214,12,'SS0905/2','','',752,'2016-03-22 11:57:21',NULL),(215,12,'CS0705/3','','',738,'2016-03-25 07:53:35',NULL),(216,13,'DS0306/1','124','',756,'2016-03-31 17:30:26',NULL),(217,13,'DS0308/1','54','',758,'2016-03-31 17:30:26',NULL),(218,13,'DS0306/2','124','',756,'2016-03-31 19:55:28',NULL),(219,13,'DS0308/2','54','',758,'2016-03-31 19:55:28',NULL),(220,13,'DS0306/3','124','',756,'2016-03-31 20:57:51',NULL),(221,13,'DS0308/3','54','',758,'2016-03-31 20:57:51',NULL),(222,13,'DS0306/4','124','',756,'2016-03-31 21:00:58',NULL),(223,13,'DS0308/4','54','',758,'2016-03-31 21:00:58',NULL),(224,14,'DS0306/1','124','',765,'2016-03-31 21:57:38',NULL),(225,14,'DS0308/1','54','',767,'2016-03-31 21:57:38',NULL),(226,14,'DS0306/2','124','',765,'2016-04-01 03:59:21',NULL),(227,14,'DS0308/2','54','',767,'2016-04-01 03:59:21',NULL),(228,12,'DS0308/2','54','',736,'2016-04-01 04:42:08',NULL),(229,12,'DS0306/2','124','',734,'2016-04-01 05:35:15',NULL),(230,12,'DS0308/3','54','',736,'2016-04-01 05:35:15',NULL),(231,16,'DS0306/2','124','',777,'2016-04-01 06:46:03',NULL),(232,16,'DS0308/2','54','',779,'2016-04-01 06:46:03',NULL),(233,16,'DS0306/12','124','',783,'2016-04-01 06:46:57',NULL),(234,16,'DS0308/12','54','',785,'2016-04-01 06:46:57',NULL),(235,15,'DG0101/1','','',771,'2016-04-01 06:48:43',NULL),(236,15,'DG0102/1','','',786,'2016-04-01 07:05:26',NULL),(237,15,'DG0103/1','','',771,'2016-04-01 07:05:41',NULL),(238,16,'DS0309/2','55','',790,'2016-04-01 07:17:04',NULL);
/*!40000 ALTER TABLE `polling_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polling_station_election`
--

DROP TABLE IF EXISTS `polling_station_election`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `polling_station_election` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `polling_station_id` int(11) NOT NULL,
  `election_id` int(11) NOT NULL,
  `isopen` int(11) NOT NULL DEFAULT '0' COMMENT '0=not opened, 1=opened',
  `isclose` int(11) NOT NULL DEFAULT '0' COMMENT '0=not closed, 1= closed',
  `opentime` time NOT NULL,
  `openedat` timestamp NULL DEFAULT NULL,
  `closedat` timestamp NULL DEFAULT NULL,
  `ballot_box_number` varchar(45) DEFAULT NULL,
  `election_status` int(11) DEFAULT '0' COMMENT '0=open, 1=closed',
  `ballotstart` int(11) DEFAULT NULL,
  `ballotend` int(11) DEFAULT NULL,
  `tenderstart` int(11) DEFAULT NULL,
  `tenderend` int(11) DEFAULT NULL,
  `ballot2start` int(11) DEFAULT NULL,
  `ballot2end` int(11) DEFAULT NULL,
  `tender2start` int(11) DEFAULT NULL,
  `tender2end` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `psel_fk1_idx` (`organization_id`),
  KEY `psel_fk2_idx` (`polling_station_id`),
  KEY `psel_fk3_idx` (`election_id`),
  CONSTRAINT `psel_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `psel_fk2` FOREIGN KEY (`polling_station_id`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `psel_fk3` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polling_station_election`
--

LOCK TABLES `polling_station_election` WRITE;
/*!40000 ALTER TABLE `polling_station_election` DISABLE KEYS */;
INSERT INTO `polling_station_election` VALUES (36,6,171,9,1,1,'07:01:21',NULL,'2016-02-18 23:26:57','Ballot box 1',1,5000001,5001701,5000001,5000011,NULL,NULL,NULL,NULL),(37,6,172,9,1,1,'07:00:58',NULL,'2016-02-18 23:27:52','Ballot box 2',1,5001701,5003201,5000011,5000021,NULL,NULL,NULL,NULL),(38,3,6,4,0,0,'10:03:51',NULL,'2016-02-23 22:00:00','Ballot box3',0,5000,54000,5000,54000,NULL,NULL,NULL,NULL),(39,3,7,4,0,0,'10:03:51',NULL,'2016-02-23 22:00:00','Ballot box3',0,5000,54000,5000,54000,NULL,NULL,NULL,NULL),(40,3,10,4,0,0,'10:03:51',NULL,'2016-02-23 22:00:00','Ballot box3',0,5000,54000,5000,54000,NULL,NULL,NULL,NULL),(41,3,11,4,0,0,'10:03:51',NULL,'2016-02-23 22:00:00','Ballot box3',0,5000,54000,5000,54000,NULL,NULL,NULL,NULL),(42,9,173,10,0,0,'10:13:41',NULL,'2016-02-23 22:00:00','Ballot box 2',0,5000,65000,6000,65000,NULL,NULL,NULL,NULL),(43,9,174,10,0,0,'10:19:47',NULL,'2016-02-23 22:00:00','Ballot box 2',0,5000,65000,5000,65000,NULL,NULL,NULL,NULL),(45,9,176,10,0,0,'05:09:03',NULL,'2016-02-23 22:00:00','Ballot box 2',0,5000,65000,5000,65000,NULL,NULL,NULL,NULL),(46,9,173,11,0,0,'10:13:41',NULL,'2016-02-23 22:00:00','Ballot box 2',0,5000,65000,5000,65000,NULL,NULL,NULL,NULL),(48,9,175,11,0,0,'04:01:14',NULL,'2016-02-23 22:00:00','Ballot box 2',0,5000,65000,5000,65000,NULL,NULL,NULL,NULL),(49,9,176,11,0,0,'05:09:03',NULL,'2016-02-23 22:00:00','Ballot box 2',0,5000,65000,5000,65000,NULL,NULL,NULL,NULL),(50,10,177,12,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(51,10,178,12,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(52,10,179,12,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(53,10,180,12,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(54,10,181,12,0,0,'19:52:23',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(55,10,182,12,0,0,'19:52:39',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(56,10,177,13,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(57,10,178,13,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(58,10,179,13,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(59,10,180,13,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(60,10,181,13,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(61,10,182,13,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(84,12,199,17,1,0,'11:04:14',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(85,12,200,17,0,0,'15:53:49',NULL,'2016-03-23 13:30:39','0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(86,12,201,17,1,0,'10:59:13',NULL,'2016-03-24 11:29:46','0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(87,12,202,17,1,0,'11:00:06',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(88,12,203,17,1,0,'11:03:14',NULL,'2016-03-24 15:34:13','0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(89,12,204,17,0,0,'16:04:28',NULL,'2016-03-24 16:11:00','0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(90,12,205,18,0,0,'10:34:53',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(91,12,206,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(92,12,207,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(93,12,208,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(94,12,209,18,0,0,'11:03:41',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(95,12,210,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(96,12,211,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(97,12,212,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(98,12,213,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(99,12,214,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(100,12,199,22,1,0,'08:51:39',NULL,NULL,'0',1,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(101,12,200,22,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(102,12,201,22,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(103,12,202,22,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(104,12,203,22,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(105,12,204,22,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(106,12,199,26,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(107,12,200,26,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(108,12,201,26,1,0,'07:10:25',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(109,12,202,26,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(110,12,203,26,1,0,'14:12:40',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(111,12,204,26,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(112,12,199,27,1,0,'07:41:26',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(113,12,200,27,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(114,12,201,27,1,0,'04:19:42',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(115,12,202,27,1,0,'04:20:04',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(116,12,215,27,1,0,'04:20:35',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(117,12,203,27,0,0,'14:12:40',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(118,12,204,27,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(119,12,205,28,1,0,'14:08:37',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(120,12,206,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(121,12,207,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(122,12,208,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(123,12,209,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(124,12,210,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(125,12,211,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(126,12,212,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(127,12,213,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(128,12,214,28,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(129,12,205,29,1,0,'14:08:37',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(130,12,206,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(131,12,207,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(132,12,208,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(133,12,209,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(134,12,210,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(135,12,211,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(136,12,212,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(137,12,213,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(138,12,214,29,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(139,12,199,30,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(140,12,200,30,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(141,12,201,30,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(142,12,202,30,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(143,12,203,30,1,0,'14:12:40',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(144,12,204,30,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(145,12,205,34,1,0,'14:08:37',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(146,12,206,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(147,12,207,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(148,12,208,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(149,12,209,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(150,12,210,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(151,12,211,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(152,12,212,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(153,12,213,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(154,12,214,34,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(155,12,199,35,1,0,'08:51:39',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(156,12,200,35,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(157,12,201,35,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(158,12,202,35,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(159,12,203,35,0,0,'14:12:40',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(160,12,204,35,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(161,12,199,38,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(162,12,200,38,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(163,12,201,38,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(164,12,202,38,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(165,12,203,38,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(166,12,204,38,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(167,12,199,40,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(168,12,200,40,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(169,12,201,40,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(170,12,202,40,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(171,12,215,40,1,0,'11:39:51',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(172,12,203,40,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(173,12,204,40,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(174,12,199,43,1,0,'08:51:39',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(175,12,200,43,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(176,12,201,43,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(177,12,202,43,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(178,12,215,43,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(179,12,203,43,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(180,12,204,43,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000,NULL,NULL,NULL,NULL),(181,13,216,46,0,0,'00:00:00',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(182,13,217,46,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(183,13,218,46,0,0,'00:00:00',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(184,13,219,46,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(185,13,218,47,0,0,'00:00:00',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(186,13,220,46,0,0,'00:00:00',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(187,13,221,46,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(188,13,216,47,0,0,'00:00:00',NULL,NULL,'1452',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(189,13,222,47,0,0,'00:00:00',NULL,NULL,'1452',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(190,13,223,47,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(191,14,224,48,0,0,'00:00:00',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(192,14,225,48,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(193,14,226,48,0,0,'00:00:00',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(194,14,227,48,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(195,12,228,51,1,0,'07:42:08',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(196,12,228,50,1,0,'07:42:08',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(197,12,228,17,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(198,12,228,18,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(199,12,229,55,1,0,'07:42:48',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(200,12,228,55,1,0,'07:42:08',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(201,12,230,55,1,0,'07:44:27',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(202,12,228,56,1,0,'07:42:08',NULL,NULL,'455',1,1,2,1,2,NULL,NULL,NULL,NULL),(203,12,229,57,1,0,'07:42:48',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(204,12,228,57,1,0,'07:42:08',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(205,12,228,58,1,0,'07:42:08',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(206,12,229,59,1,0,'07:42:48',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(207,12,228,59,1,0,'07:42:08',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(208,12,230,59,1,0,'07:44:27',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(209,12,229,60,1,0,'07:42:48',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(210,12,228,60,1,0,'07:42:08',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(211,16,231,62,1,0,'07:55:23',NULL,NULL,'1452',0,200,119999,18888,118888,NULL,NULL,NULL,NULL),(212,16,232,62,1,0,'07:58:15',NULL,NULL,'455',0,210,19988,8898,18888,NULL,NULL,NULL,NULL),(213,16,233,61,1,1,'06:55:15',NULL,'2016-04-01 08:14:46','1452',1,1,2,1,2,NULL,NULL,NULL,NULL),(214,16,234,61,0,0,'00:00:00',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(215,16,231,63,1,0,'07:55:23',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(216,16,232,63,1,0,'07:58:15',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(217,15,235,53,0,0,'00:00:00',NULL,NULL,'0',0,1,800,100001,100020,NULL,NULL,NULL,NULL),(218,15,236,53,0,0,'00:00:00',NULL,NULL,'0',0,1601,2600,100041,100060,NULL,NULL,NULL,NULL),(219,15,237,53,0,0,'00:00:00',NULL,NULL,'0',0,2601,3200,100061,100080,NULL,NULL,NULL,NULL),(220,16,231,65,1,0,'07:55:23',NULL,NULL,'1452',0,1,2,1,2,NULL,NULL,NULL,NULL),(221,16,232,65,1,0,'07:58:15',NULL,NULL,'455',0,1,2,1,2,NULL,NULL,NULL,NULL),(222,16,238,65,1,0,'08:01:41',NULL,NULL,'500',0,1,2,1,2,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `polling_station_election` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polling_station_election_counting`
--

DROP TABLE IF EXISTS `polling_station_election_counting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `polling_station_election_counting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `polling_station_id` int(11) NOT NULL,
  `election_id` int(11) NOT NULL,
  `counting_center_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `polling_station_election_counting_election_idx` (`election_id`),
  KEY `polling_station_election_counting_polling_station_` (`polling_station_id`),
  KEY `polling_station_election_counting_counting_idx` (`counting_center_id`),
  KEY `polling_station_election_counting_organization_idx` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polling_station_election_counting`
--

LOCK TABLES `polling_station_election_counting` WRITE;
/*!40000 ALTER TABLE `polling_station_election_counting` DISABLE KEYS */;
INSERT INTO `polling_station_election_counting` VALUES (1,2,1,1,1),(2,2,2,2,1),(3,2,1,2,1),(4,2,2,1,1),(5,2,3,3,1),(6,2,4,1,1),(7,2,5,2,1),(8,2,5,1,1),(9,3,6,4,2),(10,3,7,4,2),(11,4,8,5,3),(12,4,9,5,3),(13,2,3,1,1),(14,2,5,3,1),(15,3,10,4,2),(16,3,11,4,2),(17,3,12,4,2),(18,3,13,4,2),(19,3,14,4,2),(20,3,15,4,2),(21,6,171,9,5),(22,6,172,9,5),(23,2,1,7,1),(24,2,4,7,1),(25,2,1,8,1),(26,2,4,8,1),(32,9,173,10,8),(33,9,174,10,8),(34,9,175,10,8),(35,9,175,10,8),(36,10,177,12,9),(37,10,178,12,9),(38,10,179,12,9),(39,10,180,12,9),(40,10,181,12,9),(41,10,182,12,9),(42,10,177,13,10),(43,10,178,13,10),(44,10,179,13,10),(45,10,180,13,10),(46,10,181,13,10),(47,10,182,13,10),(70,12,199,17,14),(71,12,200,17,14),(72,12,201,17,14),(73,12,202,17,14),(74,12,203,17,14),(75,12,204,17,14),(76,12,205,18,15),(77,12,206,18,15),(78,12,207,18,15),(79,12,208,18,15),(80,12,209,18,15),(81,12,210,18,15),(82,12,211,18,15),(83,12,212,18,15),(84,12,213,18,15),(85,12,214,18,15),(86,12,199,22,19),(87,12,200,22,19),(88,12,201,22,19),(89,12,202,22,19),(90,12,203,22,19),(91,12,204,22,19),(92,12,199,26,23),(93,12,200,26,23),(94,12,201,26,23),(95,12,202,26,23),(96,12,203,26,23),(97,12,204,26,23),(98,12,199,27,24),(99,12,200,27,24),(100,12,201,27,24),(101,12,202,27,24),(102,12,215,27,24),(103,12,203,27,24),(104,12,204,27,24),(105,12,205,28,25),(106,12,206,28,25),(107,12,207,28,25),(108,12,208,28,25),(109,12,209,28,25),(110,12,210,28,25),(111,12,211,28,25),(112,12,212,28,25),(113,12,213,28,25),(114,12,214,28,25),(115,12,205,29,26),(116,12,206,29,26),(117,12,207,29,26),(118,12,208,29,26),(119,12,209,29,26),(120,12,210,29,26),(121,12,211,29,26),(122,12,212,29,26),(123,12,213,29,26),(124,12,214,29,26),(125,12,199,30,27),(126,12,200,30,27),(127,12,201,30,27),(128,12,202,30,27),(129,12,203,30,27),(130,12,204,30,27),(131,12,205,34,31),(132,12,206,34,31),(133,12,207,34,31),(134,12,208,34,31),(135,12,209,34,31),(136,12,210,34,31),(137,12,211,34,31),(138,12,212,34,31),(139,12,213,34,31),(140,12,214,34,31),(141,12,199,35,32),(142,12,200,35,32),(143,12,201,35,32),(144,12,202,35,32),(145,12,203,35,32),(146,12,204,35,32),(147,12,199,38,35),(148,12,200,38,35),(149,12,201,38,35),(150,12,202,38,35),(151,12,203,38,35),(152,12,204,38,35),(153,12,199,40,37),(154,12,200,40,37),(155,12,201,40,37),(156,12,202,40,37),(157,12,215,40,37),(158,12,203,40,37),(159,12,204,40,37),(160,12,199,43,40),(161,12,200,43,40),(162,12,201,43,40),(163,12,202,43,40),(164,12,215,43,40),(165,12,203,43,40),(166,12,204,43,40),(167,13,216,46,43),(168,13,217,46,43),(169,13,218,46,43),(170,13,219,46,43),(171,13,218,47,44),(172,13,220,46,43),(173,13,221,46,43),(174,13,216,47,44),(175,13,222,47,44),(176,13,223,47,44),(177,14,224,48,45),(178,14,225,48,45),(179,14,226,48,45),(180,14,227,48,45),(181,12,228,51,48),(182,12,228,50,47),(183,12,228,17,14),(184,12,228,18,15),(185,12,229,55,52),(186,12,228,55,52),(187,12,230,55,52),(188,12,228,56,53),(189,12,229,57,54),(190,12,228,57,54),(191,12,228,58,55),(192,12,229,59,56),(193,12,228,59,56),(194,12,230,59,56),(195,12,229,60,57),(196,12,228,60,57),(197,16,231,62,59),(198,16,232,62,59),(199,16,233,61,58),(200,16,234,61,58),(201,16,231,63,60),(202,16,232,63,60),(203,15,235,53,50),(204,15,236,53,50),(205,15,237,53,50),(206,16,231,65,62),(207,16,232,65,62),(208,16,238,65,62);
/*!40000 ALTER TABLE `polling_station_election_counting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station_photo`
--

DROP TABLE IF EXISTS `station_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station_photo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `station_id` int(11) DEFAULT NULL,
  `election_id` int(11) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `stp_fk1_idx` (`organization_id`),
  KEY `stp_fk2_idx` (`election_id`),
  CONSTRAINT `stp_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `stp_fk2` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station_photo`
--

LOCK TABLES `station_photo` WRITE;
/*!40000 ALTER TABLE `station_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `station_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracking`
--

DROP TABLE IF EXISTS `tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `pollingstationid` int(11) DEFAULT NULL,
  `election_id` int(11) DEFAULT NULL,
  `latitude` varchar(45) DEFAULT NULL,
  `longtitude` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0=at station, 1=on the move,2=arrived',
  `deliver_address` varchar(100) DEFAULT NULL,
  `dispatch_time` timestamp NULL DEFAULT NULL,
  `deliver_time` timestamp NULL DEFAULT NULL,
  `eta` datetime DEFAULT NULL,
  `deliver_lat` varchar(45) DEFAULT NULL,
  `deliver_long` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trac_fk1_idx` (`organization_id`),
  KEY `trac_fk2_idx` (`election_id`),
  KEY `trac_fk2_idx1` (`pollingstationid`),
  CONSTRAINT `trac_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `trac_fk2` FOREIGN KEY (`pollingstationid`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `trac_fk3` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking`
--

LOCK TABLES `tracking` WRITE;
/*!40000 ALTER TABLE `tracking` DISABLE KEYS */;
INSERT INTO `tracking` VALUES (46,12,199,17,NULL,NULL,1,'address','2016-03-23 12:14:04',NULL,NULL,NULL,NULL),(47,12,200,17,'55.0128427','-7.313085300000001',1,'address','2016-03-23 12:28:44',NULL,NULL,NULL,NULL),(48,12,205,18,'55.012911599999995','-7.3132383',1,'address','2016-03-23 14:54:57',NULL,NULL,NULL,NULL),(49,12,203,17,'54.5870374','-5.8638284',1,'address','2016-03-23 16:26:15',NULL,NULL,NULL,NULL),(50,12,204,17,'54.5870374','-5.8638284',1,'address','2016-03-23 16:26:15',NULL,NULL,NULL,NULL),(52,12,201,17,'6.7904553','79.885915',1,'address','2016-03-24 12:45:28',NULL,NULL,NULL,NULL),(53,12,202,17,'6.7904553','79.885915',1,'address','2016-03-24 12:45:28',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_election`
--

DROP TABLE IF EXISTS `user_election`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_election` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `election_id` int(11) DEFAULT NULL,
  `pollingstation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_el_fk1_idx` (`organization_id`),
  KEY `user_el_fk2_idx` (`user_id`),
  KEY `user_el_fk3_idx` (`election_id`),
  KEY `user_el_fk4_idx` (`pollingstation_id`),
  CONSTRAINT `user_el_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_el_fk2` FOREIGN KEY (`user_id`) REFERENCES `security`.`user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_el_fk3` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_el_fk4` FOREIGN KEY (`pollingstation_id`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_election`
--

LOCK TABLES `user_election` WRITE;
/*!40000 ALTER TABLE `user_election` DISABLE KEYS */;
INSERT INTO `user_election` VALUES (1,2,2,1,1),(2,2,2,2,2),(4,2,2,3,3),(5,2,5,1,4),(6,2,6,1,5),(7,3,7,4,6),(8,3,7,4,7),(9,3,8,5,10),(10,3,8,5,11),(11,2,2,1,2),(12,2,2,1,3),(13,2,2,1,4),(14,2,2,1,5),(15,3,7,4,10),(16,3,7,4,11),(17,3,7,4,12),(18,3,7,4,13),(19,3,7,4,14),(20,3,7,4,15),(30,6,73,6,171),(31,6,74,6,172),(33,6,76,6,171),(34,6,76,6,172),(35,6,77,6,171),(36,6,77,6,172),(37,2,2,7,4),(38,2,2,7,1),(39,2,2,8,4),(40,2,2,8,1),(47,6,73,9,171),(48,6,74,9,172),(50,6,76,9,171),(51,6,76,9,172),(52,6,77,9,171),(53,6,77,9,172),(55,6,73,9,172),(56,6,78,9,171),(57,6,78,9,172),(67,9,83,10,174),(69,9,83,10,176),(70,9,84,10,173),(74,9,85,10,173),(75,9,85,10,174),(77,9,85,10,176),(81,9,83,11,176),(82,9,84,11,173),(84,9,84,11,175),(86,9,85,11,173),(88,9,85,11,175),(89,9,85,11,176),(90,10,87,12,177),(91,10,88,12,178),(92,10,89,12,179),(93,10,89,12,180),(94,10,90,12,181),(95,10,90,12,182),(96,10,87,13,177),(97,10,88,13,178),(98,10,89,13,179),(99,10,89,13,180),(100,10,90,13,181),(101,10,90,13,182),(124,12,103,17,199),(125,12,104,17,200),(126,12,105,17,201),(127,12,105,17,202),(128,12,106,17,203),(129,12,106,17,204),(130,12,107,18,205),(131,12,108,18,206),(132,12,108,18,207),(133,12,109,18,208),(134,12,110,18,209),(135,12,110,18,210),(136,12,111,18,211),(137,12,111,18,212),(138,12,112,18,213),(139,12,112,18,214),(140,12,103,22,199),(141,12,104,22,200),(142,12,105,22,201),(143,12,105,22,202),(144,12,106,22,203),(145,12,106,22,204),(146,12,103,26,199),(147,12,104,26,200),(148,12,105,26,201),(149,12,105,26,202),(150,12,106,26,203),(151,12,106,26,204),(152,12,103,27,199),(153,12,104,27,200),(154,12,105,27,201),(155,12,105,27,202),(156,12,105,27,215),(157,12,106,27,203),(158,12,106,27,204),(159,12,107,28,205),(160,12,108,28,206),(161,12,108,28,207),(162,12,109,28,208),(163,12,110,28,209),(164,12,110,28,210),(165,12,111,28,211),(166,12,111,28,212),(167,12,112,28,213),(168,12,112,28,214),(169,12,107,29,205),(170,12,108,29,206),(171,12,108,29,207),(172,12,109,29,208),(173,12,110,29,209),(174,12,110,29,210),(175,12,111,29,211),(176,12,111,29,212),(177,12,112,29,213),(178,12,112,29,214),(179,12,103,30,199),(180,12,104,30,200),(181,12,105,30,201),(182,12,105,30,202),(183,12,106,30,203),(184,12,106,30,204),(185,12,107,34,205),(186,12,108,34,206),(187,12,108,34,207),(188,12,109,34,208),(189,12,110,34,209),(190,12,110,34,210),(191,12,111,34,211),(192,12,111,34,212),(193,12,112,34,213),(194,12,112,34,214),(195,12,103,35,199),(196,12,104,35,200),(197,12,105,35,201),(198,12,105,35,202),(199,12,106,35,203),(200,12,106,35,204),(201,12,103,38,199),(202,12,104,38,200),(203,12,105,38,201),(204,12,105,38,202),(205,12,106,38,203),(206,12,106,38,204),(207,12,103,40,199),(208,12,104,40,200),(209,12,105,40,201),(210,12,105,40,202),(211,12,105,40,215),(212,12,106,40,203),(213,12,106,40,204),(214,12,103,43,199),(215,12,104,43,200),(216,12,105,43,201),(217,12,105,43,202),(218,12,105,43,215),(219,12,106,43,203),(220,12,106,43,204),(221,13,122,46,216),(222,13,122,46,217),(223,13,122,46,218),(224,13,122,46,219),(225,13,122,47,218),(226,13,122,46,220),(227,13,122,46,221),(228,13,122,47,216),(229,13,122,47,222),(230,13,122,47,223),(231,14,124,48,224),(232,14,124,48,225),(233,14,124,48,226),(234,14,124,48,227),(235,12,103,51,228),(236,12,103,50,228),(237,12,103,17,228),(238,12,103,18,228),(239,12,103,55,229),(240,12,103,55,228),(241,12,103,55,230),(242,12,103,56,228),(243,12,103,57,229),(244,12,103,57,228),(245,12,103,58,228),(246,12,103,59,229),(247,12,103,59,228),(248,12,103,59,230),(249,12,103,60,229),(250,12,103,60,228),(251,16,128,62,231),(252,16,128,62,232),(253,16,128,61,233),(254,16,128,61,234),(255,16,128,63,231),(256,16,128,63,232),(257,15,NULL,53,235),(258,15,NULL,53,236),(259,15,NULL,53,237),(260,16,128,65,231),(261,16,128,65,232),(262,16,128,65,238);
/*!40000 ALTER TABLE `user_election` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voter_list`
--

DROP TABLE IF EXISTS `voter_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voter_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `organizationid` int(11) NOT NULL,
  `polling_station_id` int(11) NOT NULL,
  `voter_name` varchar(90) NOT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `companion_name` varchar(90) NOT NULL,
  `companion_address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voter_list`
--

LOCK TABLES `voter_list` WRITE;
/*!40000 ALTER TABLE `voter_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `voter_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'psm'
--
/*!50003 DROP FUNCTION IF EXISTS `isclose` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `isclose`(stationid int) RETURNS int(11)
BEGIN
DECLARE electioncount int;
DECLARE closed int;
DECLARE resp int;

select count(*) into electioncount from psm.polling_station_election pse 
inner join psm.election el on el.id=pse.election_id 
where pse.polling_station_id=stationid and date(el.election_date_start)=current_date();

select (sum(pse.isopen=0)+sum(pse.isclose)) into closed from psm.polling_station_election pse 
inner join psm.election el on el.id=pse.election_id 
where pse.polling_station_id=stationid and date(el.election_date_start)=current_date();


 IF electioncount = closed THEN SET resp = 1;
    ELSE SET resp = 0;
    END IF;

RETURN resp;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `isopen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `isopen`(stationid int) RETURNS int(11)
BEGIN
DECLARE opened int;
DECLARE resp int;

select sum(pse.isopen)-sum(pse.isclose) into opened from psm.polling_station_election pse 
inner join psm.election el on el.id=pse.election_id 
where pse.polling_station_id=stationid and date(el.election_date_start)=current_date();


 IF opened>0 THEN SET resp = 1;
    ELSE SET resp = 0;
    END IF;

RETURN resp;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assignissue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `assignissue`(in token varchar(255),in issueid int,in userid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    set spcode='assignissue';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        #delete previous assignments
        delete from psm.issue_assignment where issue_id=issueid and organization_id=orgid;
        insert into psm.issue_assignment (organization_id,issue_id,user_id)
        values (orgid,issueid,userid);
        select 'success' as response;
	else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `chatresolveissue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `chatresolveissue`(in token varchar(255),in issueid int,in issuestatus int,in description varchar(2000))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    #declare userid int;
    set spcode='resolveissue';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        #select id into userid from security.user where organization_id=orgid and username=username;
        
		update psm.issue set status=issuestatus,resolution_desc=description,resolvedon=current_timestamp where id=issueid and organization_id=orgid;
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `closeelection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `closeelection`(in token varchar(255),in electionid int,in stationid int,in electionstatus int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
         
			
			if(select exists 
				(					
					SELECT * from psm.election el inner join
        polling_station_election pse on pse.election_id=el.id where pse.organization_id = orgid
        and pse.election_id = electionid and pse.polling_station_id = stationid
                    ) 
            ) then
				update psm.election el inner join polling_station_election pse on pse.election_id=el.id 
                set pse.election_status = electionstatus
                where pse.organization_id = orgid 
                and pse.organization_id=orgid and pse.election_id=electionid and pse.polling_station_id=stationid;
				
				select 'success' as response;
			else
				select 'success' as response;
            end if;
	else
		select 'unauthorized' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `closepollingstation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `closepollingstation`(in token varchar(255),in pollingstationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='closepollingstation';
    
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
		/** check whether the station is opned first **/
        if(select exists(
						select * from psm.polling_station_election pse 
						inner join election e on pse.election_id = e.id 
                        where pse.organization_id=orgid 
                        and pse.polling_station_id=pollingstationid 
                        and date(e.election_date_start)=date(current_date)
                        and pse.isopen=1 )) then
                        
							update psm.polling_station_election pse 
							inner join election e on pse.election_id = e.id 
							set pse.isclose=1, pse.closedat=CURRENT_TIMESTAMP 
							where pse.organization_id=orgid and pse.polling_station_id=pollingstationid 
							and date(e.election_date_start)=date(current_date) and pse.isopen=1;
            
            select 'success' as response;
        else
			select 'Station not opened' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `closetrack` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `closetrack`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
    
		update psm.tracking as t
		inner join psm.user_election ue on t.election_id = ue.election_id and t.pollingstationid = ue.pollingstation_id and ue.organization_id = t.organization_id 
		inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
        inner join election e on ue.election_id = e.id
		set status=2,deliver_time=CURRENT_TIMESTAMP
		where u.organization_id = orgid and u.username= username and date(e.election_date_start)=date(current_date) and u.is_deleted=0;
                 
        select "success" as response;
    else
		select "unauthorized" as response;
    end if;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `collectpostalpacks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `collectpostalpacks`(in token varchar(255),in stationdid int,in electionid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
		update psm.election_stats set postalpack_collected=postalpack where organization_id=orgid
        and electionid=electionid and polling_station_id=stationdid;
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createchat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `createchat`(token varchar(255), issueid int, pollingstationid int, chatmessage text, attachtment_url varchar(500) )
BEGIN
	declare spcode varchar(45);
    declare usernamechat varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set usernamechat=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'createchat';
    select id into organizationid from subscription.organization where code = orgcode;
    select id into userid from security.user where username = usernamechat;
    
    if (security.fn_validate_token(token)=1) then
		insert into chat(userid, issueid, organizationid, pollingstationid, chatmessage, attachtment_url)
		values(userid, issueid, organizationid, pollingstationid, chatmessage, attachtment_url);
		select 'success' as response;
        
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createelection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `createelection`(in token varchar(255),
in ename varchar(255), in election_date varchar(55),
in start_time varchar(55), in end_time varchar(55), in counting_center_name varchar(45),
in counting_center_address varchar(100), in counting_center_latitude varchar(45),
in counting_center_longitude varchar(45), in BPA_identifier int)
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare added_election_id int(11);
    declare current_time_short varchar(10);
    declare current_time_short_modified varchar(10);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    select LEFT(CURTIME() , 5) into current_time_short;
    select REPLACE(current_time_short, ':', '.') into current_time_short_modified;
    
    if(UNIX_TIMESTAMP(election_date) > UNIX_TIMESTAMP(CURDATE())) then
    
		if (security.fn_validate_token(token)=1) then
		
			if(select exists 
					(					
						select * FROM psm.election where election_name=ename and DATE(election_date_start) = election_date
						) 
				) then
				select 'dataduplicate' as response;
			else
				#insert to psm.election
				insert into psm.election (organization_id,election_name,election_date_start,election_date_end,status,BPA_identifier) 
				values (orgid,ename,CONCAT(election_date,' ',start_time),CONCAT(election_date,' ',end_time),0,BPA_identifier);
				
				set added_election_id = (SELECT id FROM psm.election ORDER BY id DESC LIMIT 1);
				#insert to psm.counting_center
				insert into psm.counting_center (name,organization_id,election_id,latitude,longitude,address) 
				values (counting_center_name,orgid,added_election_id,counting_center_latitude,counting_center_longitude,counting_center_address);
				
				select 'success' as response;
				#select current_time_short_modified as response;
			end if;
		else
			select 'unauthorized' as response;
		end if;
	elseif(UNIX_TIMESTAMP(election_date) = UNIX_TIMESTAMP(CURDATE())) then
    
		#if(UNIX_TIMESTAMP(start_time) >= UNIX_TIMESTAMP(CURTIME())) then
        if(start_time >= current_time_short_modified) then
        
			if (security.fn_validate_token(token)=1) then
			
				if(select exists 
						(					
							select * FROM psm.election where election_name=ename and DATE(election_date_start) = election_date
							) 
					) then
					select 'dataduplicate' as response;
				else
					#insert to psm.election
					insert into psm.election (organization_id,election_name,election_date_start,election_date_end,status,BPA_identifier) 
					values (orgid,ename,CONCAT(election_date,' ',start_time),CONCAT(election_date,' ',end_time),0,BPA_identifier);
					
					set added_election_id = (SELECT id FROM psm.election ORDER BY id DESC LIMIT 1);
					#insert to psm.counting_center
					insert into psm.counting_center (name,organization_id,election_id,latitude,longitude,address) 
					values (counting_center_name,orgid,added_election_id,counting_center_latitude,counting_center_longitude,counting_center_address);
					
					select 'success' as response;
                    #select current_time_short_modified as response;
				end if;
			else
				select 'unauthorized' as response;
			end if;
		else
			select 'notcurrenttime' as response;
		end if;
	else
		select 'notcurrentdate' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createnotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `createnotification`(in token varchar(255),in pollingstationid int,in description varchar(2000) ,in filepath varchar(255) )
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    declare notificationid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code = orgcode;
    set userid=(select id as userid from security.user where username = username and is_deleted = 0);

    if (security.fn_validate_token(token)=1) then
    
		insert into psm.notification(organization_id,station_id,message,attachtment_url,createdon)
				values(orgid,pollingstationid,description,filepath,CURRENT_TIMESTAMP);
        
		insert into psm.notification_status(organization_id,notificationid,userid,status,isprivate) 
				values(orgid,notificationid,userid,0,1);
				select 'success' as response;
                
	else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createvoter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `createvoter`(in token varchar(255), in polling_station_id int, in voter_name varchar(90), in phone_number varchar(45), in companion_name varchar(90), in companion_address  varchar(100))
BEGIN
	declare spcode varchar(45);
    declare usernamevoter varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set usernamevoter=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'createvoter';
    select id into organizationid from subscription.organization where code = orgcode;
    select id into userid from security.user where username = usernamevoter and is_deleted = 0;
    
    if (security.fn_validate_token(token)=1) then
		insert into voter_list(userid, organizationid, polling_station_id, voter_name, phone_number, companion_name, companion_address)
		values(userid, organizationid, polling_station_id, voter_name, phone_number, companion_name, companion_address);
		select 'success' as response;
        
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_index_if_not_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `create_index_if_not_exists`(schema_name varchar(50), table_name_vc varchar(50), index_name_vc varchar(50), field_list_vc varchar(200))
BEGIN
set @Index_cnt = (
select	count(1) cnt
FROM	INFORMATION_SCHEMA.STATISTICS
WHERE	table_name = table_name_vc
and	index_name = index_name_vc
);

IF ifnull(@Index_cnt,0) = 0 THEN set @index_sql = concat('Alter table ',schema_name,'.',table_name_vc,' ADD INDEX ',index_name_vc,'(',field_list_vc,');');

PREPARE stmt FROM @index_sql;
EXECUTE stmt;

DEALLOCATE PREPARE stmt;

END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `csvballotstartupdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `csvballotstartupdate`(in token varchar(255),
in ename varchar(255), in stationname varchar(255),
in bstartnumber int, in bendnumber int,
in tstartnumber int, in tendnumber int)
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
    declare eid int(11);
    declare stationid int(11);
    declare ballottypecount int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    
    if(select not exists (select * from psm.election 
			where election_name=ename and DATE(election_date_start)>current_date()-1 and organization_id=orgid) 
		)then
			select 'errorename' as response;
    elseif(select not exists (select * from psm.polling_station 
			where name=stationname and organization_id=orgid) 
		)then    
			select 'errorstationname' as response;
    else         
		select id into eid from psm.election 
			where election_name=ename and DATE(election_date_start)>current_date()-1 and organization_id=orgid;
		select id into stationid from psm.polling_station 
			where name=stationname and organization_id=orgid;
		select ballot_type_count into ballottypecount from psm.election
			where id=eid;
	 
		if(ballottypecount>1) then		
			UPDATE psm.polling_station_election SET ballotstart=bstartnumber, ballotend=bendnumber, 
				tenderstart=tstartnumber, tenderend=tendnumber, ballot2start=bstartnumber, ballot2end=bendnumber, 
				tender2start=tstartnumber, tender2end=tendnumber
				WHERE organization_id=orgid and election_id=eid and polling_station_id=stationid;
		else
			UPDATE psm.polling_station_election SET ballotstart=bstartnumber, ballotend=bendnumber, 
				tenderstart=tstartnumber, tenderend=tendnumber
				WHERE organization_id=orgid and election_id=eid and polling_station_id=stationid;
		end if;  
		select 'success' as response;        
	end if; 
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `csvelection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `csvelection`(in orgid int(11),in electionid int(11),in ballotboxnumber int(55),
in pollstationid int(11),in user_name varchar(255),in first_name varchar(255),
in last_name varchar(255), in passwords varchar(255))
BEGIN

    declare userid int(11);
    
    insert into psm.polling_station_election (organization_id,election_id,isopen,isclose,
            ballot_box_number,election_status,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,pollstationid;
    /*insert into psm.polling_station_election (organization_id,election_id,isopen,isclose,
            ballot_box_number,election_status,ballotend,ballotstart,tenderend,tenderstart,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,2,1,2,1,pollstationid;*/        

            if(select not exists (SELECT * FROM security.user u where u.organization_id=orgid and u.username=user_name and u.is_deleted = 0) 
			)then
				insert into security.user (organization_id,firstname,lastname,username,passwordhash,locale,language_id,createdon) 
				select orgid,first_name,last_name,user_name,sha1(CONCAT('S@l+VaL',passwords)),'en-GB',1,current_timestamp;
			end if; 
            
			select us.id into userid from security.user us where us.organization_id=orgid and us.username=user_name; 
            
            insert into psm.user_election (organization_id,election_id,user_id,pollingstation_id)
			select orgid,electionid,userid,pollstationid;   
            
            insert into security.user_role (organization_id,user_id,role_id) 
			select orgid,userid,ro.id FROM security.role ro 
			where ro.name='Presiding Officer' and ro.organization_id=orgid;
            
            insert into psm.polling_station_election_counting (organization_id,
            polling_station_id,election_id,counting_center_id)
			select orgid,pollstationid,electionid,id from psm.counting_center cc 
            where cc.organization_id=orgid and cc.election_id=electionid;
            
            insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
			,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
			select  pollstationid,orgid,electionid,0,0,0,0,0,0 from psm.polling_station_election 
			where election_id=electionid and organization_id=orgid;
						
            select 'success' as response;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `csvelection_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `csvelection_v2`(in orgid int(11),in electionid int(11),
in ballotboxnumber int(55),in pollstationid int(11),
in bstartnumber int, in bendnumber int,
in tstartnumber int, in tendnumber int)
BEGIN

    declare ballottypecount int(11);
    select ballot_type_count into ballottypecount from psm.election
		where id=electionid;
        
	if(ballottypecount>1) then		
        insert into psm.polling_station_election (organization_id,election_id,isopen,isclose,
            ballot_box_number,election_status,ballotend,ballotstart,tenderend,tenderstart,
            ballot2end,ballot2start,tender2end,tender2start,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,bendnumber,bstartnumber,tendnumber,tstartnumber,
            bendnumber,bstartnumber,tendnumber,tstartnumber,pollstationid;
    else
		insert into psm.polling_station_election (organization_id,election_id,isopen,isclose,
            ballot_box_number,election_status,ballotend,ballotstart,tenderend,tenderstart,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,bendnumber,bstartnumber,tendnumber,tstartnumber,pollstationid;
    end if; 
    
    insert into psm.user_election (organization_id,election_id,pollingstation_id)
			select orgid,electionid,pollstationid;   
            
	insert into psm.polling_station_election_counting (organization_id,
            polling_station_id,election_id,counting_center_id)
			select orgid,pollstationid,electionid,id from psm.counting_center cc 
            where cc.organization_id=orgid and cc.election_id=electionid;
    
	insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
			,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
			values  (pollstationid,orgid,electionid,0,0,0,0,0,0);
						
            select 'success' as response;
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `csvhierarchyandpollingstations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `csvhierarchyandpollingstations`(in token varchar(255),
in address varchar(255), in district varchar(255),
in constituency varchar(255), in stationname varchar(255),
in ward varchar(255), in place varchar(255), in electionid varchar(11),in ballotboxnumber varchar(55),
in first_name varchar(255), in last_name varchar(255),in user_name varchar(255),in passwords varchar(255))
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    declare pollstationid int(11);
    declare st_elec_id int(11);
    declare st_ward_id int(11);
    declare st_dist_id int(11);
    declare st_plac_id int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    select id into st_elec_id FROM psm.hierarchy where organization_id=orgid and name='Electorate';
    select id into st_ward_id FROM psm.hierarchy where organization_id=orgid and name='Ward';
	select id into st_dist_id FROM psm.hierarchy where organization_id=orgid and name='District';
    select id into st_plac_id FROM psm.hierarchy where organization_id=orgid and name='Place';
    
    if (security.fn_validate_token(token)=1) then
    
		if(select not exists (select * FROM psm.hierarchy_value hv 
              where hv.hierarchy_id=st_elec_id and hv.organization_id=orgid and hv.value=constituency and hv.hierarchy_id=st_elec_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon) 
			values (orgid,st_elec_id,constituency,current_timestamp);
		end if;
        
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_ward_id and hv.organization_id=orgid and hv.value=ward and hv.hierarchy_id=st_ward_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_ward_id,ward,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=constituency;
		end if;  
        
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_dist_id and hv.organization_id=orgid and hv.value=district and hv.hierarchy_id=st_dist_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_dist_id,district,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=ward;
		end if;  
        
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_plac_id and hv.organization_id=orgid and hv.value=place and hv.hierarchy_id=st_plac_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_plac_id,place,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=district;
		end if; 
        
        
        if(select not exists (SELECT * FROM psm.polling_station
				where organization_id=orgid and name=stationname) 
		)then
			insert into psm.polling_station (organization_id,name,address,createdon,hierarchy_value_id) 
			select orgid,stationname,address,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=place and hierarchy_id=st_plac_id;
            
            select LAST_INSERT_ID() into pollstationid; 
            call psm.csvelection(orgid,electionid,ballotboxnumber,pollstationid,user_name,first_name,last_name,passwords);
            
        ELSEIF(select not exists (SELECT * FROM psm.polling_station_election pse 
				inner join psm.polling_station ps on ps.id=pse.polling_station_id
				where pse.organization_id=orgid and pse.election_id=electionid and ps.organization_id=orgid 
                and ps.name=stationname) 
		)then
			select id into pollstationid from psm.polling_station where organization_id=orgid 
			and name=stationname; 
            call psm.csvelection(orgid,electionid,ballotboxnumber,pollstationid,user_name,first_name,last_name,passwords);
            
        else
			select 'duplicatedata' as response;
		end if; 
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `csvsavereport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `csvsavereport`(in token varchar(255),
in path varchar(255),
in eid int(11),in filestatus int(3))
BEGIN
	declare orgcode varchar(45);
	declare orgid int(11);
	set orgcode=security.SPLIT_STR(token,'|',2);

	select id into orgid from subscription.organization where code=orgcode;
    
    if(select not exists (select * FROM psm.csv_upload 
				where organization_id=orgid and election_id=eid) 
		)then
			insert into psm.csv_upload(organization_id,election_id,report_path,status) 
			values (orgid,eid,path,filestatus);
    else
		UPDATE psm.csv_upload SET report_path=path,status=filestatus
			WHERE organization_id=orgid and election_id=eid;
    
	end if; 
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `csvsecondstructure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `csvsecondstructure`(in token varchar(255),
in ward varchar(255), in district varchar(255),
in place varchar(255), in stationname varchar(255),
in ballotstartnumber int(11), in ballotendnumber int(11), in ballotboxnumber varchar(55),
in tenderstartnumber int(11), in tenderendnumber int(11),in eid int(11))
BEGIN
	declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    declare pollstationid int(11);
    declare st_elec_id int(11);
    declare st_elec_value_id int(11);
    declare st_ward_id int(11);
    declare st_dist_id int(11);
    declare st_plac_id int(11);

	set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    select id into st_elec_id FROM psm.hierarchy where organization_id=orgid and name='Electorate';
    select id into st_ward_id FROM psm.hierarchy where organization_id=orgid and name='Ward';
	select id into st_dist_id FROM psm.hierarchy where organization_id=orgid and name='District';
    select id into st_plac_id FROM psm.hierarchy where organization_id=orgid and name='Place';
    select id into st_elec_value_id from psm.hierarchy_value where hierarchy_id=st_elec_id and organization_id=orgid;

	if (security.fn_validate_token(token)=1) then
		/* inserting ward value */
		if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_ward_id and hv.organization_id=orgid and hv.value=ward and hv.hierarchy_id=st_ward_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			values (orgid,st_ward_id,ward,current_timestamp,st_elec_value_id);
		end if;
        
        /* inserting district value */
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_dist_id and hv.organization_id=orgid and hv.value=district and hv.hierarchy_id=st_dist_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_dist_id,district,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=ward;
		end if;  
        
        /* inserting place value */
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_plac_id and hv.organization_id=orgid and hv.value=place and hv.hierarchy_id=st_plac_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_plac_id,place,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=district;
		end if;
        
        
        
        /* inserting unique Station value */
        if(select not exists (SELECT * FROM psm.polling_station
				where organization_id=orgid and name=stationname) 
		)then
			insert into psm.polling_station (organization_id,name,createdon,hierarchy_value_id) 
			select orgid,stationname,current_timestamp,hv.id from psm.hierarchy_value hv
			where hv.organization_id=orgid and hv.value=place and hv.hierarchy_id=st_plac_id;
            
            select LAST_INSERT_ID() into pollstationid; 
           call psm.csvelection_v2(orgid,eid,ballotboxnumber,pollstationid,ballotstartnumber,ballotendnumber,tenderstartnumber,tenderendnumber);
        ELSEIF(select not exists (SELECT * FROM psm.polling_station_election pse 
				inner join psm.polling_station ps on ps.id=pse.polling_station_id
				where pse.organization_id=orgid and pse.election_id=eid and ps.organization_id=orgid 
                and ps.name=stationname) 
		)then
			select id into pollstationid from psm.polling_station where organization_id=orgid 
			and name=stationname; 
           call psm.csvelection_v2(orgid,eid,ballotboxnumber,pollstationid,ballotstartnumber,ballotendnumber,tenderstartnumber,tenderendnumber);
        else
			select 'duplicatedata' as response;
		end if;
        
    else
		select 'unauthorized' as response;
    end if;    
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `csvsecondstructure_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `csvsecondstructure_v2`(in token varchar(255),
in place varchar(255),
in stationname varchar(255),in role varchar(255),
in first_name varchar(255), in last_name varchar(255),
in user_name varchar(255), in passwords varchar(255))
BEGIN
	declare orgcode varchar(45);
	declare orgid int(11);
	declare userid int(11);
    declare pollstationid int(11);
	
	set orgcode=security.SPLIT_STR(token,'|',2);

	select id into orgid from subscription.organization where code=orgcode;
	select id into pollstationid from psm.polling_station where organization_id=orgid 
			and name=stationname; 
	
	if(select not exists (SELECT * FROM security.user u where u.organization_id=orgid and u.username=user_name and u.is_deleted = 0) 
		)then
			insert into security.user (organization_id,firstname,lastname,username,passwordhash,locale,language_id,createdon) 
			select orgid,first_name,last_name,user_name,sha1(CONCAT('S@l+VaL',passwords)),'en-GB',1,current_timestamp;
            
            select 'success' as response;
     else select 'duplicatedata' as response;       
	end if; 
    
	select us.id into userid from security.user us where us.organization_id=orgid and us.username=user_name and us.is_deleted = 0; 
				
	UPDATE psm.user_election SET user_id=userid
			WHERE organization_id=orgid and polling_station_id=pollstationid;
	
	insert into security.user_role (organization_id,user_id,role_id) 
			select orgid,userid,ro.id FROM security.role ro 
			where ro.name='Presiding Officer' and ro.organization_id=orgid;	
			
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteelection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deleteelection`(in token varchar(255), in eid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'deleteelection';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		/*#delete from child tables
        
        #psm.compliance_election
		delete from psm.compliance_election where election_id=eid and organization_id=organizationid;
        
        #psm.election_close_stats
        delete from psm.election_close_stats where election_id=eid and organization_id=organizationid;
        
        #psm.election_stats
        delete from psm.election_stats where electionid=eid and organization_id=organizationid;
        
        #psm.issue
        delete from psm.issue where electionid=eid and organization_id=organizationid;
        
        #psm.open_close_election
        delete from psm.open_close_election where election_id=eid and organization_id=organizationid;        
        
        #psm.polling_station_election_counting
        delete from psm.polling_station_election_counting where election_id=eid and organization_id=organizationid;
        
        #psm.station_photo
        delete from psm.station_photo where election_id=eid and organization_id=organizationid;
        
        #psm.tracking
        delete from psm.tracking where election_id=eid and organization_id=organizationid;
        
        #psm.counting_center
        delete from psm.counting_center where election_id=eid and organization_id=organizationid;
        
        #psm.user_election
        delete from psm.user_election where election_id=eid and organization_id=organizationid;
        
        #psm.polling_station_election
        delete from psm.polling_station_election where election_id=eid and organization_id=organizationid;
        
        #delete from parent table election
        delete from psm.election where id=eid and organization_id=organizationid;*/
        
        update psm.election election set election.is_deleted=1 where election.id=eid; 
        
        select 'success' as response;
		
    else
		select 'unauthorized' response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletevoter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deletevoter`(in token varchar(255), in voter_list_id int)
BEGIN
	declare spcode varchar(45);
    declare usernamevoter varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set usernamevoter=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'deletevoter';
    select id into organizationid from subscription.organization where code = orgcode;
    select id into userid from security.user where username = usernamevoter;
    
    if (security.fn_validate_token(token)=1) then
		delete from voter_list where voter_list.id=voter_list_id;
        select 'success' as response;
        
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generatebpa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `generatebpa`(in token varchar(255),in stationid int,in electionid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare tot_ballots int;
    declare tot_spolied_issued int;
    declare tot_unused int;
    declare tot_tend_ballots int;
    declare tot_tend_spoiled int;
    declare tot_tend_unused int;
    declare start_count int;
    declare end_count int;
    declare tend_start_count int;
    declare tend_end_count int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    select ballotstart,ballotend,tenderstart,tenderend 
    into start_count,end_count,tend_start_count,tend_end_count
    from psm.polling_station_election where organization_id=orgid and polling_station_id=stationid and election_id=electionid;
    if (security.fn_validate_token(token)=1 ) then
		select ifnull(sum(ballotpaper),0),
        ifnull(sum(spoilt_ballot),0),
        end_count-start_count -ifnull(sum(ballotpaper),0),
        ifnull(sum(ten_ballot_papers),0),
        ifnull(sum(ten_spoilt_ballots),0),
        tend_end_count - tend_start_count - ifnull(sum(ten_ballot_papers),0) into
        tot_ballots,tot_spolied_issued,tot_unused,tot_tend_ballots,tot_tend_spoiled,tot_tend_unused
        
        from psm.election_stats es
        inner join psm.election el on el.id=es.electionid
        where es.organization_id=orgid and el.organization_id=orgid and
        es.polling_station_id=stationid and es.electionid=electionid;
        
        #delete the close stats first
        delete from psm.election_close_stats where organization_id=orgid and
        election_id=electionid and polling_station_id=stationid;
        
        #insert the new close stats
        insert into psm.election_close_stats (
        organization_id,
        election_id,
        tot_ballots,
        tot_spolied_issued,
        tot_unused,
        tot_tend_ballots,
        tot_tend_spoiled,
        tot_tend_unused,
        updatedon,
        polling_station_id) values
        
        (orgid,
        electionid,
        tot_ballots,
        tot_spolied_issued,
        tot_unused,
        tot_tend_ballots,
        tot_tend_spoiled,
        tot_tend_unused,
        current_timestamp,
        stationid);
        
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallclosestats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallclosestats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getallclosestats';
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
    
		select ecs.tot_ballots,ecs.tot_spolied_issued as tot_spoiled_replaced,ecs.tot_unused,ecs.tot_tend_ballots,
        ecs.tot_tend_spoiled,ecs.tot_tend_unused,el.election_name as electionname,ps.name as pollingstation, el.Id as electionid,'ok' as response from 
        
        psm.election_close_stats ecs
        inner join psm.election el on el.id=election_id
        inner join psm.polling_station ps on ps.id=polling_station_id
        
		where ecs.organization_id=orgid and
        UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) ; 
    else
		select null as tot_ballots,null as tot_spoiled_replaced,null as tot_unused,null as tot_tend_ballots,null as tot_tend_spoiled,
        null as tot_tend_unused,null as electionname,null as pollingstation, null as electionid,'unauthorized' as response; 
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallclosestatssummary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallclosestatssummary`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getallclosestatssummary';
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
    
		select sum(ecs.tot_ballots) as sum_tot_ballots,sum(ecs.tot_spolied_issued) as sum_tot_spoiled_replaced,sum(ecs.tot_unused) as sum_tot_unused,sum(ecs.tot_tend_ballots) as sum_tot_tend_ballots,
        sum(ecs.tot_tend_spoiled) as sum_tot_tend_spoiled,sum(ecs.tot_tend_unused) as sum_tot_tend_unused, ecs.election_id as electionid,'ok' as response from 
        
        psm.election_close_stats ecs
        
        
		where ecs.organization_id=orgid and
        UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) 
        group by ecs.election_id; 
    else
		select null as sum_tot_ballots,null as sum_tot_spoiled_replaced,null as sum_tot_unused,null as sum_tot_tend_ballots,null as sum_tot_tend_spoiled,
        null as sum_tot_tend_unused, null as electionid,'unauthorized' as response; 
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallissues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallissues`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select isu.id as id,lst.list_value as reason,isu.description as description,isu.priority  as priority,ps.name as pollingstation,ps.id as pollingstationid,
        ps.hierarchy_value_id as pollingstationhierarchyid,isu.status as issuestatus,concat(usr.firstname,' ',usr.lastname) as asignee,usr.id as userid,isu.createdon as issuedate,'success' as response from psm.issue isu
		inner join psm.list lst on lst.id=isu.issue_list_id
		inner join psm.polling_station ps on isu.pollingstation_id=ps.id
		left outer join psm.issue_assignment ism on isu.id=ism.issue_id
		left outer join security.user usr on ism.user_id=usr.id
        where  UNIX_TIMESTAMP(isu.createdon) > UNIX_TIMESTAMP(CURDATE())  and 
        isu.organization_id=orgid and lst.organization_id=orgid and ps.organization_id=orgid order by isu.createdon desc;
    else
		select null as id,null as reason,null  as description,null as priority,null as  pollingstation,null as pollingstationid,null as pollingstationhierarchyid,null as  issuestatus,null  as asignee,null as userid,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallnotifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallnotifications`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set spcode='getnewnotifications';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		/** check for new notifications **/
        select nt.id as notification_id,nt.message as message,nt.attachtment_url as att_url,nt.createdon as generatedon,
        ns.isprivate as isprivate,ns.status,'ok' as response 
        from psm.notification nt inner join 
			psm.notification_status ns on ns.notificationid=nt.id
			inner join subscription.organization org on
			nt.organization_id=org.id
			inner join security.user usr on
			ns.userid=usr.id
			where org.code=orgcode and usr.username=username and date(nt.createdon)=date(current_date) order by nt.createdon desc ;
    else
		select null as notification_id,null as message,null as att_url,null as generatedon,null as isprivate,
        'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallusers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallusers`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    if (security.fn_validate_token(token)=1) then
		select firstname,lastname,username,'success' as response from security.user;
    else
		select null firstname,null lastname,null username,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getballotissuegraphstats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getballotissuegraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select el.election_name as electionname,HOUR(est.updatedon) as issuehour, 
        sum(ballotpaper) as ballotpaperissued,"success" as response from psm.election_stats  est		
		inner join psm.election el on el.id=est.electionid
		where date(el.election_date_start)=date(current_date) and est.organization_id=orgid and el.organization_id=orgid 
		group by el.id, el.election_name, HOUR(est.updatedon);
    else
		select null as electionname,null as issuehour,null as ballotpaperissued,"unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getbpastatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getbpastatus`(in token varchar(255),in stationid int,in electionid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
		if(select exists(select * from psm.election_close_stats where organization_id=orgid and election_id=electionid and polling_station_id=stationid )) then
			select 1 as status,'success' as response;
        else
			select 0 as status,'success' as response;
        end if;
    else
		select null as status,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getbpastatusbystation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getbpastatusbystation`(in token varchar(255), in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare varelid int(11);
    DECLARE done INT DEFAULT FALSE;
    declare bpastatus int(11);
    
    declare cur cursor  for
    select el.id from psm.polling_station_election pse
        inner join psm.election el on el.id=pse.election_id
        where pse.polling_station_id=stationid and pse.organization_id=orgid and
        el.organization_id=orgid and date(election_date_start)=date(current_date);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;    
    
    
    set bpastatus=1;    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);

    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1) then
		open cur;
        read_loop: LOOP
			FETCH cur INTO varelid;
			IF done THEN
				LEAVE read_loop;
			END IF;
			# check the bpa status
            if(select not exists(select * from psm.election_close_stats where organization_id=orgid and election_id=varelid and polling_station_id=stationid)) then
				set bpastatus=0;  
            end if;
		END LOOP;
		CLOSE cur;
        select bpastatus as status,'success' as response;
    else
		select null as status,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getchat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getchat`(token varchar(255), issueid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare userfirstname varchar(45);
    declare userlastname varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'chat';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select isu.id as issueid, ps.id as pollingstationid, concat(usr.firstname,' ',usr.lastname) as userfullname ,
        usr.id as userid, chat.chatid as chatid, chat.chatmessage as chatmessage, chat.attachtment_url as attachtment_url, 
        usr.profile_picture as profile_picture, isu.status as issuestatus,
        chat.createdon as createdon, usr.organization_id as organizationid,
        'success' as response 
        from psm.issue isu
		inner join psm.polling_station ps on isu.pollingstation_id=ps.id
		left outer join psm.chat chat on isu.id=chat.issueid
        inner join security.user usr on chat.userid=usr.id
        where  UNIX_TIMESTAMP(chat.createdon) > UNIX_TIMESTAMP(CURDATE())  and
        chat.userid=usr.id and isu.id=issueid and usr.organization_id=organizationid order by chat.createdon desc;
    else
		select null chatid, null chatmessage, null attachtment_url, null createdon, null issueid, null pollingstationid, null userfullname, null userid, null organizationid, 'unauthorized' response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getchatcountalert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getchatcountalert`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare usernamechat varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    declare useridother int(11);
    
    set usernamechat=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    select id into useridother from security.user where username = usernamechat;
    
    if (security.fn_validate_token(token)=1) then
		/*select count(chat.chatid) as chatcount,
        "success" as response from psm.chat chat
		where  date(chat.createdon)=date(current_date)  and
		chat.organizationid=orgid and
        chat.userid<>useridother;*/
        
        select count(chat.chatid) as chatcount, (SELECT cc.issueid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 ) as issueid,
        "success" as response from psm.chat chat
		where  date(chat.createdon)=date(current_date)  and
		chat.organizationid=orgid and
        chat.userid<>useridother;
    else 
		select null as chatcount, null as issueid, "unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getclosestats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getclosestats`(in token varchar(255),in electionid int, in pollingstationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getclosestats';
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
    
		select tot_ballots,tot_spolied_issued as tot_spoiled_replaced,tot_unused,tot_tend_ballots,tot_tend_spoiled,tot_tend_unused,'ok' as response from 
        psm.election_close_stats
		where election_id=electionid and polling_station_id = pollingstationid and organization_id = orgid ; 
    else
		select null as tot_ballots,null as tot_spoiled_replaced,null as tot_unused,null as tot_tend_ballots,null as tot_tend_spoiled,null as tot_tend_unused,'unauthorized' as response; 
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getcsvstructureid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getcsvstructureid`(in token varchar(255))
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    select csvstructureid from subscription.organization where code=orgcode;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getelection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getelection`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelection';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select election.id as electionid, 
        election.organization_id as organization_id, 
        election.election_name as election_name,
        date(election.election_date_start) as election_date, 
        time(election.election_date_start) as election_start_time,
        time(election.election_date_end) as election_end_time,
        election.election_date_start as election_date_start, 
		election.election_date_end as election_date_end,
        election.status as status,
        counting_center.name as counting_center_name,
        counting_center.id as counting_center_id,
        counting_center.address as counting_center_address,
        election.ballotboxno as ballotboxno,
        election.is_deleted as is_deleted,
        'success' as response 
        from psm.election election
		inner join psm.counting_center counting_center on counting_center.election_id=election.id
        where  /*UNIX_TIMESTAMP(election.election_date_start) > UNIX_TIMESTAMP(CURDATE())  and*/
		election.organization_id=organizationid and
        election.is_deleted!=1 order by election.organization_id desc;
    else
		select null electionid, null organization_id, null election_name, null election_date_start, null election_date_end, null status, 
        null counting_center_name, null counting_center_id, null counting_center_address, null ballotboxno, 'unauthorized' response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getelectionbyid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getelectionbyid`(in token varchar(255), in election_Id int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelectionbyid';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select election.id as electionid, 
        election.organization_id as organization_id, 
        election.election_name as election_name,
        date(election.election_date_start) as election_date, 
        time(election.election_date_start) as election_start_time,
        time(election.election_date_end) as election_end_time,
        election.election_date_start as election_date_start, 
		election.election_date_end as election_date_end,
        election.status as status,
        election.ballotboxno as ballotboxno,
        counting_center.name as counting_center_name,
        counting_center.id as counting_center_id,
        counting_center.address as counting_center_address,
        election.BPA_identifier as BPA_identifier,
        CURDATE() as today_date,
        CURTIME() as today_time,
        'success' as response 
        from psm.election election
        inner join psm.counting_center counting_center on counting_center.election_id=election.id
        where 
        #UNIX_TIMESTAMP(election.election_date_start) > UNIX_TIMESTAMP(CURDATE()) and
        election.id = election_Id and
		election.organization_id=organizationid;
    else
		select null electionid, null organization_id, null election_name, null election_date_start, null election_date_end, null status, null ballotboxno, 'unauthorized' response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getelectionfileuploaddetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getelectionfileuploaddetails`(in token varchar(255), in eid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    declare polling_station_election_exist int(11);
    declare user_election_exist int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelectionfileuploaddetails';
    
    select id into organizationid from subscription.organization where code = orgcode;
    select count(id) into polling_station_election_exist from psm.polling_station_election polling_station_election where polling_station_election.election_id=eid;
    select count(id) into user_election_exist from psm.user_election user_election where user_election.election_id=eid;
    
    if (security.fn_validate_token(token)=1) then
		
        if ((polling_station_election_exist > 0) && (user_election_exist > 0)) then 
			select 'success' as response; 
        else
			select 'nodata' as response;
		end if;
    else
		select 'unauthorized' response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getelectionsbystationid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getelectionsbystationid`(in token varchar(255),in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set spcode='getelectionsbystationid';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select "success" as response,
        el.id as electionid,
        el.election_name as electionname,
        el.election_date_start as startdate,
        el.election_date_end as enddate,
        el.status as status,
        el.ballotboxno as ballotboxno,
        pse.isopen as isopened,
        pse.isclose as isclosed,
        pse.opentime as electionstarttime,
        pse.openedat as openedat,
        pse.closedat as closedat
        
        from psm.election el inner join
        psm.polling_station_election pse on pse.election_id=el.id
        inner join subscription.organization org on org.id=pse.organization_id
        where pse.polling_station_id=stationid and date(el.election_date_start)=date(current_date)
        and el.is_deleted = 0;
    else
		select "unauthorized" as response,
        null as electionid,
        null as electionname,
        null as startdate,
        null as enddate,
        null as status,
        null as ballotboxno,
        null as isopened,
        null as isclosed,
        null as electionstarttime,
        null as openedat,
        null as closedat;
    end if;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getelectionstatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getelectionstatus`(in token varchar(255),in electionid int,in stationid int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
         
			
			if(select exists 
				(					
					SELECT pse.election_status from polling_station_election pse where 
                    pse.election_id = electionid and pse.polling_station_id = stationid and 
                    pse.organization_id = orgid
                    ) 
            ) then
				select 'success' as response, pse.election_status as electionstatus, 
					(pse.ballotend - pse.ballotstart) as ballotturnout,
                    (pse.tenderend - pse.tenderstart) as tendturnout
					from polling_station_election pse where 
                    pse.election_id = electionid and pse.polling_station_id = stationid and 
                    pse.organization_id = orgid;
			else
				select 'no elections' as response, null as electionstatus, null as ballotturnout, null as tendturnout;
            end if;
	else
		select null as buttonshow,'unauthorized' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getelectiontimearray` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getelectiontimearray`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelectiontimearray';
    
  
    if (security.fn_validate_token(token)=1) then
    
			drop table if exists `hourlyresult`;
			create temporary table hourlyresult (id int,hourlytime varchar(55),ballotsissued int,spoiltballots int,postalpacks int,tenballotsissued int,tenspoiltballots int)engine=memory;
            
			SELECT (HOUR(election_date_start)) as starttimehour, (TIMESTAMPDIFF(HOUR,election_date_start,election_date_end)) 
			as difference, id as electionid,'success' as response from psm.election WHERE UNIX_TIMESTAMP(DATE(election_date_start)) = UNIX_TIMESTAMP(CURDATE());
	else
		select null as starttimehour,null as difference,null as electionid,'unauthorized' as response;
    end if;
    
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getelection_1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getelection_1`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelection';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
        select election.election_date_start as response from psm.election election;
   end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getfilereport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getfilereport`(in token varchar(255),in electionId int(11))
BEGIN
	declare orgcode varchar(45);
    declare orgid int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1) then	
		select report_path as reportpath, status as filestatus, 'success' as response 
			from psm.csv_upload where organization_id=orgid and election_id=electionId;
    else 
		select 'unauthorized' as response, null as reportpath, null as filestatus;
    end if;    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getglobalnotifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getglobalnotifications`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare readcount int;
    declare unreadcount int;
    declare cur_id int;
    declare cur_message varchar(10000);
    declare cur_attactmnent varchar(500);
    declare cur_senton timestamp;
    DECLARE done INT DEFAULT FALSE;
    
    declare cur cursor for
    select noti.id,noti.message,noti.attachtment_url, noti.createdon 
        from psm.notification noti
        where noti.organization_id=orgid and date(noti.createdon) = date(current_date);
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getglobalnotifications';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
        drop table if exists `notificationsresult`;
		create temporary table notificationsresult (id int,message varchar(10000),attachtment varchar(500),senton timestamp,status varchar(55),response varchar(55))engine=memory;
        
        open cur;
        read_loop: LOOP
			FETCH cur INTO cur_id,cur_message,cur_attactmnent,cur_senton;
			IF done THEN
				LEAVE read_loop;
			END IF;
			set readcount=(select count(id) from psm.notification_status where notificationid=cur_id and organization_id=orgid and status=1);
			set unreadcount=(select count(id) from psm.notification_status where notificationid=cur_id and organization_id=orgid and status=0);
            
            insert into notificationsresult (id,message,attachtment,senton,status,response) values
            (cur_id,cur_message,cur_attactmnent,cur_senton,concat(readcount,'/',readcount+unreadcount),'success');
		END LOOP;
		CLOSE cur;
        select * from notificationsresult;
        drop table notificationsresult;
    else
		select null as id,null as message,null as attachtment, null as senton,null as status,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getissuebyid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getissuebyid`(in token varchar(255),in issueid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    #declare userid int;
    set spcode='getissuebyid';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
		select 
        isu.pollingstation_id as stationid,
        ps.name as stationname,
        lst.list_value as issuetype,
        IFNULL(isu.description,'') as issuedescription,
        isu.priority as priority,
        IFNULL(isu.resolution_desc,'') as resolutiondescription,
        isu.status as issuestatus,
        concat(usr.firstname, ' ',usr.lastname) as assignedto,
        isa.user_id as userid,
        isa.assignon as assignedon,
        isu.createdon as createdon,
        isu.resolvedon as resolvedon,
        isu.reportedby as reportedby,
        'success' as response
        
        from psm.issue isu
        left outer join psm.issue_assignment isa on isu.id=isa.issue_id
        left outer join security.user usr on usr.id=isa.user_id
        inner join psm.polling_station ps on isu.pollingstation_id=ps.id
        inner join psm.list lst on isu.issue_list_id=lst.id
        where isu.id=issueid and isu.organization_id=orgid and ps.organization_id=orgid and lst.organization_id=orgid;
    else
		select 
        null as stationid,
        null stationname,
        null as issuetype,
        null as issuedescription,
        null as priority,
        null as resolutiondescription,
        null as issuestatus,
        null as assignedto,
        null as userid,
        null as assignedon,
        null as createdon,
        null as resolvedon,
        null as reportedby,
        'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getissuecategorygraphstats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getissuecategorygraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select lst.list_value as reason,COUNT(isu.id) AS issuecount,'success' as response from psm.issue isu
		inner join psm.list lst on lst.id=isu.issue_list_id
        where  date(isu.createdon) =date(current_date)  and 
        isu.organization_id=orgid and lst.organization_id=orgid 
        group by lst.list_value;
    else
		select null as reason,null as issuecount,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getissuecountgraphstats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getissuecountgraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select count(isu.id) as openissues,"success" as response from psm.issue isu
		where  date(isu.createdon) =date(current_date)  and
		isu.status=0 and  isu.organization_id=orgid;
    else 
		select null as openissues,"unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getissuelist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getissuelist`(token varchar(255))
BEGIN
	
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getissuelist';
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
			select l.id, l.list_value as issuetitle 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
			where lc.name = 'issue' and org.code = orgcode;
        
        else
			select null as id, null as activity,0 as iscompleted,  'denied' as response;
        end if;
    else
		select null as id, null as activity,0 as iscompleted, 'unauthorized' as response;
    end if;

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getissuepriority` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getissuepriority`(token varchar(255))
BEGIN
	
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getissuepriority';
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
			select l.id, l.list_value as issuetitle 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
			where lc.name = 'issue_priority' and org.code = orgcode;
        
        else
			select null as id, null as activity,0 as iscompleted,  'denied' as response;
        end if;
    else
		select null as id, null as activity,0 as iscompleted, 'unauthorized' as response;
    end if;

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getissueresolvegraphstats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getissueresolvegraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    declare varIssueHr int;
    declare varAvgTime int;
    DECLARE done INT DEFAULT FALSE;
    
	declare cur cursor  for select HOUR(isu.createdon) issuehour,Coalesce(sum(TIMESTAMPDIFF(MINUTE,isu.createdon,isu.resolvedon))/count(isu.id), 0)  as avgresolve from psm.issue isu
		
		where isu.status=1 and isu.organization_id=orgid and date(isu.createdon)=date(current_date)
        group by HOUR(isu.createdon);
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		
        drop table if exists `result`;
		create temporary table result (issuehour int,reported int,avgresolvetime float,response varchar(55))engine=memory;
        insert into result
        
        select HOUR(isu.createdon),count(isu.id),0,"ok" from psm.issue isu
		
		where isu.status=1 and isu.organization_id=orgid and date(isu.createdon)=date(current_date)
        group by HOUR(isu.createdon);
        
        
        open cur;
        read_loop: LOOP
			FETCH cur INTO varIssueHr,varAvgTime;
			IF done THEN
				LEAVE read_loop;
			END IF;
			update result set avgresolvetime=varAvgTime where issuehour=varIssueHr;
		END LOOP;
		CLOSE cur;
        
        
        
        select * from result;
        drop table result;
    else
		select null as issuehour,null as reported,null as avgresolvetime,"unautorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getlist`(token varchar(255),organization_id int(11), category_name varchar(45))
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getlist';
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
			select l.id, l.list_internal_name, l.list_value, 'ok' as response 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
			where lc.name = category_name and org.code = orgcode;
        
        else
			select null as id, null as list_internal_name,null as list_value,  'denied' as response;
        end if;
    else
		select null as id, null as list_internal_name,null as list_value, 'unauthorized' as response;
    end if;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getnewnotificationpulse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getnewnotificationpulse`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare rcount int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1) then
		/** check for new notifications **/
        select count(ns.status) as has_new_notification,'ok' as response from psm.notification nt inner join 
			psm.notification_status ns on ns.notificationid=nt.id
			inner join subscription.organization org on
			nt.organization_id=org.id
			inner join security.user usr on
			ns.userid=usr.id
			where org.code=orgcode and usr.username=username and ns.status=0 and date(nt.createdon)=date(current_date)   ;
    else
		select 0 as has_new_notification,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getnewnotifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getnewnotifications`(in token varchar(255),in electionid INT)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set spcode='getnewnotifications';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		/** check for new notifications **/
        select nt.id as notification_id,nt.message as message,nt.attachtment_url as att_url,nt.createdon as generatedon,
        'ok' as response 
        from psm.notification nt inner join 
			psm.notification_status ns on ns.notificationid=nt.id
			inner join subscription.organization org on
			nt.organization_id=org.id
			inner join security.user usr on
			ns.userid=usr.id
			where org.code=orgcode and usr.username=username and ns.status=0;
    else
		select null as notification_id,null as message,null as att_url,null as generatedon,
        'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getnotificationbyid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getnotificationbyid`(in token varchar(255),in notificationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare readcount int;
    declare unreadcount int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getnotificationbyid';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
		set readcount=(select count(id) from psm.notification_status ee where ee.notificationid=notificationid and ee.organization_id=orgid and ee.status=1);
        set unreadcount=(select count(id) from psm.notification_status ee where ee.notificationid=notificationid and ee.organization_id=orgid and ee.status=0);
        
        select id,message,attachtment_url as attachtment, createdon as senton,concat(readcount,'/',readcount+unreadcount) as status,'success' as response   
        from psm.notification where organization_id=orgid and id=notificationid;
    else
		select null as id,null as message,null as attachtment, null as senton,null as status,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getnotificationcountgraphstats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getnotificationcountgraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select count(noti.id) as notificationcount,"success" as response from psm.notification noti
		
		where date(noti.createdon) =date(current_date) and noti.organization_id=orgid;
    else 
		select null as notificationcount,"unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpollingstationclosedstatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationclosedstatus`(in token varchar(255),in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set spcode='getnewnotifications';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then
    
    select min(pse.isopen) as open_status, min(pse.isclose) as closed_status,"success" as response from psm.polling_station_election pse
	inner join psm.election e on pse.election_id = e.id and pse.organization_id = e.organization_id
	where pse.polling_station_id=stationid and pse.organization_id = orgid 
    and UNIX_TIMESTAMP(DATE(e.election_date_start)) = UNIX_TIMESTAMP(CURDATE());

    else
		select null as open_status,null as closed_status ,"unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpollingstationelectiondetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationelectiondetails`(in token varchar(255),in electionid int,in pollingstationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare BPAIdentifier int(11);
    declare ballotstartnum int(11);
    declare ballotendnum int(11);
    declare tenderedstartnum int(11);
    declare tenderedendnum int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    select BPA_identifier into BPAIdentifier from psm.election where id=electionid and organization_id=orgid;
    
    if (security.fn_validate_token(token)=1) then
		select BPAIdentifier as BPAIdentifier,
        ballotstart as ballotstart, 
        ballotend as ballotend,
        tenderstart as tenderstart,
        tenderend as tenderend,
        'success' as response
        FROM psm.polling_station_election 
        where election_id=electionid 
        and polling_station_id=pollingstationid 
        and organization_id=orgid;
    else
		select 'unauthorized' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpollingstations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstations`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getpollingstations';
    
    
    if (security.fn_validate_token(token)=1) then
    
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
    
			/** get polling stations **/
			select distinct ps.id, ps.name, ps.address, ps.postcode, null as opentime, 'ok' as response from psm.polling_station ps 
			inner join psm.polling_station_election pse on ps.id = pse.polling_station_id  
            inner join psm.election el on el.id=pse.election_id
			inner join psm.user_election ue on ue.election_id = pse.election_id and ue.pollingstation_id  = pse.polling_station_id
			inner join security.user u on ue.user_id = u.id
			inner join subscription.organization org on org.id = u.organization_id
			where u.username = username and org.code=orgcode and date(el.election_date_start)=date(current_date) and el.is_deleted=0 ; 
        
        else
			select null as id, null as name,null as address, null as postcode, null as opentime, 'unauthorized' as response;
        end if;
    else
		select null as id, null as name,null as address, null as postcode, null as opentime, 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpollingstationstatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationstatus`(in token varchar(255),in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set spcode='getnewnotifications';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then
    
    select min(pse.isopen) as status,"success" as response from psm.polling_station_election pse
	inner join psm.election e on pse.election_id = e.id and pse.organization_id = e.organization_id
	where pse.polling_station_id=stationid and pse.organization_id = orgid 
    and UNIX_TIMESTAMP(DATE(e.election_date_start)) = UNIX_TIMESTAMP(CURDATE());

    else
		select null as status,"unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpollingsummary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingsummary`(in token varchar(255),in stationid int,in electionid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare tot_ballots int;
    declare tot_spolied_issued int;
    declare tot_unused int;
    declare tot_tend_ballots int;
    declare tot_tend_spoiled int;
    declare tot_tend_unused int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
		select sum(ballotpaper) as tot_ballots,
        sum(spoilt_ballot) as tot_spolied_issued,
        el.ballotend-el.ballotstart -sum(ballotpaper) as tot_unused,
        sum(ten_ballot_papers) as tot_tend_ballots,
        sum(ten_spoilt_ballots) as tot_tend_spoiled,
        el.tenderend - el.tenderstart - sum(ten_ballot_papers) as tot_tend_unused,
        'success' as response
        
        from psm.election_stats es
        inner join psm.election el on el.id=es.electionid
        where es.organization_id=orgid and el.organization_id=orgid and
        es.polling_station_id=stationid and es.electionid=electionid;
    else
		select null as tot_ballots,
        null as tot_spolied_issued,
        null as tot_unused,
        null as tot_tend_ballots,
        null as tot_tend_spoiled,
        null as tot_tend_unused,
        'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpostalcollectgraphstats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpostalcollectgraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select el.election_name as electionname,HOUR(est.updatedon) as issuehour, sum(postalpack_collected) as postalcollected,"success" as response from psm.election_stats  est
		inner join psm.election el on el.id=est.electionid
		where date(el.election_date_start)=date(current_date) and est.organization_id=orgid and el.organization_id=orgid
		group by el.election_name, HOUR(est.updatedon);
    else
		select null as electionname,null as issuehour,null as postalcollected,"unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpostpollactivities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpostpollactivities`(in token varchar(255), in polling_station_id int,in electionid int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare election_id int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    
    if (security.fn_validate_token(token)=1) then
		if(select exists(select vel.id   from election vel inner join polling_station_election vpse on vel.id=vpse.election_id where vpse.polling_station_id=polling_station_id and date(vel.election_date_start)=date(current_date) limit 1)) then
                     
			set election_id=electionid;		 
			
            select l.id, l.list_value as activity,lc.name as category, IFNULL(oce.iscompleted,0) as iscompleted, 'success' as response 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
            left outer join psm.open_close_election oce on oce.list_id = l.id and oce.polling_station_id = polling_station_id and oce.election_id = election_id
			where lc.name = 'postpoll_activity' and org.code = orgcode  order by lc.list_order,l.list_order;
         else
			select null as id, null as activity,null as category,0 as iscompleted,  'success' as response;
         end if;
		
    else
		select null as id, null as activity,null as category,0 as iscompleted,  'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getprepollactivities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getprepollactivities`(token varchar(255), election_id int, polling_station_id int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getprepollactivities';
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
			select l.id, l.list_value as activity, IFNULL(oce.iscompleted,0) as status, 'ok' as response 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
            left outer join psm.open_close_election oce on oce.list_id = l.id and oce.polling_station_id = polling_station_id and oce.election_id = election_id
			where lc.name = 'prepoll_activity' and org.code = orgcode;
        
        else
			select null as id, null as activity,0 as iscompleted,  'denied' as response;
        end if;
    else
		select null as id, null as activity,0 as iscompleted, 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getprepollactivities_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getprepollactivities_v2`(token varchar(255), polling_station_id int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare election_id int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getprepollactivities';
    
    
    
    if (security.fn_validate_token(token)=1) then
    
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
        
	     if(select exists(select vel.id   from election vel inner join polling_station_election vpse on vel.id=vpse.election_id where vpse.polling_station_id=polling_station_id and date(vel.election_date_start)=date(current_date) limit 1)) then
                     
			select vel.id into election_id  from election vel inner join polling_station_election vpse on vel.id=vpse.election_id where vpse.polling_station_id=polling_station_id and vpse.isclose=0 and  date(vel.election_date_start)=date(current_date) limit 1;		 
			
            select l.id, l.list_value as activity,lc.name as category, IFNULL(oce.iscompleted,0) as iscompleted, 'success' as response 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
            left outer join psm.open_close_election oce on oce.list_id = l.id and oce.polling_station_id = polling_station_id and oce.election_id = election_id
			where lc.name like 'prepoll_activity%' and org.code = orgcode order by lc.list_order,l.list_order;
         else
			select null as id, null as activity,null as category,0 as iscompleted,  'success' as response;
         end if;
        
			
        
        else
			select null as id, null as activity,null as category,0 as iscompleted,  'unauthorized' as response;
        end if;
    else
		select null as id, null as activity,null as category,0 as iscompleted,  'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getprogress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getprogress`(in token varchar(255),in electionid int,in pollingstationid int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
        if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
        
			if(select exists (select * from psm.election_stats es 
			where es.organization_id = orgid and es.electionid = electionid and es.polling_station_id = pollingstationid)) then
				select 
				SUM(es.ballotpaper) as ballotpapers, 
				SUM(es.postalpack) as postalpacks, 
				sum(es.postalpack_collected) as postalpackscollected,
				'success' as response
				from psm.election_stats es 
				where es.organization_id = orgid and es.electionid = electionid and es.polling_station_id = pollingstationid
				group by es.electionid, es.polling_station_id, es.organization_id;
			else
				select 0 as ballotpapers, 0 as postalpacks, 0 as postalpackscollected,  'success' as response;
			end if;
    
        else
			select null as ballotpapers, null as postalpacks, null as postalpackscollected,  'unauthorized' as response;
		end if;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getprogressbytime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getprogressbytime`(in token varchar(255),in electionid int,in pollingstationid int,
in updatehour int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare BPAIdentifier int(11);
    declare ballotstartnum int(11);
    declare ballotendnum int(11);
    declare tot_ballotpapers int(11);
    declare tenderedstartnum int(11);
    declare tenderedendnum int(11);
    declare tot_tenderedpapers int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    select BPA_identifier into BPAIdentifier from psm.election where id=electionid and organization_id=orgid;
    
    SELECT ballotstart into ballotstartnum
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT ballotend into ballotendnum 
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT tenderstart into tenderedstartnum
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT tenderend into tenderedendnum 
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    if (security.fn_validate_token(token)=1) then
    if (BPAIdentifier=0) then
		select BPAIdentifier, ballotstartnum,
        ballotendnum, tenderedstartnum, tenderedendnum,
		SUM(es.ballotpaper) as ballotpapers, 
        SUM(es.postalpack) as postalpacks, 
        SUM(es.postalpack_collected) as postalpackscollected,
        SUM(es.spoilt_ballot) as spoilt_ballots,
        SUM(es.ten_ballot_papers) as ten_ballot_papers, 
        SUM(es.ten_spoilt_ballots) as ten_spoilt_ballots,
        'success' as response
		from psm.election_stats es 
		where es.organization_id = orgid and es.electionid = electionid 
        and es.polling_station_id = pollingstationid and HOUR(es.updatedon) = updatehour and UNIX_TIMESTAMP(DATE(es.updatedon)) = UNIX_TIMESTAMP(CURDATE())
		group by es.electionid, es.polling_station_id, es.organization_id; 
	elseif (BPAIdentifier=1) then
		select BPAIdentifier, ballotstartnum,
        ballotendnum, tenderedstartnum, tenderedendnum,
		SUM(es.ballotpaper) as ballotpapers, 
        SUM(es.postalpack) as postalpacks, 
        SUM(es.postalpack_collected) as postalpackscollected,
        SUM(es.spoilt_ballot) as spoilt_ballots,
        SUM(es.ten_ballot_papers) as ten_ballot_papers, 
        SUM(es.ten_spoilt_ballots) as ten_spoilt_ballots,
        'success' as response
		from psm.election_stats es 
		where es.organization_id = orgid and es.electionid = electionid 
        and es.polling_station_id = pollingstationid and HOUR(es.updatedon) = updatehour and UNIX_TIMESTAMP(DATE(es.updatedon)) = UNIX_TIMESTAMP(CURDATE())
		group by es.electionid, es.polling_station_id, es.organization_id; 
    end if;
    else
		select 'unauthorized' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getrecordclosebuttonshow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getrecordclosebuttonshow`(in token varchar(255),in electionid int,in stationid int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
         
			
			if(select exists 
				(					
					SELECT * from psm.election el inner join
        polling_station_election pse on pse.election_id=el.id where HOUR(el.election_date_end)-1 = HOUR(current_time())
        and pse.election_id = electionid and pse.polling_station_id = stationid and pse.organization_id = orgid and pse.election_status = 0
                    ) 
            ) then
				select 'success' as response, 1 as buttonshow;
			else
				select 'success' as response, 0 as buttonshow;
            end if;
	else
		select null as buttonshow,'unauthorized' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gettopnotifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `gettopnotifications`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set spcode='getnewnotifications';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1) then
		/** check for new notifications **/
        select nt.id as notification_id,nt.message as message,nt.attachtment_url as att_url,nt.createdon as generatedon,
        ns.isprivate as isprivate,'ok' as response 
        from psm.notification nt inner join 
			psm.notification_status ns on ns.notificationid=nt.id
			inner join subscription.organization org on
			nt.organization_id=org.id
			inner join security.user usr on
			ns.userid=usr.id
			where org.code=orgcode and usr.username=username and nt.createdon >= CURDATE()
            order by nt.createdon desc limit 7;
    else
		select null as notification_id,null as message,null as att_url,null as generatedon,null as isprivate,
        'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gettrackingprogress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `gettrackingprogress`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    set spcode='gettrackingstatus';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
     select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
    
    select track.pollingstationid as stationid, 
	td.ballot_box_number,
	IFNULL(track.longtitude,0) as longtitude,
	IFNULL(track.latitude, 0) as latitude,
    cc.name as counting_center_id,
    IFNULL(cc.latitude, 0) as destination_latitude,
    IFNULL(cc.longitude,0) as destination_longtitude,
    p.name as polling_station,
	'success' as response
    from psm.tracking track
    inner join 
    (
		select 
        MAX(t.id) as trackingid
        /*t.pollingstationid as stationid
        ,t.election_id as electionid*/
        ,GROUP_CONCAT(pse.ballot_box_number) as ballot_box_number
        /*,IFNULL(t.longtitude,0) as longtitude
        , IFNULL(t.latitude, 0) as latitude
        , 'success' as response */
        from 
		psm.tracking t inner join psm.polling_station_election pse
		on pse.polling_station_id = t.pollingstationid and pse.election_id = t.election_id and pse.organization_id = t.organization_id
        inner join psm.election e on pse.election_id = e.id and pse.organization_id = t.organization_id
        where t.organization_id = orgid 
        and date(e.election_date_start)=date(current_date) 
        GROUP BY t.pollingstationid
        ) td on track.id = td.trackingid
        INNER JOIN polling_station_election_counting psec on 
        psec.polling_station_id = track.pollingstationid and psec.election_id = track.election_id and psec.organization_id = track.organization_id
        inner join counting_center cc on psec.counting_center_id = cc.id and psec.organization_id = cc.organization_id
        inner join polling_station p on psec.polling_station_id = p.id
        order by p.id;
    else
		select null as trackingid,null as stationid,null as electionid,null as ballot_box_number,null as latitude, null as longtitude,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gettrackingstatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `gettrackingstatus`(in token varchar(255),in electionid INT,in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    set spcode='gettrackingstatus';
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select t.status as status,"success" as response  from psm.tracking t
        inner join psm.election e on t.election_id=e.id
        inner join psm.polling_station p on t.pollingstationid=p.id
        inner join subscription.organization o on t.organization_id=o.id
        where o.code=orgcode and t.election_id=electionid and t.pollingstationid=stationid;
    else
		select null as status,"unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getvoter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getvoter`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getvoter';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select voter_list.id as vlid, usr.id as userid, usr.organization_id as organization_id, 
        ps.id as pollingstationid, voter_list.voter_name as vlname, voter_list.phone_number as vlphonenumber, 
        voter_list.companion_name as vlcompanionname, voter_list.companion_address as vlcompanionaddress, 
        'success' as response
        from psm.voter_list voter_list
        inner join psm.polling_station ps on voter_list.polling_station_id=ps.id
        inner join security.user usr on voter_list.userid=usr.id
        where voter_list.userid=usr.id and 
        voter_list.polling_station_id=ps.id and usr.organization_id=organizationid;
	else
		select null vlid, null userid, null organization_id, 
        null pollingstationid, null vlname, null vlphonenumber, 
        null vlcompanionname, null vlcompanionaddress, 
        'unauthorized' response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getvoterturnout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getvoterturnout`(in token varchar(255),in electionid int,in pollingstationid int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
        if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
        
			if(select exists (select * from psm.election_stats es 
			where es.organization_id = orgid and es.electionid = electionid and es.polling_station_id = pollingstationid)) then
				select 
				SUM(es.ballotpaper) as ballotpapers, 
				SUM(es.postalpack) as postalpacks, 
				sum(es.postalpack_collected) as postalpackscollected,
				'success' as response
				from psm.election_stats es 
				where es.organization_id = orgid and es.electionid = electionid and es.polling_station_id = pollingstationid
				group by es.electionid, es.polling_station_id, es.organization_id;
			else
				select 0 as ballotpapers, 0 as postalpacks, 0 as postalpackscollected,  'success' as response;
			end if;
    
    
        else
			select null as ballotpapers, null as postalpacks, null as postalpackscollected,  'unauthorized' as response;
		end if;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `initscript` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `initscript`(in org_name varchar(255),
in usrname varchar(255),in user_password varchar(255),in csvstructure int,in electorate_value varchar(255))
BEGIN

    declare org_id int(11);
    declare usr_id int(11);
    declare role_em_id int(11);
    declare list_id_01 int(11);
    declare list_id_02 int(11);
    declare list_id_03 int(11);
    declare list_id_04 int(11);
    declare list_id_05 int(11);
    declare list_id_06 int(11);
    declare list_id_07 int(11);
    declare electorateid int(11);


/*Creating the Organization */    
insert into subscription.organization (name,code,area_name,logo_url,created_on,isactive,isdeleted,csvstructureid) 
values (org_name,org_name,org_name,'assets/global/images/derry.jpg',current_timestamp(),1,0,csvstructure);

select LAST_INSERT_ID() into org_id;


/* Adding the super user */ 
insert into security.user (organization_id,firstname,lastname,username,passwordhash,locale,language_id,createdon) 
select org_id,usrname,' ',usrname,sha1(CONCAT('S@l+VaL',user_password)),'en-GB',1,current_timestamp;

select LAST_INSERT_ID() into usr_id;


/*Creating all Roles */
insert into security.role (organization_id,name,description,createdon) 
values (org_id,'Election Manager','Election Manager',current_timestamp());
select LAST_INSERT_ID() into role_em_id;

insert into security.role (organization_id,name,description,createdon) 
	values (org_id,'Presiding Officer','Presiding Officer',current_timestamp());

insert into security.role (organization_id,name,description,createdon) 
	values (org_id,'Super Presiding Officer','Super Presiding Officer',current_timestamp());
    
insert into security.role (organization_id,name,description,createdon) 
	values (org_id,'Issue Resolver','Issue Resolver',current_timestamp());
    
insert into security.role (organization_id,name,description,createdon) 
	values (org_id,'Polling Station Inspector','Polling Station Inspector',current_timestamp());


/* Adding user to a role */ 
insert into security.user_role (organization_id,role_id,user_id) 
value (org_id,role_em_id,usr_id);


/* Giving Permissions to roles */ 
insert into security.role_permission (organization_id,role_id,permission_id) 
	select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
        where ro.name='Presiding Officer' and ro.organization_id=org_id;
insert into security.role_permission (organization_id,role_id,permission_id) 
	select org_id,role_em_id,id FROM subscription.permission;
/*insert into security.role_permission (organization_id,role_id,permission_id) 
	select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
		where ro.name='Super Presiding Officer' and ro.organization_id=org_id;  
insert into security.role_permission (organization_id,role_id,permission_id) 
	select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
		where ro.name='Issue Resolver' and ro.organization_id=org_id;          
insert into security.role_permission (organization_id,role_id,permission_id) 
	select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
		where ro.name='Polling Station Inspector' and ro.organization_id=org_id;  */
 
/* Creating Hierarchy Structure */  
insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
	values (org_id,'Electorate',NULL,1,current_timestamp());
select LAST_INSERT_ID() into electorateid;    
insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
	values (org_id,'Ward',electorateid,2,current_timestamp());
insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
	values (org_id,'District',LAST_INSERT_ID(),3,current_timestamp());
insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
	values (org_id,'Place',LAST_INSERT_ID(),4,current_timestamp()); 
if (csvstructure=2) then insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon)    
	values (org_id,electorateid,electorate_value,current_timestamp());  
end if;    

/* Creating issue and prepoll activity list categories*/  
insert into psm.list_category (organization_id,name,list_order) values (org_id,'issue',NULL);
select LAST_INSERT_ID() into list_id_01;
insert into psm.list_category (organization_id,name,list_order) values (org_id,'issue_resolution',NULL);
select LAST_INSERT_ID() into list_id_02;
insert into psm.list_category (organization_id,name,list_order) values (org_id,'prepoll_activity_Outside_the_polling_station',1);
select LAST_INSERT_ID() into list_id_03;
insert into psm.list_category (organization_id,name,list_order) values (org_id,'prepoll_activity_Inside_the_polling_station',2);
select LAST_INSERT_ID() into list_id_04;
insert into psm.list_category (organization_id,name,list_order) values (org_id,'prepoll_activity_Polling_booths_and_ballot_boxes',3);
select LAST_INSERT_ID() into list_id_05;
insert into psm.list_category (organization_id,name,list_order) values (org_id,'prepoll_activity_Ballot_papers',4);
select LAST_INSERT_ID() into list_id_06;
insert into psm.list_category (organization_id,name,list_order) values (org_id,'postpoll_activity',1);
select LAST_INSERT_ID() into list_id_07;

/* Creating issue and prepoll activity lists*/  

insert into psm.list (organization_id,list_category_id,list_internal_name,list_value,list_order) values 
(org_id,list_id_01,'Staffing','Staffing',0),
(org_id,list_id_01,'Accessibility','Accessibility',0),
(org_id,list_id_01,'Logistics','Logistics',0),
(org_id,list_id_01,'Security','Security',0),
(org_id,list_id_01,'Ballot Papers','Ballot Papers',0),
(org_id,list_id_01,'Health and Safety','Health and Safety',0),
(org_id,list_id_01,'Problems with Register','Problems with Register',0),
(org_id,list_id_01,'Postal and Proxy Voters','Postal and Proxy Voters',0),
(org_id,list_id_01,'Other','Other',0),

(org_id,list_id_03,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),
(org_id,list_id_03,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),
(org_id,list_id_03,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),
(org_id,list_id_03,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),
(org_id,list_id_03,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),
(org_id,list_id_03,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),
(org_id,list_id_03,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),

(org_id,list_id_04,'Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),
(org_id,list_id_04,'Would the layout work if there was a build-up of electors waiting to cast their ballots?','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),
(org_id,list_id_04,'Is best use being made of the lights and natural light available?','Is best use being made of the lights and natural light available?',3),
(org_id,list_id_04,'Is there a seat available if an elector needs to sit down?','Is there a seat available if an elector needs to sit down?',4),
(org_id,list_id_04,'Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),
(org_id,list_id_04,'Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),
(org_id,list_id_04,'As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),
(org_id,list_id_04,'Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),

(org_id,list_id_05,'Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),
(org_id,list_id_05,'Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),
(org_id,list_id_05,'Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),
(org_id,list_id_05,'Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),
(org_id,list_id_05,'Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),
(org_id,list_id_05,'Is the tactile template available and in full view? Do all staff know how to use it?','Is the tactile template available and in full view? Do all staff know how to use it?',6),

(org_id,list_id_06,'Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),
(org_id,list_id_06,'Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),
(org_id,list_id_06,'Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),
(org_id,list_id_06,'Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),
(org_id,list_id_06,'Do you have the correct register for your polling station?','Do you have the correct register for your polling station?',5),

(org_id,list_id_07,'Packet for tendered ballot papers marked by voters','Packet for tendered ballot papers marked by voters',1),
(org_id,list_id_07,'Packet for marked register','Packet for marked register',2),
(org_id,list_id_07,'Packet for certificates of employment','Packet for certificates of employment',3),
(org_id,list_id_07,'Packet for various lists and declarations','Packet for various lists and declarations',4),
(org_id,list_id_07,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),
(org_id,list_id_07,'Packet for CNL','Packet for CNL',6),
(org_id,list_id_07,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),
(org_id,list_id_07,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),
(org_id,list_id_07,'Tactile voting device','Tactile voting device',9),
(org_id,list_id_07,'Ballot box compactor','Ballot box compactor',10),
(org_id,list_id_07,'Unused seals','Unused seals',11),
(org_id,list_id_07,'Unused signs and notices etc.','Unused signs and notices etc.',12),
(org_id,list_id_07,'Packet for ballot paper account','Packet for ballot paper account',13),
(org_id,list_id_07,'Postal votes – handed in but not previously collected','Postal votes – handed in but not previously collected',14),
(org_id,list_id_07,'Ballot Box(es)','Ballot Box(es)',15);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `isopenisclosed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `isopenisclosed`(IN strIDs VARCHAR(255))
BEGIN

  DECLARE strLen    INT DEFAULT 0;
  DECLARE SubStrLen INT DEFAULT 0;
  DECLARE stationid INT;
  DECLARE isopen INT DEFAULT 0;
  DECLARE isclose INT DEFAULT 0;

  IF strIDs IS NULL THEN
    SET strIDs = '';
  END IF;

do_this:
  LOOP
    SET strLen = CHAR_LENGTH(strIDs);

    select SUBSTRING_INDEX(strIDs, ',', 1) into stationid;
    SET isopen = isopen+(select psm.isopen(stationid));
    SET isclose = isclose+(select psm.isclose(stationid));

    SET SubStrLen = CHAR_LENGTH(SUBSTRING_INDEX(strIDs, ',', 1)) + 2;
    SET strIDs = MID(strIDs, SubStrLen, strLen);

    IF strIDs = '' THEN
      LEAVE do_this;
    END IF;
  END LOOP do_this;
  
    select isopen as opened,isclose as closed;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `openstation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `openstation`(token varchar(255), polling_station_id int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code = orgcode;
    set spcode = 'openstation';
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
        update polling_station_election pse 
        inner join election e on pse.election_id = e.id 
        set pse.isopen = 1, pse.opentime = UTC_TIMESTAMP()
        where pse.organization_id = orgid and pse.polling_station_id = polling_station_id 
        and date(e.election_date_start)=date(current_date);
        
        select 'success' as response;
        
        
        else
			select null as id, null as activity,0 as iscompleted,  'denied' as response;
        end if;
    else
		select null as id, null as activity,0 as iscompleted, 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `readnotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `readnotification`(in token varchar(255),in notification_id INT)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='readnotification';
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		update
			psm.notification nt inner join 
			psm.notification_status ns on ns.notificationid=nt.id
			inner join subscription.organization org on
			nt.organization_id=org.id
			inner join security.user usr on
			ns.userid=usr.id
            set ns.status=1,ns.akn_time=CURRENT_TIMESTAMP
			where nt.id=notification_id  and org.code=orgcode and usr.username=username;
        select "success" as response;
    else
		select "unauthorized" as response;
    end if;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reportissue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `reportissue`(token varchar(255),election_id int, polling_station_id int, issue_list_id int, description text, priority int )
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'reportissue';
    select id into orgid from subscription.organization where code = orgcode;
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
			if (election_id =-1) then
				insert into issue(organization_id, pollingstation_id,issue_list_id, description,priority, status,reportedby)
				values(orgid,polling_station_id,issue_list_id, description,priority,0,username);
				select 'success' as response;
            else
				insert into issue(organization_id, pollingstation_id, electionid,issue_list_id, description,priority, status,reportedby)
				values(orgid,polling_station_id, election_id,issue_list_id, description,priority,0,username);
				select 'success' as response;
            end if;
			
            
        else
			select   'denied' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `resetdb` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `resetdb`(in electionid int,in orgid int)
BEGIN
insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
select  polling_station_id,orgid,electionid,0,0,0,0,0,0 from psm.polling_station_election 
where election_id=electionid and organization_id=orgid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `resetelection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `resetelection`(in electionid int,in organizationid int)
BEGIN
update psm.election set election_date_start=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 7 HOUR), '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),election_date_end=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 22 HOUR), '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),status=0 where id=electionid;

delete from psm.notification_status where organization_id=organizationid;
delete from psm.notification where organization_id=organizationid;
delete from psm.issue_assignment;
delete from psm.issue where organization_id=organizationid;

delete from psm.election_stats where organization_id=organizationid and electionid=electionid;
delete from psm.election_close_stats where election_id=electionid;
delete from psm.open_close_election where election_id=electionid;
delete from psm.station_photo where election_id=electionid;

/*insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
select  polling_station_id,organizationid,electionid,0,0,0,0,0,0 from psm.polling_station_election 
where election_id=electionid and organization_id=organizationid;*/

update psm.polling_station_election set isopen=0,isclose=0,election_status=0 where election_id=electionid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `resolveissue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `resolveissue`(in token varchar(255),in issueid int,in description varchar(2000))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    #declare userid int;
    set spcode='resolveissue';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        #select id into userid from security.user where organization_id=orgid and username=username;
        
		update psm.issue set status=1,resolution_desc=description,resolvedon=current_timestamp where id=issueid and organization_id=orgid;
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `starttrack` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `starttrack`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    set spcode='starttrack';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		if(select exists(
        
          select t.* from psm.tracking as t
		  inner join psm.user_election ue on t.election_id = ue.election_id and t.pollingstationid = ue.pollingstation_id and ue.organization_id = t.organization_id 
		  inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
          inner join election e on ue.election_id = e.id
			where u.username= username and u.organization_id = orgid and date(e.election_date_start)=date(current_date) )) then
            
			select "tracking already started" as response;
        else
			insert into psm.tracking (organization_id,pollingstationid,election_id,deliver_address,dispatch_time,status)
			select ue.organization_id, ue.pollingstation_id, ue.election_id,'address',CURRENT_TIMESTAMP,1
				from psm.user_election ue  
				inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
                inner join election e on ue.election_id = e.id
				where u.username= username and u.organization_id = orgid and date(e.election_date_start)=date(current_date);

			select "success" as response;
        end if;
    else
		select "unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateclosestats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateclosestats`(in token varchar(255),in electionid int, in tot_ballots int,in tot_spoiled_replaced int,in tot_unused int,in tot_tend_ballots int,in tot_tend_spoiled int,in tot_tend_unused int,in pollingstationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code = orgcode;
    set spcode='updateclosestats';
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
		/** check whether there is a record **/
        if(select exists(select * from psm.election_close_stats where election_id=electionid and polling_station_id = pollingstationid )) then
			/** update the record record **/
            update psm.election_close_stats set
            tot_ballots=tot_ballots,
            tot_spolied_issued=tot_spoiled_replaced,
            tot_unused=tot_unused,
            tot_tend_ballots=tot_tend_ballots,
            tot_tend_spoiled=tot_tend_spoiled,
            tot_tend_unused=tot_tend_unused,
            updatedon=CURRENT_TIMESTAMP where
            organization_id=orgid and election_id=electionid and polling_station_id = pollingstationid;
            select "success" as response;
        else
			/** insert  a record **/
            insert into psm.election_close_stats (organization_id,election_id,polling_station_id,tot_ballots,tot_spolied_issued,tot_unused,tot_tend_ballots,tot_tend_spoiled,tot_tend_unused)
            values (orgid,electionid,pollingstationid,tot_ballots,tot_spoiled_replaced,tot_unused,tot_tend_ballots,tot_tend_spoiled,tot_tend_unused);
            select "success" as response;
        end if;
    else
		select "unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateelection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateelection`(in token varchar(255), in election_id int, in ename varchar(255), in election_date varchar(55),
in start_time varchar(55), in end_time varchar(55), in counting_center_name varchar(45),
in counting_center_address varchar(100), in counting_center_latitude varchar(45),
in counting_center_longitude varchar(45), in BPAidentifier int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare electionid int(11);
    declare userid int(11);
    declare added_counting_center_id int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'updateelection';
    
    select id into organizationid from subscription.organization where code = orgcode;
    select id into electionid from psm.election where id = election_id;
    
    SELECT id into added_counting_center_id FROM psm.counting_center cc where cc.election_id=election_id;
    
    if (security.fn_validate_token(token)=1) then
		#update psm.election
        update psm.election
        set election_name=ename, election_date_start=CONCAT(election_date,' ',start_time),
        election_date_end=CONCAT(election_date,' ',end_time), status=0, BPA_identifier=BPAidentifier
        where id=electionid;
        
        #update psm.counting_center
        update psm.counting_center
        set name=counting_center_name, latitude=counting_center_latitude, longitude=counting_center_longitude, address=counting_center_address
        where id=added_counting_center_id;
        
		/*update psm.election election, psm.counting_center counting_center 
        set election.election_name=ename, election.election_date_start=CONCAT(election_date,' ',start_time),
        election.election_date_end=CONCAT(election_date,' ',end_time), status=0,
        counting_center.name=counting_center_name, counting_center.address=counting_center_address
        where election.id=electionid and counting_center.id=added_counting_center_id;*/
        
        /*update psm.election election INNER JOIN psm.counting_center counting_center 
        set election.election_name=ename, election.election_date_start=CONCAT(election_date,' ',start_time),
        election.election_date_end=CONCAT(election_date,' ',end_time), status=0,
        counting_center.name=counting_center_name, counting_center.address=counting_center_address
        where election.id=electionid and counting_center.id=added_counting_center_id;*/
		
        select 'success' as response;
        
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateissue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateissue`(in token varchar(255),in issueid int,in userid int,in status int,in priority int,in comment varchar(1000))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    set spcode='updateissue';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        #delete previous assignments
        delete from psm.issue_assignment where issue_id=issueid and organization_id=orgid;
		insert into psm.issue_assignment (organization_id,issue_id,user_id)
		values (orgid,issueid,userid);
        
        #now update the data to issue table
        if status=1 then
			update psm.issue set resolution_desc=comment,status=status,priority=priority,resolvedon=current_timestamp where id=issueid and organization_id=orgid;
        else
			update psm.issue set resolution_desc=comment,status=status,priority=priority where id=issueid and organization_id=orgid;
        end if;
        
        select 'success' as response;
	else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatepostpollactivity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updatepostpollactivity`(token varchar(255), polling_station_id int,election_id int, activity_id int, status int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'updateprepollactivity';
    select id into orgid from subscription.organization where code = orgcode;
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
			if(select exists 
				(
					select oce.* from psm.open_close_election oce where oce.election_id = election_id 
					and oce.polling_station_id = polling_station_id and oce.list_id = activity_id 
					and oce.organization_id = orgid
				) 
            ) then
                /*update status if record exists */
				
                update psm.open_close_election oce set oce.iscompleted = status 
                where oce.election_id = election_id and 
				oce.polling_station_id = polling_station_id and oce.list_id = activity_id 
                and oce.organization_id = orgid;
                
				select 'success' as response;
                
			else
				/*insert record if doesnt*/
				insert into psm.open_close_election(organization_id,polling_station_id, election_id,list_id,iscompleted ) 
                values(orgid,polling_station_id,election_id, activity_id,status);
                
				select 'success' as response;
                
            end if;

        else
			select   'denied' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateprepollactivity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateprepollactivity`(token varchar(255), polling_station_id int, activity_id int, status int)
BEGIN

 declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'updateprepollactivity';
    select id into orgid from subscription.organization where code = orgcode;
    
    
    if (security.fn_validate_token(token)=1) then
  if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
   if(select exists 
    (
     select oce.* from psm.open_close_election oce inner join
     psm.polling_station_election pse on oce.polling_station_id = pse.polling_station_id and oce.election_id = pse.election_id 
     and oce.organization_id = pse.organization_id
                    inner join psm.election e on e.id = oce.election_id  
                    where pse.polling_station_id = polling_station_id and oce.list_id = activity_id 
                    and pse.organization_id = orgid and date(e.election_date_start)=date(current_date)
     /*select oce.* from psm.open_close_election oce where oce.election_id = election_id 
     and oce.polling_station_id = polling_station_id and oce.list_id = activity_id 
     and oce.organization_id = orgid*/
    ) 
            ) then
                /*update status if record exists */
                update psm.open_close_election oce 
    inner join
    psm.polling_station_election pse on oce.polling_station_id = pse.polling_station_id and oce.election_id = pse.election_id 
    and oce.organization_id = pse.organization_id
                inner join election e on pse.election_id  = e.id
                set oce.iscompleted = status
                where pse.polling_station_id = polling_station_id and oce.list_id = activity_id 
    and pse.organization_id = orgid
                and date(e.election_date_start)=date(current_date);
    
                /*update psm.open_close_election oce set oce.iscompleted = status 
                where oce.election_id = election_id and 
    oce.polling_station_id = polling_station_id and oce.list_id = activity_id 
                and oce.organization_id = orgid;*/
    select 'success' as response;
                
   else
    /*insert record if doesnt*/
    insert into psm.open_close_election(organization_id,polling_station_id, election_id,list_id,iscompleted ) 
    select orgid,polling_station_id, pse.election_id,activity_id,status 
                from psm.polling_station_election pse
                inner join election e on pse.election_id = e.id
                where pse.polling_station_id = polling_station_id and pse.organization_id = orgid
                and date(e.election_date_start)=date(current_date);
                /*values(orgid,polling_station_id,election_id, activity_id,status);*/
    select 'success' as response;
                
            end if;

        else
   select   'denied' as response;
        end if;
    else
  select 'unauthorized' as response;
    end if;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateprogress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateprogress`(in token varchar(255),in electionid int,in pollingstationid int,
in ballotpapers int, in postalpacks int, in postalpackscollected int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
            
		insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected)
		values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected);
        
		select 
		SUM(es.ballotpaper) as ballotpapers, 
		SUM(es.postalpack) as postalpacks, 
		sum(es.postalpack_collected) as postalpackscollected,
		'success' as response
		from psm.election_stats es 
		where es.organization_id = orgid and es.electionid = electionid and es.polling_station_id = pollingstationid
		group by es.electionid, es.polling_station_id, es.organization_id;
  
	else
		select null as ballotpapers, null as postalpacks, null as postalpackscollected,  'unauthorized' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateprogress_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateprogress_v2`(in token varchar(255),in electionid int,in pollingstationid int,
in ballotpapers int, in postalpacks int, in postalpackscollected int,
in spoiltballots int,in tenballotpapers int,in tenspoiltballots int,in updatetime int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare eid int(11);
    declare BPAIdentifier int(11);
    declare ballotstartnum int(11);
    declare ballotendnum int(11);
    declare tot_ballotpapers int(11);
    declare tenderedstartnum int(11);
    declare tenderedendnum int(11);
    declare tot_tenderedpapers int(11);
    declare currentballotnum int(11);
    declare currenttenderednum int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
    select BPA_identifier into BPAIdentifier from psm.election where id=electionid;
    
    SELECT ballotstart into ballotstartnum
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT ballotend into ballotendnum 
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT tenderstart into tenderedstartnum
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT tenderend into tenderedendnum 
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
	if (security.fn_validate_token(token)=1) then
		if (BPAIdentifier=0) then
			if(select exists 
				(					
					SELECT * FROM psm.election_stats es where (HOUR(es.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(es.updatedon)) 
				and es.organization_id=orgid and es.electionid=electionid and es.polling_station_id=pollingstationid
                    ) 
            ) then
                /*update status if record exists */
                update psm.election_stats est 
                set est.ballotpaper = ballotpapers, est.postalpack = postalpacks, est.postalpack_collected = postalpackscollected, est.spoilt_ballot = spoiltballots, est.ten_ballot_papers = tenballotpapers, est.ten_spoilt_ballots = tenspoiltballots
                where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
                and (HOUR(est.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(est.updatedon));
				
				select 'success' as response;
                
			else
				insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon)
				values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'));
	  
				select 'success' as response;
                
            end if;
		elseif (BPAIdentifier=1) then
        
				SELECT ifnull(sum(ballotpaper),0) into tot_ballotpapers FROM psm.election_stats election_stats
				where election_stats.electionid=electionid and election_stats.polling_station_id=pollingstationid and election_stats.organization_id=orgid
                and UNIX_TIMESTAMP(election_stats.updatedon) > UNIX_TIMESTAMP(CURDATE());
				
				SELECT ifnull(sum(ten_ballot_papers),0) into tot_tenderedpapers FROM psm.election_stats election_stats 
				where election_stats.electionid=electionid and election_stats.polling_station_id=pollingstationid and election_stats.organization_id=orgid
                and UNIX_TIMESTAMP(election_stats.updatedon) > UNIX_TIMESTAMP(CURDATE());
                
			if(select exists 
				(					
					SELECT * FROM psm.election_stats es where (HOUR(es.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(es.updatedon)) 
				and es.organization_id=orgid and es.electionid=electionid and es.polling_station_id=pollingstationid
					) 
			) then
				/*update status if record exists */
				
				/*SELECT es.ballotpaper into currentballotnum FROM psm.election_stats es where (HOUR(es.updatedon) = DATE(es.updatedon)) 
				and es.organization_id=orgid and es.electionid=electionid and es.polling_station_id=pollingstationid;
                
				SELECT es.ten_ballot_papers into currenttenderednum FROM psm.election_stats es where (HOUR(es.updatedon) = DATE(es.updatedon)) 
				and es.organization_id=orgid and es.electionid=electionid and es.polling_station_id=pollingstationid;*/
                
                SELECT ballotpaper into currentballotnum FROM psm.election_stats es where (HOUR(es.updatedon) = updatetime) 
				and es.organization_id=orgid and es.electionid=electionid and es.polling_station_id=pollingstationid;
                
				SELECT ten_ballot_papers into currenttenderednum FROM psm.election_stats es where (HOUR(es.updatedon) = updatetime) 
                and es.organization_id=orgid and es.electionid=electionid and es.polling_station_id=pollingstationid;


				if(((tot_ballotpapers-currentballotnum)+(ballotstartnum+ballotpapers))<=(ballotendnum)) then
				
					if(((tot_tenderedpapers-currenttenderednum)+(tenderedstartnum+tenballotpapers))<=(tenderedendnum)) then
					
						update psm.election_stats est 
						set est.ballotpaper = ballotpapers, est.postalpack = postalpacks, est.postalpack_collected = postalpackscollected, est.spoilt_ballot = spoiltballots, est.ten_ballot_papers = tenballotpapers, est.ten_spoilt_ballots = tenspoiltballots
						where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
						and (HOUR(est.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(est.updatedon));
						
						select 'success' as response;
					else
						select 'invalidtenderedpapercount' as response;
					end if;
				else
					select 'invalidballotpapercount' as response;
				end if;
				
			else
			
				if((ballotstartnum+ballotpapers+tot_ballotpapers)<=(ballotendnum)) then
				
					if((tenderedstartnum+tenballotpapers+tot_tenderedpapers)<=(tenderedendnum)) then
					
						insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon)
						values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'));
			  
						select 'success' as response;
					else
						select 'invalidtenderedpapercount' as response;
					end if;
				else
					select 'invalidballotpapercount' as response;
				end if;
			end if;
		end if;
	else
		select 'unauthorized' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateprogress_v3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateprogress_v3`(in token varchar(255),in electionid int,in pollingstationid int,
in ballotpapers int, in postalpacks int, in postalpackscollected int,
in spoiltballots int,in tenballotpapers int,in tenspoiltballots int,in updatetime int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare eid int(11);
    declare BPAIdentifier int(11);
    declare ballotstartnum int(11);
    declare ballotendnum int(11);
    declare tot_ballotpapers int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress_v3';
    
    select id into orgid from subscription.organization where code=orgcode;
    select BPA_identifier into BPAIdentifier from psm.election where id=electionid;
    
    SELECT ballotstart into ballotstartnum
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT ballotend into ballotendnum 
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
	if (security.fn_validate_token(token)=1) then
			if(select exists 
				(					
					SELECT * FROM psm.election_stats es where (HOUR(es.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(es.updatedon)) 
				and es.organization_id=orgid and es.electionid=electionid and es.polling_station_id=pollingstationid
					) 
			) then
				/*update status if record exists */
				
				SELECT SUM(ballotpaper) into tot_ballotpapers FROM psm.election_stats election_stats
				where election_stats.electionid=electionid and election_stats.polling_station_id=pollingstationid and election_stats.organization_id=orgid
                and UNIX_TIMESTAMP(election_stats.updatedon) > UNIX_TIMESTAMP(CURDATE());
				
				#start
					#select (ballotstartnum+ballotpapers+tot_ballotpapers) as response;
				#end
				
				if((ballotstartnum+ballotpapers+tot_ballotpapers)<=(ballotendnum)) then
				
					update psm.election_stats est 
					set est.ballotpaper = ballotpapers, est.postalpack = postalpacks, est.postalpack_collected = postalpackscollected, est.spoilt_ballot = spoiltballots, est.ten_ballot_papers = tenballotpapers, est.ten_spoilt_ballots = tenspoiltballots
					where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
					and (HOUR(est.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(est.updatedon));
					
					select 'success' as response;
				else
					select 'invalid ballot paper count' as response;
				end if;
				
			else
				#start
					#select (ballotendnum) as response;
				#end
				if((ballotstartnum+ballotpapers)<=(ballotendnum)) then
					insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon)
					values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'));
		  
					select 'success' as response;
				
				else
					select 'invalid ballot paper count' as response;
				end if;
			end if;
	else
		select 'unauthorized' as response;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatetrack` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updatetrack`(in token varchar(255), in longtitude varchar(45) ,in latitude varchar(45) )
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
    
		  update psm.tracking as t
		  inner join psm.user_election ue on t.election_id = ue.election_id and t.pollingstationid = ue.pollingstation_id and ue.organization_id = t.organization_id 
		  inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
          inner join election e on ue.election_id = e.id
		  set latitude= latitude,longtitude=longtitude
		  where u.organization_id = orgid
          and u.username= username and  date(e.election_date_start)=date(current_date);
        
        
        select "success" as response;
    else
		select "unauthorized" as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `validate_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `validate_token`(in token varchar(255))
BEGIN
    if (security.fn_validate_token(token)=1) then
		select 1 as response;
    else
		select 0 as response;
	end if;
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

-- Dump completed on 2016-04-01 15:14:29
CREATE DATABASE  IF NOT EXISTS `security` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `security`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: ec2-52-48-101-197.eu-west-1.compute.amazonaws.com    Database: security
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

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
-- Table structure for table `access_token`
--

DROP TABLE IF EXISTS `access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `token` varchar(100) NOT NULL,
  `fromdate` datetime NOT NULL,
  `todate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accto_fk1_idx` (`organization_id`),
  KEY `accto_fk2_idx` (`userid`),
  KEY `accto_token_idx` (`token`),
  CONSTRAINT `accto_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `accto_fk2` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_token`
--

LOCK TABLES `access_token` WRITE;
/*!40000 ALTER TABLE `access_token` DISABLE KEYS */;
INSERT INTO `access_token` VALUES (69,2,2,'admin|DERRY|a0dccf4df1f2fb6b395b3576194e2cd6','2016-02-10 01:28:52','2016-02-11 01:28:52'),(74,2,2,'admin|Derry|1881f7d1afb1a93cd6748fe2b99fecd1','2016-02-11 04:03:26','2016-02-12 04:03:26'),(85,2,2,'Admin|Derry|cb7ecc20e93bae546b63db6179e61661','2016-02-12 09:52:18','2016-02-13 09:52:18'),(93,2,2,'admin|DERRY|6275766838e02c26a01098df10efe0a0','2016-02-14 05:01:00','2016-02-15 05:01:00'),(97,2,2,'Admin|Derry|5b4d12d493e6b1fa32e3ccb72a68f281','2016-02-15 09:48:49','2016-02-16 09:48:49'),(105,6,76,'mbloxham|Amersham|95123fef931c00b7f5d79b9221fdf543','2016-02-16 12:00:45','2016-02-17 12:00:45'),(107,6,73,'apercival|Amersham|2ec1ea1c379e031fd1bb9c680a07899d','2016-02-16 12:16:40','2016-02-17 12:16:40'),(108,6,77,'lblue|Amersham|0760b2acba9615c980fb745eb667a9ba','2016-02-16 12:27:36','2016-02-17 12:27:36'),(109,2,2,'admin|derry|b2b9ff58decda2dee4baa38a364be3c1','2016-02-17 06:05:39','2016-02-18 06:05:39'),(112,6,73,'apercival|Amersham|f73f0ae99274320a3756e3d7479bbac6','2016-02-17 12:25:02','2016-02-18 12:25:02'),(113,6,77,'Lblue|Amersham|4fdc0e32b9f9a556e84dd40672a89c7c','2016-02-17 13:58:22','2016-02-18 13:58:22'),(114,6,78,'mdluser|Amersham|b1086567e3a8b84139f457ffe40b4c57','2016-02-17 15:08:58','2016-02-18 15:08:58'),(115,6,76,'mbloxham|Amersham|f9c80bf9950383d6f5bf73a6e6313a3e','2016-02-17 15:49:52','2016-02-18 15:49:52'),(116,6,73,'apercival|Amersham|e154b44f93097a87a48bf0da1a3bdf07','2016-02-18 12:25:23','2016-02-19 12:25:23'),(117,6,77,'lblue|Amersham|d85a3d39bf34894a23806da0e64d8d77','2016-02-18 13:59:37','2016-02-19 13:59:37'),(118,6,78,'MDLuser|Amersham|c3596f5b6d3ad7fd530dd2f88dff285e','2016-02-18 15:45:27','2016-02-19 15:45:27'),(119,6,76,'mbloxham|amersham|330ef9741ccd072f4842ae88324c9c0e','2016-02-18 15:50:18','2016-02-19 15:50:18'),(120,2,2,'Admin|Derry|a645ef4abdc657c131d4df02affb9e6c','2016-02-22 14:10:16','2016-02-23 14:10:16'),(121,6,78,'mdluser|Amersham|b1d65d67354204fc1be21797d053e332','2016-02-22 14:14:02','2016-02-23 14:14:02'),(122,6,73,'apercival|Amersham|c40b1e84d66cafc90e2a7f4f5e85350d','2016-02-22 15:55:05','2016-02-23 15:55:05'),(123,6,78,'mdluser|Amersham|2e5d5844ee642438ae963422c5e21e73','2016-02-24 10:33:22','2016-02-25 10:33:22'),(127,6,73,'apercival|Amersham|9ed927e0deefaa4e4782a3390f3c2124','2016-02-24 12:55:19','2016-02-25 12:55:19'),(129,9,83,'mdluser1|MDL|24d7d9b2bfa24c1107562dec27a19d50','2016-02-25 07:18:40','2016-02-26 07:18:40'),(130,9,83,'mdluser1|MDL|19843e60bf6acfbea909855c5f6e2951','2016-02-26 08:11:22','2016-02-27 08:11:22'),(131,9,84,'mdluser2|MDL|88afb06810f1300b20566920c201f81c','2016-02-26 16:48:18','2016-02-27 16:48:18'),(132,9,85,'mdluser3|MDL|a120f5f66c7fc0012054a33c4af0da83','2016-02-27 11:16:23','2016-02-28 11:16:23'),(133,9,83,'mdluser1|MDL|d6832d881cef4e1b22c3ff5c94cbb1d3','2016-02-27 14:15:49','2016-02-28 14:15:49'),(134,9,84,'mdluser2|MDL|ded8a33058d723b39318686e2096b4b0','2016-02-28 03:50:36','2016-02-29 03:50:36'),(135,9,83,'MDLuser1|MDL|7f98f06757c407df4d6d5e551c92563d','2016-02-28 15:08:45','2016-02-29 15:08:45'),(136,6,76,'mbloxham|Amersham|0c018b547c4baae0c4e000ff0abdcf74','2016-02-28 15:35:36','2016-02-29 15:35:36'),(137,9,84,'mdluser2|MDL|4e4fbb4d8d1810690b97a4cb2daf44de','2016-02-29 05:01:48','2016-03-01 05:01:48'),(138,9,85,'mdluser3|MDL|cf0bb0ff8487288df74839dccf5f1ca3','2016-02-29 08:06:29','2016-03-01 08:06:29'),(139,9,83,'mdluser1|mdl|f172d47a127f39aa76f012b551efc6f4','2016-02-29 15:11:15','2016-03-01 15:11:15'),(140,2,2,'Admin|Derry|8636b2e5efcb20867132502d46cd97e5','2016-02-29 16:55:49','2016-03-01 16:55:49'),(141,9,84,'mdluser2|MDL|ce7e1caf08b850c048418313a9df9dc7','2016-03-01 08:53:02','2016-03-02 08:53:02'),(142,9,83,'mdluser1|mdl|4e372902ef2dd293dc37ee74cc98ee3f','2016-03-01 15:33:29','2016-03-02 15:33:29'),(143,9,85,'mdluser3|MDL|62bc7469323126fafea5bbdfd7cf281f','2016-03-01 17:01:46','2016-03-02 17:01:46'),(144,9,84,'Mdluser2|MDL|f46b2178af1874d22ba35730d88595cc','2016-03-02 09:30:32','2016-03-03 09:30:32'),(145,2,2,'admin|Derry|c5c770e8c62c058489513ff289ebb3f5','2016-03-03 14:06:10','2016-03-04 14:06:10'),(146,2,2,'admin|derry|73df75042cc32e20228dcfccd129f688','2016-03-04 14:07:33','2016-03-05 14:07:33'),(147,2,2,'admin|DERRY|19f0917c09d810ec749b85cfde8976c7','2016-03-07 11:51:55','2016-03-08 11:51:55'),(148,9,83,'mdluser1|MDL|9762724d3c04361dd15e317f9d31fcdf','2016-03-09 10:25:32','2016-03-10 10:25:32'),(149,2,2,'admin|derry|d5505b95a2824c2d193acd3e11aa5c41','2016-03-09 10:30:06','2016-03-10 10:30:06'),(150,6,73,'apercival|Amersham|7106b3ccc79b1274905e3d4178694ce4','2016-03-11 18:04:26','2016-03-12 18:04:26'),(151,2,2,'admin|Derry|fae68d353b7659a01752892f84fd06d7','2016-03-15 15:48:48','2016-03-16 15:48:48'),(152,2,2,'admin|Derry|6bb648ea0e99763de5140dca03fee259','2016-03-18 10:07:13','2016-03-19 10:07:13'),(153,9,84,'mdluser2|MDL|514aa5bc5509b3b7adbe247f9ff40de4','2016-03-18 19:15:50','2016-03-19 19:15:50'),(154,10,86,'adm|mit|c89acbb77619708cf91ffd77bc6214b0','2016-03-18 19:37:33','2016-03-19 19:37:33'),(155,9,83,'mdluser1|MDL|64d28011503fa10078709a1d016e4ac4','2016-03-18 19:48:40','2016-03-19 19:48:40'),(156,10,90,'mcd|mit|2e4c8be5343e45e18dd4ea93e8706fce','2016-03-18 19:50:25','2016-03-19 19:50:25'),(165,12,102,'administrator|Mitra|224af07bbad1d3714d3c2e251fa4bf71','2016-03-22 11:54:19','2016-03-23 11:54:19'),(166,12,103,'bruce|Mitra|419d6c193830d19217e214ff24bf6381','2016-03-22 12:04:51','2016-03-23 12:04:51'),(167,12,105,'gow|mitra|38621b95aa21487ab6d7293982f71ec5','2016-03-22 12:09:18','2016-03-23 12:09:18'),(168,12,104,'Forbes|Mitra|02cd669c87b14ad19d5139764bddd500','2016-03-22 15:52:52','2016-03-23 15:52:52'),(169,12,107,'Twine|Mitra|a9e1953edabc63e297cdab8c46ce755f','2016-03-23 07:08:27','2016-03-24 07:08:27'),(170,12,106,'McDonald|Mitra|cfa587bf06ef7ddf0ea3e61a482771b4','2016-03-23 10:12:56','2016-03-24 10:12:56'),(171,12,110,'Pace|Mitra|3c929d88bbd0f4499c7b04a58037ae94','2016-03-23 11:03:18','2016-03-24 11:03:18'),(172,12,102,'administrator|mitra|0c27335b92f282ebc7cb7a0d25d42da8','2016-03-23 12:03:26','2016-03-24 12:03:26'),(173,12,103,'Bruce|mitra|0fddab719b3dfd60ac7ab660debe2827','2016-03-23 12:08:51','2016-03-24 12:08:51'),(174,12,104,'Forbes|mitra|dce97d7852ce0cdf9f5d224d5ff282d6','2016-03-24 04:40:03','2016-03-25 04:40:03'),(175,12,105,'Gow|Mitra|723ffbf860eedcfd90980595d1caa849','2016-03-24 05:51:04','2016-03-25 05:51:04'),(176,12,107,'Twine|Mitra|57d41ee44e156e1d8baf78626b8d6f65','2016-03-24 07:21:18','2016-03-25 07:21:18'),(177,12,106,'McDonald|Mitra|6dfab0d9a6d2626675e298b7472d15dd','2016-03-24 11:10:47','2016-03-25 11:10:47'),(178,12,102,'administrator|mitra|07fe93706325fff837cf298643785c1f','2016-03-24 12:10:02','2016-03-25 12:10:02'),(179,12,103,'bruce|Mitra|54b1949c53da2d320cc4c4725b3836d1','2016-03-24 13:51:11','2016-03-25 13:51:11'),(180,12,105,'GOW|mitra|52a47607af9c44a2ff21dc709255271f','2016-03-25 06:02:51','2016-03-26 06:02:51'),(181,12,106,'McDonald|Mitra|5f0781912df4d936fe6c2dce61acc1e7','2016-03-25 11:19:56','2016-03-26 11:19:56'),(182,12,102,'administrator|Mitra|239071e88bd12b70c1795a72afaac591','2016-03-25 12:23:52','2016-03-26 12:23:52'),(183,12,107,'Twine|Mitra|078e575c0d7c16011b2af41bd8c6a06b','2016-03-25 13:32:29','2016-03-26 13:32:29'),(184,12,102,'administrator|Mitra|7a8c38eaf3cc2b2f0e7579e9db7c71e5','2016-03-27 06:17:10','2016-03-28 06:17:10'),(185,12,103,'bruce|mitra|e34d9f5ddbb8c36e147f103e8f1afc8a','2016-03-28 04:10:16','2016-03-29 04:10:16'),(186,12,105,'GOW|mitra|2a378c16006b9f2482094e60f5370919','2016-03-28 05:25:39','2016-03-29 05:25:39'),(187,12,102,'administrator|mitra|6218992345d236179ee1815274603713','2016-03-28 08:09:19','2016-03-29 08:09:19'),(188,12,107,'Twine|Mitra|551fa1ea47377aea0b99d863319f58ad','2016-03-28 11:26:55','2016-03-29 11:26:55'),(189,12,103,'bruce|mitra|28244b9c4092387dee8f4dde91e3c5fb','2016-03-29 04:21:17','2016-03-30 04:21:17'),(190,12,105,'Gow|Mitra|647b2ebc1323b10c7f49b84a3d0278c2','2016-03-29 06:55:14','2016-03-30 06:55:14'),(191,12,102,'administrator|mitra|55d3ea1ef8ed3f5a4f2ba9d31f639602','2016-03-29 08:21:04','2016-03-30 08:21:04'),(192,12,107,'Twine|Mitra|4a7832b672c92022a9e7f24d9b8b4376','2016-03-30 04:03:44','2016-03-31 04:03:44'),(193,12,103,'bruce|mitra|c1cdf9493df2cc5811b9b6d1ac761511','2016-03-30 04:46:45','2016-03-31 04:46:45'),(194,12,102,'administrator|mitra|9890123fff479b0544dd43bc588dcca3','2016-03-30 08:43:31','2016-03-31 08:43:31'),(195,12,106,'McDonald|Mitra|eae2192f45dc7e23dc3d7fd48f450b44','2016-03-30 10:36:53','2016-03-31 10:36:53'),(196,12,105,'Gow|Mitra|18bf5797444134a9d95a51e256fbd8c2','2016-03-31 10:19:24','2016-04-01 10:19:24'),(197,12,102,'Administrator|Mitra|f7f4481c95a872c468e910c5f00e8b5b','2016-03-31 10:19:53','2016-04-01 10:19:53'),(198,12,103,'bruce|mitra|10b5bf9c6fa1c88fb10366d1200cf7c1','2016-03-31 10:37:27','2016-04-01 10:37:27'),(199,12,107,'Twine|Mitra|507f3258951b9ba64f883305b6ff881f','2016-03-31 10:52:23','2016-04-01 10:52:23'),(200,12,106,'McDonald|Mitra|c06140ad270dfa085bbe8e4d544fe753','2016-03-31 11:01:01','2016-04-01 11:01:01'),(201,13,121,'admin|sliit|81d3a8ce960f416ef7d39723ad254cbc','2016-03-31 17:29:01','2016-04-01 17:29:01'),(202,14,123,'admin|sliit2|48ff4b56d0e44285e984660e88696834','2016-03-31 21:47:24','2016-04-01 21:47:24'),(203,15,125,'admin|org_2|1ebbd8a506ca97139aa6bead44c41f9d','2016-04-01 05:21:54','2016-04-02 05:21:54'),(204,16,126,'Administrator3|Mitra3|b8c9fee8fa9ecb81a2ffc892b6b7871e','2016-04-01 06:34:48','2016-04-02 06:34:48'),(205,16,128,'star|mitra3|2f99770ad49a52a786edd1c69d6969a3','2016-04-01 06:47:51','2016-04-02 06:47:51'),(206,17,127,'Administrator4|Mitra4|897a599f84be12075be9943dbb807950','2016-04-01 07:30:17','2016-04-02 07:30:17');
/*!40000 ALTER TABLE `access_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedon` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organization_fk_idx` (`organization_id`),
  CONSTRAINT `organization_fk` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,2,'super admin','super admin role','2016-01-13 04:18:18',NULL),(2,3,'admin','Election Manager','2016-01-21 14:02:10',NULL),(3,4,'manager','manager role','2016-01-21 14:02:11',NULL),(4,2,'Manager','Manager Role for overall management','2016-01-13 04:18:18','2016-01-29 07:44:56'),(5,2,'Counter','Counter Role','2016-01-28 03:57:07',NULL),(6,2,'Staff Officer','staff oficcer role','2016-01-28 04:00:55',NULL),(7,2,'Ballot Manager','ballot manager role','2016-01-28 04:02:44',NULL),(8,2,'Facility Manager','Facilitry manager role for the building','2016-01-28 04:04:07','2016-01-29 07:45:23'),(9,2,'Security Manager','sec manager','2016-01-28 04:06:10',NULL),(10,2,'Vehicle Manager','manages the vehicles','2016-01-28 04:09:07',NULL),(11,2,'Pacifier','pacifier role','2016-01-28 04:11:09',NULL),(12,2,'Presiding Officer','presiding officer role','2016-01-28 07:43:22',NULL),(13,2,'Election Officer','election officer','2016-01-28 08:03:39',NULL),(14,5,'Presiding Officer','Presiding Officer','2016-02-02 15:36:22',NULL),(15,2,'Brain','PSMM','2016-02-03 10:32:02','2016-02-03 10:32:22'),(16,6,'Presiding Officer','Presiding Officer','2016-02-05 10:02:37',NULL),(17,6,'Issue Resolver','Issue Resolver','2016-02-05 10:03:01',NULL),(18,6,'Election Manager','Election Manager','2016-02-05 10:03:22',NULL),(19,7,'Presiding Officer','Presiding Officer','2016-02-05 10:02:37',NULL),(20,7,'Issue Resolver','Issue Resolver','2016-02-05 10:03:01',NULL),(21,7,'Election Manager','Election Manager','2016-02-05 10:03:22',NULL),(22,8,'Presiding Officer','Presiding Officer','2016-02-05 10:02:37',NULL),(23,8,'Issue Resolver','Issue Resolver','2016-02-05 10:03:01',NULL),(24,8,'Election Manager','Election Manager','2016-02-05 10:03:22',NULL),(25,9,'EM','Election Manager','2016-02-05 10:03:22',NULL),(26,9,'PSM','Presiding Officer','2016-02-05 10:03:22',NULL),(27,10,'Election Manager','Election Manager','2016-03-18 19:37:17',NULL),(28,10,'Presiding Officer','Presiding Officer','2016-03-18 19:37:17',NULL),(29,10,'Super Presiding Officer','Super Presiding Officer','2016-03-18 19:37:17',NULL),(30,10,'Issue Resolver','Issue Resolver','2016-03-18 19:37:17',NULL),(31,10,'Polling Station Inspector','Polling Station Inspector','2016-03-18 19:37:17',NULL),(38,12,'Presiding Officer','Presiding Officer','2016-03-22 11:53:17',NULL),(39,12,'Super Presiding Officer','Super Presiding Officer','2016-03-22 11:53:17',NULL),(40,12,'Issue Resolver','Issue Resolver','2016-03-22 11:53:17',NULL),(41,12,'Polling Station Inspector','Polling Station Inspector','2016-03-22 11:53:17',NULL),(42,12,'shai','super','2016-03-24 10:57:28',NULL),(46,12,'1234','numbers add for role name','2016-03-29 11:28:04',NULL),(50,12,'change user 1','cccc','2016-03-29 11:53:31','2016-03-29 16:41:20'),(53,12,'Poll Station Inspector','POi18','2016-03-30 11:12:15','2016-03-30 12:29:33'),(54,13,'Election Manager','Election Manager','2016-03-31 17:25:30',NULL),(55,13,'Presiding Officer','Presiding Officer','2016-03-31 17:25:30',NULL),(56,13,'Super Presiding Officer','Super Presiding Officer','2016-03-31 17:25:30',NULL),(57,13,'Issue Resolver','Issue Resolver','2016-03-31 17:25:30',NULL),(58,13,'Polling Station Inspector','Polling Station Inspector','2016-03-31 17:25:30',NULL),(59,14,'Election Manager','Election Manager','2016-03-31 21:46:35',NULL),(60,14,'Presiding Officer','Presiding Officer','2016-03-31 21:46:35',NULL),(61,14,'Super Presiding Officer','Super Presiding Officer','2016-03-31 21:46:35',NULL),(62,14,'Issue Resolver','Issue Resolver','2016-03-31 21:46:35',NULL),(63,14,'Polling Station Inspector','Polling Station Inspector','2016-03-31 21:46:35',NULL),(64,15,'Election Manager','Election Manager','2016-04-01 05:21:08',NULL),(65,15,'Presiding Officer','Presiding Officer','2016-04-01 05:21:08',NULL),(66,15,'Super Presiding Officer','Super Presiding Officer','2016-04-01 05:21:08',NULL),(67,15,'Issue Resolver','Issue Resolver','2016-04-01 05:21:08',NULL),(68,15,'Polling Station Inspector','Polling Station Inspector','2016-04-01 05:21:08',NULL),(69,16,'Election Manager','Election Manager','2016-04-01 06:34:14',NULL),(70,16,'Presiding Officer','Presiding Officer','2016-04-01 06:34:14',NULL),(71,16,'Super Presiding Officer','Super Presiding Officer','2016-04-01 06:34:14',NULL),(72,16,'Issue Resolver','Issue Resolver','2016-04-01 06:34:14',NULL),(73,16,'Polling Station Inspector','Polling Station Inspector','2016-04-01 06:34:14',NULL),(74,17,'Election Manager','Election Manager','2016-04-01 06:40:34',NULL),(75,17,'Presiding Officer','Presiding Officer','2016-04-01 06:40:34',NULL),(76,17,'Super Presiding Officer','Super Presiding Officer','2016-04-01 06:40:34',NULL),(77,17,'Issue Resolver','Issue Resolver','2016-04-01 06:40:34',NULL),(78,17,'Polling Station Inspector','Polling Station Inspector','2016-04-01 06:40:34',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_per_fk1_idx` (`role_id`),
  KEY `role_per_fk2_idx` (`permission_id`),
  KEY `role_per_fk3_idx` (`organization_id`),
  CONSTRAINT `role_per_fk1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `role_per_fk2` FOREIGN KEY (`permission_id`) REFERENCES `subscription`.`permission` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `role_per_fk3` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1824 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,2,1,1),(2,2,1,2),(3,2,1,3),(4,2,1,4),(5,2,1,5),(6,2,1,6),(7,2,1,7),(8,2,1,8),(9,2,1,9),(10,2,1,10),(11,2,1,11),(12,2,1,12),(13,2,1,13),(14,2,1,14),(15,2,1,15),(16,2,1,16),(17,2,1,17),(18,2,1,18),(19,2,1,19),(20,2,1,20),(21,2,1,21),(22,2,1,22),(23,3,2,1),(24,3,2,2),(25,3,2,3),(26,3,2,4),(27,3,2,5),(28,3,2,6),(29,3,2,7),(30,3,2,8),(31,3,2,9),(32,3,2,10),(33,3,2,11),(34,3,2,12),(35,3,2,13),(36,3,2,14),(37,3,2,15),(38,3,2,16),(39,3,2,17),(40,3,2,18),(41,3,2,19),(42,3,2,20),(43,3,2,21),(44,3,2,22),(54,4,3,1),(55,4,3,2),(56,4,3,3),(57,4,3,4),(58,4,3,5),(59,4,3,6),(60,4,3,7),(61,4,3,8),(62,4,3,9),(63,4,3,10),(64,4,3,11),(65,4,3,12),(66,4,3,13),(67,4,3,14),(68,4,3,15),(69,4,3,16),(70,4,3,17),(71,4,3,18),(72,4,3,19),(73,4,3,20),(74,4,3,21),(75,4,3,22),(76,2,1,23),(77,2,1,24),(78,2,1,25),(79,2,1,26),(80,2,1,27),(81,3,2,25),(82,3,2,26),(83,3,2,27),(84,3,2,4),(85,3,1,24),(86,3,2,24),(87,5,14,1),(88,5,14,2),(89,5,14,3),(90,5,14,4),(91,5,14,5),(92,5,14,6),(93,5,14,7),(94,5,14,8),(95,5,14,9),(96,5,14,10),(97,5,14,11),(98,5,14,12),(99,5,14,13),(100,5,14,14),(101,5,14,15),(102,5,14,16),(103,5,14,17),(104,5,14,18),(105,5,14,19),(106,5,14,20),(107,5,14,21),(108,5,14,22),(109,5,14,23),(110,5,14,24),(111,5,14,25),(112,5,14,26),(113,5,14,27),(118,2,1,28),(119,2,1,29),(120,2,1,30),(121,2,1,31),(215,2,1,32),(216,7,19,1),(217,7,19,2),(218,7,19,3),(219,7,19,4),(220,7,19,5),(221,7,19,6),(222,7,19,7),(223,7,19,8),(224,7,19,9),(225,7,19,10),(226,7,19,11),(227,7,19,12),(228,7,19,13),(229,7,19,14),(230,7,19,15),(231,7,19,16),(232,7,19,17),(233,7,19,18),(234,7,19,19),(235,7,19,20),(236,7,19,21),(237,7,19,22),(238,7,19,23),(239,7,19,24),(240,7,19,25),(241,7,19,26),(242,7,19,27),(243,7,19,28),(244,7,19,29),(245,7,19,30),(246,7,19,31),(247,7,19,32),(279,7,20,1),(280,7,20,2),(281,7,20,3),(282,7,20,4),(283,7,20,5),(284,7,20,6),(285,7,20,7),(286,7,20,8),(287,7,20,9),(288,7,20,10),(289,7,20,11),(290,7,20,12),(291,7,20,13),(292,7,20,14),(293,7,20,15),(294,7,20,16),(295,7,20,17),(296,7,20,18),(297,7,20,19),(298,7,20,20),(299,7,20,21),(300,7,20,22),(301,7,20,23),(302,7,20,24),(303,7,20,25),(304,7,20,26),(305,7,20,27),(306,7,20,28),(307,7,20,29),(308,7,20,30),(309,7,20,31),(310,7,20,32),(342,7,21,1),(343,7,21,2),(344,7,21,3),(345,7,21,4),(346,7,21,5),(347,7,21,6),(348,7,21,7),(349,7,21,8),(350,7,21,9),(351,7,21,10),(352,7,21,11),(353,7,21,12),(354,7,21,13),(355,7,21,14),(356,7,21,15),(357,7,21,16),(358,7,21,17),(359,7,21,18),(360,7,21,19),(361,7,21,20),(362,7,21,21),(363,7,21,22),(364,7,21,23),(365,7,21,24),(366,7,21,25),(367,7,21,26),(368,7,21,27),(369,7,21,28),(370,7,21,29),(371,7,21,30),(372,7,21,31),(373,7,21,32),(405,8,22,1),(406,8,22,2),(407,8,22,3),(408,8,22,4),(409,8,22,5),(410,8,22,6),(411,8,22,7),(412,8,22,8),(413,8,22,9),(414,8,22,10),(415,8,22,11),(416,8,22,12),(417,8,22,13),(418,8,22,14),(419,8,22,15),(420,8,22,16),(421,8,22,17),(422,8,22,18),(423,8,22,19),(424,8,22,20),(425,8,22,21),(426,8,22,22),(427,8,22,23),(428,8,22,24),(429,8,22,25),(430,8,22,26),(431,8,22,27),(432,8,22,28),(433,8,22,29),(434,8,22,30),(435,8,22,31),(436,8,22,32),(468,8,23,1),(469,8,23,2),(470,8,23,3),(471,8,23,4),(472,8,23,5),(473,8,23,6),(474,8,23,7),(475,8,23,8),(476,8,23,9),(477,8,23,10),(478,8,23,11),(479,8,23,12),(480,8,23,13),(481,8,23,14),(482,8,23,15),(483,8,23,16),(484,8,23,17),(485,8,23,18),(486,8,23,19),(487,8,23,20),(488,8,23,21),(489,8,23,22),(490,8,23,23),(491,8,23,24),(492,8,23,25),(493,8,23,26),(494,8,23,27),(495,8,23,28),(496,8,23,29),(497,8,23,30),(498,8,23,31),(499,8,23,32),(531,8,24,1),(532,8,24,2),(533,8,24,3),(534,8,24,4),(535,8,24,5),(536,8,24,6),(537,8,24,7),(538,8,24,8),(539,8,24,9),(540,8,24,10),(541,8,24,11),(542,8,24,12),(543,8,24,13),(544,8,24,14),(545,8,24,15),(546,8,24,16),(547,8,24,17),(548,8,24,18),(549,8,24,19),(550,8,24,20),(551,8,24,21),(552,8,24,22),(553,8,24,23),(554,8,24,24),(555,8,24,25),(556,8,24,26),(557,8,24,27),(558,8,24,28),(559,8,24,29),(560,8,24,30),(561,8,24,31),(562,8,24,32),(594,6,16,1),(595,6,16,2),(596,6,16,3),(597,6,16,4),(598,6,16,5),(599,6,16,6),(600,6,16,7),(601,6,16,8),(602,6,16,9),(603,6,16,10),(604,6,16,11),(605,6,16,12),(606,6,16,13),(607,6,16,14),(608,6,16,15),(609,6,16,16),(610,6,16,17),(611,6,16,18),(612,6,16,19),(613,6,16,20),(614,6,16,21),(615,6,16,22),(616,6,16,23),(617,6,16,24),(618,6,16,25),(619,6,16,26),(620,6,16,27),(621,6,16,28),(622,6,16,29),(623,6,16,30),(624,6,16,31),(625,6,16,32),(657,6,17,1),(658,6,17,2),(659,6,17,3),(660,6,17,4),(661,6,17,5),(662,6,17,6),(663,6,17,7),(664,6,17,8),(665,6,17,9),(666,6,17,10),(667,6,17,11),(668,6,17,12),(669,6,17,13),(670,6,17,14),(671,6,17,15),(672,6,17,16),(673,6,17,17),(674,6,17,18),(675,6,17,19),(676,6,17,20),(677,6,17,21),(678,6,17,22),(679,6,17,23),(680,6,17,24),(681,6,17,25),(682,6,17,26),(683,6,17,27),(684,6,17,28),(685,6,17,29),(686,6,17,30),(687,6,17,31),(688,6,17,32),(720,6,18,1),(721,6,18,2),(722,6,18,3),(723,6,18,4),(724,6,18,5),(725,6,18,6),(726,6,18,7),(727,6,18,8),(728,6,18,9),(729,6,18,10),(730,6,18,11),(731,6,18,12),(732,6,18,13),(733,6,18,14),(734,6,18,15),(735,6,18,16),(736,6,18,17),(737,6,18,18),(738,6,18,19),(739,6,18,20),(740,6,18,21),(741,6,18,22),(742,6,18,23),(743,6,18,24),(744,6,18,25),(745,6,18,26),(746,6,18,27),(747,6,18,28),(748,6,18,29),(749,6,18,30),(750,6,18,31),(751,6,18,32),(783,9,25,1),(784,9,25,2),(785,9,25,3),(786,9,25,4),(787,9,25,5),(788,9,25,6),(789,9,25,7),(790,9,25,8),(791,9,25,9),(792,9,25,10),(793,9,25,11),(794,9,25,12),(795,9,25,13),(796,9,25,14),(797,9,25,15),(798,9,25,16),(799,9,25,17),(800,9,25,18),(801,9,25,19),(802,9,25,20),(803,9,25,21),(804,9,25,22),(805,9,25,23),(806,9,25,24),(807,9,25,25),(808,9,25,26),(809,9,25,27),(810,9,25,28),(811,9,25,29),(812,9,25,30),(813,9,25,31),(814,9,25,32),(815,9,26,1),(816,9,26,2),(817,9,26,3),(818,9,26,4),(819,9,26,5),(820,9,26,6),(821,9,26,7),(822,9,26,8),(823,9,26,9),(824,9,26,10),(825,9,26,11),(826,9,26,12),(827,9,26,13),(828,9,26,14),(829,9,26,15),(830,9,26,16),(831,9,26,17),(832,9,26,18),(833,9,26,19),(834,9,26,20),(835,9,26,21),(836,9,26,22),(837,9,26,23),(838,9,26,24),(839,9,26,25),(840,9,26,26),(841,9,26,27),(842,9,26,28),(843,9,26,29),(844,9,26,30),(845,9,26,31),(846,9,26,32),(847,10,28,1),(848,10,28,2),(849,10,28,3),(850,10,28,4),(851,10,28,5),(852,10,28,6),(853,10,28,7),(854,10,28,8),(855,10,28,9),(856,10,28,10),(857,10,28,11),(858,10,28,12),(859,10,28,13),(860,10,28,14),(861,10,28,15),(862,10,28,16),(863,10,28,17),(864,10,28,18),(865,10,28,19),(866,10,28,20),(867,10,28,21),(868,10,28,22),(869,10,28,23),(870,10,28,24),(871,10,28,25),(872,10,28,26),(873,10,28,27),(874,10,28,28),(875,10,28,29),(876,10,28,30),(877,10,28,31),(878,10,28,32),(910,10,27,1),(911,10,27,2),(912,10,27,3),(913,10,27,4),(914,10,27,5),(915,10,27,6),(916,10,27,7),(917,10,27,8),(918,10,27,9),(919,10,27,10),(920,10,27,11),(921,10,27,12),(922,10,27,13),(923,10,27,14),(924,10,27,15),(925,10,27,16),(926,10,27,17),(927,10,27,18),(928,10,27,19),(929,10,27,20),(930,10,27,21),(931,10,27,22),(932,10,27,28),(933,10,27,29),(934,10,27,30),(935,10,27,31),(936,10,27,32),(937,10,27,23),(938,10,27,24),(939,10,27,25),(940,10,27,26),(941,10,27,27),(1099,12,38,1),(1100,12,38,2),(1101,12,38,3),(1102,12,38,4),(1103,12,38,5),(1104,12,38,6),(1105,12,38,7),(1106,12,38,8),(1107,12,38,9),(1108,12,38,10),(1109,12,38,11),(1110,12,38,12),(1111,12,38,13),(1112,12,38,14),(1113,12,38,15),(1114,12,38,16),(1115,12,38,17),(1116,12,38,18),(1117,12,38,19),(1118,12,38,20),(1119,12,38,21),(1120,12,38,22),(1121,12,38,23),(1122,12,38,24),(1123,12,38,25),(1124,12,38,26),(1125,12,38,27),(1126,12,38,28),(1127,12,38,29),(1128,12,38,30),(1129,12,38,31),(1130,12,38,32),(1162,12,40,1),(1163,12,40,2),(1164,12,40,3),(1165,12,40,4),(1166,12,40,5),(1167,12,40,6),(1168,12,40,7),(1169,12,40,8),(1170,12,40,9),(1171,12,40,10),(1172,12,40,11),(1173,12,40,12),(1174,12,40,13),(1175,12,40,14),(1176,12,40,15),(1177,12,40,16),(1178,12,40,17),(1179,12,40,18),(1180,12,40,19),(1181,12,40,20),(1182,12,40,21),(1183,12,40,22),(1184,12,40,28),(1185,12,40,29),(1186,12,40,30),(1187,12,40,31),(1188,12,40,32),(1189,12,40,23),(1190,12,40,24),(1191,12,40,25),(1192,12,40,26),(1193,12,40,27),(1194,13,55,1),(1195,13,55,2),(1196,13,55,3),(1197,13,55,4),(1198,13,55,5),(1199,13,55,6),(1200,13,55,7),(1201,13,55,8),(1202,13,55,9),(1203,13,55,10),(1204,13,55,11),(1205,13,55,12),(1206,13,55,13),(1207,13,55,14),(1208,13,55,15),(1209,13,55,16),(1210,13,55,17),(1211,13,55,18),(1212,13,55,19),(1213,13,55,20),(1214,13,55,21),(1215,13,55,22),(1216,13,55,23),(1217,13,55,24),(1218,13,55,25),(1219,13,55,26),(1220,13,55,27),(1221,13,55,28),(1222,13,55,29),(1223,13,55,30),(1224,13,55,31),(1225,13,55,32),(1257,13,54,1),(1258,13,54,2),(1259,13,54,3),(1260,13,54,4),(1261,13,54,5),(1262,13,54,6),(1263,13,54,7),(1264,13,54,8),(1265,13,54,9),(1266,13,54,10),(1267,13,54,11),(1268,13,54,12),(1269,13,54,13),(1270,13,54,14),(1271,13,54,15),(1272,13,54,16),(1273,13,54,17),(1274,13,54,18),(1275,13,54,19),(1276,13,54,20),(1277,13,54,21),(1278,13,54,22),(1279,13,54,28),(1280,13,54,29),(1281,13,54,30),(1282,13,54,31),(1283,13,54,32),(1284,13,54,23),(1285,13,54,24),(1286,13,54,25),(1287,13,54,26),(1288,13,54,27),(1320,14,60,1),(1321,14,60,2),(1322,14,60,3),(1323,14,60,4),(1324,14,60,5),(1325,14,60,6),(1326,14,60,7),(1327,14,60,8),(1328,14,60,9),(1329,14,60,10),(1330,14,60,11),(1331,14,60,12),(1332,14,60,13),(1333,14,60,14),(1334,14,60,15),(1335,14,60,16),(1336,14,60,17),(1337,14,60,18),(1338,14,60,19),(1339,14,60,20),(1340,14,60,21),(1341,14,60,22),(1342,14,60,23),(1343,14,60,24),(1344,14,60,25),(1345,14,60,26),(1346,14,60,27),(1347,14,60,28),(1348,14,60,29),(1349,14,60,30),(1350,14,60,31),(1351,14,60,32),(1383,14,59,1),(1384,14,59,2),(1385,14,59,3),(1386,14,59,4),(1387,14,59,5),(1388,14,59,6),(1389,14,59,7),(1390,14,59,8),(1391,14,59,9),(1392,14,59,10),(1393,14,59,11),(1394,14,59,12),(1395,14,59,13),(1396,14,59,14),(1397,14,59,15),(1398,14,59,16),(1399,14,59,17),(1400,14,59,18),(1401,14,59,19),(1402,14,59,20),(1403,14,59,21),(1404,14,59,22),(1405,14,59,28),(1406,14,59,29),(1407,14,59,30),(1408,14,59,31),(1409,14,59,32),(1410,14,59,23),(1411,14,59,24),(1412,14,59,25),(1413,14,59,26),(1414,14,59,27),(1446,15,65,1),(1447,15,65,2),(1448,15,65,3),(1449,15,65,4),(1450,15,65,5),(1451,15,65,6),(1452,15,65,7),(1453,15,65,8),(1454,15,65,9),(1455,15,65,10),(1456,15,65,11),(1457,15,65,12),(1458,15,65,13),(1459,15,65,14),(1460,15,65,15),(1461,15,65,16),(1462,15,65,17),(1463,15,65,18),(1464,15,65,19),(1465,15,65,20),(1466,15,65,21),(1467,15,65,22),(1468,15,65,23),(1469,15,65,24),(1470,15,65,25),(1471,15,65,26),(1472,15,65,27),(1473,15,65,28),(1474,15,65,29),(1475,15,65,30),(1476,15,65,31),(1477,15,65,32),(1509,15,64,1),(1510,15,64,2),(1511,15,64,3),(1512,15,64,4),(1513,15,64,5),(1514,15,64,6),(1515,15,64,7),(1516,15,64,8),(1517,15,64,9),(1518,15,64,10),(1519,15,64,11),(1520,15,64,12),(1521,15,64,13),(1522,15,64,14),(1523,15,64,15),(1524,15,64,16),(1525,15,64,17),(1526,15,64,18),(1527,15,64,19),(1528,15,64,20),(1529,15,64,21),(1530,15,64,22),(1531,15,64,28),(1532,15,64,29),(1533,15,64,30),(1534,15,64,31),(1535,15,64,32),(1536,15,64,23),(1537,15,64,24),(1538,15,64,25),(1539,15,64,26),(1540,15,64,27),(1572,16,70,1),(1573,16,70,2),(1574,16,70,3),(1575,16,70,4),(1576,16,70,5),(1577,16,70,6),(1578,16,70,7),(1579,16,70,8),(1580,16,70,9),(1581,16,70,10),(1582,16,70,11),(1583,16,70,12),(1584,16,70,13),(1585,16,70,14),(1586,16,70,15),(1587,16,70,16),(1588,16,70,17),(1589,16,70,18),(1590,16,70,19),(1591,16,70,20),(1592,16,70,21),(1593,16,70,22),(1594,16,70,23),(1595,16,70,24),(1596,16,70,25),(1597,16,70,26),(1598,16,70,27),(1599,16,70,28),(1600,16,70,29),(1601,16,70,30),(1602,16,70,31),(1603,16,70,32),(1635,16,69,1),(1636,16,69,2),(1637,16,69,3),(1638,16,69,4),(1639,16,69,5),(1640,16,69,6),(1641,16,69,7),(1642,16,69,8),(1643,16,69,9),(1644,16,69,10),(1645,16,69,11),(1646,16,69,12),(1647,16,69,13),(1648,16,69,14),(1649,16,69,15),(1650,16,69,16),(1651,16,69,17),(1652,16,69,18),(1653,16,69,19),(1654,16,69,20),(1655,16,69,21),(1656,16,69,22),(1657,16,69,28),(1658,16,69,29),(1659,16,69,30),(1660,16,69,31),(1661,16,69,32),(1662,16,69,23),(1663,16,69,24),(1664,16,69,25),(1665,16,69,26),(1666,16,69,27),(1698,17,75,1),(1699,17,75,2),(1700,17,75,3),(1701,17,75,4),(1702,17,75,5),(1703,17,75,6),(1704,17,75,7),(1705,17,75,8),(1706,17,75,9),(1707,17,75,10),(1708,17,75,11),(1709,17,75,12),(1710,17,75,13),(1711,17,75,14),(1712,17,75,15),(1713,17,75,16),(1714,17,75,17),(1715,17,75,18),(1716,17,75,19),(1717,17,75,20),(1718,17,75,21),(1719,17,75,22),(1720,17,75,23),(1721,17,75,24),(1722,17,75,25),(1723,17,75,26),(1724,17,75,27),(1725,17,75,28),(1726,17,75,29),(1727,17,75,30),(1728,17,75,31),(1729,17,75,32),(1761,17,74,1),(1762,17,74,2),(1763,17,74,3),(1764,17,74,4),(1765,17,74,5),(1766,17,74,6),(1767,17,74,7),(1768,17,74,8),(1769,17,74,9),(1770,17,74,10),(1771,17,74,11),(1772,17,74,12),(1773,17,74,13),(1774,17,74,14),(1775,17,74,15),(1776,17,74,16),(1777,17,74,17),(1778,17,74,18),(1779,17,74,19),(1780,17,74,20),(1781,17,74,21),(1782,17,74,22),(1783,17,74,28),(1784,17,74,29),(1785,17,74,30),(1786,17,74,31),(1787,17,74,32),(1788,17,74,23),(1789,17,74,24),(1790,17,74,25),(1791,17,74,26),(1792,17,74,27);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `passwordhash` varchar(500) NOT NULL,
  `passwordsalt` varchar(500) NOT NULL DEFAULT 'S@l+VaL',
  `apikey` varchar(45) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `timezone` varchar(45) DEFAULT NULL,
  `locale` varchar(45) DEFAULT NULL,
  `language_id` int(11) NOT NULL,
  `login_count` int(11) DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `createdon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedon` timestamp NULL DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT '/data/media/profile.jpg',
  `is_deleted` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organization_fk_idx` (`organization_id`),
  KEY `user_name_idx` (`username`),
  CONSTRAINT `organization_user_fk` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,2,'admin','user','rarunod@mitrai.com','admin','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-01-13 04:18:34',NULL,NULL,0),(5,2,'John','Doe','aamarasinghe@mitrai.com','johndoe','3e8c7dd165aa540b459be7527115f588ad7f9e0c','123',NULL,'2012-01-01','M',NULL,'en-GB',1,NULL,NULL,'2016-01-21 11:07:32',NULL,NULL,0),(6,2,'Jane','Doe','aperera@mitrai.com','janedoe','ad565542ccacde4811e50c3088e9858fa6817449','456',NULL,'2012-01-01','F',NULL,'en-GB',1,NULL,NULL,'2016-01-21 11:07:33',NULL,NULL,0),(7,3,'Mark ','Hunter','Mark@Mark .com','Mark','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,'2012-01-01','M',NULL,'en-GB',1,NULL,NULL,'2016-01-21 13:59:08',NULL,NULL,0),(8,3,'Anne','Wilks','Anne@Anne.com','Anne','ad565542ccacde4811e50c3088e9858fa6817449','456',NULL,'2012-01-01','F',NULL,'en-GB',1,NULL,NULL,'2016-01-21 13:59:08',NULL,NULL,0),(9,3,'Carol','Forbes',NULL,'Carol','f7e8aad3acea29cab7ea32a8a37aa64fc83c2bdf','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:40',NULL,NULL,0),(10,5,'Stirling','Gow',NULL,'Stirling','27a6777633bc3d68a0627514af83317cfac35082','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:40',NULL,NULL,0),(11,5,'Sandra','Bruce',NULL,'Sandra','2aa5009dcddcd040ed54724960e92f6e181d821a','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:40',NULL,NULL,0),(12,5,'Karen','McDonald',NULL,'Karen','b23253eed4dfc5b9b0192b32e28aea6186a345fe','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:41',NULL,NULL,0),(13,5,'Kenneth','Macleod',NULL,'Kenneth','b253688c2f0a9a0f7aed3f5727ee8450573eefe2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:41',NULL,NULL,0),(14,5,'John','Purcell',NULL,'John','b110c1576f3bf8674a22e1ecb976261ead782b09','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:41',NULL,NULL,0),(15,5,'Edward','Thomas',NULL,'Edward','80317a3d21cd3da9d8c44f5f0ce2d3a89ce3170a','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:41',NULL,NULL,0),(16,5,'Claire','Burt',NULL,'Claire','f777ab670678e2022d009774573aecf15f5feaa9','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:41',NULL,NULL,0),(17,5,'Graham','Shand',NULL,'Graham','25cb1f4212ecd03586d4d74d1fc70ae8ae5425df','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:42',NULL,NULL,0),(18,5,'Doreen','McDonald',NULL,'Doreen','5598f65bf6837e71d5991477f81f190ec4f952fa','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:42',NULL,NULL,0),(19,5,'Margaret','Gray',NULL,'Margaret','533be9c0efd51fb4346eae98d6e228b8d5c83009','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:42',NULL,NULL,0),(20,5,'Sarah','Macaskill',NULL,'Sarah','64f799388ed2d38a8c339d8329c3e02725a5e986','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:42',NULL,NULL,0),(21,5,'Kathleen','Hoy',NULL,'Kathleen','932d72fb87258fbdb505795137833be8017c3c98','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:43',NULL,NULL,0),(22,5,'Michelle','Tosh',NULL,'Michelle','352b709d9cf3de87e86706fe12cc981ad6669dba','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:43',NULL,NULL,0),(23,5,'Kerry','Thorneycroft',NULL,'Kerry','dea242be79648c41e7ea032c3906dff6226245cc','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:43',NULL,NULL,0),(24,5,'Angus','Plumb',NULL,'Angus','12f2c7e726a5314ed990db124c72059212450be8','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:43',NULL,NULL,0),(25,5,'Sharon','Robb',NULL,'Sharon','1347d2ba5a4bd4ad7438644170b39ff4d70e25e5','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:43',NULL,NULL,0),(26,5,'Shelagh','Johnstone',NULL,'Shelagh','e0cd3878ad97d498e2fbbe24368ce72a36b8e3a1','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:44',NULL,NULL,0),(27,5,'Alan','Buck',NULL,'Alan','fb57c7dc3e298e075933c4d87ad9ced9bfd59a01','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:44',NULL,NULL,0),(28,5,'Sinclair','Laing',NULL,'Sinclair','8a71bfbcd926020b27e5ca8bc48fee1027fa08f2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:44',NULL,NULL,0),(29,5,'Irene','Pace',NULL,'Irene','e7a1d2931cfbaa10ca719e5c80e71362d0f5a9ee','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:44',NULL,NULL,0),(30,5,'Jacqueline','Gordon',NULL,'Jacqueline','6235ee60caf86dc17dc3a84ff5627fcb57c58d1b','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:44',NULL,NULL,0),(31,5,'Patricia','Brown',NULL,'Patricia','d91478b548190212cea572f115097e6e96617c15','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:45',NULL,NULL,0),(32,5,'Sheena','Davidson',NULL,'Sheena','6a49b0c99d5fa0e9da5a6b6cba2fa4ff1700f44a','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:45',NULL,NULL,0),(33,5,'Louise','Hough',NULL,'Louise','2c20593f41bb65be7760ccdbc56bb05b4b9e282f','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:45',NULL,NULL,0),(34,5,'Graham','Stubbins',NULL,'Graham','2dd052a0f97b2e7d3026a6b60ae5d64ebe5bac34','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:45',NULL,NULL,0),(35,5,'Linda','Mason',NULL,'Linda','834a091e149857bded06d4e36ee67205d1ebdc3e','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:46',NULL,NULL,0),(36,5,'Martin','Duguid',NULL,'Martin','fc945ff997378bbb79a6ed9e379bd8a37c4e7146','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:46',NULL,NULL,0),(37,5,'Peter','Twine',NULL,'Peter','6d320bace4210b375d62ed115e3ff951cf5cf6c0','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:46',NULL,NULL,0),(38,5,'David','Wilson',NULL,'David','647aecf9125b5482640e8984a510149dfa8c8564','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:46',NULL,NULL,0),(39,5,'Morag','Barclay',NULL,'Morag','effe200db2860f5e484ed97e52a1f56fbfa17290','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:47',NULL,NULL,0),(40,5,'Christine','Wilson',NULL,'Christine','c9a2ff9cc2f9bd2678fb40bad1e55aff11d82e34','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:47',NULL,NULL,0),(41,5,'Alastair','Condie',NULL,'Alastair','b0feda22f0056ab8441b7fd843d6fab45d298e35','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:47',NULL,NULL,0),(42,5,'Helen','Elliot',NULL,'Helen','577e30597941d8cc542a4b37514ce0a225681965','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:47',NULL,NULL,0),(43,5,'Derek','Beverley',NULL,'Derek','e3b33e7cbbecde2ab7e89b364d746250eefcf262','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:47',NULL,NULL,0),(44,5,'Joanna','McRae',NULL,'Joanna','a800901faefdb193c62a155dad80e3fdc2471424','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:48',NULL,NULL,0),(45,5,'Brian','Dow',NULL,'Brian','3e45eaabb68b6729278880c2f77434b2b5813b18','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:48',NULL,NULL,0),(46,5,'Neal','Murray',NULL,'Neal','de0b4640d54c5dd43a09f137f54bcb081c34b946','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:48',NULL,NULL,0),(47,5,'Ian','Sutherland',NULL,'Ian','20c3ddaf8de4ddf73a8e9e547a529de984b8028a','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:49',NULL,NULL,0),(48,5,'Susan','Caroline',NULL,'Susan','5d4bb773c1b3a52e350cfadcd682c3ee96092057','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:49',NULL,NULL,0),(49,5,'Robert','Morrison',NULL,'Robert','0c17a2abf16c11b8c66b8cd9966e12edec5a60cb','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:50',NULL,NULL,0),(50,5,'Bruce ','Strachan',NULL,'Bruce ','71c07b0c805d0a11b740f191c08c65bdc50a58cd','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:51',NULL,NULL,0),(51,5,'Sharon','Wren',NULL,'Sharon','f2fdd27c765b2e64dc71831bc2de125a3046ca1c','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:51',NULL,NULL,0),(52,5,'Ronnie','Fisher',NULL,'Ronnie','c82ee9eb44b2d0a12fbe88123b0dc8f4fca8fbfe','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:52',NULL,NULL,0),(53,5,'Valerie','Rae',NULL,'Valerie','6b93f35cdb6e1373775bacf6fd6a3f9782d01b97','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:52',NULL,NULL,0),(54,5,'Alan','Barclay',NULL,'Alan','9e47bd7dda4073f5143da47f942748a4d8057e2b','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:52',NULL,NULL,0),(55,5,'Stuart','Reid',NULL,'Stuart','fa6cc9e1de35890060977aee643e5228c1c48761','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:53',NULL,NULL,0),(56,5,'Martin','Murchie',NULL,'Martin','71a39b5fb07b2963903c7cb277256ef1bb38a913','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:53',NULL,NULL,0),(57,5,'Louise','Beaton',NULL,'Louise','6959ba8ad77dd89c64016f2762cbfddc61377432','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:53',NULL,NULL,0),(58,5,'Lesley','Strachan',NULL,'Lesley','4db409c40b7d33bd83ddb405254b3b865c828f6d','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:53',NULL,NULL,0),(59,5,'Jill','Forbes',NULL,'Jill','816a598a68f0698306eee7adde9f236c053bcfe6','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:54',NULL,NULL,0),(60,5,'Alan','Wilson',NULL,'Alan','e6d5b1c1b575369a4bcbbd62de9cf287570903fd','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:54',NULL,NULL,0),(61,5,'Alice','Mutch',NULL,'Alice','7129c6e86ae42e0a699061ea2e2d169fe487a099','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:54',NULL,NULL,0),(62,5,'Paul','Connolly',NULL,'Paul','37c358ef8082cccce2f584e5a2dfb5aaf9473781','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:54',NULL,NULL,0),(63,5,'Evelyn','Currie',NULL,'Evelyn','f65d28eca234b880b3102da486ad22637a10742a','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:54',NULL,NULL,0),(64,5,'Alan','Towns',NULL,'Alan','bf6a2a1f62ccdf188690cad363492deaf24023eb','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:55',NULL,NULL,0),(65,5,'Esther','Walterson',NULL,'Esther','5b813194a7fa673b6fa109071e0f3aaf90fba644','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:55',NULL,NULL,0),(66,5,'Lynn','Healey',NULL,'Lynn','31d78f303cac2e7b89a7ceb79d10b7955c5dea09','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:55',NULL,NULL,0),(67,5,'Charles','Walker',NULL,'Charles','aa399cb97db663ea722aad01d77938880ce0acc5','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:55',NULL,NULL,0),(68,5,'Kirsty','Jarman',NULL,'Kirsty','8b246d095b4ecbe48d0106d133f0170f191a5acf','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:56',NULL,NULL,0),(69,5,'William','Michie',NULL,'William','214ca69601ac97e4ed21d878b60f10739cf2e94f','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:56',NULL,NULL,0),(70,5,'Kenny ','Luke',NULL,'Kenny ','27b78432436ef42f4788190e779d3304c35c0da7','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:56',NULL,NULL,0),(71,5,'Stephen','Pirie',NULL,'Stephen','060d6395aefffe152b0f187631c07237339b4f38','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:56',NULL,NULL,0),(72,5,'Kim','Menzies',NULL,'Kim','a3f1745306ac25c06b089d1a5f40af42c8c7e1f1','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-02-03 04:41:56',NULL,NULL,0),(73,6,'Aaron','Percival','sdonaghy@moderndemocracy.com','apercival','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-02-05 10:20:22',NULL,NULL,0),(74,6,'Barbara','Jeffries','sdonaghy@moderndemocracy.com','bjeffries','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-02-05 10:20:54',NULL,NULL,0),(76,6,'Mat','Bloxham','sdonaghy@moderndemocracy.com','mbloxham','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-02-05 10:21:40',NULL,NULL,0),(77,6,'Lesley','Blue','sdonaghy@moderndemocracy.com','lblue','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-02-05 10:22:03',NULL,NULL,0),(78,6,'MDL','User','slappin@moderndemocracy.com','mdluser','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,'2012-01-01','M',NULL,'en-GB',1,NULL,NULL,'2016-02-17 10:22:03',NULL,NULL,0),(83,9,'MDL','User1','slappin@moderndemocracy.com','mdluser1','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,'2012-01-01','M',NULL,'en-GB',1,NULL,NULL,'2016-02-17 10:22:03',NULL,NULL,0),(84,9,'MDL','User2','slappin@moderndemocracy.com','mdluser2','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,'2012-01-01','M',NULL,'en-GB',1,NULL,NULL,'2016-02-17 10:22:03',NULL,NULL,0),(85,9,'MDL','User3','slappin@moderndemocracy.com','mdluser3','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,'2012-01-01','M',NULL,'en-GB',1,NULL,NULL,'2016-02-17 10:22:03',NULL,NULL,0),(86,10,'adm',' ',NULL,'adm','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-18 19:37:17',NULL,'/data/media/profile.jpg',0),(87,10,'Sandra','Bruce',NULL,'Bru','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-18 19:49:44',NULL,'/data/media/profile.jpg',0),(88,10,'Carol','Forbes',NULL,'For','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-18 19:49:44',NULL,'/data/media/profile.jpg',0),(89,10,'Stirling','Gow',NULL,'Gows','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-18 19:49:44',NULL,'/data/media/profile.jpg',0),(90,10,'Karen','McDonald',NULL,'McD','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-18 19:49:44',NULL,'/data/media/profile.jpg',0),(102,12,'administrator',' ',NULL,'administrator','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:53:17',NULL,'/data/media/profile.jpg',0),(103,12,'Sandra','Bruce',NULL,'Bruce','28c9894a6fa5379f0aa641237a9ba5467e81e9b6','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:55:20',NULL,'/data/media/profile.jpg',0),(104,12,'Carol','Forbes',NULL,'Forbes','65ad6820478148806d28d04bf274ee0eb16f6e1c','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:55:20',NULL,'/data/media/profile.jpg',0),(105,12,'Stirling','Gow',NULL,'Gow','d5e146d1426387b0004985d96ec9d89375ccd4ea','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:55:20',NULL,'/data/media/profile.jpg',0),(106,12,'Karen','McDonald',NULL,'McDonald','2f98571df75624ae75bf90f2e5b5394ef7c1649d','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:55:20',NULL,'/data/media/profile.jpg',0),(107,12,'Peter','Twine',NULL,'Twine','7637fbf8702740e94d509a234c6a2284afdac0ab','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(108,12,'Morag','Barclay',NULL,'Barclay','775d1e3f03101684e6d64264c8b6949f342c8299','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(109,12,'Stuart','Reid',NULL,'Reid','90a58bf02a6acc66461f31666ab3af464ae90153','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(110,12,'Irene','Pace',NULL,'Pace','9ae0dd20f5ef5a7f8e8b5822645101050328caca','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(111,12,'Martin','Murchie',NULL,'Murchie','465ad0b6dc06b16e415cd55f2c222be78f4add8a','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(112,12,'Graham','Shand',NULL,'Shand','cbb1940dc0f32ca1f13256ce15af6229619130e1','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(113,12,'sd2e.121','tt','12321@1212.comssds','sdsadas','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-03-29 07:27:54','2016-03-29 07:29:01','/data/media/profile.jpg',1),(114,12,'user','test 1','utest1@mail.com','psm 10','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-03-29 11:57:43',NULL,'/data/media/profile.jpg',0),(115,12,'user','test 1','utest1@mail.com','psm10','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-03-29 12:00:00',NULL,'/data/media/profile.jpg',0),(116,12,'rety','test','rety@test.com','em','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-03-29 12:07:33',NULL,'/data/media/profile.jpg',0),(117,12,'test','user 3','test@test3.com','gimi gimii','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-03-29 12:08:47','2016-03-29 16:54:01','/data/media/profile.jpg',0),(118,12,'yami 1','yashi','yshi@mail.com','yami','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-03-29 17:16:28','2016-03-29 17:18:24','/data/media/profile.jpg',0),(119,12,'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww','yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy','y@ma.com','wy','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-03-29 17:17:01',NULL,'/data/media/profile.jpg',1),(120,12,'User','Test','UserTest@email.com','UsrTest','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2016-03-30 13:30:45',NULL,'/data/media/profile.jpg',1),(121,13,'admin',' ',NULL,'admin','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-31 17:25:30',NULL,'/data/media/profile.jpg',0),(122,13,'Sandra','Bruce',NULL,'Bruce','28c9894a6fa5379f0aa641237a9ba5467e81e9b6','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-31 17:30:26',NULL,'/data/media/profile.jpg',0),(123,14,'admin',' ',NULL,'admin','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-31 21:46:35',NULL,'/data/media/profile.jpg',0),(124,14,'Sandra','Bruce',NULL,'Bruce','28c9894a6fa5379f0aa641237a9ba5467e81e9b6','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-31 21:57:38',NULL,'/data/media/profile.jpg',0),(125,15,'admin',' ',NULL,'admin','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-04-01 05:21:08',NULL,'/data/media/profile.jpg',0),(126,16,'administrator3',' ',NULL,'administrator3','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-04-01 06:34:14',NULL,'/data/media/profile.jpg',0),(127,17,'administrator4',' ',NULL,'administrator4','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-04-01 06:40:34',NULL,'/data/media/profile.jpg',0),(128,16,'Sandra','Bruce',NULL,'star','28c9894a6fa5379f0aa641237a9ba5467e81e9b6','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-04-01 06:46:03',NULL,'/data/media/profile.jpg',0),(129,15,'William','Michie',NULL,'William','5ec94b96c2b00732f520bca92685a33f5ba291ea','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-04-01 08:15:50',NULL,'/data/media/profile.jpg',0),(130,15,'Wind','Will',NULL,'Wind','499fadc02e7bddacb041efdbf59ecc6ca5286cf5','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-04-01 08:15:50',NULL,'/data/media/profile.jpg',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_role_fk1_idx` (`role_id`),
  KEY `user_role_fk2_idx` (`user_id`),
  KEY `user_role_fk3_idx` (`organization_id`),
  CONSTRAINT `user_role_fk1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_role_fk2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_role_fk3` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (3,2,1,2),(4,2,1,5),(5,2,1,6),(6,3,2,7),(7,4,3,8),(8,6,16,73),(9,6,17,74),(11,6,18,76),(12,6,18,77),(13,6,18,78),(18,9,25,83),(19,9,26,84),(20,9,25,85),(21,10,27,86),(22,10,28,87),(23,10,28,88),(24,10,28,89),(25,10,28,89),(26,10,28,90),(27,10,28,90),(28,10,28,87),(29,10,28,88),(30,10,28,89),(31,10,28,89),(32,10,28,90),(33,10,28,90),(57,12,40,102),(58,12,38,103),(59,12,38,104),(60,12,38,105),(61,12,38,105),(62,12,38,106),(63,12,38,106),(64,12,38,107),(65,12,38,108),(66,12,38,108),(67,12,38,109),(68,12,38,110),(69,12,38,110),(70,12,38,111),(71,12,38,111),(72,12,38,112),(73,12,38,112),(74,12,38,103),(75,12,38,104),(76,12,38,105),(77,12,38,105),(78,12,38,106),(79,12,38,106),(80,12,38,103),(81,12,38,104),(82,12,38,105),(83,12,38,105),(84,12,38,106),(85,12,38,106),(86,12,38,103),(87,12,38,104),(88,12,38,105),(89,12,38,105),(90,12,38,105),(91,12,38,106),(92,12,38,106),(93,12,38,107),(94,12,38,108),(95,12,38,108),(96,12,38,109),(97,12,38,110),(98,12,38,110),(99,12,38,111),(100,12,38,111),(101,12,38,112),(102,12,38,112),(103,12,38,107),(104,12,38,108),(105,12,38,108),(106,12,38,109),(107,12,38,110),(108,12,38,110),(109,12,38,111),(110,12,38,111),(111,12,38,112),(112,12,38,112),(113,12,38,103),(114,12,38,104),(115,12,38,105),(116,12,38,105),(117,12,38,106),(118,12,38,106),(119,12,38,107),(120,12,38,108),(121,12,38,108),(122,12,38,109),(123,12,38,110),(124,12,38,110),(125,12,38,111),(126,12,38,111),(127,12,38,112),(128,12,38,112),(129,12,38,103),(130,12,38,104),(131,12,38,105),(132,12,38,105),(133,12,38,106),(134,12,38,106),(135,12,38,103),(136,12,38,104),(137,12,38,105),(138,12,38,105),(139,12,38,106),(140,12,38,106),(141,12,38,103),(142,12,38,104),(143,12,38,105),(144,12,38,105),(145,12,38,105),(146,12,38,106),(147,12,38,106),(148,12,38,103),(149,12,38,104),(150,12,38,105),(151,12,38,105),(152,12,38,105),(153,12,38,106),(154,12,38,106),(155,13,54,121),(156,13,55,122),(157,13,55,122),(158,13,55,122),(159,13,55,122),(160,13,55,122),(161,13,55,122),(162,13,55,122),(163,13,55,122),(164,13,55,122),(165,13,55,122),(166,14,59,123),(167,14,60,124),(168,14,60,124),(169,14,60,124),(170,14,60,124),(171,12,38,103),(172,12,38,103),(173,12,38,103),(174,12,38,103),(175,15,64,125),(176,12,38,103),(177,12,38,103),(178,12,38,103),(179,12,38,103),(180,12,38,103),(181,12,38,103),(182,12,38,103),(183,12,38,103),(184,12,38,103),(185,12,38,103),(186,12,38,103),(187,12,38,103),(188,16,69,126),(189,17,74,127),(190,16,70,128),(191,16,70,128),(192,16,70,128),(193,16,70,128),(194,16,70,128),(195,16,70,128),(196,16,70,128),(197,16,70,128),(198,16,70,128);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'security'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_validate_permission` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_validate_permission`( token VARCHAR(255),permission_code VARCHAR(255), app_name VARCHAR(255) ) RETURNS tinyint(1)
BEGIN

    DECLARE user VARCHAR(45);
    DECLARE orgcode VARCHAR(45);
    
    set user=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
	if (select exists (
		select p.* 
		from security.user u inner join security.user_role ur on u.id = ur.user_id
		inner join security.role_permission rp on ur.role_id = rp.role_id
		inner join subscription.permission p on rp.permission_id = p.id
		inner join subscription.organization org on u.organization_id = org.id
        inner join subscription.application a on p.application_id = a.id
		where u.username = user and org.code = orgcode and 
        p.permissioncode = permission_code and a.name = app_name
	))
    then
		return 1;
    else
		return 0;
    end if;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_validate_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_validate_token`( token VARCHAR(255) ) RETURNS tinyint(1)
BEGIN
/** break the token **/
    DECLARE user VARCHAR(45);
    DECLARE orgcode VARCHAR(45);
    DECLARE accesstoken VARCHAR(255);
    
    set user=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    /** check the token in the token table **/
    if (select exists(select * from security.access_token act inner join subscription.organization org on act.organization_id=org.id
    inner join security.user usr on act.userid=usr.id
    where org.code=orgcode and usr.username=user and act.token=token and
    now() >= act.fromdate and now() <= act.todate))
    then
		return 1;
    else
		return 0;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SPLIT_STR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SPLIT_STR`(
x VARCHAR(255),
delim VARCHAR(12),
pos INT
) RETURNS varchar(255) CHARSET utf8
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
delim, '') ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addrole` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `addrole`(in token varchar(255),in rolename varchar(55),in description varchar(255))
BEGIN
	
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		if(select exists(select * from security.role where name=rolename and organization_id=orgid)) then
			select 'Role already exists' as response;
        else
			insert into security.role (organization_id,name,description) values (
            orgid,rolename,description);
            select 'success' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `adduser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `adduser`(in token varchar(255),in firstname varchar(127),in lastname varchar(127),
in email varchar(127),in username varchar(127),in passwordhash varchar(127),in passwordsalt varchar(127),in language_id int)
BEGIN
	
    declare usersname varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set usersname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		if(select exists(select * from security.user usr where usr.username=username and usr.organization_id=orgid)) then
			select 'dataduplicate' as response;
        else
			insert into security.user (organization_id,firstname,lastname,email,username,passwordhash,passwordsalt,language_id) 
            values (orgid,firstname,lastname,email,username,passwordhash,passwordsalt,language_id);
            select 'success' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_token`(IN username VARCHAR(45),IN orgcode VARCHAR(45),IN token VARCHAR(500))
BEGIN
	insert into security.access_token (organization_id,userid,token,fromdate,todate)
    select o.id,u.id,token,now(),(now() + INTERVAL 1 DAY) from 
    subscription.organization o inner join security.user u on u.organization_id=o.id
    where u.username=username and o.code=orgcode;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleterole` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deleterole`(in token varchar(255),in deleteroleid int,in alterroleid int)
BEGIN
	declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN          
          ROLLBACK;
          select 'error deleting Role' as response;
    END;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);

    if (security.fn_validate_token(token)=1 ) then		
		START TRANSACTION;
			update security.user_role set role_id=alterroleid where 
			role_id=deleteroleid and organization_id=orgid;
            
            update security.role_permission set role_id=alterroleid where
            role_id=deleteroleid and organization_id=orgid;
            
            delete from security.role where id=deleteroleid;
		COMMIT;
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteuser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deleteuser`(in token varchar(255),in usrid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'deleteuser';
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1 ) then
		/*#delete from child tables
        
        #psm
        #psm.chat
        delete from psm.chat where userid=usrid and organizationid=orgid;
        
        #psm.issue
        delete from psm.issue where reportedby=username and organization_id=orgid;
        
        #psm.issue_assignment
        delete from psm.issue_assignment where user_id=usrid and organization_id=orgid;
        
        #psm.issue_comment
        delete from psm.issue_comment where user_id=usrid and organization_id=orgid;
        
        #psm.notification_status
        delete from psm.notification_status where userid=usrid and organization_id=orgid;
        
        #psm.user_election
        delete from psm.user_election where user_id=usrid and organization_id=orgid;
        
        #psm.voter_list
        delete from psm.voter_list where userid=usrid and organizationid=orgid;
        
        #security
        #security.access_token
        delete from security.access_token where userid=usrid and organization_id=orgid;
        
        #security.user_role
        delete from security.user_role where user_id=usrid and organization_id=orgid;
        
        #delete from parent table user
        delete from security.user where id=usrid and organization_id=orgid;*/
        
        update security.user usr set usr.is_deleted=1 where usr.id=usrid; 
        
		select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallroles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallroles`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set spcode='getallroles';
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'ADMIN')) then
		select id,name,description,'success' as response from security.role where organization_id=orgid;
    else
		select null as id,null as name,null as description,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallusers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallusers`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    set spcode='getallusers';
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        select id as id,firstname as firstname,lastname as lastname,concat(firstname , ' ' ,lastname) as fullname,
        email as email,username as username,is_deleted as is_deleted,
        'success' as response from security.user where organization_id=orgid and is_deleted!=1;
	else
		select null as id,null as firstname,null as lastname,null as fullname,null as email,null as username,null as is_deleted,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getallusersbyissueid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallusersbyissueid`(in token varchar(255), in issueid int)
BEGIN
	declare spcode varchar(45);
    declare usersname varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    declare repoter varchar(45);
    
    set spcode='getallusers';
    
    set usersname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select reportedby into repoter from psm.issue where id=issueid;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        select id,firstname,lastname,concat(firstname , ' ' ,lastname) as fullname,email,username,
        'success' as response 
		from security.user where organization_id=orgid and !(username = repoter) and is_deleted=0;
	else
		select null as id,null as firstname,null as lastname,null as fullname,null as email,null as username,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getrolebyid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getrolebyid`(in token varchar(255),in roleid int)
BEGIN
	
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		select id,name,description,'success' as response from security.role where id=roleid and organization_id=orgid;
    else
		select null as id,null as name,null as description,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getuserbyid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getuserbyid`(in token varchar(255),in userid int)
BEGIN        
    if (security.fn_validate_token(token)=1 ) then
		select firstname,lastname,IFNULL(email,'') as email,username,gender,'success' as response from security.user where id=userid;
    else
		select null as firstname,null as lastname,null as email,null as username,null as gender,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login`(IN username VARCHAR(45),IN orgcode VARCHAR(45),IN usersecret VARCHAR(45))
BEGIN
	DECLARE vartoken VARCHAR(500) DEFAULT NULL;
    DECLARE result VARCHAR(500);
	/** check the user in the given organization **/
    if (select exists (
		select * from security.user u inner join subscription.organization o on
		u.organization_id=o.id where 
		 o.code=orgcode and u.username=username and u.passwordhash=sha1(CONCAT(u.passwordsalt,usersecret))
         and u.is_deleted = 0
    )) then
		/** user is vlid. check whether there is an issued token **/
        select a.token into vartoken from security.access_token a inner join subscription.organization b on
        a.organization_id=b.id inner join
        security.user c on a.userid=c.id where b.code=orgcode and c.username=username and 
        now() >= a.fromdate and now() <= a.todate;
        
        if(vartoken is null ) then
			/** issue a new token here **/
            set result=concat(username,'|',orgcode,'|', MD5(RAND()));
            /** create with validity of a day **/
            call security.create_token(username,orgcode,result);
        else
			set result=vartoken;
        end if;
    else
		set result='unauthorized';
    end if;
    
    select result as response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login1`(IN username VARCHAR(45),IN orgcode VARCHAR(45),IN usersecret VARCHAR(45))
BEGIN
	DECLARE vartoken VARCHAR(500) DEFAULT NULL;
    DECLARE result VARCHAR(500);
	/** check the user in the given organization **/
    if (select exists (
		select * from security.user u inner join subscription.organization o on
		u.organization_id=o.id where 
		u.username=username and u.passwordhash=sha1(CONCAT(u.passwordsalt,usersecret)) and o.code=orgcode
    )) then
		/** user is vlid. check whether there is an issued token **/
        select a.token into vartoken from security.access_token a inner join subscription.organization b on
        a.organization_id=b.id inner join
        security.user c on a.userid=c.id where b.code=orgcode and c.username=username and 
        now() >= a.fromdate and now() <= a.todate;
        
        if(vartoken is null ) then
			/** issue a new token here **/
            set result=concat(username,'|',orgcode,'|', MD5(RAND()));
            /** create with validity of a day **/
            call security.create_token(username,orgcode,result);
        else
			set result=vartoken;
        end if;
    else
		set result='unauthorized';
    end if;
    
    select result as response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updaterole` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updaterole`(in token varchar(255),in roleid int,in rolename varchar(55),in description varchar(255))
BEGIN
	
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		update security.role set name=rolename,description=description,updatedon=current_timestamp where
        organization_id=orgid and id=roleid;
        
		select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateuser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateuser`(in token varchar(255),in userid int,in firstname varchar(127),
in lastname varchar(127),in email varchar(127),in username varchar(127))
BEGIN
    
    if (security.fn_validate_token(token)=1 ) then
		update security.user usr set usr.firstname=firstname,
        usr.lastname=lastname,usr.email=email,usr.username=username,usr.updatedon=current_timestamp where
        usr.id=userid;        
		select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `validate_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `validate_token`(IN token varchar(255))
BEGIN
	/** break the token **/
    DECLARE user VARCHAR(45);
    DECLARE orgcode VARCHAR(45);
    DECLARE accesstoken VARCHAR(255);
    
    set user=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set accesstoken=security.SPLIT_STR(token,'|',3);
    
    /** check the token in the token table **/
    if (select exists(select * from security.access_token act inner join subscription.organization org on act.organization_id=org.id
    inner join security.user usr on act.userid=usr.id
    where org.code=orgcode and usr.username=user and act.token=accesstoken and
    now() >= act.fromdate OR now() <= act.todate))
    then
		select 1;
    else
		select 0;
    end if;
    
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

-- Dump completed on 2016-04-01 15:14:57
CREATE DATABASE  IF NOT EXISTS `subscription` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `subscription`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: ec2-52-48-101-197.eu-west-1.compute.amazonaws.com    Database: subscription
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

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
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,'PSM','PSM'),(2,'EM','EM'),(3,'Admin','Admin');
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(45) NOT NULL,
  `area_name` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `postcode` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `province` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `logo_url` varchar(45) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedon` timestamp NULL DEFAULT NULL,
  `isactive` int(11) DEFAULT '1',
  `isdeleted` int(11) DEFAULT '0',
  `csvstructureid` int(11) DEFAULT '1' COMMENT '1-psm structure\n2-aberdeen structure',
  PRIMARY KEY (`id`),
  KEY `org_code_idx` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (2,'Derry City Council','DERRY','Derry','20, York Drive','Derry','DE8466Y','','','council@derry','assets/global/images/derry.jpg','2016-01-13 04:16:15',NULL,1,0,1),(3,'Wolverhampton','Wolverhampton','Wolverhampton','Wolverhampton','Wolverhampton','1234',NULL,NULL,'Wolverhampton@Wolverhampton.com','assets/global/images/wolverhampton.png','2016-01-21 13:08:25',NULL,1,0,1),(4,'Kilmarnock and Loudoun','Kilmarnock','Kilmarnock','Kilmarnock','Kilmarnock','1234',NULL,NULL,'Kilmarnock@Kilmarnock.com','assets/global/images/kilmarnock.jpg','2016-01-21 13:08:25',NULL,1,0,1),(5,'Aberdeen','ABD','Aberdeen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2016-02-02 15:34:59',NULL,1,0,1),(6,'Amersham','Amersham','Amersham',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2016-02-05 09:53:45',NULL,1,0,1),(7,'Amersham UAT1','AMSUAT1','Amersham UAT1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2016-02-05 09:53:45',NULL,1,0,1),(8,'Amersham UAT2','AMSUAT2','Amersham UAT2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2016-02-05 09:53:45',NULL,1,0,1),(9,'MDL','MDL','MDL','MDL',NULL,NULL,NULL,NULL,NULL,'assets/global/images/wolverhampton.png','2016-02-05 09:53:45',NULL,1,0,1),(10,'Mit','Mit','Mit',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-03-18 19:37:17',NULL,1,0,1),(12,'Mitra','Mitra','Mitra',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-03-22 11:53:17',NULL,1,0,1),(13,'sliit','sliit','sliit',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-03-31 17:25:30',NULL,1,0,1),(14,'sliit2','sliit2','sliit2',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-03-31 21:46:35',NULL,1,0,1),(15,'org_2','org_2','org_2',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-01 05:21:08',NULL,1,0,2),(16,'Mitra3','Mitra3','Mitra3',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-01 06:34:14',NULL,1,0,1),(17,'Mitra4','Mitra4','Mitra4',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-01 06:40:34',NULL,1,0,1);
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_application`
--

DROP TABLE IF EXISTS `organization_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organization_fk_idx` (`organization_id`),
  KEY `application_fk_idx` (`application_id`),
  CONSTRAINT `application_fk` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `organization_fk` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_application`
--

LOCK TABLES `organization_application` WRITE;
/*!40000 ALTER TABLE `organization_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `verb` varchar(45) DEFAULT NULL,
  `permissioncode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `perm_app_fk_idx` (`application_id`),
  KEY `perm_code_idx` (`permissioncode`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,1,'getpollingstations',NULL,NULL,'getpollingstations'),(2,1,'getnewnotifications',NULL,NULL,'getnewnotifications'),(3,1,'readnotification',NULL,NULL,'readnotification'),(4,1,'getallnotifications',NULL,NULL,'getallnotifications'),(5,1,'getlist',NULL,NULL,'getlist'),(6,1,'getprepollactivities',NULL,NULL,'getprepollactivities'),(7,1,'updateprepollactivity',NULL,NULL,'updateprepollactivity'),(8,1,'openstation',NULL,NULL,'openstation'),(9,1,'getissuelist',NULL,NULL,'getissuelist'),(10,1,'getissuepriority',NULL,NULL,'getissuepriority'),(11,1,'reportissue',NULL,NULL,'reportissue'),(12,1,'getclosestats',NULL,NULL,'getclosestats'),(13,1,'updateclosestats',NULL,NULL,'updateclosestats'),(14,1,'closepollingstation',NULL,NULL,'closepollingstation'),(15,1,'getpollingstations',NULL,NULL,'getpollingstations'),(16,1,'starttrack',NULL,NULL,'starttrack'),(17,1,'gettrackingstatus',NULL,NULL,'gettrackingstatus'),(18,1,'getnewnotificationpulse',NULL,NULL,'getnewnotificationpulse'),(19,1,'getorginfo',NULL,NULL,'getorginfo'),(20,1,'getelectionsbystationid',NULL,NULL,'getelectionsbystationid'),(21,1,'getprogress',NULL,NULL,'getprogress'),(22,1,'updateprogress',NULL,NULL,'updateprogress'),(23,3,'getallroles',NULL,NULL,'getallroles'),(24,3,'getnotificationbyid',NULL,NULL,'getnotificationbyid'),(25,3,'getglobalnotifications',NULL,NULL,'getglobalnotifications'),(26,3,'getallclosestats',NULL,NULL,'getallclosestats'),(27,3,'getallclosestatssummary',NULL,NULL,'getallclosestatssummary'),(28,1,'resolveissue',NULL,NULL,'resolveissue'),(29,1,'getissuebyid',NULL,NULL,'getissuebyid'),(30,1,'assignissue',NULL,NULL,'assignissue'),(31,1,'getallusers',NULL,NULL,'getallusers'),(32,1,'updateissue',NULL,NULL,'updateissue');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'subscription'
--
/*!50003 DROP PROCEDURE IF EXISTS `getallapplications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallapplications`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    set spcode='getorginfo';
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    if (security.fn_validate_token(token)=1) then
		select app.id as applicationid,app.name as applicationname,'success' as response from subscription.organization_application orgapp
        inner join subscription.organization org on org.id=orgapp.organization_id
        inner join subscription.application app on app.id=orgapp.application_id
        where org.code=orgcode;
    else
		select null as applicationid,null as applicationname,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getorginfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getorginfo`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    set spcode='getorginfo';
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select 'success' as response,org.name as organization,org.logo_url as logourl,concat(us.firstname,' ',us. lastname) as userfullname  from security.user us
        inner join subscription.organization org on us.organization_id=org.id
        where org.code=orgcode and us.username=username;
    else
		select 'unauthorized' as response,null as organization,null as logourl,null as userfullname;
    end if;
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

-- Dump completed on 2016-04-01 15:15:20
