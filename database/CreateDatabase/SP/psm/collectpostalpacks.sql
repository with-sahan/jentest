DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `collectpostalpacks`(in token varchar(255),in stationdid int,in electionid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
		update psm.election_stats set postalpack_collected=postalpack where organization_id=orgid
        and electionid=electionid and polling_station_id=stationdid;
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
