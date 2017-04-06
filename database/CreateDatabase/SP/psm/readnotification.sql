DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `readnotification`(in token varchar(255),in notification_id INT)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='readnotification';
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		update
			psm.notification nt inner join 
			psm.notification_status ns on ns.notificationid=nt.id
			inner join subscription.organization org on
			nt.organization_id=org.id
			inner join security.user usr on
			ns.userid=usr.id
            set ns.status=1,ns.akn_time=CURRENT_TIMESTAMP
			where nt.id=notification_id  and org.code=orgcode and usr.username=username;
        select "success" as response;
    else
		select "unauthorized" as response;
    end if;
    
END$$
DELIMITER ;
