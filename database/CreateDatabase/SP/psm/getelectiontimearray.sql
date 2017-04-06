DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getelectiontimearray`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getelectiontimearray';
    
  
    if (security.fn_validate_token(token)=1) then
    
			drop table if exists `hourlyresult`;
			create temporary table hourlyresult (id int,hourlytime varchar(55),ballotsissued int,spoiltballots int,postalpacks int,tenballotsissued int,tenspoiltballots int)engine=memory;
            
			SELECT (HOUR(election_date_start)) as starttimehour, (TIMESTAMPDIFF(HOUR,election_date_start,election_date_end)) 
			as difference, id as electionid,'success' as response from psm.election WHERE UNIX_TIMESTAMP(DATE(election_date_start)) = UNIX_TIMESTAMP(CURDATE());
	else
		select null as starttimehour,null as difference,null as electionid,'unauthorized' as response;
    end if;
    
		
END$$
DELIMITER ;
