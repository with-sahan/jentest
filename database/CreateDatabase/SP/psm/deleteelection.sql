DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `deleteelection`(in token varchar(255), in eid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'deleteelection';
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
		/*#delete from child tables
        
        #psm.compliance_election
		delete from psm.compliance_election where election_id=eid and organization_id=organizationid;
        
        #psm.election_close_stats
        delete from psm.election_close_stats where election_id=eid and organization_id=organizationid;
        
        #psm.election_stats
        delete from psm.election_stats where electionid=eid and organization_id=organizationid;
        
        #psm.issue
        delete from psm.issue where electionid=eid and organization_id=organizationid;
        
        #psm.open_close_election
        delete from psm.open_close_election where election_id=eid and organization_id=organizationid;        
        
        #psm.polling_station_election_counting
        delete from psm.polling_station_election_counting where election_id=eid and organization_id=organizationid;
        
        #psm.station_photo
        delete from psm.station_photo where election_id=eid and organization_id=organizationid;
        
        #psm.tracking
        delete from psm.tracking where election_id=eid and organization_id=organizationid;
        
        #psm.counting_center
        delete from psm.counting_center where election_id=eid and organization_id=organizationid;
        
        #psm.user_election
        delete from psm.user_election where election_id=eid and organization_id=organizationid;
        
        #psm.polling_station_election
        delete from psm.polling_station_election where election_id=eid and organization_id=organizationid;
        
        #delete from parent table election
        delete from psm.election where id=eid and organization_id=organizationid;*/
        
        update psm.election election set election.is_deleted=1 where election.id=eid; 
        
        select 'success' as response;
		
    else
		select 'unauthorized' response;
    end if;
END$$
DELIMITER ;
