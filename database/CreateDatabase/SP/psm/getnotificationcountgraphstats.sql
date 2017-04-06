DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getnotificationcountgraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select count(noti.id) as notificationcount,"success" as response from psm.notification noti
		
		where date(noti.createdon) =date(current_date) and noti.organization_id=orgid;
    else 
		select null as notificationcount,"unauthorized" as response;
    end if;
END$$
DELIMITER ;
