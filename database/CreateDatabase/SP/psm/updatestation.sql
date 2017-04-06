DELIMITER $$
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
    
END$$
DELIMITER ;
