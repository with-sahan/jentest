DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getchatcountalert_v2`(in token varchar(255))
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
        
        select count(chat.chatid) as chatcount, (SELECT cc.issueid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 ) as issueid,
        (SELECT cc.pollingstationid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 ) as pollingstationid,
        issue.status as issue_status,
        "success" as response from psm.chat chat
        inner join psm.issue issue on issue.id = (SELECT cc.issueid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 )
		where 
		chat.organizationid=orgid and
        chat.userid<>useridother and
		usernamechat=(SELECT issue.reportedby FROM psm.issue issue where issue.id = 
        (SELECT cc.issueid FROM psm.chat cc where cc.organizationid=orgid and
        cc.userid<>useridother ORDER BY cc.chatid DESC LIMIT 1 ));
        /*where  date(chat.createdon)=date(current_date)  and*/
    else 
		select null as chatcount, null as issueid, null as pollingstationid, null as issue_status, "unauthorized" as response;
    end if;
END$$
DELIMITER ;
