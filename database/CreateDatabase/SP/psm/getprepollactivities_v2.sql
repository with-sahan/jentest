DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getprepollactivities_v2`(token varchar(255), polling_station_id int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare election_id int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getprepollactivities';
    
    
    
    if (security.fn_validate_token(token)=1) then
    
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
        
	     if(select exists(select vel.id   from election vel inner join polling_station_election vpse on vel.id=vpse.election_id where vpse.polling_station_id=polling_station_id and date(vel.election_date_start)=date(current_date) limit 1)) then
                     
			select vel.id into election_id  from election vel inner join polling_station_election vpse on vel.id=vpse.election_id where vpse.polling_station_id=polling_station_id and date(vel.election_date_start)=date(current_date) limit 1;		 
			
            select l.id, l.list_value as activity,lc.name as category, IFNULL(oce.iscompleted,0) as iscompleted, 'success' as response 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
            left outer join psm.open_close_election oce on oce.list_id = l.id and oce.polling_station_id = polling_station_id and oce.election_id = election_id
			where lc.name like 'prepoll_activity%' and org.code = orgcode order by lc.list_order,l.list_order;
         else
			select null as id, null as activity,null as category,0 as iscompleted,  'success' as response;
         end if;
        
			
        
        else
			select null as id, null as activity,null as category,0 as iscompleted,  'unauthorized' as response;
        end if;
    else
		select null as id, null as activity,null as category,0 as iscompleted,  'unauthorized' as response;
    end if;
END$$
DELIMITER ;
