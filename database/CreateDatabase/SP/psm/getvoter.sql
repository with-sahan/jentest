DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getvoter`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getvoter';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select voter_list.id as vlid, usr.id as userid, usr.organization_id as organization_id, 
        ps.id as pollingstationid, voter_list.voter_name as vlname, voter_list.phone_number as vlphonenumber, 
        voter_list.companion_name as vlcompanionname, voter_list.companion_address as vlcompanionaddress, 
        'success' as response
        from psm.voter_list voter_list
        inner join psm.polling_station ps on voter_list.polling_station_id=ps.id
        inner join security.user usr on voter_list.userid=usr.id
        where voter_list.userid=usr.id and 
        voter_list.polling_station_id=ps.id and usr.organization_id=organizationid;
	else
		select null vlid, null userid, null organization_id, 
        null pollingstationid, null vlname, null vlphonenumber, 
        null vlcompanionname, null vlcompanionaddress, 
        'unauthorized' response;
    end if;
END$$
DELIMITER ;
