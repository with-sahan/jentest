DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getUsersByRoleIds`(in token varchar(255),IN role_id_list TEXT)
BEGIN

declare orgid int;
declare roleid int;
declare orgcode varchar(45);

set orgcode=security.SPLIT_STR(token,'|',2);
    

if (security.fn_validate_token(token)=1 )
then
	
	SELECT u.firstname,u.lastname,u.username,u.id,'success' as response FROM security.user_role ur
		inner join  security.user u on u.id=ur.user_id
		where FIND_IN_SET(ur.role_id, role_id_list);

else
	select 'unauthorized' as response;
     
end if;

END$$
DELIMITER ;
