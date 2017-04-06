DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `generatebpa_v2`(in token varchar(255),in stationid int)
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
    declare start_count int;
    declare end_count int;
    declare tend_start_count int;
    declare tend_end_count int;
    declare tot_ballots2 int;
	declare tot_spolied_issued2 int;
    declare tot_unused2 int;
    declare tot_tend_ballots2 int;
	declare tot_tend_spoiled2 int;
    declare tot_tend_unused2 int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    
    select id into orgid from subscription.organization where code=orgcode;
    select ballotstart,ballotend,tenderstart,tenderend 
    into start_count,end_count,tend_start_count,tend_end_count
    from psm.polling_station_election where organization_id=orgid and polling_station_id=stationid and election_id=electionid;
    
    if (security.fn_validate_token(token)=1 ) then
		select ifnull(sum(ballotpaper),0),
        ifnull(sum(spoilt_ballot),0),
        (end_count+1)-start_count -ifnull(sum(ballotpaper),0),
        ifnull(sum(ten_ballot_papers),0),
        ifnull(sum(ten_spoilt_ballots),0),
        (tend_end_count+1) - tend_start_count - ifnull(sum(ten_ballot_papers),0),
        
        ifnull(sum(ballotpaper2),0),
        ifnull(sum(spoilt_ballot2),0),
        (end_count+1)-start_count -ifnull(sum(ballotpaper2),0),
        ifnull(sum(ten_ballot_papers2),0),
        ifnull(sum(ten_spoilt_ballots2),0),
        (tend_end_count+1) - tend_start_count - ifnull(sum(ten_ballot_papers2),0)
        into
        tot_ballots,tot_spolied_issued,tot_unused,tot_tend_ballots,tot_tend_spoiled,tot_tend_unused,
        tot_ballots2,
        tot_spolied_issued2,
        tot_unused2,
        tot_tend_ballots2,
        tot_tend_spoiled2,
        tot_tend_unused2
        
        from psm.election_stats es
        inner join psm.election el on el.id=es.electionid
        where es.organization_id=orgid and el.organization_id=orgid and
        es.polling_station_id=stationid and es.electionid=electionid;
        
        #delete the close stats first
        delete from psm.election_close_stats where organization_id=orgid and
        election_id=electionid and polling_station_id=stationid;
        
        #insert the new close stats
        insert into psm.election_close_stats (
        organization_id,
        election_id,
        tot_ballots,
        tot_spolied_issued,
        tot_unused,
        tot_tend_ballots,
        tot_tend_spoiled,
        tot_tend_unused,
        tot_ballots2,
        tot_spolied_issued2,
        tot_unused2,
        tot_tend_ballots2,
        tot_tend_spoiled2,
        tot_tend_unused2,
        updatedon,
        polling_station_id) values
        
        (orgid,
        electionid,
        tot_ballots,
        tot_spolied_issued,
        tot_unused,
        tot_tend_ballots,
        tot_tend_spoiled,
        tot_tend_unused,
        tot_ballots2,
        tot_spolied_issued2,
        tot_unused2,
        tot_tend_ballots2,
        tot_tend_spoiled2,
        tot_tend_unused2,
        current_timestamp,
        stationid);
        
        select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
