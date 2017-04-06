/*SELECT * FROM psm.polling_station_election where organization_id=123 and polling_station_id=6839; */


set @status = 0;
set @orgid = 123;
set @eid = 187;
set @stationid = 6839;
update psm.election el inner join polling_station_election pse on pse.election_id=el.id 
                set pse.election_status = @status 
                where pse.organization_id = @orgid 
                and pse.organization_id=@orgid and pse.election_id=@eid and pse.polling_station_id=@stationid;
/*
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='13200';
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='13201';
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='12592';
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='13323';
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='13324';
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='13325';
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='13282';
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='12304';
UPDATE `psm`.`polling_station_election` SET `election_status`='0' WHERE `id`='13283';
*/