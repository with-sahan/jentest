DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getballotissuegraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select el.election_name as electionname,HOUR(est.updatedon) as issuehour, 
        sum(ballotpaper) as ballotpaperissued,"success" as response from psm.election_stats  est		
		inner join psm.election el on el.id=est.electionid
		where date(el.election_date_start)=date(current_date) and est.organization_id=orgid and el.organization_id=orgid 
		group by el.id, el.election_name, HOUR(est.updatedon);
    else
		select null as electionname,null as issuehour,null as ballotpaperissued,"unauthorized" as response;
    end if;
END$$
DELIMITER ;
