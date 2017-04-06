DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `returnHierarchy`(placeid int, type int) RETURNS varchar(255) CHARSET utf8
BEGIN
/* 
 type 1 = Ward
 type 2 = District
 type 3 = Place
 */
	declare wardid int;
    declare districtid int;
    declare ward varchar(255);
    declare district varchar(255);
    declare place varchar(255);
if (type=3) then 
	select value into place from psm.hierarchy_value where id=placeid;
	return place;
elseif (type=2) then
	select parent_id into districtid from psm.hierarchy_value where id=placeid;
	select value into district from psm.hierarchy_value where id=districtid;
	return district;
elseif (type=1) then  
	select parent_id into districtid from psm.hierarchy_value where id=placeid;
    select parent_id into wardid from psm.hierarchy_value where id=districtid;
	select value into ward from psm.hierarchy_value where id=wardid;
	return ward;	
end if;
END$$
DELIMITER ;
