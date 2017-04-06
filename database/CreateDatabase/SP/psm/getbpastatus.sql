DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getbpastatus`(in token varchar(255),in stationid int,in electionid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
		if(select exists(select * from psm.election_close_stats where organization_id=orgid and election_id=electionid and polling_station_id=stationid )) then
			select 1 as status,'success' as response;
        else
			select 0 as status,'success' as response;
        end if;
    else
		select null as status,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
