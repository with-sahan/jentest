DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `resolveissue`(in token varchar(255),in issueid int,in description varchar(2000))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    #declare userid int;
    set spcode='resolveissue';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        #select id into userid from security.user where organization_id=orgid and username=username;
        
		update psm.issue set status=1,resolution_desc=description,resolvedon=current_timestamp where id=issueid and organization_id=orgid;
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
