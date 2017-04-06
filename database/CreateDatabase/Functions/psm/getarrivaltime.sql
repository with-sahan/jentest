DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `getarrivaltime`(trackid int) RETURNS varchar(255) CHARSET utf8
BEGIN

	/*DECLARE arrivaltime timestamp;
	DECLARE trackstatus int;
	DECLARE hours varchar(5);   
    DECLARE response varchar(255);
    select status into trackstatus from psm.tracking where id=trackid;
    
    select SUBSTRING_INDEX(TIMEDIFF(deliver_time, dispatch_time),':',1)
		into hours from psm.tracking where id=trackid;
    
	if (trackstatus=2) then
		if(hours='00') then
			select CONCAT(
			SUBSTR(TIMEDIFF(deliver_time, dispatch_time), INSTR(TIMEDIFF(deliver_time, dispatch_time), ':')+1, 2), ' minutes') 
			into response from psm.tracking where id=trackid;        
        else
			select CONCAT(hours,' hours ',
			SUBSTR(TIMEDIFF(deliver_time, dispatch_time), INSTR(TIMEDIFF(deliver_time, dispatch_time), ':')+1, 2), ' minutes') 
			into response from psm.tracking where id=trackid;
        end if;    
	else
		select ' ' into response;
    end if;    */
    DECLARE response varchar(255);
	select deliver_time into response from psm.tracking where id=trackid;
RETURN response;
END$$
DELIMITER ;
