DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `resetelection_2`(in organizationid int)
BEGIN
update psm.election set election_date_start=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 7 HOUR), '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),
election_date_end=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 22 HOUR),
 '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),status=0 where organization_id=organizationid;

DELETE it
	FROM psm.issue_tracking it
	INNER JOIN psm.issue i
	ON i.id=it.issue_id
	where i.organization_id=organizationid;
delete from psm.notification_status where organization_id=organizationid;
delete from psm.notification where organization_id=organizationid;
delete from psm.issue_assignment;
delete from psm.issue where organization_id=organizationid;

delete from psm.election_stats where organization_id=organizationid;
delete from psm.election_close_stats where organization_id=organizationid;
delete from psm.open_close_election where organization_id=organizationid;
delete from psm.station_photo where organization_id=organizationid;
delete from psm.tracking where organization_id=organizationid;
/*insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
select  polling_station_id,organizationid,electionid,0,0,0,0,0,0 from psm.polling_station_election 
where election_id=electionid and organization_id=organizationid;*/
insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
select  polling_station_id,organizationid,election_id,0,0,0,0,0,0 from psm.polling_station_election 
where election_id in (SELECT id FROM psm.election where organization_id=organizationid) and organization_id=organizationid;

update psm.polling_station_election set isopen=0,isclose=0,election_status=0 where organization_id=organizationid;
select 'success' as response;
END$$
DELIMITER ;
