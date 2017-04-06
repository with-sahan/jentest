DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstations_v2`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getpollingstations_v2';
    
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then
    
		/** get polling stations **/
		select distinct ps.id as polling_station_id, ps.name as polling_station_name, 
        ps.address as polling_station_address, ps.postcode as polling_station_postcode, 
        ps.createdon as opentime, ps.organization_id as organization_id, 
        'success' as response from psm.polling_station ps 
		inner join psm.polling_station_election pse on ps.id = pse.polling_station_id  
		inner join psm.election el on el.id=pse.election_id
		inner join psm.user_election ue on ue.election_id = pse.election_id and 
        ue.pollingstation_id  = pse.polling_station_id
		where el.is_deleted=0 
        and ps.organization_id=orgid; 
		/*where date(el.election_date_start)=date(current_date) and el.is_deleted=0 */
        
        
    else
		select null as id, null as name,null as address, null as postcode, null as opentime, 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
