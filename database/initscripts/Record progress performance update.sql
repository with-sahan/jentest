alter table election_stats add column timeHour int null;

SET SQL_SAFE_UPDATES = 0;
update election_stats set timeHour = HOUR(updatedon);


ALTER TABLE election_stats ADD INDEX election_stats_timeHour (timeHour)