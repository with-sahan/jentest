DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `createchat`(token varchar(255), issueid int, pollingstationid int, chatmessage text, attachtment_url varchar(500) )
BEGIN
	declare spcode varchar(45);
    declare usernamechat varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set usernamechat=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'createchat';
    select id into organizationid from subscription.organization where code = orgcode;
    select id into userid from security.user where username = usernamechat;
    
    if (security.fn_validate_token(token)=1) then
		insert into chat(userid, issueid, organizationid, pollingstationid, chatmessage, attachtment_url)
		values(userid, issueid, organizationid, pollingstationid, chatmessage, attachtment_url);
		select 'success' as response;
        
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
