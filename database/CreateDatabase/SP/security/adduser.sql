DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `adduser`(in token varchar(255),in firstname varchar(127),in lastname varchar(127),
in email varchar(127),in username varchar(127),in userpassword varchar(127),in language_id int)
BEGIN
	
    declare usersname varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    set usersname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		if(select exists(select * from security.user usr where usr.username=username and usr.organization_id=orgid)) then
			select 'dataduplicate' as response;
        else
			insert into security.user (organization_id,firstname,lastname,email,username,passwordhash,language_id) 
            values (orgid,firstname,lastname,email,username,sha1(CONCAT('S@l+VaL',userpassword)) ,language_id);
            select 'success' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
