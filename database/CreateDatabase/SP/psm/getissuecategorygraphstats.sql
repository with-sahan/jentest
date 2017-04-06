DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getissuecategorygraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select lst.list_value as reason,COUNT(isu.id) AS issuecount,'success' as response from psm.issue isu
		inner join psm.list lst on lst.id=isu.issue_list_id
        where  date(isu.createdon) =date(current_date)  and 
        isu.organization_id=orgid and lst.organization_id=orgid 
        group by lst.list_value;
    else
		select null as reason,null as issuecount,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
