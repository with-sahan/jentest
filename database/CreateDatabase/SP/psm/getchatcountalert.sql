DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getchatcountalert`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare usernamechat varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    declare useridother int(11);
    
    set usernamechat=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    select id into useridother from security.user where username = usernamechat and organization_id=orgid;
    
    if (security.fn_validate_token(token)=1) then
		/*select count(chat.chatid) as chatcount,
        "success" as response from psm.chat chat
		where  date(chat.createdon)=date(current_date)  and
		chat.organizationid=orgid and
        chat.userid<>useridother;*/
        
        select count(chat.chatid) as chatcount, (SELECT cc.issueid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 ) as issueid,
        "success" as response from psm.chat chat
		where  date(chat.createdon)=date(current_date)  and
		chat.organizationid=orgid and
        chat.userid<>useridother;
    else 
		select null as chatcount, null as issueid, "unauthorized" as response;
    end if;
END$$
DELIMITER ;
