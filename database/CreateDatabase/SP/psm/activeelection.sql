DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `activeelection`(in orgid int)
BEGIN
update psm.election set election_date_start=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 7 HOUR),
 '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),
 election_date_end=STR_TO_DATE(DATE_FORMAT(DATE_ADD(current_date,INTERVAL 22 HOUR),
 '%d-%m-%Y %H:%m:%S'),'%d-%m-%Y %H:%m:%S'),status=0 
 where organization_id=orgid;

END$$
DELIMITER ;
