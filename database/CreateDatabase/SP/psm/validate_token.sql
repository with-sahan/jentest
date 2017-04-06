DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `validate_token`(in token varchar(255))
BEGIN
    if (security.fn_validate_token(token)=1) then
		select 1 as response;
    else
		select 0 as response;
	end if;
END$$
DELIMITER ;
