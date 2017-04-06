DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getcsvballotaccountexporteddetails`(in token varchar(255),in stationid int,in electionid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
        
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 ) then
        select *
        from psm.election_close_stats
        where csv_export=1 and organization_id=orgid and polling_station_id=stationid and election_id=electionid;
        
        #select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
