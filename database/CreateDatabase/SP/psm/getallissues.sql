DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getallissues`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		select isu.id as id,lst.list_value as reason,isu.description as description,isu.priority  as priority,ps.name as pollingstation,ps.id as pollingstationid,
        ps.hierarchy_value_id as pollingstationhierarchyid,isu.status as issuestatus,concat(usr.firstname,' ',usr.lastname) as asignee,usr.id as userid,isu.createdon as issuedate,'success' as response from psm.issue isu
		inner join psm.list lst on lst.id=isu.issue_list_id
		inner join psm.polling_station ps on isu.pollingstation_id=ps.id
		left outer join psm.issue_assignment ism on isu.id=ism.issue_id
		left outer join security.user usr on ism.user_id=usr.id
        where 
        isu.organization_id=orgid and lst.organization_id=orgid and ps.organization_id=orgid order by isu.createdon desc;
    else
		select null as id,null as reason,null  as description,null as priority,null as  pollingstation,null as pollingstationid,null as pollingstationhierarchyid,null as  issuestatus,null  as asignee,null as userid,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
