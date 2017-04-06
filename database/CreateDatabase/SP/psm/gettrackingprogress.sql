DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `gettrackingprogress`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    set spcode='gettrackingstatus';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
     select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
    
    select track.pollingstationid as stationid, 
    psm.getarrivaltime(track.id) as arrivaltime,
	td.ballot_box_number,
    track.status as status, 
	IFNULL(track.longtitude,0) as longtitude,
	IFNULL(track.latitude, 0) as latitude,
    cc.name as counting_center_id,
    IFNULL(cc.latitude, 0) as destination_latitude,
    IFNULL(cc.longitude,0) as destination_longtitude,
    p.name as polling_station,
	'success' as response
    from psm.tracking track
    inner join 
    (
		select 
        MAX(t.id) as trackingid
        /*t.pollingstationid as stationid
        ,t.election_id as electionid*/
        ,GROUP_CONCAT(pse.ballot_box_number) as ballot_box_number
        /*,IFNULL(t.longtitude,0) as longtitude
        , IFNULL(t.latitude, 0) as latitude
        , 'success' as response */
        from 
		psm.tracking t inner join psm.polling_station_election pse
		on pse.polling_station_id = t.pollingstationid and pse.election_id = t.election_id and pse.organization_id = t.organization_id
        inner join psm.election e on pse.election_id = e.id and pse.organization_id = t.organization_id
        where t.organization_id = orgid 
        and date(e.election_date_start)=date(current_date) 
        GROUP BY t.pollingstationid
        ) td on track.id = td.trackingid
        INNER JOIN polling_station_election_counting psec on 
        psec.polling_station_id = track.pollingstationid and psec.election_id = track.election_id and psec.organization_id = track.organization_id
        inner join counting_center cc on psec.counting_center_id = cc.id and psec.organization_id = cc.organization_id
        inner join polling_station p on psec.polling_station_id = p.id
        order by p.id;
    else
		select null as trackingid,null as stationid,null as electionid,null as ballot_box_number,null as latitude, null as longtitude,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
