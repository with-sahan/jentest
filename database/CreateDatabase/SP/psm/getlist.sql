DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getlist`(token varchar(255),organization_id int(11), category_name varchar(45))
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getlist';
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
			select l.id, l.list_internal_name, l.list_value, 'ok' as response 
			from psm.list l inner join psm.list_category lc on l.list_category_id = lc.id
			inner join subscription.organization org on lc.organization_id = org.id
			where lc.name = category_name and org.code = orgcode;
        
        else
			select null as id, null as list_internal_name,null as list_value,  'denied' as response;
        end if;
    else
		select null as id, null as list_internal_name,null as list_value, 'unauthorized' as response;
    end if;
    

END$$
DELIMITER ;
