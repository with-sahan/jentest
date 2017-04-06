DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `getlastrowvalues`(orgid int,stationid int,election_id int) RETURNS int(11)
BEGIN
	declare lastrecordsum int(15);
    
	SELECT ballotpaper+postalpack+postalpack_collected+spoilt_ballot+ten_ballot_papers+ten_spoilt_ballots
        +ballotpaper2+postalpack2+postalpack_collected2+spoilt_ballot2+ten_ballot_papers2+ten_spoilt_ballots2
        into lastrecordsum
		FROM psm.election_stats 
		where organization_id=orgid 
		and polling_station_id=stationid 
		and electionid=election_id
		order by id desc limit 1;

RETURN lastrecordsum;
END$$
DELIMITER ;
