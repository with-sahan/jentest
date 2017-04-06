DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `reportissue_v2`(token varchar(255),election_id int, polling_station_id int, issue_list_id int, description text, priority int )
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
				select LAST_INSERT_ID() as response;
            else
				insert into issue(organization_id, pollingstation_id, electionid,issue_list_id, description,priority, status,reportedby)
				values(orgid,polling_station_id, election_id,issue_list_id, description,priority,0,username);
				select LAST_INSERT_ID() as response;
            end if;
			
           
        else
			select   -2 as response;
        end if;
    else
		select -3 as response;
    end if;
END$$
DELIMITER ;
