DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `completeprogresssequence`(in token varchar(255),in stationid int )
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare eidcount int(11);
    declare varelid int(11);
    DECLARE done INT DEFAULT FALSE;
    
    declare cur cursor  for
			select election_id FROM psm.polling_station_election where polling_station_id=stationid;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
            
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;

	if (security.fn_validate_token(token)=1) then
         
         open cur;
         read_loop: LOOP
         
			FETCH cur INTO varelid;
            
			IF done THEN
				LEAVE read_loop;
			END IF;
            
            /* Close elections */
            call closeelection(token,varelid,stationid,1);
            call generatebpa(token,stationid,varelid);
            call closepollingstation(token,stationid);
            /*call starttrack(token,longtitude,latitude);*/
            
		END LOOP read_loop;
		CLOSE cur;
		select 'finished' as reply;		
	else
		select 'unauthorized' as reply;
	end if;
END$$
DELIMITER ;
