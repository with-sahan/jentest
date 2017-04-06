DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getallusers`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    set spcode='getallusers';
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        select id as id,firstname as firstname,lastname as lastname,concat(firstname , ' ' ,lastname) as fullname,
        email as email,username as username,is_deleted as is_deleted,
        'success' as response from security.user where organization_id=orgid and is_deleted!=1;
	else
		select null as id,null as firstname,null as lastname,null as fullname,null as email,null as username,null as is_deleted,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
