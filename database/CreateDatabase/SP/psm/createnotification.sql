DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `createnotification`(in token varchar(255),in pollingstationid int,in description varchar(2000) ,in filepath varchar(255) )
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    declare notificationid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code = orgcode;
    set userid=(select id as userid from security.user where username = username and is_deleted = 0);

    if (security.fn_validate_token(token)=1) then
    
		insert into psm.notification(organization_id,station_id,message,attachtment_url,createdon)
				values(orgid,pollingstationid,description,filepath,CURRENT_TIMESTAMP);
        
		insert into psm.notification_status(organization_id,notificationid,userid,status,isprivate) 
				values(orgid,notificationid,userid,0,1);
				select 'success' as response;
                
	else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
