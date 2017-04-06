-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: psm
-- ------------------------------------------------------
-- Server version	5.5.47

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
  `tot_ballots2` int(11) NOT NULL,
  `tot_spolied_issued2` int(11) NOT NULL,
  `tot_unused2` int(11) NOT NULL,
  `tot_tend_ballots2` int(11) NOT NULL,
  `tot_tend_spoiled2` int(11) NOT NULL,
  `tot_tend_unused2` int(11) NOT NULL,
  `csv_export` int(11) NOT NULL,
  `csv_exporting_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `eleclost_fk1_idx` (`organization_id`),
  KEY `eleclost_fk2_idx` (`election_id`),
  KEY `eleclost_fk3_idx` (`polling_station_id`),
  CONSTRAINT `eleclost_fk1` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eleclost_fk2` FOREIGN KEY (`election_id`) REFERENCES `election` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eleclost_fk3` FOREIGN KEY (`polling_station_id`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4841 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-03 15:02:59
