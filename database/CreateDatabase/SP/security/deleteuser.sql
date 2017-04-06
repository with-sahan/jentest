DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `deleteuser`(in token varchar(255),in usrid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'deleteuser';
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1 ) then
		/*#delete from child tables
        
        #psm
        #psm.chat
        delete from psm.chat where userid=usrid and organizationid=orgid;
        
        #psm.issue
        delete from psm.issue where reportedby=username and organization_id=orgid;
        
        #psm.issue_assignment
        delete from psm.issue_assignment where user_id=usrid and organization_id=orgid;
        
        #psm.issue_comment
        delete from psm.issue_comment where user_id=usrid and organization_id=orgid;
        
        #psm.notification_status
        delete from psm.notification_status where userid=usrid and organization_id=orgid;
        
        #psm.user_election
        delete from psm.user_election where user_id=usrid and organization_id=orgid;
        
        #psm.voter_list
        delete from psm.voter_list where userid=usrid and organizationid=orgid;
        
        #security
        #security.access_token
        delete from security.access_token where userid=usrid and organization_id=orgid;
        
        #security.user_role
        delete from security.user_role where user_id=usrid and organization_id=orgid;
        
        #delete from parent table user
        delete from security.user where id=usrid and organization_id=orgid;*/
        
        update security.user usr set usr.is_deleted=1 where usr.id=usrid; 
        
		select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
