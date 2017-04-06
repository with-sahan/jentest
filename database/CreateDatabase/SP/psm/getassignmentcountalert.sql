DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getassignmentcountalert`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare usernameissue varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    declare useridother int(11);
    
    set usernameissue=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    select id into useridother from security.user where username = usernameissue and organization_id=orgid;
    
    if (security.fn_validate_token(token)=1) then
        
        select count(issue_assignment.id) as issueassigncount,
			(SELECT cc.issue_id FROM psm.issue_assignment cc where cc.organization_id=orgid and
					cc.user_id=useridother ORDER BY cc.issue_id DESC LIMIT 1 ) as issue_id,
			(SELECT issue.pollingstation_id FROM psm.issue issue where issue.organization_id=orgid and
					issue.reportedby=usernameissue ORDER BY issue.id DESC LIMIT 1 ) as pollingstationid,
		"success" as response
		from psm.issue_assignment issue_assignment 
		where issue_assignment.organization_id=orgid 
		and issue_assignment.user_id=(select id from security.user where username = usernameissue  and organization_id=orgid); 

    else 
		select null as issueassigncount, null as issue_id, null as pollingstationid, "unauthorized" as response;
    end if;
END$$
DELIMITER ;
