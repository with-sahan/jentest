DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validate_token`(IN token varchar(255))
BEGIN
	/** break the token **/
    DECLARE user VARCHAR(45);
    DECLARE orgcode VARCHAR(45);
    DECLARE accesstoken VARCHAR(255);
    
    set user=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set accesstoken=security.SPLIT_STR(token,'|',3);
    
    /** check the token in the token table **/
    if (select exists(select * from security.access_token act inner join subscription.organization org on act.organization_id=org.id
    inner join security.user usr on act.userid=usr.id
    where org.code=orgcode and usr.username=user and act.token=accesstoken and
    now() >= act.fromdate OR now() <= act.todate))
    then
		select 1;
    else
		select 0;
    end if;
    
END$$
DELIMITER ;
