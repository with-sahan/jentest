use `security`;

ALTER TABLE `security`.`role` 
ADD COLUMN `roleid` INT NULL ;


SET SQL_SAFE_UPDATES = 0;
update role set roleid = 
case name 
	when 'Presiding Officer' then 1
    when 'Election Manager' then 2
    when 'Polling Station Inspector' then 3
    when 'Issue Resolver' then 4
    when 'Returning officer' then 5
    when 'Polling clerks' then 6
    when 'Super Admin' then 7
else 0
end;






use `psm`;
DROP PROCEDURE `psm`.`initscript`;

DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `initscript`(in org_name varchar(255),
in usrname varchar(255),in user_password varchar(255),in csvstructure int,in electorate_value varchar(255))
BEGIN

    declare org_id int(11);
    declare usr_id int(11);
    declare role_em_id int(11);
    declare role_sa_id int(11);
    declare list_id_01 int(11);
    declare list_id_02 int(11);
    declare list_id_03 int(11);
    declare list_id_04 int(11);
    declare list_id_05 int(11);
    declare list_id_06 int(11);
    declare list_id_07 int(11);
    declare electorateid int(11);

if(select not exists (select * FROM subscription.organization
				where code=org_name) 
	)then
			
	/*Creating the Organization */    
	insert into subscription.organization (name,code,area_name,logo_url,created_on,isactive,isdeleted,csvstructureid) 
	values (org_name,org_name,org_name,'assets/global/images/derry.jpg',current_timestamp(),1,0,csvstructure);

	select LAST_INSERT_ID() into org_id;


	/* Adding the super user */ 
	insert into security.user (organization_id,firstname,lastname,username,passwordhash,locale,language_id,createdon) 
	select org_id,usrname,' ',usrname,sha1(CONCAT('S@l+VaL',user_password)),'en-GB',1,current_timestamp;

	select LAST_INSERT_ID() into usr_id;


	/*Creating all Roles */
	insert into security.role (organization_id,name,description,createdon, roleid) 
	values (org_id,'Election Manager','Election Manager',current_timestamp(),2);
	select LAST_INSERT_ID() into role_em_id;

	insert into security.role (organization_id,name,description,createdon, roleid) 
		values (org_id,'Presiding Officer','Presiding Officer',current_timestamp(),1);
    
    insert into security.role (organization_id,name,description,createdon, roleid) 
		values (org_id,'Super Admin','Super Admin',current_timestamp(),7);
    select LAST_INSERT_ID() into role_sa_id;
    
    insert into security.role (organization_id,name,description,createdon, roleid) 
		values (org_id,'Returning officer','Returning officer',current_timestamp(),5);

	insert into security.role (organization_id,name,description,createdon, roleid) 
		values (org_id,'Polling clerks','Polling clerks',current_timestamp(),6);
		
	insert into security.role (organization_id,name,description,createdon, roleid) 
		values (org_id,'Issue Resolver','Issue Resolver',current_timestamp(),4);
		
	insert into security.role (organization_id,name,description,createdon, roleid) 
		values (org_id,'Polling Station Inspector','Polling Station Inspector',current_timestamp(),3);


	/* Adding user to a role */ 
	insert into security.user_role (organization_id,role_id,user_id) 
	value (org_id,role_sa_id,usr_id);


	/* Giving Permissions to roles */ 
	insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Presiding Officer' and ro.organization_id=org_id;
            
	insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,role_em_id,id FROM subscription.permission;  
    
    insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,role_sa_id,id FROM subscription.permission;  
            
	insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Returning officer' and ro.organization_id=org_id;   
            
    insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Issue Resolver' and ro.organization_id=org_id;  
    
    insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Polling clerks' and ro.organization_id=org_id; 
            
	insert into security.role_permission (organization_id,role_id,permission_id) 
		select org_id,ro.id,pe.id FROM subscription.permission pe cross join security.role ro 
			where ro.name='Polling Station Inspector' and ro.organization_id=org_id;  
	 
	/* Creating Hierarchy Structure */  
	insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
		values (org_id,'Electorate',NULL,1,current_timestamp());
	select LAST_INSERT_ID() into electorateid;    
	insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
		values (org_id,'Ward',electorateid,2,current_timestamp());
	insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
		values (org_id,'District',LAST_INSERT_ID(),3,current_timestamp());
	insert into psm.hierarchy (organization_id,name,parent_id,sortorder,createdon)
		values (org_id,'Place',LAST_INSERT_ID(),4,current_timestamp()); 
	if (csvstructure=2) then insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon)    
		values (org_id,electorateid,electorate_value,current_timestamp());  
	end if;    

	/* Creating issue and prepoll activity list categories*/  
	insert into psm.list_category (organization_id,name,list_order) values (org_id,'issue',NULL);
	select LAST_INSERT_ID() into list_id_01;
	insert into psm.list_category (organization_id,name,list_order) values (org_id,'issue_resolution',NULL);
	select LAST_INSERT_ID() into list_id_02;
	insert into psm.list_category (organization_id,name,list_order) values (org_id,'prepoll_activity_Outside_the_polling_station',1);
	select LAST_INSERT_ID() into list_id_03;
	insert into psm.list_category (organization_id,name,list_order) values (org_id,'prepoll_activity_Inside_the_polling_station',2);
	select LAST_INSERT_ID() into list_id_04;
	insert into psm.list_category (organization_id,name,list_order) values (org_id,'prepoll_activity_Polling_booths_and_ballot_boxes',3);
	select LAST_INSERT_ID() into list_id_05;
	insert into psm.list_category (organization_id,name,list_order) values (org_id,'prepoll_activity_Ballot_papers',4);
	select LAST_INSERT_ID() into list_id_06;
	insert into psm.list_category (organization_id,name,list_order) values (org_id,'postpoll_activity',1);
	select LAST_INSERT_ID() into list_id_07;

	/* Creating issue and prepoll activity lists*/  

	insert into psm.list (organization_id,list_category_id,list_internal_name,list_value,list_order) values 
	(org_id,list_id_01,'Staffing','Staffing',0),
	(org_id,list_id_01,'Accessibility','Accessibility',0),
	(org_id,list_id_01,'Logistics','Logistics',0),
	(org_id,list_id_01,'Security','Security',0),
	(org_id,list_id_01,'Ballot Papers','Ballot Papers',0),
	(org_id,list_id_01,'Health and Safety','Health and Safety',0),
	(org_id,list_id_01,'Problems with Register','Problems with Register',0),
	(org_id,list_id_01,'Postal and Proxy Voters','Postal and Proxy Voters',0),
	(org_id,list_id_01,'Other','Other',0),

	(org_id,list_id_03,'Is the approach signage clear and are elector','Is the approach signage clear and are electors able to easily identify where the polling station is?',1),
	(org_id,list_id_03,'Are there parking spaces reserved for disable','Are there parking spaces reserved for disabled people?',2),
	(org_id,list_id_03,'Check there are no hazards between the car pa','Check there are no hazards between the car parking spaces and the entrance to the polling station',3),
	(org_id,list_id_03,'Have you ensured good signage for any alterna','Have you ensured good signage for any alternative disabled access, and can it be read by someone in a wheelchair?',4),
	(org_id,list_id_03,'Is the ‘How to vote at these elections’ notic','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed outside the polling station and accessible to all voters?',5),
	(org_id,list_id_03,'Is there a suitable ramp clear of obstruction','Is there a suitable ramp clear of obstructions?',6),
	(org_id,list_id_03,'Have double doors been checked to ensure good','Have double doors been checked to ensure good access for all? Is the door for any separate disabled access properly signed?',7),

	(org_id,list_id_04,'Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting','Is the polling station set up to make best use of space?Walk through the route the voter will be expected to follow, and check that the layout will work for voters, taking into account how they will move through the voting process from entering to exiting',1),
	(org_id,list_id_04,'Would the layout work if there was a build-up of electors waiting to cast their ballots?','Would the layout work if there was a build-up of electors waiting to cast their ballots?',2),
	(org_id,list_id_04,'Is best use being made of the lights and natural light available?','Is best use being made of the lights and natural light available?',3),
	(org_id,list_id_04,'Is there a seat available if an elector needs to sit down?','Is there a seat available if an elector needs to sit down?',4),
	(org_id,list_id_04,'Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?','Is the ‘How to vote at these elections’ notice (including any supplied in alternative languages and formats) displayed inside the polling station and accessible to all voters?',5),
	(org_id,list_id_04,'Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?','Is the notice that provides information on how to mark the ballot papers (including any supplied in alternative languages and formats) posted inside all polling booths?',6),
	(org_id,list_id_04,'As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?','As you walk through the route that the voter will be expected to follow, are the posters and notices clearly visible, including for wheelchair users?',7),
	(org_id,list_id_04,'Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?','Have you ensured that the notices/posters are not displayed among other posters where electors would find it difficult to see them?',8),

	(org_id,list_id_05,'Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?','Are the ballot box(es) placed immediately adjacent to the Presiding Officer? Are the ballot box(es) correctly sealed?',1),
	(org_id,list_id_05,'Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?','Are polling booths correctly erected and in such a position so as to make best use of the lights and natural light?',2),
	(org_id,list_id_05,'Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?','Have you ensured that polling booths are positioned so that people outside cannot see how voters are marking their ballot papers?',3),
	(org_id,list_id_05,'Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?','Can the Presiding Officer and Poll Clerk observe them clearly? Are the pencils in each booth sharpened and available for use?',4),
	(org_id,list_id_05,'Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?','Is the string attached to the pencils long enough for the size of ballot papers and to accommodate both right-handed and left-handed voters?',5),
	(org_id,list_id_05,'Is the tactile template available and in full view? Do all staff know how to use it?','Is the tactile template available and in full view? Do all staff know how to use it?',6),

	(org_id,list_id_06,'Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?','Are the large-print ballot papers clearly visible to all voters? Are the hand-held samples available and visible to voters?',1),
	(org_id,list_id_06,'Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?','Are the ballot papers the correct ones for the polling station and are they numbered correctly and stacked in order?',2),
	(org_id,list_id_06,'Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?','Are the ballot paper numbers on the corresponding number list(s) printed in numerical order?',3),
	(org_id,list_id_06,'Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?','Do the ballot paper numbers printed on the corresponding number list(s) match those on the ballot papers?',4),
	(org_id,list_id_06,'Do you have the correct register for your polling station?','Do you have the correct register for your polling station?',5),

	(org_id,list_id_07,'Packet for tendered ballot papers marked by voters','Packet for tendered ballot papers marked by voters',1),
	(org_id,list_id_07,'Packet for marked register','Packet for marked register',2),
	(org_id,list_id_07,'Packet for certificates of employment','Packet for certificates of employment',3),
	(org_id,list_id_07,'Packet for various lists and declarations','Packet for various lists and declarations',4),
	(org_id,list_id_07,'Packet for appointment of POs and PCs','Packet for appointment of POs and PCs',5),
	(org_id,list_id_07,'Packet for CNL','Packet for CNL',6),
	(org_id,list_id_07,'Packet for unused and spoilt ballot papers','Packet for unused and spoilt ballot papers',7),
	(org_id,list_id_07,'Sundries box with stationery etc.','Sundries box with stationery etc.',8),
	(org_id,list_id_07,'Tactile voting device','Tactile voting device',9),
	(org_id,list_id_07,'Ballot box compactor','Ballot box compactor',10),
	(org_id,list_id_07,'Unused seals','Unused seals',11),
	(org_id,list_id_07,'Unused signs and notices etc.','Unused signs and notices etc.',12),
	(org_id,list_id_07,'Packet for ballot paper account','Packet for ballot paper account',13),
	(org_id,list_id_07,'Postal votes – handed in but not previously collected','Postal votes – handed in but not previously collected',14),
	(org_id,list_id_07,'Ballot Box(es)','Ballot Box(es)',15);
    
    else
		select 'Already Exists';
    end if;
END$$
DELIMITER ;



DROP PROCEDURE `psm`.`completeprogresssequence`;


DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `completeprogresssequence`(in token varchar(255),in stationid int)
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare eidcount int(11);
    declare varelid int(11);
    DECLARE done INT DEFAULT FALSE;
    
    declare cur cursor  for
			select election_id FROM psm.polling_station_election where polling_station_id=stationid;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
            
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;

	if (security.fn_validate_token(token)=1) then
         
         open cur;
         read_loop: LOOP
         
			FETCH cur INTO varelid;
            
			IF done THEN
				LEAVE read_loop;
			END IF;
            
            
            call closeelection(token,varelid,stationid,1);
            call generatebpa(token,stationid,varelid);
            call closepollingstation(token,stationid);
            
            
		END LOOP read_loop;
		CLOSE cur;
		select 'success' as response;		
	else
		select 'unauthorized' as response;
	end if;
END$$
DELIMITER ;
;


/* MSP-198 user create for application usage */ 
DROP USER 'mdldbuser'@'%' ;
/* select SHA2('md1Pa$$w0rd', 224); */
CREATE USER 'mdldbuser'@'%' IDENTIFIED BY 'e5e51c435686f74c13bd54ecd2e2c6a9223e3738a411a36b887a1df7';
/* set password later for the user
SET PASSWORD FOR 'mdldbuser'@'%'  = PASSWORD('e5e51c435686f74c13bd54ecd2e2c6a9223e3738a411a36b887a1df7');
*/
GRANT SELECT ON mysql.* TO 'mdldbuser'@'%';
GRANT SELECT,INSERT,UPDATE,DELETE,EXECUTE ON psm.* TO 'mdldbuser'@'%';
GRANT SELECT,INSERT,UPDATE,DELETE,EXECUTE ON security.* TO 'mdldbuser'@'%';
GRANT SELECT,INSERT,UPDATE,DELETE,EXECUTE ON subscription.* TO 'mdldbuser'@'%';