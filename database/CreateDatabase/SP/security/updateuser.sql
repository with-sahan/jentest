DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updateuser`(in token varchar(255),in userid int,in firstname varchar(127),
in lastname varchar(127),in email varchar(127),in username varchar(127),in roleid int)
BEGIN

	declare orgcode varchar(45);
    declare orgid int(11);
    set orgcode=security.SPLIT_STR(token,'|',2);    
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1 ) then
		update security.user usr set usr.firstname=firstname,
        usr.lastname=lastname,usr.email=email,usr.username=username,usr.updatedon=current_timestamp where
        usr.id=userid;      
        
        DELETE from security.user_role where user_id=userid and organization_id=orgid;

		INSERT INTO security.user_role (organization_id,role_id,user_id) values (orgid,roleid,userid);
        
		select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
