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
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (59,'MDL','MDL','MDL',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-03 10:12:40',NULL,1,0,1),(60,'Ab','Ab','Ab',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-03 11:20:25',NULL,1,0,2),(61,'Derry','Derry','Derry',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-03 20:35:56',NULL,1,0,1),(62,'Aberdeen','Aberdeen','Aberdeen',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-03 20:36:14',NULL,1,0,2),(63,'mdl2','mdl2','mdl2',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-06 13:41:26',NULL,1,0,1),(64,'Aberdeen2','Aberdeen2','Aberdeen2',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-07 06:39:16',NULL,1,0,2),(65,'abs','abs','abs',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-08 13:52:07',NULL,1,0,2),(66,'prod_qa','prod_qa','prod_qa',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-08 14:00:51',NULL,1,0,2),(67,'AberdeenTraining','AberdeenTraining','AberdeenTraining',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-08 14:30:43',NULL,1,0,2),(68,'SandwellTraining','SandwellTraining','SandwellTraining',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-08 14:30:44',NULL,1,0,1),(69,'MidsussexTraining','MidsussexTraining','MidsussexTraining',NULL,NULL,NULL,NULL,NULL,NULL,'midsussex.png','2016-04-08 14:30:44',NULL,1,0,1),(70,'DudleyTraining','DudleyTraining','DudleyTraining',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-08 14:30:45',NULL,1,0,1),(71,'SheffieldTraining','SheffieldTraining','SheffieldTraining',NULL,NULL,NULL,NULL,NULL,NULL,'sheffield.png','2016-04-08 14:30:45',NULL,1,0,1),(72,'AberdeenTraining1','AberdeenTraining1','AberdeenTraining1',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-08 14:30:45',NULL,1,0,2),(73,'SandwellTraining1','SandwellTraining1','SandwellTraining1',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-08 14:30:46',NULL,1,0,1),(74,'MidSussexLive-backup','MidSussexLive-backup','MidSussexLive-backup',NULL,NULL,NULL,NULL,NULL,NULL,'midsussex.png','2016-04-08 14:30:46',NULL,1,0,1),(75,'DudleyTraining1','DudleyTraining1','DudleyTraining1',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-08 14:30:47',NULL,1,0,1),(76,'SheffieldTraining1','SheffieldTraining1','SheffieldTraining1',NULL,NULL,NULL,NULL,NULL,NULL,'sheffield.png','2016-04-08 14:30:47',NULL,1,0,1),(77,'Aberdeen1','Aberdeen1','Aberdeen1',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-08 15:06:21',NULL,1,0,2),(78,'Sandwell1','Sandwell1','Sandwell1',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-08 15:06:33',NULL,1,0,2),(79,'MidSussex1','MidSussex1','MidSussex1',NULL,NULL,NULL,NULL,NULL,NULL,'midsussex.png','2016-04-08 15:06:54',NULL,1,0,2),(80,'mdl3','mdl3','mdl3',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-08 15:15:57',NULL,1,0,1),(81,'Aberdeen11','Aberdeen11','Aberdeen11',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-11 10:21:13',NULL,1,0,2),(83,'SheffieldTraining10','SheffieldTraining10','SheffieldTraining10',NULL,NULL,NULL,NULL,NULL,NULL,'sheffield.png','2016-04-11 14:35:31',NULL,1,0,1),(84,'PerformanceMdl','PerformanceMdl','PerformanceMdl',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-12 15:14:19',NULL,1,0,1),(85,'DudleyTraining2','DudleyTraining2','DudleyTraining2',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-12 19:50:59',NULL,1,0,1),(86,'testSL','testSL','testSL',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-15 12:10:32',NULL,1,0,1),(87,'mdlPerf','mdlPerf','mdlPerf',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-15 14:05:00',NULL,1,0,1),(88,'SandwellTraining05','SandwellTraining05','SandwellTraining05',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-19 06:10:11',NULL,1,0,1),(89,'MidSussexTraining05','MidSussexTraining05','MidSussexTraining05',NULL,NULL,NULL,NULL,NULL,NULL,'midsussex.png','2016-04-19 06:10:41',NULL,1,0,1),(90,'DudleyLive-backup2','DudleyLive-backup2','DudleyLive-backup2',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-19 06:11:11',NULL,1,0,1),(91,'SandwellTraining02','SandwellTraining02','SandwellTraining02',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-19 08:23:17',NULL,1,0,1),(92,'Aberdeen19','Aberdeen19','Aberdeen19',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-19 08:31:23',NULL,1,0,1),(93,'midsussexlive-b','midsussexlive-b','midsussexlive-b',NULL,NULL,NULL,NULL,NULL,NULL,'midsussex.png','2016-04-19 10:29:47',NULL,1,0,1),(94,'DudleyTraining02','DudleyTraining02','DudleyTraining02',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-19 10:29:56',NULL,1,0,1),(95,'Thanuja','Thanuja','Thanuja',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-19 10:33:37',NULL,1,0,1),(96,'SandwellTraining03','SandwellTraining03','SandwellTraining03',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-19 11:06:40',NULL,1,0,1),(97,'sandwelltraining10','sandwelltraining10','sandwelltraining10',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-19 17:19:22',NULL,1,0,1),(98,'sandwelltraining11','sandwelltraining11','sandwelltraining11',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-19 17:19:34',NULL,1,0,1),(99,'DudleyTraining10','DudleyTraining10','DudleyTraining10',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-19 17:49:05',NULL,1,0,1),(100,'DudleyLive','DudleyLive','DudleyLive',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-19 17:49:11',NULL,1,0,1),(101,'MitraDudleyTest','MitraDudleyTest','MitraDudleyTest',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-19 18:21:01',NULL,1,0,1),(102,'MidSussexTraining10','MidSussexTraining10','MidSussexTraining10',NULL,NULL,NULL,NULL,NULL,NULL,'midsussex.png','2016-04-19 18:55:03',NULL,1,0,1),(103,'DudleyLive-backup','DudleyLive-backup','DudleyLive-backup',NULL,NULL,NULL,NULL,NULL,NULL,'dudley.png','2016-04-19 18:56:30',NULL,1,0,1),(104,'SandwellTraining20','SandwellTraining20','SandwellTraining20',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-19 19:40:47',NULL,1,0,1),(105,'SandwellTraining21','SandwellTraining21','SandwellTraining21',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-20 01:36:35',NULL,1,0,1),(106,'Aberdeen21','Aberdeen21','Aberdeen21',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-21 08:25:42',NULL,1,0,1),(107,'AberdeenS','AberdeenS','AberdeenS',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-21 08:28:46',NULL,1,0,2),(108,'SheffieldLive2','SheffieldLive2','SheffieldLive2',NULL,NULL,NULL,NULL,NULL,NULL,'sheffield.png','2016-04-22 08:25:15',NULL,1,0,1),(109,'SheffieldLive-backup','SheffieldLive-backup','SheffieldLive-backup',NULL,NULL,NULL,NULL,NULL,NULL,'sheffield.png','2016-04-22 11:12:00',NULL,1,0,1),(110,'AberdeenLive','AberdeenLive','AberdeenLive',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-22 12:45:32',NULL,1,0,2),(111,'SandwellLive2','SandwellLive2','SandwellLive2',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-27 20:13:05',NULL,1,0,1),(112,'SheffieldLive000','SheffieldLive000','SheffieldLive000',NULL,NULL,NULL,NULL,NULL,NULL,'sheffield.png','2016-04-27 20:13:22',NULL,1,0,1),(113,'prod-10','prod-10','prod-10',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-28 05:09:27',NULL,1,0,1),(114,'prod-11','prod-11','prod-11',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-28 05:09:27',NULL,1,0,1),(115,'prod-12','prod-12','prod-12',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-28 05:09:28',NULL,1,0,1),(116,'prod-13','prod-13','prod-13',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-28 05:09:28',NULL,1,0,1),(117,'prod-14','prod-14','prod-14',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-28 05:09:29',NULL,1,0,1),(118,'SandwellLive','SandwellLive','SandwellLive',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-28 15:39:00',NULL,1,0,1),(119,'SandwellMDLTest','SandwellMDLTest','SandwellMDLTest',NULL,NULL,NULL,NULL,NULL,NULL,'sandwell.png','2016-04-28 15:51:23',NULL,1,0,1),(121,'midsussexlive','midsussexlive','midsussexlive',NULL,NULL,NULL,NULL,NULL,NULL,'midsussex.png','2016-04-29 07:38:01',NULL,1,0,1),(123,'SheffieldLive','SheffieldLive','SheffieldLive',NULL,NULL,NULL,NULL,NULL,NULL,'sheffield.png','2016-04-29 08:18:07',NULL,1,0,1),(124,'AberdeenNextTest','AberdeenNextTest','AberdeenNextTest',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-29 11:08:15',NULL,1,0,2),(125,'AberdeenNextTest2','AberdeenNextTest2','AberdeenNextTest2',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-04-29 14:09:04',NULL,1,0,1),(126,'AberdeenNextLive','AberdeenNextLive','AberdeenNextLive',NULL,NULL,NULL,NULL,NULL,NULL,'aberdeen.png','2016-04-29 15:49:35',NULL,1,0,2),(127,'dev111','dev111','dev111',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-05-02 08:02:33',NULL,1,0,1),(128,'dev_new','dev_new','dev_new',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-05-02 08:52:24',NULL,1,0,1),(129,'dev_123','dev_123','dev_123',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-05-02 09:25:46',NULL,1,0,1),(130,'dev-fresh','dev-fresh','dev-fresh',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-05-18 05:00:33',NULL,1,0,1),(131,'AberdeenSJDL','AberdeenSJDL','AberdeenSJDL',NULL,NULL,NULL,NULL,NULL,NULL,'assets/global/images/derry.jpg','2016-05-20 10:16:14',NULL,1,0,2);
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
INSERT INTO `permission` VALUES (1,1,'getpollingstations','NULL','NULL','getpollingstations'),(2,1,'getnewnotifications','NULL','NULL','getnewnotifications'),(3,1,'readnotification','NULL','NULL','readnotification'),(4,1,'getallnotifications','NULL','NULL','getallnotifications'),(5,1,'getlist','NULL','NULL','getlist'),(6,1,'getprepollactivities','NULL','NULL','getprepollactivities'),(7,1,'updateprepollactivity','NULL','NULL','updateprepollactivity'),(8,1,'openstation','NULL','NULL','openstation'),(9,1,'getissuelist','NULL','NULL','getissuelist'),(10,1,'getissuepriority','NULL','NULL','getissuepriority'),(11,1,'reportissue','NULL','NULL','reportissue'),(12,1,'getclosestats','NULL','NULL','getclosestats'),(13,1,'updateclosestats','NULL','NULL','updateclosestats'),(14,1,'closepollingstation','NULL','NULL','closepollingstation'),(15,1,'getpollingstations','NULL','NULL','getpollingstations'),(16,1,'starttrack','NULL','NULL','starttrack'),(17,1,'gettrackingstatus','NULL','NULL','gettrackingstatus'),(18,1,'getnewnotificationpulse','NULL','NULL','getnewnotificationpulse'),(19,1,'getorginfo','NULL','NULL','getorginfo'),(20,1,'getelectionsbystationid','NULL','NULL','getelectionsbystationid'),(21,1,'getprogress','NULL','NULL','getprogress'),(22,1,'updateprogress','NULL','NULL','updateprogress'),(23,3,'getallroles','NULL','NULL','getallroles'),(24,3,'getnotificationbyid','NULL','NULL','getnotificationbyid'),(25,3,'getglobalnotifications','NULL','NULL','getglobalnotifications'),(26,3,'getallclosestats','NULL','NULL','getallclosestats'),(27,3,'getallclosestatssummary','NULL','NULL','getallclosestatssummary'),(28,1,'resolveissue','NULL','NULL','resolveissue'),(29,1,'getissuebyid','NULL','NULL','getissuebyid'),(30,1,'assignissue','NULL','NULL','assignissue'),(31,1,'getallusers','NULL','NULL','getallusers'),(32,1,'updateissue','NULL','NULL','updateissue');
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
    declare userid int(11);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare user_role_id int(11);    
    declare role_result int(11); 
    
    declare psi_id int(11);    
    declare psm_id int(11);    
    declare em_id int(11);
    declare ro_id int(11);    
    declare ir_id int(11);    
    declare pc_id int(11);
    declare sa_id int(11);

    set spcode='getorginfo';
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    set userid=(select id FROM security.user u where u.organization_id=orgid and u.username=username);
    set psm_id=(select id from security.role where organization_id=orgid and name='Presiding Officer');
    set psi_id=(select id from security.role where organization_id=orgid and name='Polling Station Inspector');
    set em_id=(select id from security.role where organization_id=orgid and name='Election Manager');
    
    set ro_id=(select id from security.role where organization_id=orgid and name='Returning officer');
    set ir_id=(select id from security.role where organization_id=orgid and name='Issue Resolver');
    set pc_id=(select id from security.role where organization_id=orgid and name='Polling clerks');
    set sa_id=(select id from security.role where organization_id=orgid and name='Super Admin');
    
    set user_role_id=(select distinct role_id FROM security.user_role where user_id=userid and organization_id=orgid);
    
    if (user_role_id=psm_id) then
		select 1 into role_result;
    elseif (user_role_id=em_id) then
		select 2 into role_result;
	elseif (user_role_id=psi_id) then
		select 3 into role_result;  
    elseif (user_role_id=ir_id) then
		select 4 into role_result;
	elseif (user_role_id=ro_id) then
		select 5 into role_result;  
    elseif (user_role_id=pc_id) then
		select 6 into role_result; 
    elseif (user_role_id=sa_id) then
		select 7 into role_result;      
    else select 0 into role_result; 
    end if;    
    
    if (security.fn_validate_token(token)=1) then
		select 'success' as response,org.name as organization,role_result as roletype,
        org.logo_url as logourl,concat(us.firstname,' ',us. lastname) as userfullname  
        from security.user us
        inner join subscription.organization org on us.organization_id=org.id
        where org.code=orgcode and us.username=username;
    else
		select 'unauthorized' as response,null as organization,null as logourl,null as userfullname,null as roletype;
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

-- Dump completed on 2016-05-25 14:55:39
