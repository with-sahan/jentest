DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getuserbyissueid`(in orgid int,in issueid int)
BEGIN
	
		select i.reportedby as userName, u.id as userId, u.firstname as firstName, u.lastname as lastName,'success' as response
		from psm.issue i
		inner join security.user u on u.username=i.reportedby and u.organization_id=i.organization_id
		where i.id=issueid and i.organization_id=orgid;
        

END$$
DELIMITER ;
