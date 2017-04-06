use `psm`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `cumilativeballotcount`(stationid int(11), hour int(3)) RETURNS int(11)
BEGIN
	declare runningtotal int(11) ;
	SELECT sum(ballotpaper) into runningtotal FROM psm.election_stats 
	where polling_station_id=stationid and timeHour>0 and timeHour<=hour;
RETURN runningtotal;
END$$
DELIMITER ;

use `security`;

INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/hourlyanalysis', 'HOURLY_ANALYSIS');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('7', last_insert_id());


INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/pdf-hourlyanalysis', 'HOURLY_ANALYSIS_PDF');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('7', last_insert_id());



use `psm`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `gethourlypapersbybpai`(
stationid int(11), hour int(3), bpai int(2), eid int(11)
) RETURNS int(11)
BEGIN
	declare papers int(11) ;
    declare start int(12);
	if(bpai=1)then
		SELECT ballotstart into start
        FROM psm.polling_station_election where polling_station_id=stationid and election_id=eid;
        
		SELECT sum(es.ballotpaper) into papers 
		FROM psm.election_stats es 
		where es.polling_station_id=stationid 
		and es.timeHour<=hour and es.electionid=eid group by(es.electionid);
        
        set papers = papers + start;
    else
		SELECT es.ballotpaper into papers 
		FROM psm.election_stats es 
		where es.polling_station_id=stationid 
		and es.timeHour=hour and es.electionid=eid group by(es.electionid);
    end if;    
    
RETURN papers;
END$$
DELIMITER ;


INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/psm-hourlyanalysis', 'HOURLY_ANALYSIS_PSM');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('1', last_insert_id());

USE `psm`;
DROP procedure IF EXISTS `getstationidsbyuser`;

DELIMITER $$
USE `psm`$$
CREATE DEFINER=`root`@`%` PROCEDURE `getstationidsbyuser`(in token varchar(255))
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    declare userid int;
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
	select id into orgid from subscription.organization where code=orgcode;
    select u.id into userid from security.user u where u.organization_id=orgid and u.username=username;
    
    SELECT distinct pollingstation_id FROM psm.user_election where user_id=userid;
END$$

DELIMITER ;


