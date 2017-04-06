DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getunclosedelectionsbystationid`(in token varchar(255),in stationid int,in eid int)
BEGIN

    declare orgcode varchar(45);
    declare orgid int(11);
    declare lastrecordsum int(15);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1) then
		if exists(
			SELECT * FROM psm.polling_station_election 
			where organization_id=orgid and polling_station_id=stationid and election_id not in (eid)
			and election_status=0) then
            
				SELECT pse.election_id as electionid,'success' as response,el.election_name as electionname,
                if(getlastrowvalues(orgid,stationid,pse.election_id)>0,'readytoclose','nolasthourrecord') as status
                FROM psm.polling_station_election pse inner join psm.election el on el.id=pse.election_id
				where pse.organization_id=orgid and pse.polling_station_id=stationid and pse.election_id not in (eid)
				and pse.election_status=0;
		else select null as electionid,'empty' as response,null as electionname, null as status;
		end if;
	else
		select null as electionid,'unauthorized' as response, null as electionname, null as status;
	end if;
END$$
DELIMITER ;
