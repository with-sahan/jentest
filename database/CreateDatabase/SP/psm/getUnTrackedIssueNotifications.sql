DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getUnTrackedIssueNotifications`(in token varchar(255))
BEGIN

  declare user_name varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    
    set user_name=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);

if (security.fn_validate_token(token)=1) then

  
     select id into orgid from subscription.organization where code=orgcode;
    
	SELECT id into userid FROM security.user where username=user_name and organization_id=orgid;
   # set userid=405;

	select it.id as issuenotificationid, ps.name as pollingstationname, i.id as issueid , i.description as description, 'success' as response from psm.issue_tracking as it
    inner join psm.issue i on i.id= it.issue_id
    inner join psm.polling_station ps on ps.id=i.pollingstation_id
    where user_id=userid and it.watched=0
    order by i.createdon desc;
    
  else
  	select null as issueid , null as description,'unauthorized' as response;
    end if;
END$$
DELIMITER ;
