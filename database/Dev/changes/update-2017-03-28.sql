use `psm`;

DROP TABLE IF EXISTS `tracking_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracking_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking_id` int(11) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  `latitude` varchar(45) NOT NULL,
  `isactive` int(11) NOT NULL DEFAULT '0',
  `updateon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `td_fk_1_idx` (`tracking_id`),
  CONSTRAINT `td_fk_1` FOREIGN KEY (`tracking_id`) REFERENCES `tracking` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=869 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


USE `psm`;
DROP procedure IF EXISTS `starttrack`;

/*starttrack*/
delimiter $$

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

			insert into psm.tracking_data (tracking_id,longitude,latitude,isactive,updateon) 
            values (LAST_INSERT_ID(),longtitude,latitude,1,CURRENT_TIMESTAMP);
            
			select "success" as response;
        end if;
    else
		select "unauthorized" as response;
    end if;
END$$


USE `psm`;
DROP procedure IF EXISTS `updatetrack`;

/*updatetrack*/
delimiter $$

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
 /*
 insert into psm.tracking_test(org_id,username,latitude,longtitude,time) 
values (orgid,username,latitude,longtitude,current_timestamp()); */

		  update psm.tracking as t
		  inner join psm.user_election ue on t.election_id = ue.election_id and t.pollingstationid = ue.pollingstation_id and ue.organization_id = t.organization_id 
		  inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
          inner join election e on ue.election_id = e.id
		  set t.latitude= latitude,t.longtitude=longtitude
		  where u.organization_id = orgid
          and u.username= username;

          insert into psm.tracking_data (tracking_id,longitude,latitude,isactive,updateon) 
		  select t.id,longtitude,latitude,1,CURRENT_TIMESTAMP 
		  from psm.tracking t 
		  inner join psm.user_election ue on t.election_id = ue.election_id and t.pollingstationid = ue.pollingstation_id and ue.organization_id = t.organization_id 
	      inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
		  inner join election e on ue.election_id = e.id
		  where u.organization_id = orgid
		  and u.username= username;       
        
        select "success" as response;
    else
		select "unauthorized" as response;
    end if;
END$$

ALTER TABLE `psm`.`tracking` 
ADD COLUMN `begin_long` VARCHAR(45) NULL DEFAULT NULL AFTER `deliver_long`,
ADD COLUMN `begin_lat` VARCHAR(45) NULL DEFAULT NULL AFTER `begin_long`,
ADD COLUMN `updated_time` TIMESTAMP NULL DEFAULT NULL AFTER `begin_lat`;


