DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updatepsichecklist`(token varchar(255), place_id int, activity_id int, status int)
BEGIN

	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'updatepsichecklist';
    select id into orgid from subscription.organization where code = orgcode;
    
    if (security.fn_validate_token(token)=1) then
        
		if(select exists 
			(
			 select pcl.* from psm.psi_check_list pcl inner join
			 psm.hierarchy_value hv on pcl.place_id = hv.id
			 where pcl.organization_id = hv.organization_id
             and pcl.organization_id = orgid and pcl.place_id=place_id
             and pcl.list_id = activity_id
			) 
            ) then
                /*update psi_check_list if record exists */
                update psm.psi_check_list pcl 
                set pcl.iscompleted = status
                where pcl.place_id = place_id and
                pcl.organization_id = orgid and pcl.list_id = activity_id;
    
				select 'success' as response;
                
		else

			/*insert record if doesnt*/
			insert into psm.psi_check_list(organization_id, list_id, place_id, iscompleted)
			values(orgid, activity_id, place_id, status);

			select 'success' as response;
			
		end if;
            
    else
  
		select 'unauthorized' as response;
    
    end if;
    
END$$
DELIMITER ;
