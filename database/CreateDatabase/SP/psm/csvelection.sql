DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `csvelection`(in orgid int(11),in electionid int(11),in ballotboxnumber int(55),
in pollstationid int(11),in user_name varchar(255),in first_name varchar(255),
in last_name varchar(255), in passwords varchar(255))
BEGIN

    declare userid int(11);
    
    insert into psm.polling_station_election (organization_id,election_id,isopen,isclose,
            ballot_box_number,election_status,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,pollstationid;
    /*insert into psm.polling_station_election (organization_id,election_id,isopen,isclose,
            ballot_box_number,election_status,ballotend,ballotstart,tenderend,tenderstart,polling_station_id)
			select orgid,electionid,0,0,ballotboxnumber,0,2,1,2,1,pollstationid;*/        

            if(select not exists (SELECT * FROM security.user u where u.organization_id=orgid and u.username=user_name and u.is_deleted = 0) 
			)then
				insert into security.user (organization_id,firstname,lastname,username,passwordhash,locale,language_id,createdon) 
				select orgid,first_name,last_name,user_name,sha1(CONCAT('S@l+VaL',passwords)),'en-GB',1,current_timestamp;
			end if; 
            
			select us.id into userid from security.user us where us.organization_id=orgid and us.username=user_name; 
            
            insert into psm.user_election (organization_id,election_id,user_id,pollingstation_id)
			select orgid,electionid,userid,pollstationid;   
            
            insert into security.user_role (organization_id,user_id,role_id) 
			select orgid,userid,ro.id FROM security.role ro 
			where ro.name='Presiding Officer' and ro.organization_id=orgid;
            
            insert into psm.polling_station_election_counting (organization_id,
            polling_station_id,election_id,counting_center_id)
			select orgid,pollstationid,electionid,id from psm.counting_center cc 
            where cc.organization_id=orgid and cc.election_id=electionid;
            
            insert into psm.election_stats (polling_station_id,organization_id,electionid,ballotpaper,postalpack,postalpack_collected
			,spoilt_ballot,ten_ballot_papers,ten_spoilt_ballots) 
			select  pollstationid,orgid,electionid,0,0,0,0,0,0 from psm.polling_station_election 
			where election_id=electionid and organization_id=orgid;
						
            select 'success' as response;

END$$
DELIMITER ;
