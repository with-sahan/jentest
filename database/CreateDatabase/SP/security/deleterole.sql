DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `deleterole`(in token varchar(255),in deleteroleid int,in alterroleid int)
BEGIN
	declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN          
          ROLLBACK;
          select 'error deleting Role' as response;
    END;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);

    if (security.fn_validate_token(token)=1 ) then		
		START TRANSACTION;
			update security.user_role set role_id=alterroleid where 
			role_id=deleteroleid and organization_id=orgid;
            
            update security.role_permission set role_id=alterroleid where
            role_id=deleteroleid and organization_id=orgid;
            
            delete from security.role where id=deleteroleid;
		COMMIT;
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
