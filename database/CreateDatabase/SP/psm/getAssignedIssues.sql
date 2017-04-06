DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getAssignedIssues`(in token varchar(255))
BEGIN
 SELECT id as id,issue_id as issueid FROM psm.issue_assignment;
END$$
DELIMITER ;
