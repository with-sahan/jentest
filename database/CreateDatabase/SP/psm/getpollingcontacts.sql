DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `getpollingcontacts`(in token varchar(255))
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
	declare orgid int(11);
	declare userid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set orgid=(select id from subscription.organization where code=orgcode);
	select id into userid from security.user u where u.username = username and u.organization_id=orgid;
    
    
    if (security.fn_validate_token(token)=1) then
		SELECT distinct
		pc1.id as id, 
		pc1.description as description1, 
		pc1.name as name1, 
        pc1.address as address1, 
		pc1.phone as phone1, 
		pc1.email as email1, 
        pc1.mobile as mobile1, 
		pc1.primary_contact as primary_contact1, 
        pc1.pollingstation_id as pollingstation_id1,
        ps.name as pollingstation_name,
		IFNULL(pc2.description,'') as description2, 
		IFNULL(pc2.name,'') as name2, 
        IFNULL(pc2.address,'') as address2, 
		IFNULL(pc2.phone,'') as phone2, 
		IFNULL(pc2.email,'') as email2, 
        IFNULL(pc2.mobile,'') as mobile2, 
		IFNULL(pc2.primary_contact,'') as primary_contact2, 
        IFNULL(pc2.pollingstation_id,'') as pollingstation_id2,
        'success' as response
        FROM psm.polling_contacts pc1
		inner join psm.polling_station ps on ps.id=pc1.pollingstation_id 
		inner join psm.user_election ue on ue.organization_id=orgid and ue.user_id=userid 
		and ue.pollingstation_id=pc1.pollingstation_id 
		left outer join psm.polling_contacts pc2 on pc1.pollingstation_id = pc2.pollingstation_id
         and pc2.organization_id=orgid and pc2.primary_contact=0
        where ps.organization_id=orgid and pc1.organization_id=orgid 
		and pc1.primary_contact=1  
		order by pc1.id asc;
    else
		select null as id, 
		null as description1,
        null  as name1, 
		null as address1, 
		null as phone1,
        null as email1, 
		null as mobile1, 
		null as primary_contact1,
        null as pollingstation_id1, 
        null as pollingstation_name,
		null  as name2, 
		null as address2, 
		null as phone2,
        null as email2, 
		null as mobile2, 
		null as primary_contact2,
        null as pollingstation_id2, 
		'unauthorized' as response;
    end if;
END$$
DELIMITER ;
