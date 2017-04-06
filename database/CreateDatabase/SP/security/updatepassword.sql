DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatepassword`(IN token VARCHAR(255),
IN newpass VARCHAR(45),in adminpass varchar(255),in userid int(11))
BEGIN
    declare orgcode varchar(45);
    declare orgid int;
    declare usersname varchar(45);
    
    set usersname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
	select id into orgid from subscription.organization where code=orgcode;
    
    if(select not exists (select * FROM security.user u
				where u.passwordhash=sha1(CONCAT(u.passwordsalt,adminpass)) 
                and u.organization_id=orgid and u.username=usersname) 
		)then
			select 'unauthorized' as response;
     else 
		update security.user u set u.passwordhash = sha1(CONCAT(u.passwordsalt,newpass)) 
                where u.id=userid;
     select 'success' as response;       
	 end if;  
END$$
DELIMITER ;
