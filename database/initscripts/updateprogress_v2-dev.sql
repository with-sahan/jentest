CREATE DEFINER=`root`@`%` PROCEDURE `updateprogress_v2`(in token varchar(255),in electionid int,in pollingstationid int,
in ballotpapers int, in postalpacks int, in postalpackscollected int,
in spoiltballots int,in tenballotpapers int,in tenspoiltballots int,in updatetime int,
in ballotpapers2 int, in postalpacks2 int, in postalpackscollected2 int,
in spoiltballots2 int,in tenballotpapers2 int,in tenspoiltballots2 int)
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
    declare tenderedstartnum int(11);
    declare tenderedendnum int(11);
    declare tot_tenderedpapers int(11);
    declare currentballotnum int(11);
    declare currenttenderednum int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='updateprogress';
    
    select id into orgid from subscription.organization where code=orgcode;
    
    select BPA_identifier into BPAIdentifier from psm.election where id=electionid;
    

	if (security.fn_validate_token(token)=1) then
		if (BPAIdentifier=0) then
			if(select exists 
				(					
					SELECT * FROM psm.election_stats es where (timeHour = updatetime) and es.organization_id=orgid 
                    and es.electionid=electionid and es.polling_station_id=pollingstationid
                    ) 
            ) then
                /*update status if record exists */
                update psm.election_stats est 
                set est.ballotpaper = ballotpapers,
				est.postalpack = postalpacks,
				est.postalpack_collected = postalpackscollected,
				est.spoilt_ballot = spoiltballots,
				est.ten_ballot_papers = tenballotpapers,
				est.ten_spoilt_ballots = tenspoiltballots,
				est.ballotpaper2 = ballotpapers2,
				est.postalpack2 = postalpacks2,
				est.postalpack_collected2 = postalpackscollected2,
				est.spoilt_ballot2 = spoiltballots2,
				est.ten_ballot_papers2 = tenballotpapers2,
				est.ten_spoilt_ballots2 = tenspoiltballots2
                where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
                and (timeHour = updatetime) ;
				
				select 'success' as response;
                
			else
				insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon,ballotpaper2, postalpack2, postalpack_collected2,spoilt_ballot2,ten_ballot_papers2,ten_spoilt_ballots2,timeHour)
				values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'),ballotpapers2,postalpacks2,postalpackscollected2,spoiltballots2,tenballotpapers2,tenspoiltballots2,updatetime);
	  
				select 'success' as response;
                
            end if;
		elseif (BPAIdentifier=1) then
              
			if(select exists 
				(					
					SELECT * FROM psm.election_stats es where es.organization_id=orgid and es.electionid=electionid 
                    and es.polling_station_id=pollingstationid and timeHour = updatetime
					) 
			) then
				
						update psm.election_stats est 
						set est.ballotpaper = ballotpapers,
                        est.postalpack = postalpacks,
                        est.postalpack_collected = postalpackscollected,
                        est.spoilt_ballot = spoiltballots,
                        est.ten_ballot_papers = tenballotpapers,
                        est.ten_spoilt_ballots = tenspoiltballots,
						est.ballotpaper2 = ballotpapers2,
						est.postalpack2 = postalpacks2,
						est.postalpack_collected2 = postalpackscollected2,
						est.spoilt_ballot2 = spoiltballots2,
						est.ten_ballot_papers2 = tenballotpapers2,
						est.ten_spoilt_ballots2 = tenspoiltballots2
						where est.organization_id=orgid and est.electionid=electionid and est.polling_station_id=pollingstationid
						and timeHour = updatetime ;
						
						select 'success' as response;

				
			else
						insert into psm.election_stats (organization_id, electionid, polling_station_id,ballotpaper, postalpack, postalpack_collected,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots,updatedon,ballotpaper2, postalpack2, postalpack_collected2,spoilt_ballot2,ten_ballot_papers2,ten_spoilt_ballots2,timeHour)
						values (orgid, electionid, pollingstationid, ballotpapers,postalpacks,postalpackscollected,spoiltballots,tenballotpapers,tenspoiltballots,CONCAT(current_date(), ' ',updatetime,':15:12'),ballotpapers2,postalpacks2,postalpackscollected2,spoiltballots2,tenballotpapers2,tenspoiltballots2,updatetime);
			  
						select 'success' as response;

			end if;
		end if;
	else
		select 'unauthorized' as response;
	end if;
END