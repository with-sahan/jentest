DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `insertPSI`(in username varchar(255), in orgid int,in pollingstationname varchar(255),in electionid int)
BEGIN
declare userid int(11);
declare roleid int(11);
declare pollingstationid int(11);

select id into userid from security.user where security.user.username=username and security.user.organization_id=orgid;

SELECT id into roleid FROM security.role where security.role.organization_id=orgid and name='Polling Station Inspector';
 
if not exists ( select * from security.user_role where security.user_role.organization_id = orgid and security.user_role.role_id=roleid and security.user_role.user_id=userid) then
	insert into security.user_role(organization_id,role_id,user_id) values (orgid,roleid,userid);
 end if;
 
 
 SELECT id into pollingstationid FROM psm.polling_station where psm.polling_station.name=pollingstationname and psm.polling_station.organization_id=orgid;

insert into psm.user_election(organization_id,user_id,election_id,pollingstation_id) values (orgid,userid,electionid,pollingstationid);
END$$
DELIMITER ;
