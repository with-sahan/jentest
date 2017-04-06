DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getprepollactivities`(token varchar(255), election_id int, polling_station_id int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getprepollactivities';
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
			select l.id, l.list_value as activity, IFNULL(oce.iscompleted,0) as status, 'ok' as response 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
            left outer join psm.open_close_election oce on oce.list_id = l.id and oce.polling_station_id = polling_station_id and oce.election_id = election_id
			where lc.name = 'prepoll_activity' and org.code = orgcode;
        
        else
			select null as id, null as activity,0 as iscompleted,  'denied' as response;
        end if;
    else
		select null as id, null as activity,0 as iscompleted, 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
