DELIMITER $$
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
END$$
DELIMITER ;
