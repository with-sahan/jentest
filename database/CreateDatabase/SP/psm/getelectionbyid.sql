DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getelectionbyid`(in token varchar(255), in election_Id int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelectionbyid';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select election.id as electionid, 
        election.organization_id as organization_id, 
        election.election_name as election_name,
        date(election.election_date_start) as election_date, 
        time(election.election_date_start) as election_start_time,
        time(election.election_date_end) as election_end_time,
        election.election_date_start as election_date_start, 
		election.election_date_end as election_date_end,
        election.status as status,
        election.ballotboxno as ballotboxno,
        counting_center.name as counting_center_name,
        counting_center.id as counting_center_id,
        counting_center.address as counting_center_address,
        election.BPA_identifier as BPA_identifier,
        election.ballot_type_count as ballot_type_count,
        CURDATE() as today_date,
        CURTIME() as today_time,
        'success' as response 
        from psm.election election
        inner join psm.counting_center counting_center on counting_center.election_id=election.id
        where 
        #UNIX_TIMESTAMP(election.election_date_start) > UNIX_TIMESTAMP(CURDATE()) and
        election.id = election_Id and
		election.organization_id=organizationid;
    else
		select null electionid, null organization_id, null election_name, null election_date_start, null election_date_end, null status, null ballotboxno, 'unauthorized' response;
    end if;
END$$
DELIMITER ;
