DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getnewnotifications`(in token varchar(255),in electionid INT)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set spcode='getnewnotifications';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		/** check for new notifications **/
        select nt.id as notification_id,nt.message as message,nt.attachtment_url as att_url,nt.createdon as generatedon,
        'ok' as response 
        from psm.notification nt inner join 
			psm.notification_status ns on ns.notificationid=nt.id
			inner join subscription.organization org on
			nt.organization_id=org.id
			inner join security.user usr on
			ns.userid=usr.id
			where org.code=orgcode and usr.username=username and ns.status=0;
    else
		select null as notification_id,null as message,null as att_url,null as generatedon,
        'unauthorized' as response;
    end if;
END$$
DELIMITER ;
