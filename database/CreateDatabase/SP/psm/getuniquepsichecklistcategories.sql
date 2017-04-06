DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getuniquepsichecklistcategories`(in token varchar(255), in place_id int)
BEGIN
 if (security.fn_validate_token(token)=1) then
 
 select distinct lc.name as categoryname, 'success' as response
			from psm.list l 
			inner join psm.list_category lc on l.list_category_id = lc.id
			where lc.name like 'psi_checklist%';
 
 /* select distinct lc.name as categoryname, 'success' as response
			from psm.psi_check_list pcl
			inner join psm.list l on pcl.list_id = l.id
			inner join psm.list_category lc on l.list_category_id = lc.id
			where lc.name like 'psi_checklist%' and place_id=place_id;*/
  else
		select  'unauthorized' as response,null as categoryname;
    
 end if;
END$$
DELIMITER ;
