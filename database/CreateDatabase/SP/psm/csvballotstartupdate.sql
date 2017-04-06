DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `csvballotstartupdate`(in token varchar(255),
in ename varchar(255), in stationname varchar(255),
in bstartnumber int, in bendnumber int,
in tstartnumber int, in tendnumber int)
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
    declare eid int(11);
    declare stationid int(11);
    declare ballottypecount int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    
    if(select not exists (select * from psm.election 
			where election_name=ename and DATE(election_date_start)>current_date()-1 and organization_id=orgid) 
		)then
			select 'errorename' as response;
    elseif(select not exists (select * from psm.polling_station 
			where name=stationname and organization_id=orgid) 
		)then    
			select 'errorstationname' as response;
    else         
		select id into eid from psm.election 
			where election_name=ename and DATE(election_date_start)>current_date()-1 and organization_id=orgid;
		select id into stationid from psm.polling_station 
			where name=stationname and organization_id=orgid;
		select ballot_type_count into ballottypecount from psm.election
			where id=eid;
	 
		if(ballottypecount>1) then		
			UPDATE psm.polling_station_election SET ballotstart=bstartnumber, ballotend=bendnumber, 
				tenderstart=tstartnumber, tenderend=tendnumber, ballot2start=bstartnumber, ballot2end=bendnumber, 
				tender2start=tstartnumber, tender2end=tendnumber
				WHERE organization_id=orgid and election_id=eid and polling_station_id=stationid;
		else
			UPDATE psm.polling_station_election SET ballotstart=bstartnumber, ballotend=bendnumber, 
				tenderstart=tstartnumber, tenderend=tendnumber
				WHERE organization_id=orgid and election_id=eid and polling_station_id=stationid;
		end if;  
		select 'success' as response;        
	end if; 
	
END$$
DELIMITER ;
