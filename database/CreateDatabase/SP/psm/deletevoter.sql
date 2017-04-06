DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `deletevoter`(in token varchar(255), in voter_list_id int)
BEGIN
	declare spcode varchar(45);
    declare usernamevoter varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set usernamevoter=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'deletevoter';
    select id into organizationid from subscription.organization where code = orgcode;
    select id into userid from security.user where username = usernamevoter;
    
    if (security.fn_validate_token(token)=1) then
		delete from voter_list where voter_list.id=voter_list_id;
        select 'success' as response;
        
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
