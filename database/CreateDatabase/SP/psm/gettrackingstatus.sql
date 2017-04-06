DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `gettrackingstatus`(in token varchar(255),in electionid INT,in stationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    set spcode='gettrackingstatus';
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')) then
		select t.status as status,"success" as response  from psm.tracking t
        inner join psm.election e on t.election_id=e.id
        inner join psm.polling_station p on t.pollingstationid=p.id
        inner join subscription.organization o on t.organization_id=o.id
        where o.code=orgcode and t.election_id=electionid and t.pollingstationid=stationid;
    else
		select null as status,"unauthorized" as response;
    end if;
END$$
DELIMITER ;
