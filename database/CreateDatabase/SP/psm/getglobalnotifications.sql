DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getglobalnotifications`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare readcount int;
    declare unreadcount int;
    declare cur_id int;
    declare cur_message varchar(10000);
    declare cur_attactmnent varchar(500);
    declare cur_senton timestamp;
    DECLARE done INT DEFAULT FALSE;
    
    declare cur cursor for
    select noti.id,noti.message,noti.attachtment_url, noti.createdon 
        from psm.notification noti
        where noti.organization_id=orgid and date(noti.createdon) = date(current_date);
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='getglobalnotifications';
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'Admin')=1) then
        drop table if exists `notificationsresult`;
		create temporary table notificationsresult (id int,message varchar(10000),attachtment varchar(500),senton timestamp,status varchar(55),response varchar(55))engine=memory;
        
        open cur;
        read_loop: LOOP
			FETCH cur INTO cur_id,cur_message,cur_attactmnent,cur_senton;
			IF done THEN
				LEAVE read_loop;
			END IF;
			set readcount=(select count(id) from psm.notification_status where notificationid=cur_id and organization_id=orgid and status=1);
			set unreadcount=(select count(id) from psm.notification_status where notificationid=cur_id and organization_id=orgid and status=0);
            
            insert into notificationsresult (id,message,attachtment,senton,status,response) values
            (cur_id,cur_message,cur_attactmnent,cur_senton,concat(readcount,'/',readcount+unreadcount),'success');
		END LOOP;
		CLOSE cur;
        select * from notificationsresult;
        drop table notificationsresult;
    else
		select null as id,null as message,null as attachtment, null as senton,null as status,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
