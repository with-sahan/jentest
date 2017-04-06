DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getallusersbyissueid`(in token varchar(255), in issueid int)
BEGIN
	declare spcode varchar(45);
    declare usersname varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    declare repoter varchar(45);
    
    set spcode='getallusers';
    
    set usersname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select reportedby into repoter from psm.issue where id=issueid;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        select id,firstname,lastname,concat(firstname , ' ' ,lastname) as fullname,email,username,
        'success' as response 
		from security.user where organization_id=orgid and !(username = repoter) and is_deleted=0;
	else
		select null as id,null as firstname,null as lastname,null as fullname,null as email,null as username,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
