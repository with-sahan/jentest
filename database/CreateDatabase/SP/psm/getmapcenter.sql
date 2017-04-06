DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getmapcenter`(in token varchar(255))
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    if (security.fn_validate_token(token)=1 ) then
		SELECT latitude,longitude,'success' as response 
        FROM psm.counting_center where organization_id=orgid group by organization_id;
    else
		select null as latitude,null as longitude,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
