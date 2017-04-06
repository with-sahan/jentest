DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updatewatchedisse`(token varchar(255),in watched int,in issueid int  )
BEGIN
if (security.fn_validate_token(token)=1) then
	UPDATE psm.issue
		SET psm.issue.watched = watched
		WHERE psm.issue.id=issueid;
        select'success' as response;
else
		select'unauthorized' as response;

end if;
END$$
DELIMITER ;
