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

-- Dump completed on 2016-04-01 17:40:35
