DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getclosestats`(in token varchar(255),in electionid int, in pollingstationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getclosestats';
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
    
	select tot_ballots,tot_ballots2,tot_spolied_issued,tot_spolied_issued2,tot_unused,tot_unused2,tot_tend_ballots,tot_tend_ballots2,tot_tend_spoiled,tot_tend_spoiled2,tot_tend_unused,tot_tend_unused2, 'ok' as response from 
        psm.election_close_stats
		where election_id=electionid and polling_station_id = pollingstationid and organization_id = orgid ; 
    else
	select null as tot_ballots,null as tot_ballots2,null as tot_spoiled_issued,null as tot_spoiled_issued2,null as tot_unused,null as tot_unused2,null as tot_tend_ballots,null as tot_tend_ballots2,null as tot_tend_spoiled,null as tot_tend_spoiled2,null as tot_tend_unused,null as tot_tend_unused2,'unauthorized' as response; 
  
end if;
END$$
DELIMITER ;
