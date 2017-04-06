DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updaterole`(in token varchar(255),in roleid int,in rolename varchar(55),in description varchar(255))
BEGIN
	
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		update security.role set name=rolename,description=description,updatedon=current_timestamp where
        organization_id=orgid and id=roleid;
        
		select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
