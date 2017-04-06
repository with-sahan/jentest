-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: ec2-52-48-101-197.eu-west-1.compute.amazonaws.com    Database: security
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2
use `security`;
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
in email varchar(127),in username varchar(127),in userpassword varchar(127),in language_id int)
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
			insert into security.user (organization_id,firstname,lastname,email,username,passwordhash,language_id) 
            values (orgid,firstname,lastname,email,username,sha1(CONCAT('S@l+VaL',userpassword)) ,language_id);
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
/*!50003 DROP PROCEDURE IF EXISTS `updatepassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatepassword`(IN token VARCHAR(255),
IN newpass VARCHAR(45),in adminpass varchar(255),in userid int(11))
BEGIN
    declare orgcode varchar(45);
    declare orgid int;
    declare usersname varchar(45);
    
    set usersname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    if(select not exists (select * FROM security.user u
				where u.passwordhash=sha1(CONCAT(u.passwordsalt,adminpass)) 
                and u.organization_id=orgid and u.username=usersname) 
		)then
			select 'unauthorized' as response;
     else 
		update security.user u set u.passwordhash = sha1(CONCAT(u.passwordsalt,newpass)) 
                where u.id=userid;
     select 'success' as response;       
	 end if;  
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
in lastname varchar(127),in email varchar(127),in username varchar(127),in roleid int)
BEGIN

	declare orgcode varchar(45);
    declare orgid int(11);
    set orgcode=security.SPLIT_STR(token,'|',2);    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		update security.user usr set usr.firstname=firstname,
        usr.lastname=lastname,usr.email=email,usr.username=username,usr.updatedon=current_timestamp where
        usr.id=userid;      
        
        DELETE from security.user_role where user_id=userid and organization_id=orgid;

		INSERT INTO security.user_role (organization_id,role_id,user_id) values (orgid,roleid,userid);
        
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

-- Dump completed on 2016-04-29 20:09:53
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: ec2-52-48-101-197.eu-west-1.compute.amazonaws.com    Database: psm
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2
use `psm`;
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
-- Dumping routines for database 'psm'
--
/*!50003 DROP FUNCTION IF EXISTS `getactivationdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getactivationdate`() RETURNS varchar(255) CHARSET utf8
BEGIN

    DECLARE response varchar(255);
    select '2016-04-30' into response;
RETURN response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getarrivaltime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getarrivaltime`(trackid int) RETURNS varchar(255) CHARSET utf8
BEGIN

	/*DECLARE arrivaltime timestamp;
	DECLARE trackstatus int;
	DECLARE hours varchar(5);   
    DECLARE response varchar(255);
    select status into trackstatus from psm.tracking where id=trackid;
    
    select SUBSTRING_INDEX(TIMEDIFF(deliver_time, dispatch_time),':',1)
		into hours from psm.tracking where id=trackid;
    
	if (trackstatus=2) then
		if(hours='00') then
			select CONCAT(
			SUBSTR(TIMEDIFF(deliver_time, dispatch_time), INSTR(TIMEDIFF(deliver_time, dispatch_time), ':')+1, 2), ' minutes') 
			into response from psm.tracking where id=trackid;        
        else
			select CONCAT(hours,' hours ',
			SUBSTR(TIMEDIFF(deliver_time, dispatch_time), INSTR(TIMEDIFF(deliver_time, dispatch_time), ':')+1, 2), ' minutes') 
			into response from psm.tracking where id=trackid;
        end if;    
	else
		select ' ' into response;
    end if;    */
    DECLARE response varchar(255);
	select deliver_time into response from psm.tracking where id=trackid;
RETURN response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `activeelection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `activeelection`(in orgid int)
BEGIN
update psm.election set election_date_start=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 7 HOUR),
 '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),
 election_date_end=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 22 HOUR),
 '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),status=0 
 where organization_id=orgid;

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
		set t.status=2,t.deliver_time=CURRENT_TIMESTAMP
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
/*!50003 DROP PROCEDURE IF EXISTS `collectpostalpacks_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `collectpostalpacks_v2`(in token varchar(255), in stationdid int, in electionid int, 
in person_name varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
    
		insert into psm.postal_packs_collected (organization_id,electionid,polling_station_id,
			uplifting_person_name,postalpack_collected) select orgid,electionid,stationdid,person_name,
            (sum(postalpack) - sum(postalpack_collected)) 
            FROM psm.election_stats where organization_id=orgid and electionid=electionid and polling_station_id=stationdid;
    
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
in counting_center_longitude varchar(45), in BPA_identifier int,in ballot_type_count int)
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare csvstructure int(11);
    declare added_election_id int(11);
    declare current_time_short varchar(10);
    declare current_time_short_modified varchar(10);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    SELECT csvstructureid into csvstructure FROM subscription.organization where id=orgid;
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
				insert into psm.election (organization_id,election_name,election_date_start,election_date_end,status,BPA_identifier,ballot_type_count) 
				values (orgid,ename,CONCAT(election_date,' ',start_time),CONCAT(election_date,' ',end_time),0,BPA_identifier,ballot_type_count);
				
				set added_election_id = (SELECT id FROM psm.election ORDER BY id DESC LIMIT 1);
				#insert to psm.counting_center
				insert into psm.counting_center (name,organization_id,election_id,latitude,longitude,address) 
				values (counting_center_name,orgid,added_election_id,counting_center_latitude,counting_center_longitude,counting_center_address);
				
				#insert to psm.ballot_paper_type
                if(csvstructure=1) then
					insert into psm.ballot_paper_type (election_id,organization_id) values(added_election_id,orgid);
                else
					insert into psm.ballot_paper_type (election_id,organization_id,value_1,value_2) values(added_election_id,orgid,'CONSTITUENCY PAPER','REGIONAL PAPER');
                end if;
                
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
					insert into psm.election (organization_id,election_name,election_date_start,election_date_end,status,BPA_identifier,ballot_type_count) 
					values (orgid,ename,CONCAT(election_date,' ',start_time),CONCAT(election_date,' ',end_time),0,BPA_identifier,ballot_type_count);
					
					set added_election_id = (SELECT id FROM psm.election ORDER BY id DESC LIMIT 1);
					#insert to psm.counting_center
					insert into psm.counting_center (name,organization_id,election_id,latitude,longitude,address) 
					values (counting_center_name,orgid,added_election_id,counting_center_latitude,counting_center_longitude,counting_center_address);
                    
						#insert to psm.ballot_paper_type
					if(csvstructure=1) then
						insert into psm.ballot_paper_type (election_id,organization_id) values(added_election_id,orgid);
					else
						insert into psm.ballot_paper_type (election_id,organization_id,value_1,value_2) values(added_election_id,orgid,'CONSTITUENCY PAPER','REGIONAL PAPER');
					end if;
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
/*!50003 DROP PROCEDURE IF EXISTS `findPollingStationDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `findPollingStationDetails`(IN Array_String TEXT)
BEGIN
SELECT distinct pc.name as key_contact_name ,pc.phone as contact_details,  hv.value as place,ps.name as polling_station,pse.isopen as is_open,pse.isclose as is_close FROM psm.polling_station_election as pse 
inner join psm.polling_station ps on pse.polling_station_id=ps.id
inner join psm.hierarchy_value hv on hv.id=ps.hierarchy_value_id
inner join psm.polling_contacts pc on pc.pollingstation_id = ps.id
where FIND_IN_SET(hierarchy_value_id, Array_String) and pc.primary_contact=1;
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
    declare tot_ballots2 int;
	declare tot_spolied_issued2 int;
    declare tot_unused2 int;
    declare tot_tend_ballots2 int;
	declare tot_tend_spoiled2 int;
    declare tot_tend_unused2 int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    select ballotstart,ballotend,tenderstart,tenderend 
    into start_count,end_count,tend_start_count,tend_end_count
    from psm.polling_station_election where organization_id=orgid and polling_station_id=stationid and election_id=electionid;
    
    if (security.fn_validate_token(token)=1 ) then
		select ifnull(sum(ballotpaper),0),
        ifnull(sum(spoilt_ballot),0),
        (end_count+1)-start_count -ifnull(sum(ballotpaper),0),
        ifnull(sum(ten_ballot_papers),0),
        ifnull(sum(ten_spoilt_ballots),0),
        (tend_end_count+1) - tend_start_count - ifnull(sum(ten_ballot_papers),0),
        
        ifnull(sum(ballotpaper2),0),
        ifnull(sum(spoilt_ballot2),0),
        (end_count+1)-start_count -ifnull(sum(ballotpaper2),0),
        ifnull(sum(ten_ballot_papers2),0),
        ifnull(sum(ten_spoilt_ballots2),0),
        (tend_end_count+1) - tend_start_count - ifnull(sum(ten_ballot_papers2),0)
        into
        tot_ballots,tot_spolied_issued,tot_unused,tot_tend_ballots,tot_tend_spoiled,tot_tend_unused,
        tot_ballots2,
        tot_spolied_issued2,
        tot_unused2,
        tot_tend_ballots2,
        tot_tend_spoiled2,
        tot_tend_unused2
        
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
        tot_ballots2,
        tot_spolied_issued2,
        tot_unused2,
        tot_tend_ballots2,
        tot_tend_spoiled2,
        tot_tend_unused2,
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
        tot_ballots2,
        tot_spolied_issued2,
        tot_unused2,
        tot_tend_ballots2,
        tot_tend_spoiled2,
        tot_tend_unused2,
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
/*!50003 DROP PROCEDURE IF EXISTS `getallclosestatssummary_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallclosestatssummary_v2`(in token varchar(255), in eid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare return_queries int(100);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getallclosestatssummary';
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
    
		select count(*) into return_queries 
        from         
        psm.election_close_stats ecs    
		where ecs.organization_id=orgid and
        ecs.election_id = eid and
        UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()); 
        
        if (return_queries>0) then
        
			select sum(ecs.tot_ballots) as sum_tot_ballots,
			sum(ecs.tot_spolied_issued) as sum_tot_spoiled_replaced,
			sum(ecs.tot_unused) as sum_tot_unused,
			sum(ecs.tot_tend_ballots) as sum_tot_tend_ballots,
			sum(ecs.tot_tend_spoiled) as sum_tot_tend_spoiled,
			sum(ecs.tot_tend_unused) as sum_tot_tend_unused, 
			ecs.election_id as electionid,
			'success' as response from         
			psm.election_close_stats ecs    
			where ecs.organization_id=orgid and
			ecs.election_id = eid and
			UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) 
			group by ecs.election_id; 
		
        else 
        
			select null as sum_tot_ballots,
			null as sum_tot_spoiled_replaced,
			null as sum_tot_unused,
			null as sum_tot_tend_ballots,
			null as sum_tot_tend_spoiled,
			null as sum_tot_tend_unused, 
			null as electionid,
			'nodata' as response; 
		
        end if;
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
/*!50003 DROP PROCEDURE IF EXISTS `getallclosestats_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallclosestats_v2`(in token varchar(255), in eid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare return_queries int(100);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getallclosestats';
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
    
		select count(*) into return_queries
        from psm.election_close_stats ecs
        inner join psm.election el on el.id=election_id
        inner join psm.polling_station ps on ps.id=polling_station_id
		where ecs.organization_id=orgid 
        and el.id=eid 
        and UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) ; 
        
        if(return_queries>0) then
    
			select ecs.tot_ballots,ecs.tot_spolied_issued as tot_spoiled_replaced,
			ecs.tot_unused,ecs.tot_tend_ballots,
			ecs.tot_tend_spoiled,ecs.tot_tend_unused,
			ecs.tot_ballots2,ecs.tot_spolied_issued2 as tot_spoiled_replaced2,
			ecs.tot_unused2,ecs.tot_tend_ballots2,
			ecs.tot_tend_spoiled2,ecs.tot_tend_unused2,
			el.election_name as electionname,
			ps.name as pollingstation, el.Id as electionid,
            hv.value as pollingstation_place,
            hv.parent_id as parent_id,
            hv.id as hierarchy_value_id,
            'success' as response 
			from psm.election_close_stats ecs
			inner join psm.election el on el.id=election_id
			inner join psm.polling_station ps on ps.id=polling_station_id
            inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id
			where ecs.organization_id=orgid 
			and el.id=eid 
			and UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) ; 
		else 
			select null as tot_ballots, null as tot_spoiled_replaced, null as tot_unused,
            null as tot_tend_ballots, null as tot_tend_spoiled, null as tot_tend_unused,
            null as tot_ballots2, null as tot_spoiled_replaced2, null as tot_unused2,
            null as tot_tend_ballots2, null as tot_tend_spoiled2, null as tot_tend_unused2,
            null as electionname,null as pollingstation, null as electionid,
            null as pollingstation_place,
            'nodata' as response;
		end if;
    else
		select null as tot_ballots, null as tot_spoiled_replaced, null as tot_unused, 
        null as tot_tend_ballots, null as tot_tend_spoiled, null as tot_tend_unused, 
        null as tot_ballots2, null as tot_spoiled_replaced2, null as tot_unused2,
        null as tot_tend_ballots2, null as tot_tend_spoiled2, null as tot_tend_unused2,
        null as electionname,null as pollingstation, null as electionid,
        null as pollingstation_place,
        'unauthorized' as response; 
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllIssueIdsAssignedInOrganization` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getAllIssueIdsAssignedInOrganization`()
BEGIN

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
        where 
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
/*!50003 DROP PROCEDURE IF EXISTS `getallissues_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getallissues_v2`(in token varchar(255), in stationid int)
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
        where  
        isu.organization_id=orgid and lst.organization_id=orgid and 
        ps.id=stationid and
        ps.organization_id=orgid order by isu.createdon desc;
        /*where  UNIX_TIMESTAMP(isu.createdon) > UNIX_TIMESTAMP(CURDATE())  and */
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
			where org.code=orgcode and usr.username=username order by nt.createdon desc ;
            /*where org.code=orgcode and usr.username=username and date(nt.createdon)=date(current_date) order by nt.createdon desc ;*/
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
/*!50003 DROP PROCEDURE IF EXISTS `getAssignedIssues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getAssignedIssues`(in token varchar(255))
BEGIN
 SELECT id as id,issue_id as issueid FROM psm.issue_assignment;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getassignmentcountalert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getassignmentcountalert`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare usernameissue varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    declare useridother int(11);
    
    set usernameissue=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    select id into useridother from security.user where username = usernameissue and organization_id=orgid;
    
    if (security.fn_validate_token(token)=1) then
        
        select count(issue_assignment.id) as issueassigncount,
			(SELECT cc.issue_id FROM psm.issue_assignment cc where cc.organization_id=orgid and
					cc.user_id=useridother ORDER BY cc.issue_id DESC LIMIT 1 ) as issue_id,
			(SELECT issue.pollingstation_id FROM psm.issue issue where issue.organization_id=orgid and
					issue.reportedby=usernameissue ORDER BY issue.id DESC LIMIT 1 ) as pollingstationid,
		"success" as response
		from psm.issue_assignment issue_assignment 
		where issue_assignment.organization_id=orgid 
		and issue_assignment.user_id=(select id from security.user where username = usernameissue  and organization_id=orgid); 

    else 
		select null as issueassigncount, null as issue_id, null as pollingstationid, "unauthorized" as response;
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
/*!50003 DROP PROCEDURE IF EXISTS `getballotpapernames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getballotpapernames`(in token varchar(255), in electionid int)
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select value_1 as paper1,value_2 as paper2,'success' as response 
        from psm.ballot_paper_type 
        where election_id=electionid and organization_id=orgid;
    else
		select null as paper1,null as paper2,'unauthorized' as response;
    end if;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getballottypecount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getballottypecount`(in token varchar(255),in electionid int(11))
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select 'success' as response, el.ballot_type_count as typecount 
        FROM psm.election el 
        where el.organization_id=organizationid and el.id=electionid;
    
    else select 'unauthorized' as response, null as typecount;
    
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
        where
        chat.userid=usr.id and isu.id=issueid and usr.organization_id=organizationid order by chat.createdon desc;
        /*  where  UNIX_TIMESTAMP(chat.createdon) > UNIX_TIMESTAMP(CURDATE())  and */
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
    select id into useridother from security.user where username = usernamechat and organization_id=orgid;
    
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
/*!50003 DROP PROCEDURE IF EXISTS `getchatcountalert_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getchatcountalert_v2`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare usernamechat varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    declare useridother int(11);
    
    set usernamechat=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    select id into useridother from security.user where username = usernamechat and organization_id=orgid;
    
    if (security.fn_validate_token(token)=1) then
        
        select count(chat.chatid) as chatcount, (SELECT cc.issueid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 ) as issueid,
        (SELECT cc.pollingstationid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 ) as pollingstationid,
        issue.status as issue_status,
        "success" as response from psm.chat chat
        inner join psm.issue issue on issue.id = (SELECT cc.issueid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 )
		where 
		chat.organizationid=orgid and
        chat.userid<>useridother and
		usernamechat=(SELECT issue.reportedby FROM psm.issue issue where issue.id = 
        (SELECT cc.issueid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 ));
        /*where  date(chat.createdon)=date(current_date)  and*/
    else 
		select null as chatcount, null as issueid, null as pollingstationid, null as issue_status, "unauthorized" as response;
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
    
	select tot_ballots,tot_ballots2,tot_spolied_issued,tot_spolied_issued2,tot_unused,tot_unused2,tot_tend_ballots,tot_tend_ballots2,tot_tend_spoiled,tot_tend_spoiled2,tot_tend_unused,tot_tend_unused2, 'ok' as response from 
        psm.election_close_stats
		where election_id=electionid and polling_station_id = pollingstationid and organization_id = orgid ; 
    else
	select null as tot_ballots,null as tot_ballots2,null as tot_spoiled_issued,null as tot_spoiled_issued2,null as tot_unused,null as tot_unused2,null as tot_tend_ballots,null as tot_tend_ballots2,null as tot_tend_spoiled,null as tot_tend_spoiled2,null as tot_tend_unused,null as tot_tend_unused2,'unauthorized' as response; 
  
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
        election.ballot_type_count as ballot_type_count,
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
    
    
    if (security.fn_validate_token(token)=1 ) then
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
/*!50003 DROP PROCEDURE IF EXISTS `getIssuesReportedByUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getIssuesReportedByUsers`(token varchar(255),IN userIds TEXT)
BEGIN

    declare spcode varchar(45);
    

    set spcode = 'getIssuesReportedByUsers';
    
    
      if (security.fn_validate_token(token)=1) then

			select *  from psm.issue_assignment as ia
            inner join psm.issue as i on i.id=ia.issue_id
            where FIND_IN_SET(user_id, userIds);


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
/*!50003 DROP PROCEDURE IF EXISTS `getmapcenter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getmapcenter`(in token varchar(255))
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
		SELECT latitude,longitude,'success' as response 
        FROM psm.counting_center where organization_id=orgid group by organization_id;
    else
		select null as latitude,null as longitude,'unauthorized' as response;
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
			where org.code=orgcode and usr.username=username and ns.status=0;
           /* where org.code=orgcode and usr.username=username and ns.status=0 and date(nt.createdon)=date(current_date);*/
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
/*!50003 DROP PROCEDURE IF EXISTS `getplaceslist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getplaceslist`(in token varchar(255))
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare election_id int;
    declare organizationid int(11);
     declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getplaceslist';
    
	
    if (security.fn_validate_token(token)=1) then
    
    select id into organizationid from subscription.organization where code = orgcode;
    
	SELECT id into userid FROM security.user where user.username=username and user.organization_id=organizationid;
   
        
SELECT ps.hierarchy_value_id as hierarchy_value_id, hv.value as hierarchy_value_name, 'success' as response  FROM psm.polling_station as ps 
inner join  psm.hierarchy_value hv on hv.id=ps.hierarchy_value_id and hv.organization_id=ps.organization_id
where ps.id in (SELECT ue.pollingstation_id  FROM psm.user_election as ue where ue.user_id=userid and ue.organization_id=organizationid group by ue.pollingstation_id);
       
   
   
    else
		select null as hierarchy_value_id, null as hierarchy_value_name, 'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpollingcontacts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingcontacts`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int(11);
	declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
	select id into userid from security.user u where u.username = username and u.organization_id=orgid;
    
    
    if (security.fn_validate_token(token)=1) then
		SELECT distinct
		pc1.id as id, 
		pc1.description as description1, 
		pc1.name as name1, 
        pc1.address as address1, 
		pc1.phone as phone1, 
		pc1.email as email1, 
        pc1.mobile as mobile1, 
		pc1.primary_contact as primary_contact1, 
        pc1.pollingstation_id as pollingstation_id1,
        ps.name as pollingstation_name,
		IFNULL(pc2.description,'') as description2, 
		IFNULL(pc2.name,'') as name2, 
        IFNULL(pc2.address,'') as address2, 
		IFNULL(pc2.phone,'') as phone2, 
		IFNULL(pc2.email,'') as email2, 
        IFNULL(pc2.mobile,'') as mobile2, 
		IFNULL(pc2.primary_contact,'') as primary_contact2, 
        IFNULL(pc2.pollingstation_id,'') as pollingstation_id2,
        'success' as response
        FROM psm.polling_contacts pc1
		inner join psm.polling_station ps on ps.id=pc1.pollingstation_id 
		inner join psm.user_election ue on ue.organization_id=orgid and ue.user_id=userid 
		and ue.pollingstation_id=pc1.pollingstation_id 
		left outer join psm.polling_contacts pc2 on pc1.pollingstation_id = pc2.pollingstation_id
         and pc2.organization_id=orgid and pc2.primary_contact=0
        where ps.organization_id=orgid and pc1.organization_id=orgid 
		and pc1.primary_contact=1  
		order by pc1.id asc;
    else
		select null as id, 
		null as description1,
        null  as name1, 
		null as address1, 
		null as phone1,
        null as email1, 
		null as mobile1, 
		null as primary_contact1,
        null as pollingstation_id1, 
        null as pollingstation_name,
		null  as name2, 
		null as address2, 
		null as phone2,
        null as email2, 
		null as mobile2, 
		null as primary_contact2,
        null as pollingstation_id2, 
		'unauthorized' as response;
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
			where u.username = username and org.code=orgcode and el.is_deleted=0 ; 
        
		/*	where u.username = username and org.code=orgcode and date(el.election_date_start)=date(current_date) and el.is_deleted=0 ; */
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
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationsDetailsbyelectionid`(in token varchar(255),in electionid int(11))
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
	set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then    
		select ifnull((pse.ballotend-pse.ballotstart) ,0) as ballotrange, 
		ifnull((pse.tenderend-pse.tenderstart),0) as tenderedrange,
		ps.name as stationname,
		pse.ballot_box_number as boxnumber,
		hv.value as place,
        ps.id as stationid,
		ifnull(concat(uu.firstname,' ',uu.lastname) , '') as psmname,
        'success' as response
		FROM psm.polling_station_election pse 
		inner join psm.polling_station ps on ps.id=pse.polling_station_id
		inner join psm.hierarchy_value hv on hv.id=ps.hierarchy_value_id
		inner join psm.user_election ue on pse.polling_station_id=ue.pollingstation_id
		inner join security.user uu on uu.id=ue.user_id
		where pse.organization_id=orgid and pse.election_id=electionid 
        and ue.election_id=electionid and ue.organization_id=orgid group by ps.id;
    else select 
    'null' as ballotrange,
    'null' as tenderedrange,
    'null' as stationname,
    'null' as boxnumber,
    'null' as place,
    'null' as psmname,
    'null' as stationid,
    'unauthorized' as response;    
	end if;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getpollingstationsDetailsbyStationid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationsDetailsbyStationid`(in token varchar(255),in stationid int(11))
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
	set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then    
		select ifnull((pse.ballotend-pse.ballotstart) ,0) as ballotrange, 
		ifnull((pse.tenderend-pse.tenderstart),0) as tenderedrange,
		ps.name as stationname,
		pse.ballot_box_number as boxnumber,
		hv.value as place,
        ps.id as stationid,
		ifnull(concat(uu.firstname,' ',uu.lastname) , '') as psmname,
        'success' as response
		FROM psm.polling_station_election pse 
		inner join psm.polling_station ps on ps.id=pse.polling_station_id
		inner join psm.hierarchy_value hv on hv.id=ps.hierarchy_value_id
		inner join psm.user_election ue on pse.polling_station_id=ue.pollingstation_id
		inner join security.user uu on uu.id=ue.user_id
		where pse.organization_id=orgid and ue.organization_id=orgid and pse.polling_station_id=stationid
        and ps.id=stationid and ue.pollingstation_id=stationid group by ps.id;
    else select 
    'null' as ballotrange,
    'null' as tenderedrange,
    'null' as stationname,
    'null' as boxnumber,
    'null' as place,
    'null' as psmname,
    'null' as stationid,
    'unauthorized' as response;    
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
/*!50003 DROP PROCEDURE IF EXISTS `getpollingstations_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstations_v2`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getpollingstations_v2';
    
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then
    
		/** get polling stations **/
		select distinct ps.id as polling_station_id, ps.name as polling_station_name, 
        ps.address as polling_station_address, ps.postcode as polling_station_postcode, 
        ps.createdon as opentime, ps.organization_id as organization_id, 
        'success' as response from psm.polling_station ps 
		inner join psm.polling_station_election pse on ps.id = pse.polling_station_id  
		inner join psm.election el on el.id=pse.election_id
		inner join psm.user_election ue on ue.election_id = pse.election_id and 
        ue.pollingstation_id  = pse.polling_station_id
		where el.is_deleted=0 
        and ps.organization_id=orgid; 
		/*where date(el.election_date_start)=date(current_date) and el.is_deleted=0 */
        
        
    else
		select null as id, null as name,null as address, null as postcode, null as opentime, 'unauthorized' as response;
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
        IFNULL(uplifting_person_name,'') as uplifting_person_name,
		SUM(es.ballotpaper) as ballotpapers,
        SUM(es.ballotpaper2) as ballotpapers2,
        SUM(es.postalpack) as postalpacks,
        SUM(es.postalpack2) as postalpacks2,
        SUM(es.postalpack_collected) as postalpackscollected,
        SUM(es.postalpack_collected2) as postalpackscollected2,
        SUM(es.spoilt_ballot) as spoilt_ballots,
        SUM(es.spoilt_ballot2) as spoilt_ballots2,
        SUM(es.ten_ballot_papers) as ten_ballot_papers, 
        SUM(es.ten_ballot_papers2) as ten_ballot_papers2, 
        SUM(es.ten_spoilt_ballots) as ten_spoilt_ballots,
        SUM(es.ten_spoilt_ballots2) as ten_spoilt_ballots2,
        'success' as response
		from psm.election_stats es 
		where es.organization_id = orgid and es.electionid = electionid 
        and es.polling_station_id = pollingstationid and HOUR(es.updatedon) = updatehour and UNIX_TIMESTAMP(DATE(es.updatedon)) = UNIX_TIMESTAMP(CURDATE())
		group by es.electionid, es.polling_station_id, es.organization_id; 
	elseif (BPAIdentifier=1) then
		select BPAIdentifier, ballotstartnum,
        ballotendnum, tenderedstartnum, tenderedendnum,
        IFNULL(uplifting_person_name,'') as uplifting_person_name,
		SUM(es.ballotpaper) as ballotpapers,
        SUM(es.ballotpaper2) as ballotpapers2,
        SUM(es.postalpack) as postalpacks,
        SUM(es.postalpack2) as postalpacks2,
        SUM(es.postalpack_collected) as postalpackscollected,
        SUM(es.postalpack_collected2) as postalpackscollected2,
        SUM(es.spoilt_ballot) as spoilt_ballots,
        SUM(es.spoilt_ballot2) as spoilt_ballots2,
        SUM(es.ten_ballot_papers) as ten_ballot_papers, 
        SUM(es.ten_ballot_papers2) as ten_ballot_papers2, 
        SUM(es.ten_spoilt_ballots) as ten_spoilt_ballots,
        SUM(es.ten_spoilt_ballots2) as ten_spoilt_ballots2,
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
/*!50003 DROP PROCEDURE IF EXISTS `getpsichecklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getpsichecklist`(in token varchar(255), in placeid int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare election_id int;
    declare organizationid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getpsichecklist';
    
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
	
		if (select exists 
			(
				select * from psm.psi_check_list pcl
				inner join psm.list l on pcl.list_id = l.id
				inner join psm.list_category lc on l.list_category_id = lc.id
				where pcl.place_id=placeid 
				and lc.name like 'psi_checklist%' 
			)
		) then 
		
			select  l.id as id,
			l.list_value as activity,
			lc.name as category,
			pcl.iscompleted as iscompleted,
            placeid,
			'success' as response
			from psm.psi_check_list pcl
			inner join psm.list l on pcl.list_id = l.id
			inner join psm.list_category lc on l.list_category_id = lc.id
			where pcl.place_id=placeid
			and lc.name like 'psi_checklist%';
 
		else 

			select
			l.id as id,
			l.list_value as activity,
			lc.name as category,
            0 as iscompleted,
            placeid,
			'success' as response 
			from psm.list l
			inner join psm.list_category lc on l.list_category_id = lc.id 
			where lc.name like 'psi_checklist%';
            
           /* select
			l.id as id,
			l.list_value as activity,
			lc.name as category,
            0 as iscompleted,
            placeid,
			'success' as response 
			from psm.list l
			inner join psm.list_category lc on l.list_category_id = lc.id 
			inner join psm.hierarchy_value hv on hv.organization_id=l.organization_id
			where hv.id=placeid and lc.name like 'psi_checklist%';
            */
 
		end if;
        
    else
		select null as id, null as activity, null as category, null as iscompleted, 'unauthorized' as response;
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
			where org.code=orgcode and usr.username=username
            order by nt.createdon desc limit 7;
            /*where org.code=orgcode and usr.username=username and nt.createdon >= CURDATE()*/
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
    psm.getarrivaltime(track.id) as arrivaltime,
	td.ballot_box_number,
    track.status as status, 
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
/*!50003 DROP PROCEDURE IF EXISTS `getuniquepsichecklistcategories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getuniquepsichecklistcategories`(in token varchar(255), in place_id int)
BEGIN
 if (security.fn_validate_token(token)=1) then
 
 select distinct lc.name as categoryname, 'success' as response
			from psm.list l 
			inner join psm.list_category lc on l.list_category_id = lc.id
			where lc.name like 'psi_checklist%';
 
 /* select distinct lc.name as categoryname, 'success' as response
			from psm.psi_check_list pcl
			inner join psm.list l on pcl.list_id = l.id
			inner join psm.list_category lc on l.list_category_id = lc.id
			where lc.name like 'psi_checklist%' and place_id=place_id;*/
  else
		select  'unauthorized' as response,null as categoryname;
    
 end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUnTrackedIssueNotifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getUnTrackedIssueNotifications`(in token varchar(255))
BEGIN

  declare user_name varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    
    set user_name=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);

if (security.fn_validate_token(token)=1) then

  
     select id into orgid from subscription.organization where code=orgcode;
    
	SELECT id into userid FROM security.user where username=user_name and organization_id=orgid;
   # set userid=405;

	select it.id as issuenotificationid, ps.name as pollingstationname, i.id as issueid , i.description as description, 'success' as response from psm.issue_tracking as it
    inner join psm.issue i on i.id= it.issue_id
    inner join psm.polling_station ps on ps.id=i.pollingstation_id
    where user_id=userid and it.watched=0
    order by i.createdon desc;
    
  else
  	select null as issueid , null as description,'unauthorized' as response;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getunwatchedissuelist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getunwatchedissuelist`(token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getunwatchedissuelist';
    
    if (security.fn_validate_token(token)=1) then

        
			SELECT id,description FROM psm.issue where watched=0;
        
   
    else
		select null as id, null as description, 'unauthorized' as response;
    end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getupliftingperson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getupliftingperson`(in token varchar(255),
 in stationid int ,in electionid int )
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select ppc.postalpack_collected as collectedpacks, ppc.uplifting_person_name as person,
			ppc.collected_time as collectedtime,'success' as response
			from psm.postal_packs_collected ppc
			where ppc.organization_id=orgid and 
            ppc.electionid=electionid and 
            ppc.polling_station_id=stationid and
            UNIX_TIMESTAMP(ppc.collected_time) > UNIX_TIMESTAMP(CURDATE());       
    else
		select "unauthorized" as response,null as collectedpacks,null as person, null as collectedtime;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getuserbyissueid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getuserbyissueid`(in orgid int,in issueid int)
BEGIN
	
		select i.reportedby as userName, u.id as userId, u.firstname as firstName, u.lastname as lastName,'success' as response
		from psm.issue i
		inner join security.user u on u.username=i.reportedby and u.organization_id=i.organization_id
		where i.id=issueid and i.organization_id=orgid;
        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUsersByRoleIds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getUsersByRoleIds`(in token varchar(255),IN role_id_list TEXT)
BEGIN

declare orgid int;
declare roleid int;
declare orgcode varchar(45);

set orgcode=security.SPLIT_STR(token,'|',2);
    

if (security.fn_validate_token(token)=1 )
then
	
	SELECT u.firstname,u.lastname,u.username,u.id,'success' as response FROM security.user_role ur
		inner join  security.user u on u.id=ur.user_id
		where FIND_IN_SET(ur.role_id, role_id_list);

else
	select 'unauthorized' as response;
     
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
    declare role_sa_id int(11);
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
		values (org_id,'Super Admin','Super Admin',current_timestamp());
    select LAST_INSERT_ID() into role_sa_id;
    
    insert into security.role (organization_id,name,description,createdon) 
		values (org_id,'Returning officer','Returning officer',current_timestamp());

	insert into security.role (organization_id,name,description,createdon) 
		values (org_id,'Polling clerks','Polling clerks',current_timestamp());
		
	insert into security.role (organization_id,name,description,createdon) 
		values (org_id,'Issue Resolver','Issue Resolver',current_timestamp());
		
	insert into security.role (organization_id,name,description,createdon) 
		values (org_id,'Polling Station Inspector','Polling Station Inspector',current_timestamp());


	/* Adding user to a role */ 
	insert into security.user_role (organization_id,role_id,user_id) 
	value (org_id,role_sa_id,usr_id);


	/* Giving Permissions to roles */ 
	insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Presiding Officer' and ro.organization_id=org_id;
            
	insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,role_em_id,id FROM subscription.permission;  
    
    insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,role_sa_id,id FROM subscription.permission;  
            
	insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Returning officer' and ro.organization_id=org_id;   
            
    insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Issue Resolver' and ro.organization_id=org_id;  
    
    insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Polling clerks' and ro.organization_id=org_id; 
            
	insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Polling Station Inspector' and ro.organization_id=org_id;  
	 
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
/*!50003 DROP PROCEDURE IF EXISTS `insertPSI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertPSI`(in username varchar(255), in orgid int,in pollingstationname varchar(255),in electionid int)
BEGIN
declare userid int(11);
declare roleid int(11);
declare pollingstationid int(11);

select id into userid from security.user where security.user.username=username and security.user.organization_id=orgid;

SELECT id into roleid FROM security.role where security.role.organization_id=orgid and name='Polling Station Inspector';
 
if not exists ( select * from security.user_role where security.user_role.organization_id = orgid and security.user_role.role_id=roleid and security.user_role.user_id=userid) then
	insert into security.user_role(organization_id,role_id,user_id) values (orgid,roleid,userid);
 end if;
 
 
 SELECT id into pollingstationid FROM psm.polling_station where psm.polling_station.name=pollingstationname and psm.polling_station.organization_id=orgid;

insert into psm.user_election(organization_id,user_id,election_id,pollingstation_id) values (orgid,userid,electionid,pollingstationid);
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
CREATE DEFINER=`root`@`%` PROCEDURE `isopenisclosed`(IN strIDs VARCHAR(3000))
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
/*!50003 DROP PROCEDURE IF EXISTS `markIssueNotificationsAsWatched` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `markIssueNotificationsAsWatched`(in token varchar(255),in issuenotificationid int)
BEGIN
if (security.fn_validate_token(token)=1 ) then
	UPDATE psm.issue_tracking SET watched=1 where id=issuenotificationid;
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
    declare notification_id int(11);
    declare issue_id int(11);
    
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
			
            #make notification
            #insert into psm.notification (organization_id,message,createdon ) values(orgid , description  ,CURRENT_TIMESTAMP);
			#SELECT LAST_INSERT_ID() as notification_id;
          
          #make tracking notification
         # SELECT LAST_INSERT_ID() as issue_id;
          #insert into psm.issue_tracking(issue_id,user_id,watched) values (issue_id,1,0);
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
/*!50003 DROP PROCEDURE IF EXISTS `reportissue_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `reportissue_v2`(token varchar(255),election_id int, polling_station_id int, issue_list_id int, description text, priority int )
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare notification_id int(11);
    declare issue_id int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'reportissue';
    select id into orgid from subscription.organization where code = orgcode;
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
			if (election_id =-1) then
				insert into issue(organization_id, pollingstation_id,issue_list_id, description,priority, status,reportedby)
				values(orgid,polling_station_id,issue_list_id, description,priority,0,username);
				select LAST_INSERT_ID() as response;
            else
				insert into issue(organization_id, pollingstation_id, electionid,issue_list_id, description,priority, status,reportedby)
				values(orgid,polling_station_id, election_id,issue_list_id, description,priority,0,username);
				select LAST_INSERT_ID() as response;
            end if;
			
           
        else
			select   -2 as response;
        end if;
    else
		select -3 as response;
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

DELETE it
	FROM psm.issue_tracking it
	INNER JOIN psm.issue i
	ON i.id=it.issue_id
	where i.organization_id=organizationid;
delete from psm.notification_status where organization_id=organizationid;
delete from psm.notification where organization_id=organizationid;
delete from psm.issue_assignment;
delete from psm.issue where organization_id=organizationid;

delete from psm.election_stats where organization_id=organizationid and electionid=electionid;
delete from psm.election_close_stats where election_id=electionid;
delete from psm.open_close_election where election_id=electionid;
delete from psm.station_photo where election_id=electionid;
delete from psm.tracking where election_id=electionid;
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
CREATE DEFINER=`root`@`%` PROCEDURE `starttrack`(in token varchar(255), in longtitude varchar(45) ,in latitude varchar(45) )
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
            
              update psm.tracking as t
			  inner join psm.user_election ue on t.election_id = ue.election_id 
              and t.pollingstationid = ue.pollingstation_id and ue.organization_id = t.organization_id 
			  inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
			  inner join election e on ue.election_id = e.id
			  set t.dispatch_time=CURRENT_TIMESTAMP,t.status=1,t.latitude= latitude,t.longtitude=longtitude
			  where u.organization_id = orgid
			  and u.username= username and  date(e.election_date_start)=date(current_date);
              
			select "tracking already started" as response;
        else
			insert into psm.tracking (organization_id,pollingstationid,election_id,
            deliver_address,dispatch_time,status,latitude,longtitude)
			select ue.organization_id, ue.pollingstation_id, ue.election_id,'address',
            CURRENT_TIMESTAMP,1,latitude,longtitude
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
in counting_center_longitude varchar(45), in BPAidentifier int,in ballot_type_count int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare electionid int(11);
    declare userid int(11);
    declare added_counting_center_id int(11);
	declare current_time_short varchar(10);
    declare current_time_short_modified varchar(10);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'updateelection';
    
    select id into organizationid from subscription.organization where code = orgcode;
    select id into electionid from psm.election where id = election_id;
    
    SELECT id into added_counting_center_id FROM psm.counting_center cc where cc.election_id=election_id;
	
	select LEFT(CURTIME() , 5) into current_time_short;
	
	if(UNIX_TIMESTAMP(election_date) > UNIX_TIMESTAMP(CURDATE())) then
    
		if (security.fn_validate_token(token)=1) then
        
			if(select exists 
					(					
						select * FROM psm.election where election_name=ename and organization_id=organizationid
                        and id!=electionid
						) 
				) then
				select 'dataduplicate' as response;
			else
				#update psm.election
				update psm.election
				set election_name=ename, election_date_start=CONCAT(election_date,' ',start_time),
				election_date_end=CONCAT(election_date,' ',end_time), status=0, BPA_identifier=BPAidentifier,ballot_type_count=ballot_type_count
				where id=electionid;
				
				#update psm.counting_center
				update psm.counting_center
				set name=counting_center_name, latitude=counting_center_latitude, longitude=counting_center_longitude, address=counting_center_address
				where id=added_counting_center_id;
				
				select 'success' as response;
			end if;
		else
			select 'unauthorized' as response;
		end if;
		
	elseif(UNIX_TIMESTAMP(election_date) = UNIX_TIMESTAMP(CURDATE())) then
	
		if(start_time >= current_time_short) then
		
			if (security.fn_validate_token(token)=1) then
            
				if(select exists 
						(					
							select * FROM psm.election where election_name=ename and organization_id=organizationid
							and id!=electionid
							) 
					) then
					select 'dataduplicate' as response;
				else
					#update psm.election
					update psm.election
					set election_name=ename, election_date_start=CONCAT(election_date,' ',start_time),
					election_date_end=CONCAT(election_date,' ',end_time), status=0, BPA_identifier=BPAidentifier,ballot_type_count=ballot_type_count
					where id=electionid;
					
					#update psm.counting_center
					update psm.counting_center
					set name=counting_center_name, latitude=counting_center_latitude, longitude=counting_center_longitude, address=counting_center_address
					where id=added_counting_center_id;
					
					select 'success' as response;
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
    declare notificationid int;
    
    set spcode='updateissue';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        #delete previous assignments
        /*delete from psm.issue_assignment where issue_id=issueid and organization_id=orgid;
		insert into psm.issue_assignment (organization_id,issue_id,user_id)
		values (orgid,issueid,userid);*/
        
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
in spoiltballots int,in tenballotpapers int,in tenspoiltballots int,in updatetime int,
in ballotpapers2 int, in postalpacks2 int, in postalpackscollected2 int,
in spoiltballots2 int,in tenballotpapers2 int,in tenspoiltballots2 int)
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
                set est.ballotpaper = ballotpapers,
				est.postalpack = postalpacks,
				est.postalpack_collected = postalpackscollected,
				est.spoilt_ballot = spoiltballots,
				est.ten_ballot_papers = tenballotpapers,
				est.ten_spoilt_ballots = tenspoiltballots,
				est.ballotpaper2 = ballotpapers2,
				est.postalpack2 = postalpacks2,
				est.postalpack_collected2 = postalpackscollected2,
				est.spoilt_ballot2 = spoiltballots2,
				est.ten_ballot_papers2 = tenballotpapers2,
				est.ten_spoilt_ballots2 = tenspoiltballots2
                where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
                and (HOUR(est.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(est.updatedon));
				
				select 'success' as response;
                
			else
				insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon,ballotpaper2, postalpack2, postalpack_collected2,spoilt_ballot2,ten_ballot_papers2,ten_spoilt_ballots2)
				values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'),ballotpapers2,postalpacks2,postalpackscollected2,spoiltballots2,tenballotpapers2,tenspoiltballots2);
	  
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
				
						update psm.election_stats est 
						set est.ballotpaper = ballotpapers,
                        est.postalpack = postalpacks,
                        est.postalpack_collected = postalpackscollected,
                        est.spoilt_ballot = spoiltballots,
                        est.ten_ballot_papers = tenballotpapers,
                        est.ten_spoilt_ballots = tenspoiltballots,
						est.ballotpaper2 = ballotpapers2,
						est.postalpack2 = postalpacks2,
						est.postalpack_collected2 = postalpackscollected2,
						est.spoilt_ballot2 = spoiltballots2,
						est.ten_ballot_papers2 = tenballotpapers2,
						est.ten_spoilt_ballots2 = tenspoiltballots2
						where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
						and (HOUR(est.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(est.updatedon));
						
						select 'success' as response;

				
			else
						insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon,ballotpaper2, postalpack2, postalpack_collected2,spoilt_ballot2,ten_ballot_papers2,ten_spoilt_ballots2)
						values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'),ballotpapers2,postalpacks2,postalpackscollected2,spoiltballots2,tenballotpapers2,tenspoiltballots2);
			  
						select 'success' as response;

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
/*!50003 DROP PROCEDURE IF EXISTS `updatepsichecklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updatepsichecklist`(token varchar(255), place_id int, activity_id int, status int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'updatepsichecklist';
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
        
		if(select exists 
			(
			 select pcl.* from psm.psi_check_list pcl inner join
			 psm.hierarchy_value hv on pcl.place_id = hv.id
			 where pcl.organization_id = hv.organization_id
             and pcl.organization_id = orgid and pcl.place_id=place_id
             and pcl.list_id = activity_id
			) 
            ) then
                /*update psi_check_list if record exists */
                update psm.psi_check_list pcl 
                set pcl.iscompleted = status
                where pcl.place_id = place_id and
                pcl.organization_id = orgid and pcl.list_id = activity_id;
    
				select 'success' as response;
                
		else

			/*insert record if doesnt*/
			insert into psm.psi_check_list(organization_id, list_id, place_id, iscompleted)
			values(orgid, activity_id, place_id, status);

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
/*!50003 DROP PROCEDURE IF EXISTS `updatestation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updatestation`(token varchar(255), stationid int,
electionid int, boxnumber varchar(55), stationname varchar(255))
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		
        update psm.polling_station ps set ps.name = stationname
                where ps.id=stationid and ps.organization_id=orgid;
                
        update psm.polling_station_election pse set pse.ballot_box_number = boxnumber
                where pse.polling_station_id=stationid and pse.organization_id=orgid and pse.election_id=electionid;
         		
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
		  set t.latitude= latitude,t.longtitude=longtitude
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
/*!50003 DROP PROCEDURE IF EXISTS `updatewatchedisse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updatewatchedisse`(token varchar(255),in watched int,in issueid int  )
BEGIN
if (security.fn_validate_token(token)=1) then
	UPDATE psm.issue
		SET psm.issue.watched = watched
		WHERE psm.issue.id=issueid;
        select'success' as response;
else
		select'unauthorized' as response;

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

-- Dump completed on 2016-04-29 20:10:52
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: ec2-52-48-101-197.eu-west-1.compute.amazonaws.com    Database: subscription
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2
use `subscription`;
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

-- Dump completed on 2016-04-29 20:10:59
