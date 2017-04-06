DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `isopen`(stationid int) RETURNS int(11)
BEGIN
DECLARE opened int;
DECLARE resp int;

select sum(pse.isopen)-sum(pse.isclose) into opened from psm.polling_station_election pse 
inner join psm.election el on el.id=pse.election_id 
where pse.polling_station_id=stationid and date(el.election_date_start)=current_date();


 IF opened>0 THEN SET resp = 1;
    ELSE SET resp = 0;
    END IF;

RETURN resp;
END$$
DELIMITER ;
