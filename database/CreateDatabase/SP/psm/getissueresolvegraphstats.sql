DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getissueresolvegraphstats`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int;
    declare varIssueHr int;
    declare varAvgTime int;
    DECLARE done INT DEFAULT FALSE;
    
	declare cur cursor  for select HOUR(isu.createdon) issuehour,Coalesce(sum(TIMESTAMPDIFF(MINUTE,isu.createdon,isu.resolvedon))/count(isu.id), 0)  as avgresolve from psm.issue isu
		where isu.status=2 and isu.organization_id=orgid and date(isu.createdon)=date(current_date)
        group by HOUR(isu.createdon);
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
    
    if (security.fn_validate_token(token)=1) then
		
        drop table if exists `result`;
		create temporary table result (issuehour int,reported int,avgresolvetime float,response varchar(55))engine=memory;
        
		insert into result        
        select HOUR(isu.createdon),count(isu.id),0,"ok" from psm.issue isu		
		where isu.status=2 and isu.organization_id=orgid and date(isu.createdon)=date(current_date)
        group by HOUR(isu.createdon);
               
        open cur;
        read_loop: LOOP
			FETCH cur INTO varIssueHr,varAvgTime;
			IF done THEN
				LEAVE read_loop;
			END IF;
			update result set avgresolvetime=varAvgTime where issuehour=varIssueHr;
		END LOOP;
		CLOSE cur;
        
        select * from result;
        drop table result;
    else
		select null as issuehour,null as reported,null as avgresolvetime,"unautorized" as response;
    end if;
END$$
DELIMITER ;
