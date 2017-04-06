DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getballottypecount`(in token varchar(255),in electionid int(11))
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select 'success' as response, el.ballot_type_count as typecount 
        FROM psm.election el 
        where el.organization_id=organizationid and el.id=electionid;
    
    else select 'unauthorized' as response, null as typecount;
    
    end if;
END$$
DELIMITER ;
