DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getelection_1`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelection';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
        select election.election_date_start as response from psm.election election;
   end if;
END$$
DELIMITER ;
