DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingstationsDetailsbyelectionid`(in token varchar(255),in electionid int(11))
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
	set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then    
		select ifnull((pse.ballotend-pse.ballotstart) ,0) as ballotrange, 
		ifnull((pse.tenderend-pse.tenderstart),0) as tenderedrange,
		ps.name as stationname,
		pse.ballot_box_number as boxnumber,
		hv.value as place,
        ps.id as stationid,
		ifnull(concat(uu.firstname,' ',uu.lastname) , '') as psmname,
        'success' as response
		FROM psm.polling_station_election pse 
		inner join psm.polling_station ps on ps.id=pse.polling_station_id
		inner join psm.hierarchy_value hv on hv.id=ps.hierarchy_value_id
		inner join psm.user_election ue on pse.polling_station_id=ue.pollingstation_id
		inner join security.user uu on uu.id=ue.user_id
		where pse.organization_id=orgid and pse.election_id=electionid 
        and ue.election_id=electionid and ue.organization_id=orgid group by ps.id;
    else select 
    'null' as ballotrange,
    'null' as tenderedrange,
    'null' as stationname,
    'null' as boxnumber,
    'null' as place,
    'null' as psmname,
    'null' as stationid,
    'unauthorized' as response;    
	end if;
    END$$
DELIMITER ;
