DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getunwatchedissuelist`(token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'getunwatchedissuelist';
    
    if (security.fn_validate_token(token)=1) then

        
			SELECT id,description FROM psm.issue where watched=0;
        
   
    else
		select null as id, null as description, 'unauthorized' as response;
    end if;

END$$
DELIMITER ;
