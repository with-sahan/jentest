USE `psm`;
DROP function IF EXISTS `gethourlypapersbybpai`;

DELIMITER $$
USE `psm`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `gethourlypapersbybpai`(
stationid int(11), hour int(3), bpai int(2), eid int(11)
) RETURNS int(11)
BEGIN
	declare papers int(11) ;
    declare start int(12);
    declare bpai_hour_count int(11);
    
    SELECT es.ballotpaper into bpai_hour_count 
		FROM psm.election_stats es 
		where es.polling_station_id=stationid 
		and es.timeHour=hour and es.electionid=eid group by(es.electionid);
        
	if(bpai=1)then
        
        if(bpai_hour_count=0)
			then set papers = bpai_hour_count;
        else        
			SELECT ballotstart into start
			FROM psm.polling_station_election where polling_station_id=stationid and election_id=eid;
            
			SELECT sum(es.ballotpaper) into papers 
			FROM psm.election_stats es 
			where es.polling_station_id=stationid 
			and es.timeHour<=hour and es.electionid=eid group by(es.electionid);
			
			set papers = papers + start;
        end if;    
    else
		set papers = bpai_hour_count;
    end if;    
    
RETURN papers;
END$$

DELIMITER ;

