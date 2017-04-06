DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getorginfo`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare userid int(11);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare user_role_id int(11);    
    declare role_result int(11); 
    
    declare psi_id int(11);    
    declare psm_id int(11);    
    declare em_id int(11);
    declare ro_id int(11);    
    declare ir_id int(11);    
    declare pc_id int(11);
    declare sa_id int(11);

    set spcode='getorginfo';
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set orgid=(select id from subscription.organization where code=orgcode);
    set userid=(select id FROM security.user u where u.organization_id=orgid and u.username=username);
    set psm_id=(select id from security.role where organization_id=orgid and name='Presiding Officer');
    set psi_id=(select id from security.role where organization_id=orgid and name='Polling Station Inspector');
    set em_id=(select id from security.role where organization_id=orgid and name='Election Manager');
    
    set ro_id=(select id from security.role where organization_id=orgid and name='Returning officer');
    set ir_id=(select id from security.role where organization_id=orgid and name='Issue Resolver');
    set pc_id=(select id from security.role where organization_id=orgid and name='Polling clerks');
    set sa_id=(select id from security.role where organization_id=orgid and name='Super Admin');
    
    set user_role_id=(select distinct role_id FROM security.user_role where user_id=userid and organization_id=orgid);
    
    if (user_role_id=psm_id) then
		select 1 into role_result;
    elseif (user_role_id=em_id) then
		select 2 into role_result;
	elseif (user_role_id=psi_id) then
		select 3 into role_result;  
    elseif (user_role_id=ir_id) then
		select 4 into role_result;
	elseif (user_role_id=ro_id) then
		select 5 into role_result;  
    elseif (user_role_id=pc_id) then
		select 6 into role_result; 
    elseif (user_role_id=sa_id) then
		select 7 into role_result;      
    else select 0 into role_result; 
    end if;    
    
    if (security.fn_validate_token(token)=1) then
		select 'success' as response,org.name as organization,role_result as roletype,
        org.logo_url as logourl,concat(us.firstname,' ',us. lastname) as userfullname  
        from security.user us
        inner join subscription.organization org on us.organization_id=org.id
        where org.code=orgcode and us.username=username;
    else
		select 'unauthorized' as response,null as organization,null as logourl,null as userfullname,null as roletype;
    end if;
END$$
DELIMITER ;
