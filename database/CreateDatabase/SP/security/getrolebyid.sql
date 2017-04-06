DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getrolebyid`(in token varchar(255),in roleid int)
BEGIN
	
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		select id,name,description,'success' as response from security.role where id=roleid and organization_id=orgid;
    else
		select null as id,null as name,null as description,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
