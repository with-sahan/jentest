DELIMITER $$
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
   
        
SELECT distinct ps.hierarchy_value_id as hierarchy_value_id, hv.value as hierarchy_value_name, 'success' as response  FROM psm.polling_station as ps 
inner join  psm.hierarchy_value hv on hv.id=ps.hierarchy_value_id and hv.organization_id=ps.organization_id
where ps.id in (SELECT ue.pollingstation_id  FROM psm.user_election as ue where ue.user_id=userid and ue.organization_id=organizationid group by ue.pollingstation_id);
       
   
   
    else
		select null as hierarchy_value_id, null as hierarchy_value_name, 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
