DELIMITER $$
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
END$$
DELIMITER ;
