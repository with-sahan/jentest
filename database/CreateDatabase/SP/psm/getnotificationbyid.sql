DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getnotificationbyid`(in token varchar(255),in notificationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare readcount int;
    declare unreadcount int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getnotificationbyid';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
		set readcount=(select count(id) from psm.notification_status ee where ee.notificationid=notificationid and ee.organization_id=orgid and ee.status=1);
        set unreadcount=(select count(id) from psm.notification_status ee where ee.notificationid=notificationid and ee.organization_id=orgid and ee.status=0);
        
        select id,message,attachtment_url as attachtment, createdon as senton,concat(readcount,'/',readcount+unreadcount) as status,'success' as response   
        from psm.notification where organization_id=orgid and id=notificationid;
    else
		select null as id,null as message,null as attachtment, null as senton,null as status,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
