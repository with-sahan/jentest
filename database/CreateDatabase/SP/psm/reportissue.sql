DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `reportissue`(token varchar(255),election_id int, polling_station_id int, issue_list_id int, description text, priority int )
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare notification_id int(11);
    declare issue_id int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'reportissue';
    select id into orgid from subscription.organization where code = orgcode;
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
			if (election_id =-1) then
				insert into issue(organization_id, pollingstation_id,issue_list_id, description,priority, status,reportedby)
				values(orgid,polling_station_id,issue_list_id, description,priority,0,username);
				select 'success' as response;
            else
				insert into issue(organization_id, pollingstation_id, electionid,issue_list_id, description,priority, status,reportedby)
				values(orgid,polling_station_id, election_id,issue_list_id, description,priority,0,username);
				select 'success' as response;
            end if;
			
            #make notification
            #insert into psm.notification (organization_id,message,createdon ) values(orgid , description  ,CURRENT_TIMESTAMP);
			#SELECT LAST_INSERT_ID() as notification_id;
          
          #make tracking notification
         # SELECT LAST_INSERT_ID() as issue_id;
          #insert into psm.issue_tracking(issue_id,user_id,watched) values (issue_id,1,0);
        else
			select   'denied' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
    END$$
DELIMITER ;
