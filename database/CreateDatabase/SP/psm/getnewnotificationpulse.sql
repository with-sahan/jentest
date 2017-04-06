DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getnewnotificationpulse`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare rcount int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1) then
		/** check for new notifications **/
        select count(ns.status) as has_new_notification,'ok' as response from psm.notification nt inner join 
			psm.notification_status ns on ns.notificationid=nt.id
			inner join subscription.organization org on
			nt.organization_id=org.id
			inner join security.user usr on
			ns.userid=usr.id
			where org.code=orgcode and usr.username=username and ns.status=0;
           /* where org.code=orgcode and usr.username=username and ns.status=0 and date(nt.createdon)=date(current_date);*/
    else
		select 0 as has_new_notification,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
