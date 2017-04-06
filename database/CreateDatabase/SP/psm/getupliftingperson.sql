DELIMITER $$
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
END$$
DELIMITER ;
