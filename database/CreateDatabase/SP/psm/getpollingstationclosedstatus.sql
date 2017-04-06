DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationclosedstatus`(in token varchar(255),in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set spcode='getnewnotifications';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then
    
    select min(pse.isopen) as open_status, min(pse.isclose) as closed_status,"success" as response from psm.polling_station_election pse
	inner join psm.election e on pse.election_id = e.id and pse.organization_id = e.organization_id
	where pse.polling_station_id=stationid and pse.organization_id = orgid 
    and UNIX_TIMESTAMP(DATE(e.election_date_start)) = UNIX_TIMESTAMP(CURDATE());

    else
		select null as open_status,null as closed_status ,"unauthorized" as response;
    end if;
END$$
DELIMITER ;
