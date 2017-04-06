CREATE DATABASE  IF NOT EXISTS `psm` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `psm`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: psm
-- ------------------------------------------------------
-- Server version	5.6.29

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
) ENGINE=InnoDB AUTO_INCREMENT=433 DEFAULT CHARSET=utf8 COMMENT='Using for viewing chat messages in issues';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Counting centers master table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counting_center`
--

LOCK TABLES `counting_center` WRITE;
/*!40000 ALTER TABLE `counting_center` DISABLE KEYS */;
INSERT INTO `counting_center` VALUES (5,'Royal British Legion Hall','51.6769451','-0.6023963',6,9,''),(14,'counting center','','',12,17,'address one'),(15,'counting','','',12,18,'address two'),(16,'ertyu','','',12,19,'dfghj'),(17,'rtyu','','',12,20,'fghj'),(18,'gh','','',12,21,'yuj'),(19,'vista station','53.4685097','-1.4931023000000323',12,22,'1, Acre Gate, High Green, Sheffield, S35 4FT'),(20,'chilosta station','53.44847249999999','-1.4817540999999892',12,23,'280A, Whitley Lane, Grenoside, Sheffield, S35 8RQ'),(21,'delete election','53.46140399999999','-1.4941056999999773',12,24,'2, Woodland Court, Burncross, Sheffield, S35 1TN'),(22,'remove election','53.46140399999999','-1.4941056999999773',12,25,'1, Woodland Court, Burncross, Sheffield, S35 1TN');
/*!40000 ALTER TABLE `counting_center` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `elec_fk1_idx` (`organization_id`),
  KEY `elec_date_idx` (`election_date_start`),
  CONSTRAINT `elec_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election`
--

LOCK TABLES `election` WRITE;
/*!40000 ALTER TABLE `election` DISABLE KEYS */;
INSERT INTO `election` VALUES (6,6,'Amersham Town Ward District By Election','2016-02-08 00:00:00','2016-02-08 00:00:00',0,NULL,0,0),(9,6,'Amersham Town Ward District By Election','2016-02-19 07:00:00','2016-02-19 22:00:00',1,NULL,0,0),(17,12,'Test Election','2016-03-24 13:00:00','2016-03-24 17:00:00',0,NULL,0,0),(18,12,'new election','2016-03-24 07:00:00','2016-03-24 22:00:00',0,NULL,0,0),(22,12,'vista','2016-04-25 13:00:00','2016-04-25 17:00:00',0,NULL,0,1),(23,12,'chilosta election 1','2016-04-10 13:00:00','2016-04-10 17:00:00',0,NULL,0,1),(24,12,'delete election','2016-03-28 10:00:00','2016-03-28 16:00:00',0,NULL,1,1),(25,12,'remove election','2016-03-26 00:00:00','2016-03-26 16:00:00',0,NULL,0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election_close_stats`
--

LOCK TABLES `election_close_stats` WRITE;
/*!40000 ALTER TABLE `election_close_stats` DISABLE KEYS */;
INSERT INTO `election_close_stats` VALUES (47,6,9,349,0,1351,0,0,10,'2016-02-19 23:26:14',171),(48,6,9,254,0,1246,0,0,10,'2016-02-19 23:26:35',172),(61,12,17,1000,0,9000,0,0,10000,'2016-03-24 15:34:01',203),(62,12,17,300,0,9700,0,0,10000,'2016-03-24 16:10:53',204);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election_stats`
--

LOCK TABLES `election_stats` WRITE;
/*!40000 ALTER TABLE `election_stats` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hierarchy`
--

LOCK TABLES `hierarchy` WRITE;
/*!40000 ALTER TABLE `hierarchy` DISABLE KEYS */;
INSERT INTO `hierarchy` VALUES (16,6,'Ward',NULL,1,'2016-02-05 09:54:56',NULL),(17,6,'District',16,2,'2016-02-05 09:55:30',NULL),(18,6,'Place',17,3,'2016-02-05 09:56:00',NULL),(31,12,'Electorate',NULL,1,'2016-03-22 11:53:17',NULL),(32,12,'Ward',31,2,'2016-03-22 11:53:17',NULL),(33,12,'District',32,3,'2016-03-22 11:53:17',NULL),(34,12,'Place',33,4,'2016-03-22 11:53:17',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=753 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hierarchy_value`
--

LOCK TABLES `hierarchy_value` WRITE;
/*!40000 ALTER TABLE `hierarchy_value` DISABLE KEYS */;
INSERT INTO `hierarchy_value` VALUES (691,6,16,'Amersham Town',NULL,'2016-02-05 09:57:20',NULL,NULL),(692,6,17,'Amersham',NULL,'2016-02-05 09:58:27',NULL,691),(693,6,18,'Royal British Legion Hall',NULL,'2016-02-05 09:59:19',NULL,692),(731,12,31,'Aberdeen',NULL,'2016-03-22 11:55:20',NULL,NULL),(732,12,32,'Aberdeen South',NULL,'2016-03-22 11:55:20',NULL,731),(733,12,33,'KINGSWELLS SOUTH',NULL,'2016-03-22 11:55:20',NULL,732),(734,12,34,'KINGSWELLS COMMUNITY CENTRE',NULL,'2016-03-22 11:55:20',NULL,733),(735,12,33,'WOODEND',NULL,'2016-03-22 11:55:20',NULL,732),(736,12,34,'SHEDDOCKSLEY BAPTIST CHURCH',NULL,'2016-03-22 11:55:20',NULL,735),(737,12,33,'GILCOMSTON NORTH',NULL,'2016-03-22 11:55:20',NULL,732),(738,12,34,'NEW LIFE INTERNATIONAL CHURCH',NULL,'2016-03-22 11:55:20',NULL,737),(739,12,33,'GILCOMSTON SOUTH',NULL,'2016-03-22 11:55:20',NULL,732),(740,12,34,'ST MARY\'S CATHEDRAL HALL',NULL,'2016-03-22 11:55:20',NULL,739),(741,12,33,'WOOLMANHILL',NULL,'2016-03-22 11:57:21',NULL,732),(742,12,34,'CATHERINE STREET COMMUNITY CENTRE',NULL,'2016-03-22 11:57:21',NULL,741),(743,12,33,'PETERCULTER WEST',NULL,'2016-03-22 11:57:21',NULL,732),(744,12,34,'ST PETER\'S HERITAGE CENTRE',NULL,'2016-03-22 11:57:21',NULL,743),(745,12,33,'PETERCULTER EAST',NULL,'2016-03-22 11:57:21',NULL,732),(746,12,34,'PETERCULTER SPORTS CENTRE',NULL,'2016-03-22 11:57:21',NULL,745),(747,12,33,'MILLTIMBER',NULL,'2016-03-22 11:57:21',NULL,732),(748,12,34,'MILLTIMBER COMMUNITY HALL',NULL,'2016-03-22 11:57:21',NULL,747),(749,12,33,'BIELDSIDE',NULL,'2016-03-22 11:57:21',NULL,732),(750,12,34,'ST DEVENICK\'S CHURCH HALL',NULL,'2016-03-22 11:57:21',NULL,749),(751,12,33,'CULTS WEST',NULL,'2016-03-22 11:57:21',NULL,732),(752,12,34,'CULTS KIRK CENTRE',NULL,'2016-03-22 11:57:21',NULL,751);
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
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue`
--

LOCK TABLES `issue` WRITE;
/*!40000 ALTER TABLE `issue` DISABLE KEYS */;
INSERT INTO `issue` VALUES (428,6,171,NULL,235,'The heater at other end of hall has cables that are too short. Is it possible to have two extension leads? Aaron',2,NULL,'Hi Aaron. Lesley is going to bring two extension leads with her on her first inspection. We\'ll let you know when Lesley is leaving.',3,'2016-02-18 09:06:57',NULL,'apercival'),(429,6,171,NULL,235,'TEST - everything ok',1,NULL,'OK thanks',1,'2016-02-18 10:01:53','2016-02-18 10:04:51','apercival'),(430,6,171,NULL,232,'Power cut at hall. notified office and assistance will be on the way.\n\nphoned office at 10:45 and spoke to Lesley.',2,NULL,'Contacted key holder - locating fuse box to check if power can be restored. Blankets and lights to be delivered at next inspection. time to be confirmed.',3,'2016-02-18 10:52:54',NULL,'apercival'),(431,6,171,NULL,232,'Heating/Powercut update\n\nall ok now. issue was the extension lead that tripped the power. Using the other lead',1,NULL,'Ok thanks. Lesley will bring another extension lead, torches and blankets.',1,'2016-02-18 11:13:53','2016-02-18 11:17:53','apercival'),(432,6,171,NULL,235,'Hello Lesley. I had inputted a 1 on my side as well as Richards by accident so there should only be 3 not 4.',2,NULL,'Perfect thanks Aaron',2,'2016-02-18 18:11:23',NULL,'apercival'),(479,12,203,NULL,440,'hi',3,NULL,NULL,0,'2016-03-24 15:07:11',NULL,'McDonald'),(480,12,203,NULL,443,'t',2,NULL,NULL,0,'2016-03-24 15:08:50',NULL,'McDonald'),(481,12,203,NULL,443,'hi',2,NULL,'test',1,'2016-03-24 15:09:55','2016-03-24 15:22:20','McDonald'),(482,12,204,NULL,443,'hi',2,NULL,NULL,0,'2016-03-24 15:09:55',NULL,'McDonald'),(483,12,203,NULL,441,'Door slammed shut and cracked',2,NULL,'ghjkl',1,'2016-03-24 15:32:04','2016-03-24 15:59:56','McDonald'),(484,12,203,NULL,444,'ghjk',2,NULL,'hi',1,'2016-03-24 15:34:59','2016-03-24 15:59:08','McDonald');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_assignment`
--

LOCK TABLES `issue_assignment` WRITE;
/*!40000 ALTER TABLE `issue_assignment` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=489 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list`
--

LOCK TABLES `list` WRITE;
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` VALUES (227,6,22,'Staffing','Staffing',NULL),(228,6,22,'Accessibility','Accessibility',NULL),(229,6,22,'Logistics','Logistics',NULL),(230,6,22,'Security','Security',NULL),(231,6,22,'Ballot Papers','Ballot Papers',NULL),(232,6,22,'Health and Safety','Health and Safety',NULL),(233,6,22,'Problems with Register','Problems with Register',NULL),(234,6,22,'Postal and Proxy Voters','Postal and Proxy Voters',NULL),(235,6,22,'Other','Other',NULL),(257,6,24,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(258,6,24,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(259,6,24,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(260,6,24,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(261,6,24,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(262,6,24,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions? Is the ramp stable? If not, contact the elections office immediately. Are doormats flush with the floor? If not, remove them',6),(263,6,24,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(264,6,25,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(265,6,25,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(266,6,25,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(267,6,25,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(268,6,25,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(269,6,25,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(270,6,25,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(271,6,25,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(272,6,26,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed? Can a wheelchair user gain easy access to the ballot box(es)? Can a wheelchair user gain easy access to the polling booth?',1),(273,6,26,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(274,6,26,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(275,6,26,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(276,6,26,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(277,6,26,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(278,6,27,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(279,6,27,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(280,6,27,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(281,6,27,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(282,6,27,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(283,6,29,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(284,6,29,'Packet for marked register','Packet for marked register',2),(285,6,29,'Packet for certificates of employment','Packet for certificates of employment',3),(286,6,29,'Packet for various lists and declarations','Packet for various lists and declarations',4),(287,6,29,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(288,6,29,'Packet for CNL','Packet for CNL',6),(289,6,29,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(290,6,29,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(291,6,29,'Tactile voting device','Tactile voting device',9),(292,6,29,'Ballot box compactor','Ballot box compactor',10),(293,6,29,'Unused seals','Unused seals',11),(294,6,29,'Unused signs and notices etc.','Unused signs and notices etc.',12),(295,6,29,'Packet for ballot paper account','Packet for ballot paper account',13),(296,6,29,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(297,6,29,'Ballot Box(es)','Ballot Box(es)',15),(439,12,49,'Staffing','Staffing',0),(440,12,49,'Accessibility','Accessibility',0),(441,12,49,'Logistics','Logistics',0),(442,12,49,'Security','Security',0),(443,12,49,'Ballot Papers','Ballot Papers',0),(444,12,49,'Health and Safety','Health and Safety',0),(445,12,49,'Problems with Register','Problems with Register',0),(446,12,49,'Postal and Proxy Voters','Postal and Proxy Voters',0),(447,12,49,'Other','Other',0),(448,12,51,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),(449,12,51,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),(450,12,51,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),(451,12,51,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),(452,12,51,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),(453,12,51,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),(454,12,51,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),(455,12,52,'Is the polling station set up to make best us','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),(456,12,52,'Would the layout work if there was a build-up','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),(457,12,52,'Is best use being made of the lights and natu','Is best use being made of the lights and natural light available?',3),(458,12,52,'Is there a seat available if an elector needs','Is there a seat available if an elector needs to sit down?',4),(459,12,52,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),(460,12,52,'Is the notice that provides information on ho','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),(461,12,52,'As you walk through the route that the voter ','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),(462,12,52,'Have you ensured that the notices/posters are','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),(463,12,53,'Are the ballot box(es) placed immediately adj','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),(464,12,53,'Are polling booths correctly erected and in s','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),(465,12,53,'Have you ensured that polling booths are posi','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),(466,12,53,'Can the Presiding Officer and Poll Clerk obse','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),(467,12,53,'Is the string attached to the pencils long en','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),(468,12,53,'Is the tactile template available and in full','Is the tactile template available and in full view? Do all staff know how to use it?',6),(469,12,54,'Are the large-print ballot papers clearly vis','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),(470,12,54,'Are the ballot papers the correct ones for th','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),(471,12,54,'Are the ballot paper numbers on the correspon','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),(472,12,54,'Do the ballot paper numbers printed on the co','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),(473,12,54,'Do you have the correct register for your pol','Do you have the correct register for your polling station?',5),(474,12,55,'Packet for tendered ballot papers marked by v','Packet for tendered ballot papers marked by voters',1),(475,12,55,'Packet for marked register','Packet for marked register',2),(476,12,55,'Packet for certificates of employment','Packet for certificates of employment',3),(477,12,55,'Packet for various lists and declarations','Packet for various lists and declarations',4),(478,12,55,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),(479,12,55,'Packet for CNL','Packet for CNL',6),(480,12,55,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),(481,12,55,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),(482,12,55,'Tactile voting device','Tactile voting device',9),(483,12,55,'Ballot box compactor','Ballot box compactor',10),(484,12,55,'Unused seals','Unused seals',11),(485,12,55,'Unused signs and notices etc.','Unused signs and notices etc.',12),(486,12,55,'Packet for ballot paper account','Packet for ballot paper account',13),(487,12,55,'Postal votes – handed in but not previously c','Postal votes – handed in but not previously collected',14),(488,12,55,'Ballot Box(es)','Ballot Box(es)',15);
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_category`
--

LOCK TABLES `list_category` WRITE;
/*!40000 ALTER TABLE `list_category` DISABLE KEYS */;
INSERT INTO `list_category` VALUES (22,6,'issue',NULL),(24,6,'prepoll_activity_Outside_the_polling_station',1),(25,6,'prepoll_activity_Inside_the_polling_station',2),(26,6,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(27,6,'prepoll_activity_Ballot_papers',4),(29,6,'postpoll_activity',1),(49,12,'issue',NULL),(50,12,'issue_resolution',NULL),(51,12,'prepoll_activity_Outside_the_polling_station',1),(52,12,'prepoll_activity_Inside_the_polling_station',2),(53,12,'prepoll_activity_Polling_booths_and_ballot_boxes',3),(54,12,'prepoll_activity_Ballot_papers',4),(55,12,'postpoll_activity',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (333,6,'Hi AaronThere is no issue just sending you this as a test. Let me know if you receive this and hope all is ok.ThanksLesley','null','2016-02-18 07:39:27'),(334,6,'Test message to try notifications','null','2016-02-18 09:59:07'),(335,6,'Hi Aaron just got back to the office and Richard had 3 postals for me to bring back which I have done. There are 4 recorded on the system is that correct?ThanksLesley','null','2016-02-18 18:07:02'),(354,12,'ghjio','null','2016-03-24 15:03:05'),(355,12,'vbhjop','/data/media/Screenshot_2016-03-07-10-19-45.png','2016-03-24 15:03:18'),(356,12,'Hiii','null','2016-03-24 15:03:55');
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
) ENGINE=InnoDB AUTO_INCREMENT=660 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_status`
--

LOCK TABLES `notification_status` WRITE;
/*!40000 ALTER TABLE `notification_status` DISABLE KEYS */;
INSERT INTO `notification_status` VALUES (595,6,333,73,1,'2016-02-18 08:04:29',1),(596,6,333,76,0,NULL,1),(597,6,333,77,0,NULL,1),(598,6,333,78,0,NULL,1),(599,6,334,73,1,'2016-02-18 09:59:33',0),(600,6,334,74,0,NULL,0),(601,6,334,76,0,NULL,0),(602,6,334,77,0,NULL,0),(603,6,334,78,0,NULL,0),(604,6,335,73,1,'2016-02-18 18:09:01',1),(605,6,335,76,0,NULL,1),(606,6,335,77,0,NULL,1),(607,6,335,78,0,NULL,1),(639,12,354,103,0,NULL,0),(640,12,354,104,0,NULL,0),(641,12,354,105,0,NULL,0),(642,12,354,106,1,'2016-03-24 15:04:15',0),(643,12,354,107,0,NULL,0),(644,12,354,108,0,NULL,0),(645,12,354,109,0,NULL,0),(646,12,354,110,0,NULL,0),(647,12,354,111,0,NULL,0),(648,12,354,112,0,NULL,0),(649,12,355,103,0,NULL,0),(650,12,355,104,0,NULL,0),(651,12,355,105,0,NULL,0),(652,12,355,106,1,'2016-03-24 15:04:15',0),(653,12,355,107,0,NULL,0),(654,12,355,108,0,NULL,0),(655,12,355,109,0,NULL,0),(656,12,355,110,0,NULL,0),(657,12,355,111,0,NULL,0),(658,12,355,112,0,NULL,0),(659,12,356,106,1,'2016-03-24 15:04:13',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3385 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_close_election`
--

LOCK TABLES `open_close_election` WRITE;
/*!40000 ALTER TABLE `open_close_election` DISABLE KEYS */;
INSERT INTO `open_close_election` VALUES (1688,6,9,257,1,171),(1689,6,9,258,1,171),(1690,6,9,259,1,171),(1691,6,9,260,1,171),(1692,6,9,261,1,171),(1693,6,9,262,1,171),(1694,6,9,263,1,171),(1695,6,9,264,1,171),(1696,6,9,265,1,171),(1697,6,9,266,1,171),(1698,6,9,267,1,171),(1699,6,9,268,1,171),(1700,6,9,269,1,171),(1701,6,9,270,1,171),(1702,6,9,271,1,171),(1703,6,9,272,1,171),(1704,6,9,273,1,171),(1705,6,9,274,1,171),(1706,6,9,275,1,171),(1707,6,9,276,1,171),(1708,6,9,277,1,171),(1709,6,9,278,1,171),(1710,6,9,279,1,171),(1711,6,9,280,1,171),(1712,6,9,281,1,171),(1713,6,9,282,1,171),(1714,6,9,257,1,172),(1715,6,9,259,1,172),(1716,6,9,258,1,172),(1717,6,9,260,1,172),(1718,6,9,261,1,172),(1719,6,9,262,1,172),(1720,6,9,263,1,172),(1721,6,9,264,1,172),(1722,6,9,265,1,172),(1723,6,9,266,1,172),(1724,6,9,268,1,172),(1725,6,9,267,1,172),(1726,6,9,269,1,172),(1727,6,9,270,1,172),(1728,6,9,271,1,172),(1729,6,9,272,1,172),(1730,6,9,274,1,172),(1731,6,9,273,1,172),(1732,6,9,275,1,172),(1733,6,9,276,1,172),(1734,6,9,277,1,172),(1735,6,9,278,1,172),(1736,6,9,279,1,172),(1737,6,9,280,1,172),(1738,6,9,281,1,172),(1739,6,9,282,1,172),(1740,6,9,284,1,171),(1741,6,9,283,1,171),(1742,6,9,285,1,171),(1743,6,9,286,1,171),(1744,6,9,287,1,171),(1745,6,9,288,1,171),(1746,6,9,289,1,171),(1747,6,9,290,1,171),(1748,6,9,291,1,171),(1749,6,9,292,1,171),(1750,6,9,293,1,171),(1751,6,9,294,1,171),(1752,6,9,295,1,171),(1753,6,9,296,1,171),(1754,6,9,297,1,171),(1755,6,9,284,1,172),(1756,6,9,283,1,172),(1757,6,9,285,1,172),(1758,6,9,286,1,172),(1759,6,9,287,1,172),(1760,6,9,288,1,172),(1761,6,9,289,1,172),(1762,6,9,290,1,172),(1763,6,9,291,1,172),(1764,6,9,293,1,172),(1765,6,9,292,1,172),(1766,6,9,294,1,172),(1767,6,9,295,1,172),(1768,6,9,296,1,172),(1769,6,9,297,1,172),(3318,12,17,449,1,203),(3319,12,17,448,1,203),(3320,12,17,451,1,203),(3321,12,17,452,1,203),(3322,12,17,450,1,203),(3323,12,17,454,1,203),(3324,12,17,458,1,203),(3325,12,17,455,1,203),(3326,12,17,453,1,203),(3327,12,17,457,1,203),(3328,12,17,456,1,203),(3329,12,17,459,1,203),(3330,12,17,463,1,203),(3331,12,17,464,1,203),(3332,12,17,461,1,203),(3333,12,17,460,1,203),(3334,12,17,462,1,203),(3335,12,17,465,1,203),(3336,12,17,466,1,203),(3337,12,17,467,1,203),(3338,12,17,471,1,203),(3339,12,17,470,1,203),(3340,12,17,472,1,203),(3341,12,17,469,1,203),(3342,12,17,468,1,203),(3343,12,17,473,1,203),(3344,12,17,474,1,203),(3345,12,17,476,1,203),(3346,12,17,477,1,203),(3347,12,17,475,1,203),(3348,12,17,478,1,203),(3349,12,17,480,1,203),(3350,12,17,481,1,203),(3351,12,17,479,1,203),(3352,12,17,483,1,203),(3353,12,17,482,1,203),(3354,12,17,484,1,203),(3355,12,17,485,1,203),(3356,12,17,486,1,203),(3357,12,17,487,1,203),(3358,12,17,488,1,203),(3359,12,17,450,1,204),(3360,12,17,448,1,204),(3361,12,17,451,1,204),(3362,12,17,449,1,204),(3363,12,17,454,1,204),(3364,12,17,453,1,204),(3365,12,17,452,1,204),(3366,12,17,456,1,204),(3367,12,17,455,1,204),(3368,12,17,457,1,204),(3369,12,17,460,1,204),(3370,12,17,458,1,204),(3371,12,17,461,1,204),(3372,12,17,463,1,204),(3373,12,17,462,1,204),(3374,12,17,459,1,204),(3375,12,17,466,1,204),(3376,12,17,464,1,204),(3377,12,17,465,1,204),(3378,12,17,467,1,204),(3379,12,17,468,1,204),(3380,12,17,469,1,204),(3381,12,17,470,1,204),(3382,12,17,471,1,204),(3383,12,17,472,1,204),(3384,12,17,473,1,204);
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
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polling_station`
--

LOCK TABLES `polling_station` WRITE;
/*!40000 ALTER TABLE `polling_station` DISABLE KEYS */;
INSERT INTO `polling_station` VALUES (171,6,'Royal British Legion Hall Station 1 - RBLH01','','',693,'2016-02-05 10:00:58',NULL),(172,6,'Royal British Legion Hall Station 2 - RBLH02','','',693,'2016-02-05 10:01:35',NULL),(199,12,'DS0306/1','','',734,'2016-03-22 11:55:20',NULL),(200,12,'DS0308/1','','',736,'2016-03-22 11:55:20',NULL),(201,12,'CS0705/1','','',738,'2016-03-22 11:55:20',NULL),(202,12,'CS0705/2','','',738,'2016-03-22 11:55:20',NULL),(203,12,'CS0706/1','','',740,'2016-03-22 11:55:20',NULL),(204,12,'CS0706/2','','',740,'2016-03-22 11:55:20',NULL),(205,12,'CS0804/1','','',742,'2016-03-22 11:57:21',NULL),(206,12,'SS0901/1','','',744,'2016-03-22 11:57:21',NULL),(207,12,'SS0901/2','','',744,'2016-03-22 11:57:21',NULL),(208,12,'SS0902/1','','',746,'2016-03-22 11:57:21',NULL),(209,12,'SS0903/1','','',748,'2016-03-22 11:57:21',NULL),(210,12,'SS0903/2','','',748,'2016-03-22 11:57:21',NULL),(211,12,'SS0904/1','','',750,'2016-03-22 11:57:21',NULL),(212,12,'SS0904/2','','',750,'2016-03-22 11:57:21',NULL),(213,12,'SS0905/1','','',752,'2016-03-22 11:57:21',NULL),(214,12,'SS0905/2','','',752,'2016-03-22 11:57:21',NULL);
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
  PRIMARY KEY (`id`),
  KEY `psel_fk1_idx` (`organization_id`),
  KEY `psel_fk2_idx` (`polling_station_id`),
  KEY `psel_fk3_idx` (`election_id`),
  CONSTRAINT `psel_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `psel_fk2` FOREIGN KEY (`polling_station_id`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `psel_fk3` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polling_station_election`
--

LOCK TABLES `polling_station_election` WRITE;
/*!40000 ALTER TABLE `polling_station_election` DISABLE KEYS */;
INSERT INTO `polling_station_election` VALUES (36,6,171,9,1,1,'07:01:21',NULL,'2016-02-18 23:26:57','Ballot box 1',1,5000001,5001701,5000001,5000011),(37,6,172,9,1,1,'07:00:58',NULL,'2016-02-18 23:27:52','Ballot box 2',1,5001701,5003201,5000011,5000021),(84,12,199,17,0,0,'05:27:44',NULL,NULL,'0',0,10000,20000,10000,20000),(85,12,200,17,0,0,'15:53:49',NULL,'2016-03-23 13:30:39','0',0,10000,20000,10000,20000),(86,12,201,17,0,0,'11:45:22',NULL,'2016-03-24 11:29:46','0',0,10000,20000,10000,20000),(87,12,202,17,0,0,'09:37:00',NULL,NULL,'0',0,10000,20000,10000,20000),(88,12,203,17,1,1,'14:45:32',NULL,'2016-03-24 15:34:13','0',1,10000,20000,10000,20000),(89,12,204,17,1,1,'16:04:28',NULL,'2016-03-24 16:11:00','0',1,10000,20000,10000,20000),(90,12,205,18,0,0,'07:08:40',NULL,NULL,'0',0,10000,20000,10000,20000),(91,12,206,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000),(92,12,207,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000),(93,12,208,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000),(94,12,209,18,0,0,'11:03:41',NULL,NULL,'0',0,10000,20000,10000,20000),(95,12,210,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000),(96,12,211,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000),(97,12,212,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000),(98,12,213,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000),(99,12,214,18,0,0,'00:00:00',NULL,NULL,'0',0,10000,20000,10000,20000);
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
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polling_station_election_counting`
--

LOCK TABLES `polling_station_election_counting` WRITE;
/*!40000 ALTER TABLE `polling_station_election_counting` DISABLE KEYS */;
INSERT INTO `polling_station_election_counting` VALUES (21,6,171,9,5),(22,6,172,9,5),(70,12,199,17,14),(71,12,200,17,14),(72,12,201,17,14),(73,12,202,17,14),(74,12,203,17,14),(75,12,204,17,14),(76,12,205,18,15),(77,12,206,18,15),(78,12,207,18,15),(79,12,208,18,15),(80,12,209,18,15),(81,12,210,18,15),(82,12,211,18,15),(83,12,212,18,15),(84,12,213,18,15),(85,12,214,18,15);
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
INSERT INTO `tracking` VALUES (46,12,199,17,NULL,NULL,1,'address','2016-03-23 12:14:04',NULL,NULL,NULL,NULL),(47,12,200,17,'55.0128427','-7.313085300000001',1,'address','2016-03-23 12:28:44',NULL,NULL,NULL,NULL),(48,12,205,18,'55.012911599999995','-7.3132383',1,'address','2016-03-23 14:54:57',NULL,NULL,NULL,NULL),(49,12,203,17,'54.9291707','-6.9881692',1,'address','2016-03-23 16:26:15',NULL,NULL,NULL,NULL),(50,12,204,17,'54.9291707','-6.9881692',1,'address','2016-03-23 16:26:15',NULL,NULL,NULL,NULL),(52,12,201,17,'6.7904553','79.885915',1,'address','2016-03-24 12:45:28',NULL,NULL,NULL,NULL),(53,12,202,17,'6.7904553','79.885915',1,'address','2016-03-24 12:45:28',NULL,NULL,NULL,NULL);
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
  `user_id` int(11) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_election`
--

LOCK TABLES `user_election` WRITE;
/*!40000 ALTER TABLE `user_election` DISABLE KEYS */;
INSERT INTO `user_election` VALUES (30,6,73,6,171),(31,6,74,6,172),(33,6,76,6,171),(34,6,76,6,172),(35,6,77,6,171),(36,6,77,6,172),(47,6,73,9,171),(48,6,74,9,172),(50,6,76,9,171),(51,6,76,9,172),(52,6,77,9,171),(53,6,77,9,172),(55,6,73,9,172),(56,6,78,9,171),(57,6,78,9,172),(124,12,103,17,199),(125,12,104,17,200),(126,12,105,17,201),(127,12,105,17,202),(128,12,106,17,203),(129,12,106,17,204),(130,12,107,18,205),(131,12,108,18,206),(132,12,108,18,207),(133,12,109,18,208),(134,12,110,18,209),(135,12,110,18,210),(136,12,111,18,211),(137,12,111,18,212),(138,12,112,18,213),(139,12,112,18,214);
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
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
	select id into eid from psm.election 
		where election_name=ename and DATE(election_date_start)>current_date()-1 and organization_id=orgid;
	select id into stationid from psm.polling_station 
		where name=stationname and organization_id=orgid;
 
	UPDATE psm.polling_station_election SET ballotstart=bstartnumber, ballotend=bendnumber, 
		tenderstart=tstartnumber, tenderend=tendnumber
		WHERE organization_id=orgid and election_id=eid and polling_station_id=stationid;
	select 'success' as response;
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
            ballot_box_number,election_status,ballotend,ballotstart,tenderend,tenderstart,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,20000,10000,20000,10000,pollstationid;

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
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    select 
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
    cc.id as counting_center_id,
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
in usrname varchar(255),in user_password varchar(255))
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


/*Creating the Organization */    
insert into subscription.organization (name,code,area_name,logo_url,created_on,isactive,isdeleted) 
values (org_name,org_name,org_name,'assets/global/images/derry.jpg',current_timestamp(),1,0);

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
insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
	values (org_id,'Ward',LAST_INSERT_ID(),2,current_timestamp());
insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
	values (org_id,'District',LAST_INSERT_ID(),3,current_timestamp());
insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
	values (org_id,'Place',LAST_INSERT_ID(),4,current_timestamp()); 

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
				
				if((ballotstartnum+ballotpapers+tot_ballotpapers)<=(ballotendnum)) then
				
					update psm.election_stats est 
					set est.ballotpaper = ballotpapers, est.postalpack = postalpacks, est.postalpack_collected = postalpackscollected, est.spoilt_ballot = spoiltballots, est.ten_ballot_papers = tenballotpapers, est.ten_spoilt_ballots = tenspoiltballots
					where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
					and (HOUR(est.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(est.updatedon));
					
					select 'success' as response;
				else
					select 'invalidballotpapercount' as response;
				end if;
				
			else
			
				if((ballotstartnum+ballotpapers)<=(ballotendnum)) then
					insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon)
					values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'));
		  
					select 'success' as response;
				
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

-- Dump completed on 2016-03-25 12:09:35
CREATE DATABASE  IF NOT EXISTS `security` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `security`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: security
-- ------------------------------------------------------
-- Server version	5.6.29

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
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_token`
--

LOCK TABLES `access_token` WRITE;
/*!40000 ALTER TABLE `access_token` DISABLE KEYS */;
INSERT INTO `access_token` VALUES (105,6,76,'mbloxham|Amersham|95123fef931c00b7f5d79b9221fdf543','2016-02-16 12:00:45','2016-02-17 12:00:45'),(107,6,73,'apercival|Amersham|2ec1ea1c379e031fd1bb9c680a07899d','2016-02-16 12:16:40','2016-02-17 12:16:40'),(108,6,77,'lblue|Amersham|0760b2acba9615c980fb745eb667a9ba','2016-02-16 12:27:36','2016-02-17 12:27:36'),(112,6,73,'apercival|Amersham|f73f0ae99274320a3756e3d7479bbac6','2016-02-17 12:25:02','2016-02-18 12:25:02'),(113,6,77,'Lblue|Amersham|4fdc0e32b9f9a556e84dd40672a89c7c','2016-02-17 13:58:22','2016-02-18 13:58:22'),(114,6,78,'mdluser|Amersham|b1086567e3a8b84139f457ffe40b4c57','2016-02-17 15:08:58','2016-02-18 15:08:58'),(115,6,76,'mbloxham|Amersham|f9c80bf9950383d6f5bf73a6e6313a3e','2016-02-17 15:49:52','2016-02-18 15:49:52'),(116,6,73,'apercival|Amersham|e154b44f93097a87a48bf0da1a3bdf07','2016-02-18 12:25:23','2016-02-19 12:25:23'),(117,6,77,'lblue|Amersham|d85a3d39bf34894a23806da0e64d8d77','2016-02-18 13:59:37','2016-02-19 13:59:37'),(118,6,78,'MDLuser|Amersham|c3596f5b6d3ad7fd530dd2f88dff285e','2016-02-18 15:45:27','2016-02-19 15:45:27'),(119,6,76,'mbloxham|amersham|330ef9741ccd072f4842ae88324c9c0e','2016-02-18 15:50:18','2016-02-19 15:50:18'),(121,6,78,'mdluser|Amersham|b1d65d67354204fc1be21797d053e332','2016-02-22 14:14:02','2016-02-23 14:14:02'),(122,6,73,'apercival|Amersham|c40b1e84d66cafc90e2a7f4f5e85350d','2016-02-22 15:55:05','2016-02-23 15:55:05'),(123,6,78,'mdluser|Amersham|2e5d5844ee642438ae963422c5e21e73','2016-02-24 10:33:22','2016-02-25 10:33:22'),(127,6,73,'apercival|Amersham|9ed927e0deefaa4e4782a3390f3c2124','2016-02-24 12:55:19','2016-02-25 12:55:19'),(136,6,76,'mbloxham|Amersham|0c018b547c4baae0c4e000ff0abdcf74','2016-02-28 15:35:36','2016-02-29 15:35:36'),(165,12,102,'administrator|Mitra|224af07bbad1d3714d3c2e251fa4bf71','2016-03-22 11:54:19','2016-03-23 11:54:19'),(166,12,103,'bruce|Mitra|419d6c193830d19217e214ff24bf6381','2016-03-22 12:04:51','2016-03-23 12:04:51'),(167,12,105,'gow|mitra|38621b95aa21487ab6d7293982f71ec5','2016-03-22 12:09:18','2016-03-23 12:09:18'),(168,12,104,'Forbes|Mitra|02cd669c87b14ad19d5139764bddd500','2016-03-22 15:52:52','2016-03-23 15:52:52'),(169,12,107,'Twine|Mitra|a9e1953edabc63e297cdab8c46ce755f','2016-03-23 07:08:27','2016-03-24 07:08:27'),(170,12,106,'McDonald|Mitra|cfa587bf06ef7ddf0ea3e61a482771b4','2016-03-23 10:12:56','2016-03-24 10:12:56'),(171,12,110,'Pace|Mitra|3c929d88bbd0f4499c7b04a58037ae94','2016-03-23 11:03:18','2016-03-24 11:03:18'),(172,12,102,'administrator|mitra|0c27335b92f282ebc7cb7a0d25d42da8','2016-03-23 12:03:26','2016-03-24 12:03:26'),(173,12,103,'Bruce|mitra|0fddab719b3dfd60ac7ab660debe2827','2016-03-23 12:08:51','2016-03-24 12:08:51'),(174,12,104,'Forbes|mitra|dce97d7852ce0cdf9f5d224d5ff282d6','2016-03-24 04:40:03','2016-03-25 04:40:03'),(175,12,105,'Gow|Mitra|723ffbf860eedcfd90980595d1caa849','2016-03-24 05:51:04','2016-03-25 05:51:04'),(176,12,107,'Twine|Mitra|57d41ee44e156e1d8baf78626b8d6f65','2016-03-24 07:21:18','2016-03-25 07:21:18'),(177,12,106,'McDonald|Mitra|6dfab0d9a6d2626675e298b7472d15dd','2016-03-24 11:10:47','2016-03-25 11:10:47'),(178,12,102,'administrator|mitra|07fe93706325fff837cf298643785c1f','2016-03-24 12:10:02','2016-03-25 12:10:02'),(179,12,103,'bruce|Mitra|54b1949c53da2d320cc4c4725b3836d1','2016-03-24 13:51:11','2016-03-25 13:51:11');
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (16,6,'Presiding Officer','Presiding Officer','2016-02-05 10:02:37',NULL),(17,6,'Issue Resolver','Issue Resolver','2016-02-05 10:03:01',NULL),(18,6,'Election Manager','Election Manager','2016-02-05 10:03:22',NULL),(37,12,'Election Manager','Election Manager','2016-03-22 11:53:17',NULL),(38,12,'Presiding Officer','Presiding Officer','2016-03-22 11:53:17',NULL),(39,12,'Super Presiding Officer','Super Presiding Officer','2016-03-22 11:53:17',NULL),(40,12,'Issue Resolver','Issue Resolver','2016-03-22 11:53:17',NULL),(41,12,'Polling Station Inspector','Polling Station Inspector','2016-03-22 11:53:17',NULL),(42,12,'shai','super','2016-03-24 10:57:28',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=1194 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (594,6,16,1),(595,6,16,2),(596,6,16,3),(597,6,16,4),(598,6,16,5),(599,6,16,6),(600,6,16,7),(601,6,16,8),(602,6,16,9),(603,6,16,10),(604,6,16,11),(605,6,16,12),(606,6,16,13),(607,6,16,14),(608,6,16,15),(609,6,16,16),(610,6,16,17),(611,6,16,18),(612,6,16,19),(613,6,16,20),(614,6,16,21),(615,6,16,22),(616,6,16,23),(617,6,16,24),(618,6,16,25),(619,6,16,26),(620,6,16,27),(621,6,16,28),(622,6,16,29),(623,6,16,30),(624,6,16,31),(625,6,16,32),(657,6,17,1),(658,6,17,2),(659,6,17,3),(660,6,17,4),(661,6,17,5),(662,6,17,6),(663,6,17,7),(664,6,17,8),(665,6,17,9),(666,6,17,10),(667,6,17,11),(668,6,17,12),(669,6,17,13),(670,6,17,14),(671,6,17,15),(672,6,17,16),(673,6,17,17),(674,6,17,18),(675,6,17,19),(676,6,17,20),(677,6,17,21),(678,6,17,22),(679,6,17,23),(680,6,17,24),(681,6,17,25),(682,6,17,26),(683,6,17,27),(684,6,17,28),(685,6,17,29),(686,6,17,30),(687,6,17,31),(688,6,17,32),(720,6,18,1),(721,6,18,2),(722,6,18,3),(723,6,18,4),(724,6,18,5),(725,6,18,6),(726,6,18,7),(727,6,18,8),(728,6,18,9),(729,6,18,10),(730,6,18,11),(731,6,18,12),(732,6,18,13),(733,6,18,14),(734,6,18,15),(735,6,18,16),(736,6,18,17),(737,6,18,18),(738,6,18,19),(739,6,18,20),(740,6,18,21),(741,6,18,22),(742,6,18,23),(743,6,18,24),(744,6,18,25),(745,6,18,26),(746,6,18,27),(747,6,18,28),(748,6,18,29),(749,6,18,30),(750,6,18,31),(751,6,18,32),(1099,12,38,1),(1100,12,38,2),(1101,12,38,3),(1102,12,38,4),(1103,12,38,5),(1104,12,38,6),(1105,12,38,7),(1106,12,38,8),(1107,12,38,9),(1108,12,38,10),(1109,12,38,11),(1110,12,38,12),(1111,12,38,13),(1112,12,38,14),(1113,12,38,15),(1114,12,38,16),(1115,12,38,17),(1116,12,38,18),(1117,12,38,19),(1118,12,38,20),(1119,12,38,21),(1120,12,38,22),(1121,12,38,23),(1122,12,38,24),(1123,12,38,25),(1124,12,38,26),(1125,12,38,27),(1126,12,38,28),(1127,12,38,29),(1128,12,38,30),(1129,12,38,31),(1130,12,38,32),(1162,12,37,1),(1163,12,37,2),(1164,12,37,3),(1165,12,37,4),(1166,12,37,5),(1167,12,37,6),(1168,12,37,7),(1169,12,37,8),(1170,12,37,9),(1171,12,37,10),(1172,12,37,11),(1173,12,37,12),(1174,12,37,13),(1175,12,37,14),(1176,12,37,15),(1177,12,37,16),(1178,12,37,17),(1179,12,37,18),(1180,12,37,19),(1181,12,37,20),(1182,12,37,21),(1183,12,37,22),(1184,12,37,28),(1185,12,37,29),(1186,12,37,30),(1187,12,37,31),(1188,12,37,32),(1189,12,37,23),(1190,12,37,24),(1191,12,37,25),(1192,12,37,26),(1193,12,37,27);
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
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (73,6,'Aaron','Percival','sdonaghy@moderndemocracy.com','apercival','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-02-05 10:20:22',NULL,NULL,0),(74,6,'Barbara','Jeffries','sdonaghy@moderndemocracy.com','bjeffries','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-02-05 10:20:54',NULL,NULL,0),(76,6,'Mat','Bloxham','sdonaghy@moderndemocracy.com','mbloxham','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-02-05 10:21:40',NULL,NULL,0),(77,6,'Lesley','Blue','sdonaghy@moderndemocracy.com','lblue','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL','','2012-01-01','M','','en-GB',1,NULL,NULL,'2016-02-05 10:22:03',NULL,NULL,0),(78,6,'MDL','User','slappin@moderndemocracy.com','mdluser','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,'2012-01-01','M',NULL,'en-GB',1,NULL,NULL,'2016-02-17 10:22:03',NULL,NULL,0),(102,12,'administrator',' ',NULL,'administrator','4ff00acf9d9ed8147ba301263946a0a572bc0fb2','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:53:17',NULL,'/data/media/profile.jpg',0),(103,12,'Sandra','Bruce',NULL,'Bruce','28c9894a6fa5379f0aa641237a9ba5467e81e9b6','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:55:20',NULL,'/data/media/profile.jpg',0),(104,12,'Carol','Forbes',NULL,'Forbes','65ad6820478148806d28d04bf274ee0eb16f6e1c','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:55:20',NULL,'/data/media/profile.jpg',0),(105,12,'Stirling','Gow',NULL,'Gow','d5e146d1426387b0004985d96ec9d89375ccd4ea','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:55:20',NULL,'/data/media/profile.jpg',0),(106,12,'Karen','McDonald',NULL,'McDonald','2f98571df75624ae75bf90f2e5b5394ef7c1649d','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:55:20',NULL,'/data/media/profile.jpg',0),(107,12,'Peter','Twine',NULL,'Twine','7637fbf8702740e94d509a234c6a2284afdac0ab','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(108,12,'Morag','Barclay',NULL,'Barclay','775d1e3f03101684e6d64264c8b6949f342c8299','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(109,12,'Stuart','Reid',NULL,'Reid','90a58bf02a6acc66461f31666ab3af464ae90153','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(110,12,'Irene','Pace',NULL,'Pace','9ae0dd20f5ef5a7f8e8b5822645101050328caca','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(111,12,'Martin','Murchie',NULL,'Murchie','465ad0b6dc06b16e415cd55f2c222be78f4add8a','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0),(112,12,'Graham','Shand',NULL,'Shand','cbb1940dc0f32ca1f13256ce15af6229619130e1','S@l+VaL',NULL,NULL,NULL,NULL,'en-GB',1,NULL,NULL,'2016-03-22 11:57:21',NULL,'/data/media/profile.jpg',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (8,6,16,73),(9,6,17,74),(11,6,18,76),(12,6,18,77),(13,6,18,78),(57,12,37,102),(58,12,38,103),(59,12,38,104),(60,12,38,105),(61,12,38,105),(62,12,38,106),(63,12,38,106),(64,12,38,107),(65,12,38,108),(66,12,38,108),(67,12,38,109),(68,12,38,110),(69,12,38,110),(70,12,38,111),(71,12,38,111),(72,12,38,112),(73,12,38,112);
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

-- Dump completed on 2016-03-25 12:09:36
CREATE DATABASE  IF NOT EXISTS `subscription` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `subscription`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: subscription
-- ------------------------------------------------------
-- Server version	5.6.29

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
  PRIMARY KEY (`id`),
  KEY `org_code_idx` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (6,'Amersham','Amersham','Amersham',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2016-02-05 09:53:45',NULL,1,0),(12,'Mitra','Mitra','Mitra',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-03-22 11:53:17',NULL,1,0);
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

-- Dump completed on 2016-03-25 12:09:37
