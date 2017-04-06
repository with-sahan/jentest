DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getissuebyid`(in token varchar(255),in issueid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    #declare userid int;
    set spcode='getissuebyid';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 ) then
		select id into orgid from subscription.organization where code=orgcode;
		select 
        isu.pollingstation_id as stationid,
        ps.name as stationname,
        lst.list_value as issuetype,
        IFNULL(isu.description,'') as issuedescription,
        isu.priority as priority,
        IFNULL(isu.resolution_desc,'') as resolutiondescription,
        isu.status as issuestatus,
        concat(usr.firstname, ' ',usr.lastname) as assignedto,
        isa.user_id as userid,
        isa.assignon as assignedon,
        isu.createdon as createdon,
        isu.resolvedon as resolvedon,
        isu.reportedby as reportedby,
        'success' as response
        
        from psm.issue isu
        left outer join psm.issue_assignment isa on isu.id=isa.issue_id
        left outer join security.user usr on usr.id=isa.user_id
        inner join psm.polling_station ps on isu.pollingstation_id=ps.id
        inner join psm.list lst on isu.issue_list_id=lst.id
        where isu.id=issueid and isu.organization_id=orgid and ps.organization_id=orgid and lst.organization_id=orgid;
    else
		select 
        null as stationid,
        null stationname,
        null as issuetype,
        null as issuedescription,
        null as priority,
        null as resolutiondescription,
        null as issuestatus,
        null as assignedto,
        null as userid,
        null as assignedon,
        null as createdon,
        null as resolvedon,
        null as reportedby,
        'unauthorized' as response;
    end if;
END$$
DELIMITER ;
