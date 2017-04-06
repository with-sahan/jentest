DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `createvoter`(in token varchar(255), in polling_station_id int, in voter_name varchar(90), in phone_number varchar(45), in companion_name varchar(90), in companion_address  varchar(100))
BEGIN
	declare spcode varchar(45);
    declare usernamevoter varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set usernamevoter=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'createvoter';
    select id into organizationid from subscription.organization where code = orgcode;
    select id into userid from security.user where username = usernamevoter and is_deleted = 0;
    
    if (security.fn_validate_token(token)=1) then
		insert into voter_list(userid, organizationid, polling_station_id, voter_name, phone_number, companion_name, companion_address)
		values(userid, organizationid, polling_station_id, voter_name, phone_number, companion_name, companion_address);
		select 'success' as response;
        
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
