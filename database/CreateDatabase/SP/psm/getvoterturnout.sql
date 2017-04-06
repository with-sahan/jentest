DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getvoterturnout`(in token varchar(255),in electionid int,in pollingstationid int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
        if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
        
			if(select exists (select * from psm.election_stats es 
			where es.organization_id = orgid and es.electionid = electionid and es.polling_station_id = pollingstationid)) then
				select 
				SUM(es.ballotpaper) as ballotpapers, 
				SUM(es.postalpack) as postalpacks, 
				sum(es.postalpack_collected) as postalpackscollected,
				'success' as response
				from psm.election_stats es 
				where es.organization_id = orgid and es.electionid = electionid and es.polling_station_id = pollingstationid
				group by es.electionid, es.polling_station_id, es.organization_id;
			else
				select 0 as ballotpapers, 0 as postalpacks, 0 as postalpackscollected,  'success' as response;
			end if;
    
    
        else
			select null as ballotpapers, null as postalpacks, null as postalpackscollected,  'unauthorized' as response;
		end if;
    

END$$
DELIMITER ;
