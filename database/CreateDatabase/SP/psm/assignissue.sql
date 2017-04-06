DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `assignissue`(in token varchar(255),in issueid int,in userid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    set spcode='assignissue';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        #delete previous assignments
        delete from psm.issue_assignment where issue_id=issueid and organization_id=orgid;
        insert into psm.issue_assignment (organization_id,issue_id,user_id)
        values (orgid,issueid,userid);
        select 'success' as response;
	else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
