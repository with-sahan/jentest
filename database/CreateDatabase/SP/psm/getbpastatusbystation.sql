DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getbpastatusbystation`(in token varchar(255), in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare varelid int(11);
    DECLARE done INT DEFAULT FALSE;
    declare bpastatus int(11);
    
    declare cur cursor  for
    select el.id from psm.polling_station_election pse
        inner join psm.election el on el.id=pse.election_id
        where pse.polling_station_id=stationid and pse.organization_id=orgid and
        el.organization_id=orgid and date(election_date_start)=date(current_date);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;    
    
    
    set bpastatus=1;    
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
			# check the bpa status
            if(select not exists(select * from psm.election_close_stats where organization_id=orgid and election_id=varelid and polling_station_id=stationid)) then
				set bpastatus=0;  
            end if;
		END LOOP;
		CLOSE cur;
        select bpastatus as status,'success' as response;
    else
		select null as status,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
