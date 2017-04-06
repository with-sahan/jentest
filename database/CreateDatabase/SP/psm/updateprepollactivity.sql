DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updateprepollactivity`(token varchar(255), polling_station_id int, activity_id int, status int)
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
     select oce.* from psm.open_close_election oce inner join
     psm.polling_station_election pse on oce.polling_station_id = pse.polling_station_id and oce.election_id = pse.election_id 
     and oce.organization_id = pse.organization_id
                    inner join psm.election e on e.id = oce.election_id  
                    where pse.polling_station_id = polling_station_id and oce.list_id = activity_id 
                    and pse.organization_id = orgid and date(e.election_date_start)=date(current_date)
     /*select oce.* from psm.open_close_election oce where oce.election_id = election_id 
     and oce.polling_station_id = polling_station_id and oce.list_id = activity_id 
     and oce.organization_id = orgid*/
    ) 
            ) then
                /*update status if record exists */
                update psm.open_close_election oce 
    inner join
    psm.polling_station_election pse on oce.polling_station_id = pse.polling_station_id and oce.election_id = pse.election_id 
    and oce.organization_id = pse.organization_id
                inner join election e on pse.election_id  = e.id
                set oce.iscompleted = status
                where pse.polling_station_id = polling_station_id and oce.list_id = activity_id 
    and pse.organization_id = orgid
                and date(e.election_date_start)=date(current_date);
    
                /*update psm.open_close_election oce set oce.iscompleted = status 
                where oce.election_id = election_id and 
    oce.polling_station_id = polling_station_id and oce.list_id = activity_id 
                and oce.organization_id = orgid;*/
    select 'success' as response;
                
   else
    /*insert record if doesnt*/
    insert into psm.open_close_election(organization_id,polling_station_id, election_id,list_id,iscompleted ) 
    select orgid,polling_station_id, pse.election_id,activity_id,status 
                from psm.polling_station_election pse
                inner join election e on pse.election_id = e.id
                where pse.polling_station_id = polling_station_id and pse.organization_id = orgid
                and date(e.election_date_start)=date(current_date);
                /*values(orgid,polling_station_id,election_id, activity_id,status);*/
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
