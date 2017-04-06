USE `security`;

CREATE TABLE `jwt_access_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `organization_code` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL,
  `status` int(11) NOT NULL COMMENT '0-ACTIVE, 1-INACTIVE',
  `time_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `validity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jwtat_fk1_idx` (`organization_code`),
  KEY `jwtat_fk2_idx` (`user_name`),
  KEY `jwtat_token_idx` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8;


DROP FUNCTION `security`.`fn_validate_token`;

CREATE DEFINER=`root`@`%` FUNCTION `fn_validate_token`( token VARCHAR(255) ) RETURNS tinyint(1)
return 1;  




USE `psm`;
DROP PROCEDURE `psm`.`completeprogresssequence`;


DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `completeprogresssequence`(in token varchar(255),in stationid int)
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
            
            
            call closeelection(token,varelid,stationid,1);
            call generatebpa(token,stationid,varelid);
            call closepollingstation(token,stationid);
            
            
		END LOOP read_loop;
		CLOSE cur;
		select 'finished' as reply;		
	else
		select 'unauthorized' as reply;
	end if;
END$$
DELIMITER ;
;