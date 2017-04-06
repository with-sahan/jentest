DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingsummary`(in token varchar(255),in stationid int,in electionid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare tot_ballots int;
    declare tot_spolied_issued int;
    declare tot_unused int;
    declare tot_tend_ballots int;
    declare tot_tend_spoiled int;
    declare tot_tend_unused int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
		select sum(ballotpaper) as tot_ballots,
        sum(spoilt_ballot) as tot_spolied_issued,
        el.ballotend-el.ballotstart -sum(ballotpaper) as tot_unused,
        sum(ten_ballot_papers) as tot_tend_ballots,
        sum(ten_spoilt_ballots) as tot_tend_spoiled,
        el.tenderend - el.tenderstart - sum(ten_ballot_papers) as tot_tend_unused,
        'success' as response
        
        from psm.election_stats es
        inner join psm.election el on el.id=es.electionid
        where es.organization_id=orgid and el.organization_id=orgid and
        es.polling_station_id=stationid and es.electionid=electionid;
    else
		select null as tot_ballots,
        null as tot_spolied_issued,
        null as tot_unused,
        null as tot_tend_ballots,
        null as tot_tend_spoiled,
        null as tot_tend_unused,
        'unauthorized' as response;
    end if;
END$$
DELIMITER ;
