DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstations`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getpollingstations';
    
    
    if (security.fn_validate_token(token)=1) then
    
		if(security.fn_validate_permission(token,spcode,'psm') = 1) then
    
			/** get polling stations **/
			select distinct ps.id,psm.isopen(ps.id) as closed_status, ps.name, ps.address, ps.postcode, null as opentime, 'ok' as response from psm.polling_station ps 
			inner join psm.polling_station_election pse on ps.id = pse.polling_station_id  
            inner join psm.election el on el.id=pse.election_id
			inner join psm.user_election ue on ue.election_id = pse.election_id and ue.pollingstation_id  = pse.polling_station_id
			inner join security.user u on ue.user_id = u.id
			inner join subscription.organization org on org.id = u.organization_id
			where u.username = username and org.code=orgcode and el.is_deleted=0 ; 
        
		/*	where u.username = username and org.code=orgcode and date(el.election_date_start)=date(current_date) and el.is_deleted=0 ; */
        else
			select null as id, null as closed_status,null as name,null as address, null as postcode, null as opentime, 'unauthorized' as response;
        end if;
    else
		select null as id, null as closed_status,null as name,null as address, null as postcode, null as opentime, 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
