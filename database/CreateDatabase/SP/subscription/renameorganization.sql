DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `renameorganization`(in previous varchar(255),in newname varchar(255))
BEGIN
	declare orgid int(45);
    declare orgidnew int(45);
    select 0 into orgidnew;
    select id into orgidnew from subscription.organization where code=newname;
    if(orgidnew>0) then
        select 'name already in use',orgidnew; 
    else   
		select id into orgid from subscription.organization where code=previous;
		delete FROM security.access_token where organization_id=orgid;
		update subscription.organization set name=newname,code=newname,area_name=newname where id=orgid;
        select 'success',orgid;
    end if;    
END$$
DELIMITER ;
