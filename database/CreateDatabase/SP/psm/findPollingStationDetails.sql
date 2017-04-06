DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `findPollingStationDetails`(IN Array_String TEXT)
BEGIN
SELECT distinct pc.name as key_contact_name ,pc.phone as contact_details,  hv.value as place,ps.name as polling_station,pse.isopen as is_open,pse.isclose as is_close FROM psm.polling_station_election as pse 
inner join psm.polling_station ps on pse.polling_station_id=ps.id
inner join psm.hierarchy_value hv on hv.id=ps.hierarchy_value_id
inner join psm.polling_contacts pc on pc.pollingstation_id = ps.id
where FIND_IN_SET(hierarchy_value_id, Array_String) and pc.primary_contact=1;
END$$
DELIMITER ;
