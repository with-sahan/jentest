DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getfilereport`(in token varchar(255),in electionId int(11))
BEGIN
	declare orgcode varchar(45);
    declare orgid int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code=orgcode;
    
	if (security.fn_validate_token(token)=1) then	
		select report_path as reportpath, status as filestatus, 'success' as response 
			from psm.csv_upload where organization_id=orgid and election_id=electionId;
    else 
		select 'unauthorized' as response, null as reportpath, null as filestatus;
    end if;    
    
END$$
DELIMITER ;
