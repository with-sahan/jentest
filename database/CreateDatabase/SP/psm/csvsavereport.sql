DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `csvsavereport`(in token varchar(255),
in path varchar(255),
in eid int(11),in filestatus int(3))
BEGIN
	declare orgcode varchar(45);
	declare orgid int(11);
	set orgcode=security.SPLIT_STR(token,'|',2);

	select id into orgid from subscription.organization where code=orgcode;
    
    if(select not exists (select * FROM psm.csv_upload 
				where organization_id=orgid and election_id=eid) 
		)then
			insert into psm.csv_upload(organization_id,election_id,report_path,status) 
			values (orgid,eid,path,filestatus);
    else
		UPDATE psm.csv_upload SET report_path=path,status=filestatus
			WHERE organization_id=orgid and election_id=eid;
    
	end if; 
    
END$$
DELIMITER ;
