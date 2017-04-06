DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updateprogress_v3`(in token varchar(255),in electionid int,in pollingstationid int,
in ballotpapers int, in postalpacks int, in postalpackscollected int,
in spoiltballots int,in tenballotpapers int,in tenspoiltballots int,in updatetime int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare eid int(11);
    declare BPAIdentifier int(11);
    declare ballotstartnum int(11);
    declare ballotendnum int(11);
    declare tot_ballotpapers int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress_v3';
    
    select id into orgid from subscription.organization where code=orgcode;
    select BPA_identifier into BPAIdentifier from psm.election where id=electionid;
    
    SELECT ballotstart into ballotstartnum
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
    SELECT ballotend into ballotendnum 
    FROM psm.polling_station_election 
    where election_id=electionid and polling_station_id=pollingstationid and organization_id=orgid;
    
	if (security.fn_validate_token(token)=1) then
			if(select exists 
				(					
					SELECT * FROM psm.election_stats es where (HOUR(es.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(es.updatedon)) 
				and es.organization_id=orgid and es.electionid=electionid and es.polling_station_id=pollingstationid
					) 
			) then
				/*update status if record exists */
				
				SELECT SUM(ballotpaper) into tot_ballotpapers FROM psm.election_stats election_stats
				where election_stats.electionid=electionid and election_stats.polling_station_id=pollingstationid and election_stats.organization_id=orgid
                and UNIX_TIMESTAMP(election_stats.updatedon) > UNIX_TIMESTAMP(CURDATE());
				
				#start
					#select (ballotstartnum+ballotpapers+tot_ballotpapers) as response;
				#end
				
				if((ballotstartnum+ballotpapers+tot_ballotpapers)<=(ballotendnum)) then
				
					update psm.election_stats est 
					set est.ballotpaper = ballotpapers, est.postalpack = postalpacks, est.postalpack_collected = postalpackscollected, est.spoilt_ballot = spoiltballots, est.ten_ballot_papers = tenballotpapers, est.ten_spoilt_ballots = tenspoiltballots
					where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
					and (HOUR(est.updatedon) = updatetime) and (DATE(current_timestamp()) = DATE(est.updatedon));
					
					select 'success' as response;
				else
					select 'invalid ballot paper count' as response;
				end if;
				
			else
				#start
					#select (ballotendnum) as response;
				#end
				if((ballotstartnum+ballotpapers)<=(ballotendnum)) then
					insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon)
					values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'));
		  
					select 'success' as response;
				
				else
					select 'invalid ballot paper count' as response;
				end if;
			end if;
	else
		select 'unauthorized' as response;
	end if;
END$$
DELIMITER ;
