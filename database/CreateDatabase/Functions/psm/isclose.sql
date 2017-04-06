DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `isclose`(stationid int) RETURNS int(11)
BEGIN
DECLARE electioncount int;
DECLARE closed int;
DECLARE resp int;

select count(*) into electioncount from psm.polling_station_election pse 
inner join psm.election el on el.id=pse.election_id 
where pse.polling_station_id=stationid and date(el.election_date_start)=current_date();

select (sum(pse.isopen=0)+sum(pse.isclose)) into closed from psm.polling_station_election pse 
inner join psm.election el on el.id=pse.election_id 
where pse.polling_station_id=stationid and date(el.election_date_start)=current_date();


 IF electioncount = closed THEN SET resp = 1;
    ELSE SET resp = 0;
    END IF;

RETURN resp;
END$$
DELIMITER ;
