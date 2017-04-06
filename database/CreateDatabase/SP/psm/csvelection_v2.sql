DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `csvelection_v2`(in orgid int(11),in electionid int(11),
in ballotboxnumber int(55),in pollstationid int(11),
in bstartnumber int, in bendnumber int,
in tstartnumber int, in tendnumber int)
BEGIN

    declare ballottypecount int(11);
    select ballot_type_count into ballottypecount from psm.election
		where id=electionid;
        
	if(ballottypecount>1) then		
        insert into psm.polling_station_election (organization_id,election_id,isopen,isclose,
            ballot_box_number,election_status,ballotend,ballotstart,tenderend,tenderstart,
            ballot2end,ballot2start,tender2end,tender2start,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,bendnumber,bstartnumber,tendnumber,tstartnumber,
            bendnumber,bstartnumber,tendnumber,tstartnumber,pollstationid;
    else
		insert into psm.polling_station_election (organization_id,election_id,isopen,isclose,
            ballot_box_number,election_status,ballotend,ballotstart,tenderend,tenderstart,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,bendnumber,bstartnumber,tendnumber,tstartnumber,pollstationid;
    end if; 
            
	insert into psm.polling_station_election_counting (organization_id,
            polling_station_id,election_id,counting_center_id)
			select orgid,pollstationid,electionid,id from psm.counting_center cc 
            where cc.organization_id=orgid and cc.election_id=electionid;
    
	insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
			,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
			values  (pollstationid,orgid,electionid,0,0,0,0,0,0);
						
            select 'success' as response;
            
END$$
DELIMITER ;
