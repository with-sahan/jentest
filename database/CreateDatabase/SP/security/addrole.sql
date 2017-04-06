DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `addrole`(in token varchar(255),in rolename varchar(55),in description varchar(255))
BEGIN
	
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		if(select exists(select * from security.role where name=rolename and organization_id=orgid)) then
			select 'Role already exists' as response;
        else
			insert into security.role (organization_id,name,description) values (
            orgid,rolename,description);
            select 'success' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
