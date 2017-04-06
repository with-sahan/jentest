DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getprogressbytime`(in token varchar(255),in electionid int,in pollingstationid int,
in updatehour int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare BPAIdentifier int(11);
    declare ballotstartnum int(11);
    declare ballotendnum int(11);
    declare tot_ballotpapers int(11);
    declare tenderedstartnum int(11);
    declare tenderedendnum int(11);
    declare tot_tenderedpapers int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    select BPA_identifier into BPAIdentifier from psm.election where id=electionid and organization_id=orgid;
    
    SELECT ballotstart into ballotstartnum
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT ballotend into ballotendnum 
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT tenderstart into tenderedstartnum
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT tenderend into tenderedendnum 
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    if (security.fn_validate_token(token)=1) then
    if (BPAIdentifier=0) then
		select BPAIdentifier, ballotstartnum,
        ballotendnum, tenderedstartnum, tenderedendnum,
        IFNULL(uplifting_person_name,'') as uplifting_person_name,
		SUM(es.ballotpaper) as ballotpapers,
        SUM(es.ballotpaper2) as ballotpapers2,
        SUM(es.postalpack) as postalpacks,
        SUM(es.postalpack2) as postalpacks2,
        SUM(es.postalpack_collected) as postalpackscollected,
        SUM(es.postalpack_collected2) as postalpackscollected2,
        SUM(es.spoilt_ballot) as spoilt_ballots,
        SUM(es.spoilt_ballot2) as spoilt_ballots2,
        SUM(es.ten_ballot_papers) as ten_ballot_papers, 
        SUM(es.ten_ballot_papers2) as ten_ballot_papers2, 
        SUM(es.ten_spoilt_ballots) as ten_spoilt_ballots,
        SUM(es.ten_spoilt_ballots2) as ten_spoilt_ballots2,
        'success' as response
		from psm.election_stats es 
		where es.organization_id = orgid and es.electionid = electionid 
        and es.polling_station_id = pollingstationid and 
        timeHour = updatehour /*
        timeHour = updatehour and UNIX_TIMESTAMP(DATE(es.updatedon)) = UNIX_TIMESTAMP(CURDATE()) */
		group by es.electionid, es.polling_station_id, es.organization_id; 
	elseif (BPAIdentifier=1) then
		select BPAIdentifier, ballotstartnum,
        ballotendnum, tenderedstartnum, tenderedendnum,
        IFNULL(uplifting_person_name,'') as uplifting_person_name,
		SUM(es.ballotpaper) as ballotpapers,
        SUM(es.ballotpaper2) as ballotpapers2,
        SUM(es.postalpack) as postalpacks,
        SUM(es.postalpack2) as postalpacks2,
        SUM(es.postalpack_collected) as postalpackscollected,
        SUM(es.postalpack_collected2) as postalpackscollected2,
        SUM(es.spoilt_ballot) as spoilt_ballots,
        SUM(es.spoilt_ballot2) as spoilt_ballots2,
        SUM(es.ten_ballot_papers) as ten_ballot_papers, 
        SUM(es.ten_ballot_papers2) as ten_ballot_papers2, 
        SUM(es.ten_spoilt_ballots) as ten_spoilt_ballots,
        SUM(es.ten_spoilt_ballots2) as ten_spoilt_ballots2,
        'success' as response
		from psm.election_stats es 
		where es.organization_id = orgid and es.electionid = electionid 
        and es.polling_station_id = pollingstationid 
        and timeHour = updatehour /*
        and timeHour = updatehour and UNIX_TIMESTAMP(DATE(es.updatedon)) = UNIX_TIMESTAMP(CURDATE()) */
		group by es.electionid, es.polling_station_id, es.organization_id; 
    end if;
    else
		select 'unauthorized' as response;
	end if;
END$$
DELIMITER ;
