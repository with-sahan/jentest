DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `markIssueNotificationsAsWatched`(in token varchar(255),in issuenotificationid int)
BEGIN
if (security.fn_validate_token(token)=1 ) then
	UPDATE psm.issue_tracking SET watched=1 where id=issuenotificationid;
	select 'success' as response;
    
  else
  	select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
