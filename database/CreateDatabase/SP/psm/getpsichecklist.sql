DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getpsichecklist`(in token varchar(255), in placeid int )
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare election_id int;
    declare organizationid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getpsichecklist';
    
    select id into organizationid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
	
		if (select exists 
			(
				select * from psm.psi_check_list pcl
				inner join psm.list l on pcl.list_id = l.id
				inner join psm.list_category lc on l.list_category_id = lc.id
				where pcl.place_id=placeid 
				and lc.name like 'psi_checklist%' 
			)
		) then 
		
			select  l.id as id,
			l.list_value as activity,
			lc.name as category,
			pcl.iscompleted as iscompleted,
            placeid,
			'success' as response
			from psm.psi_check_list pcl
			inner join psm.list l on pcl.list_id = l.id
			inner join psm.list_category lc on l.list_category_id = lc.id
			where pcl.place_id=placeid
			and lc.name like 'psi_checklist%';
 
		else 

			select
			l.id as id,
			l.list_value as activity,
			lc.name as category,
            0 as iscompleted,
            placeid,
			'success' as response 
			from psm.list l
			inner join psm.list_category lc on l.list_category_id = lc.id 
			where lc.name like 'psi_checklist%';
            
           /* select
			l.id as id,
			l.list_value as activity,
			lc.name as category,
            0 as iscompleted,
            placeid,
			'success' as response 
			from psm.list l
			inner join psm.list_category lc on l.list_category_id = lc.id 
			inner join psm.hierarchy_value hv on hv.organization_id=l.organization_id
			where hv.id=placeid and lc.name like 'psi_checklist%';
            */
 
		end if;
        
    else
		select null as id, null as activity, null as category, null as iscompleted, 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
