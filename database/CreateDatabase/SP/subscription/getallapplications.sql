DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getallapplications`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    set spcode='getorginfo';
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    if (security.fn_validate_token(token)=1) then
		select app.id as applicationid,app.name as applicationname,'success' as response from subscription.organization_application orgapp
        inner join subscription.organization org on org.id=orgapp.organization_id
        inner join subscription.application app on app.id=orgapp.application_id
        where org.code=orgcode;
    else
		select null as applicationid,null as applicationname,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
