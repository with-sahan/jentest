DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `starttrack`(in token varchar(255), in longtitude varchar(45) ,in latitude varchar(45) )
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    set spcode='starttrack';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		if(select exists(
        
          select t.* from psm.tracking as t
		  inner join psm.user_election ue on t.election_id = ue.election_id and t.pollingstationid = ue.pollingstation_id and ue.organization_id = t.organization_id 
		  inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
          inner join election e on ue.election_id = e.id
			where u.username= username and u.organization_id = orgid and date(e.election_date_start)=date(current_date) )) then
            
              update psm.tracking as t
			  inner join psm.user_election ue on t.election_id = ue.election_id 
              and t.pollingstationid = ue.pollingstation_id and ue.organization_id = t.organization_id 
			  inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
			  inner join election e on ue.election_id = e.id
			  set t.dispatch_time=CURRENT_TIMESTAMP,t.status=1,t.latitude= latitude,t.longtitude=longtitude
			  where u.organization_id = orgid
			  and u.username= username and  date(e.election_date_start)=date(current_date);
              
			select "tracking already started" as response;
        else
			insert into psm.tracking (organization_id,pollingstationid,election_id,
            deliver_address,dispatch_time,status,latitude,longtitude)
			select ue.organization_id, ue.pollingstation_id, ue.election_id,'address',
            CURRENT_TIMESTAMP,1,latitude,longtitude
				from psm.user_election ue  
				inner join security.user u on ue.user_id = u.id and u.organization_id = ue.organization_id
                inner join election e on ue.election_id = e.id
				where u.username= username and u.organization_id = orgid and date(e.election_date_start)=date(current_date);

			select "success" as response;
        end if;
    else
		select "unauthorized" as response;
    end if;
END$$
DELIMITER ;
