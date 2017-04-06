DELIMITER $$
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
				/*
				select 'success' as response;
			else
				select 'success' as response;*/
            end if;
	/*else
		select 'unauthorized' as response;*/
	end if;
END$$
DELIMITER ;
