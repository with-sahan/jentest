DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getelectionfileuploaddetails`(in token varchar(255), in eid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    declare polling_station_election_exist int(11);
    declare user_election_exist int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelectionfileuploaddetails';
    
    select id into organizationid from subscription.organization where code = orgcode;
    select count(id) into polling_station_election_exist from psm.polling_station_election polling_station_election where polling_station_election.election_id=eid;
    select count(id) into user_election_exist from psm.user_election user_election where user_election.election_id=eid;
    
    if (security.fn_validate_token(token)=1) then
		
        if ((polling_station_election_exist > 0) && (user_election_exist > 0)) then 
			select 'success' as response; 
        else
			select 'nodata' as response;
		end if;
    else
		select 'unauthorized' response;
    end if;
END$$
DELIMITER ;
