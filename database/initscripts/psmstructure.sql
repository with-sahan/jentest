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
) ENGINE=InnoDB AUTO_INCREMENT=483 DEFAULT CHARSET=utf8 COMMENT='Using for viewing chat messages in issues';
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='Counting centers master table';
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `status` int(5) DEFAULT '0' COMMENT '0- uploaded\n1-processing the file\n2-validated with errors\n3-validated success',
  `updatedon` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=6011 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=1055 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=576 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=2789 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=378 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=377 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=698 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=5586 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=701 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=1155 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=1141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=1244 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
						select * FROM psm.election where election_name=ename and DATE(election_date_start) = election_date and organization_id=orgid
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
							select * FROM psm.election where election_name=ename and DATE(election_date_start) = election_date and organization_id=orgid
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
in user_name varchar(255), in passwords varchar(255),in eid int(11))
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
               
	end if; 
    
	select us.id into userid from security.user us where us.organization_id=orgid and us.username=user_name and us.is_deleted = 0; 
		
    insert into psm.user_election (organization_id,election_id,pollingstation_id,user_id)
			values (orgid,eid,pollstationid,userid);               
            
	insert into security.user_role (organization_id,user_id,role_id) 
			select orgid,userid,ro.id FROM security.role ro 
			where ro.name='Presiding Officer' and ro.organization_id=orgid;	
	select 'success' as response;		
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
/*!50003 DROP PROCEDURE IF EXISTS `getpollingstationsDetailsbyelectionid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationsDetailsbyelectionid`(in p_stationid int)
BEGIN
	SELECT name as response FROM psm.polling_station where id in (SELECT polling_station_id FROM psm.polling_station_election where election_id=p_stationid);
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

if(select not exists (select * FROM subscription.organization
				where code=org_name) 
	)then
			
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
    
    else
		select 'Already Exists';
    end if;
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

-- Dump completed on 2016-04-03 15:23:52
