USE `psm`;
DROP procedure IF EXISTS `getallusers`;

DELIMITER $$
USE `psm`$$
CREATE DEFINER=`root`@`%` PROCEDURE `getallusers`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);    
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1) then
		select firstname,lastname,username,'success' as response from security.user where organization_id=orgid;
    else
		select null firstname,null lastname,null username,'unauthorized' as response;
    end if;
END$$

DELIMITER ;

