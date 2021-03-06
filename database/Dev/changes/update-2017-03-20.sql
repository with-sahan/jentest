USE `psm`;
DROP procedure IF EXISTS `updatetrack`;

DELIMITER $$
USE `psm`$$
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

                
        
        select "success" as response;
    else
		select "unauthorized" as response;
    end if;
END$$

DELIMITER ;


