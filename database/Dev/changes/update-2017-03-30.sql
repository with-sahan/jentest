USE `psm`;
DROP procedure IF EXISTS `resetelection_2`;

DELIMITER $$
USE `psm`$$
CREATE DEFINER=`root`@`%` PROCEDURE `resetelection_2`(in organizationid int)
BEGIN
update psm.election set election_date_start=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 7 HOUR), '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),
election_date_end=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 22 HOUR),
 '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),status=0 where organization_id=organizationid;

DELETE it
	FROM psm.issue_tracking it
	INNER JOIN psm.issue i
	ON i.id=it.issue_id
	where i.organization_id=organizationid;
delete from psm.notification_status where organization_id=organizationid;
delete from psm.notification where organization_id=organizationid;
delete from psm.issue_assignment;
delete from psm.issue where organization_id=organizationid;

delete from psm.election_stats where organization_id=organizationid;
delete from psm.election_close_stats where organization_id=organizationid;
delete from psm.open_close_election where organization_id=organizationid;
delete from psm.station_photo where organization_id=organizationid;
delete td
	from psm.tracking_data td
	inner join psm.tracking t
    on t.id=td.tracking_id
    where t.organization_id=organizationid;

delete from psm.tracking where organization_id=organizationid;

insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
select  polling_station_id,organizationid,election_id,0,0,0,0,0,0 from psm.polling_station_election 
where election_id in (SELECT id FROM psm.election where organization_id=organizationid) and organization_id=organizationid;

update psm.polling_station_election set isopen=0,isclose=0,election_status=0 where organization_id=organizationid;
select 'success' as response;
END$$

DELIMITER ;



USE `psm`;
DROP procedure IF EXISTS `csvballotstartupdate`;

DELIMITER $$
USE `psm`$$
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
			where election_name=ename and organization_id=orgid) 
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







