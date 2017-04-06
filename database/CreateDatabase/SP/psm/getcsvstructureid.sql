DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getcsvstructureid`(in token varchar(255))
BEGIN
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set orgcode=security.SPLIT_STR(token,'|',2);
    select csvstructureid from subscription.organization where code=orgcode;

END$$
DELIMITER ;
