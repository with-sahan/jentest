DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getchat`(token varchar(255), issueid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare userfirstname varchar(45);
    declare userlastname varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'chat';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select isu.id as issueid, ps.id as pollingstationid, concat(usr.firstname,' ',usr.lastname) as userfullname ,
        usr.id as userid, chat.chatid as chatid, chat.chatmessage as chatmessage, chat.attachtment_url as attachtment_url, 
        usr.profile_picture as profile_picture, isu.status as issuestatus,
        chat.createdon as createdon, usr.organization_id as organizationid,
        'success' as response 
        from psm.issue isu
		inner join psm.polling_station ps on isu.pollingstation_id=ps.id
		left outer join psm.chat chat on isu.id=chat.issueid
        inner join security.user usr on chat.userid=usr.id
        where
        chat.userid=usr.id and isu.id=issueid and usr.organization_id=organizationid order by chat.createdon desc;
        /*  where  UNIX_TIMESTAMP(chat.createdon) > UNIX_TIMESTAMP(CURDATE())  and */
    else
		select null chatid, null chatmessage, null attachtment_url, null createdon, null issueid, null pollingstationid, null userfullname, null userid, null organizationid, 'unauthorized' response;
    end if;
END$$
DELIMITER ;
