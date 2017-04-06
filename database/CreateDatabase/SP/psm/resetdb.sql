DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `resetdb`(in electionid int,in orgid int)
BEGIN
insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
select  polling_station_id,orgid,electionid,0,0,0,0,0,0 from psm.polling_station_election 
where election_id=electionid and organization_id=orgid;

END$$
DELIMITER ;
