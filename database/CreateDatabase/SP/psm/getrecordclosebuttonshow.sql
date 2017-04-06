DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getrecordclosebuttonshow`(in token varchar(255),in electionid int,in stationid int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare lastrecordsum int(15);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
		SELECT getlastrowvalues(orgid,stationid,electionid)
        into lastrecordsum;
        /* 
		 if(select exists 
				(					
					SELECT * from psm.election el inner join
        polling_station_election pse on pse.election_id=el.id where HOUR(el.election_date_end)-1 = HOUR(current_time())
        and pse.election_id = electionid and pse.polling_station_id = stationid and pse.organization_id = orgid and pse.election_status = 0
                    ) 
            ) then */
          if(lastrecordsum>0) then
				select 'success' as response, 1 as buttonshow;
			else
				select 'success' as response, 0 as buttonshow;
            end if;
	else
		select null as buttonshow,'unauthorized' as response;
	end if;
END$$
DELIMITER ;
