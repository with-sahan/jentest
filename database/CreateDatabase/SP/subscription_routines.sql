-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: subscription
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
/*!50003 DROP PROCEDURE IF EXISTS `renameorganization` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `renameorganization`(in previous varchar(255),in newname varchar(255))
BEGIN
	declare orgid int(45);
    declare orgidnew int(45);
    select 0 into orgidnew;
    select id into orgidnew from subscription.organization where code=newname;
    if(orgidnew>0) then
        select 'name already in use',orgidnew; 
    else   
		select id into orgid from subscription.organization where code=previous;
		delete FROM security.access_token where organization_id=orgid;
		update subscription.organization set name=newname,code=newname,area_name=newname where id=orgid;
        select 'success',orgid;
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

-- Dump completed on 2017-03-03 15:03:11
