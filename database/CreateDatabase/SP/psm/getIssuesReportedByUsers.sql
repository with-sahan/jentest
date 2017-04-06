DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getIssuesReportedByUsers`(token varchar(255),IN userIds TEXT)
BEGIN

    declare spcode varchar(45);
    

    set spcode = 'getIssuesReportedByUsers';
    
    
      if (security.fn_validate_token(token)=1) then

			select *  from psm.issue_assignment as ia
            inner join psm.issue as i on i.id=ia.issue_id
            where FIND_IN_SET(user_id, userIds);


    end if;
    
END$$
DELIMITER ;
