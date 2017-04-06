DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `fn_validate_token`( token VARCHAR(255) ) RETURNS tinyint(1)
return 1$$
DELIMITER ;
