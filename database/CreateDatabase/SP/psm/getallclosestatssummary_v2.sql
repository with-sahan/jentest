DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getallclosestatssummary_v2`(in token varchar(255), in eid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare return_queries int(100);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getallclosestatssummary';
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
    
		select count(*) into return_queries 
        from         
        psm.election_close_stats ecs    
		where ecs.organization_id=orgid and
        ecs.election_id = eid and
        UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()); 
        
        if (return_queries>0) then
        
			select sum(ecs.tot_ballots) as sum_tot_ballots,
			sum(ecs.tot_spolied_issued) as sum_tot_spoiled_replaced,
			sum(ecs.tot_unused) as sum_tot_unused,
			sum(ecs.tot_tend_ballots) as sum_tot_tend_ballots,
			sum(ecs.tot_tend_spoiled) as sum_tot_tend_spoiled,
			sum(ecs.tot_tend_unused) as sum_tot_tend_unused, 
			ecs.election_id as electionid,
			'success' as response from         
			psm.election_close_stats ecs    
			where ecs.organization_id=orgid and
			ecs.election_id = eid and
			UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) 
			group by ecs.election_id; 
		
        else 
        
			select null as sum_tot_ballots,
			null as sum_tot_spoiled_replaced,
			null as sum_tot_unused,
			null as sum_tot_tend_ballots,
			null as sum_tot_tend_spoiled,
			null as sum_tot_tend_unused, 
			null as electionid,
			'nodata' as response; 
		
        end if;
    else
		select null as sum_tot_ballots,null as sum_tot_spoiled_replaced,null as sum_tot_unused,null as sum_tot_tend_ballots,null as sum_tot_tend_spoiled,
        null as sum_tot_tend_unused, null as electionid,'unauthorized' as response; 
    end if;
END$$
DELIMITER ;
