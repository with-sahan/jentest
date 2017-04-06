DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getballotpapernames`(in token varchar(255), in electionid int)
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select value_1 as paper1,value_2 as paper2,'success' as response 
        from psm.ballot_paper_type 
        where election_id=electionid and organization_id=orgid;
    else
		select null as paper1,null as paper2,'unauthorized' as response;
    end if;
    
END$$
DELIMITER ;
