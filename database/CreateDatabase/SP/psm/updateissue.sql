DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updateissue`(in token varchar(255),in issueid int,in userid int,in status int,in priority int,in comment varchar(1000))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    declare notificationid int;
    
    set spcode='updateissue';
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select id into orgid from subscription.organization where code=orgcode;
        #delete previous assignments
        /*delete from psm.issue_assignment where issue_id=issueid and organization_id=orgid;
		insert into psm.issue_assignment (organization_id,issue_id,user_id)
		values (orgid,issueid,userid);*/
        
        #now update the data to issue table
        if status=2 then
			update psm.issue set resolution_desc=nullif(comment,''),status=status,priority=priority,resolvedon=current_timestamp where id=issueid and organization_id=orgid;
        else
			update psm.issue set resolution_desc=nullif(comment,''),status=status,priority=priority where id=issueid and organization_id=orgid;
        end if;
        
       
        
        select 'success' as response;
	else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
