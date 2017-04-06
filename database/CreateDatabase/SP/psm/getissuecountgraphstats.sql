DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getissuecountgraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select count(isu.id) as openissues,"success" as response from psm.issue isu
		where  date(isu.createdon) =date(current_date)  and
		isu.status=0 and  isu.organization_id=orgid;
    else 
		select null as openissues,"unauthorized" as response;
    end if;
END$$
DELIMITER ;
