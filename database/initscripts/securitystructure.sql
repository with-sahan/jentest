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
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=6990 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=427 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2016-04-03 15:24:38
