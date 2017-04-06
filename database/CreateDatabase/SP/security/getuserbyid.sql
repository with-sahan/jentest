DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getuserbyid`(in token varchar(255),in userid int)
BEGIN        
    if (security.fn_validate_token(token)=1 ) then
		select firstname,lastname,IFNULL(email,'') as email,username,gender,'success' as response from security.user where id=userid;
    else
		select null as firstname,null as lastname,null as email,null as username,null as gender,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
