DELIMITER $$
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
END$$
DELIMITER ;
