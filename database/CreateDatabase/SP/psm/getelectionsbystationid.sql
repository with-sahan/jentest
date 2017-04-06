DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getelectionsbystationid`(in token varchar(255),in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set spcode='getelectionsbystationid';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select "success" as response,
        el.id as electionid,
        el.election_name as electionname,
        el.election_date_start as startdate,
        el.election_date_end as enddate,
        el.status as status,
        el.ballotboxno as ballotboxno,
        pse.isopen as isopened,
        pse.isclose as isclosed,
        pse.opentime as electionstarttime,
        pse.openedat as openedat,
        pse.closedat as closedat
        
        from psm.election el inner join
        psm.polling_station_election pse on pse.election_id=el.id
        inner join subscription.organization org on org.id=pse.organization_id
        where pse.polling_station_id=stationid and date(el.election_date_start)=date(current_date)
        and el.is_deleted = 0;
    else
		select "unauthorized" as response,
        null as electionid,
        null as electionname,
        null as startdate,
        null as enddate,
        null as status,
        null as ballotboxno,
        null as isopened,
        null as isclosed,
        null as electionstarttime,
        null as openedat,
        null as closedat;
    end if;
    
END$$
DELIMITER ;
