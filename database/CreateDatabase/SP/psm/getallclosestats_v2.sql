DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getallclosestats_v2`(in token varchar(255), in eid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare return_queries int(100);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getallclosestats';
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
    
		select count(*) into return_queries
        from psm.election_close_stats ecs
        inner join psm.election el on el.id=election_id
        inner join psm.polling_station ps on ps.id=polling_station_id
		where ecs.organization_id=orgid 
        and el.id=eid 
        and UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) ; 
        
        if(return_queries>0) then
    
			select ecs.tot_ballots,ecs.tot_spolied_issued as tot_spoiled_replaced,
			ecs.tot_unused,ecs.tot_tend_ballots,
			ecs.tot_tend_spoiled,ecs.tot_tend_unused,
			ecs.tot_ballots2,ecs.tot_spolied_issued2 as tot_spoiled_replaced2,
			ecs.tot_unused2,ecs.tot_tend_ballots2,
			ecs.tot_tend_spoiled2,ecs.tot_tend_unused2,
			el.election_name as electionname,
			ps.name as pollingstation, el.Id as electionid,
            hv.value as pollingstation_place,
            hv.parent_id as parent_id,
            hv.id as hierarchy_value_id,
            'success' as response 
			from psm.election_close_stats ecs
			inner join psm.election el on el.id=election_id
			inner join psm.polling_station ps on ps.id=polling_station_id
            inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id
			where ecs.organization_id=orgid 
			and el.id=eid 
			and UNIX_TIMESTAMP(ecs.updatedon) > UNIX_TIMESTAMP(CURDATE()) ; 
		else 
			select null as tot_ballots, null as tot_spoiled_replaced, null as tot_unused,
            null as tot_tend_ballots, null as tot_tend_spoiled, null as tot_tend_unused,
            null as tot_ballots2, null as tot_spoiled_replaced2, null as tot_unused2,
            null as tot_tend_ballots2, null as tot_tend_spoiled2, null as tot_tend_unused2,
            null as electionname,null as pollingstation, null as electionid,
            null as pollingstation_place,
            'nodata' as response;
		end if;
    else
		select null as tot_ballots, null as tot_spoiled_replaced, null as tot_unused, 
        null as tot_tend_ballots, null as tot_tend_spoiled, null as tot_tend_unused, 
        null as tot_ballots2, null as tot_spoiled_replaced2, null as tot_unused2,
        null as tot_tend_ballots2, null as tot_tend_spoiled2, null as tot_tend_unused2,
        null as electionname,null as pollingstation, null as electionid,
        null as pollingstation_place,
        'unauthorized' as response; 
    end if;
END$$
DELIMITER ;
