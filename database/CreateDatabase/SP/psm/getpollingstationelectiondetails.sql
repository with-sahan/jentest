DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationelectiondetails`(in token varchar(255),in electionid int,in pollingstationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare BPAIdentifier int(11);
    declare ballotstartnum int(11);
    declare ballotendnum int(11);
    declare tenderedstartnum int(11);
    declare tenderedendnum int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    select BPA_identifier into BPAIdentifier from psm.election where id=electionid and organization_id=orgid;
    
    if (security.fn_validate_token(token)=1) then
		select BPAIdentifier as BPAIdentifier,
        ballotstart as ballotstart, 
        ballotend as ballotend,
        tenderstart as tenderstart,
        tenderend as tenderend,
        'success' as response
        FROM psm.polling_station_election 
        where election_id=electionid 
        and polling_station_id=pollingstationid 
        and organization_id=orgid;
    else
		select 'unauthorized' as response;
	end if;
END$$
DELIMITER ;
