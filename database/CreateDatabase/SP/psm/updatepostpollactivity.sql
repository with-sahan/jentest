DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updatepostpollactivity`(token varchar(255), polling_station_id int,election_id int, activity_id int, status int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'updateprepollactivity';
    select id into orgid from subscription.organization where code = orgcode;
    
    
    if (security.fn_validate_token(token)=1) then
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
        
			if(select exists 
				(
					select oce.* from psm.open_close_election oce where oce.election_id = election_id 
					and oce.polling_station_id = polling_station_id and oce.list_id = activity_id 
					and oce.organization_id = orgid
				) 
            ) then
                /*update status if record exists */
				
                update psm.open_close_election oce set oce.iscompleted = status 
                where oce.election_id = election_id and 
				oce.polling_station_id = polling_station_id and oce.list_id = activity_id 
                and oce.organization_id = orgid;
                
				select 'success' as response;
                
			else
				/*insert record if doesnt*/
				insert into psm.open_close_election(organization_id,polling_station_id, election_id,list_id,iscompleted ) 
                values(orgid,polling_station_id,election_id, activity_id,status);
                
				select 'success' as response;
                
            end if;

        else
			select   'denied' as response;
        end if;
    else
		select 'unauthorized' as response;
    end if;
    
END$$
DELIMITER ;
