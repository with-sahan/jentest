/* permissions to EM for view the hourly analysis form*/
SELECT id into @id FROM security.url_permission where url='/reports/pdf-hourlyanalysis';
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('2', @id);

INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/getalltenderedvotes', 'TENDERED_VOTES_ALL');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('1', last_insert_id());

INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/gettenderedvotebyid', 'TENDERED_VOTES_BYID');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('1', last_insert_id());

INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/addtotenderedvotes', 'ADD_TENDERED_VOTES');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('1', last_insert_id());

INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/updatetenderedvote', 'UPDATE_TENDERED_VOTES');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('1', last_insert_id());

INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/deletetenderedvote', 'DELETE_TENDERED_VOTES');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('1', last_insert_id());

use `psm`;

CREATE TABLE `bof_tendered_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `polling_station_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `electionid` int(11) NOT NULL,
  `voter_name` varchar(100) NOT NULL,
  `elector_number` int(11) NOT NULL,
  `isalready_marked` int(1) NOT NULL DEFAULT '0' COMMENT '1=is marked , 0=is replaced',
  PRIMARY KEY (`id`),
  KEY `bof_tv_fk_02_idx` (`organization_id`),
  KEY `bof_tv_fk_03_idx` (`polling_station_id`),
  KEY `bof_tv_fk_04_idx` (`user_id`),
  CONSTRAINT `bof_tv_fk_02` FOREIGN KEY (`organization_id`) REFERENCES `subscription`.`organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bof_tv_fk_03` FOREIGN KEY (`polling_station_id`) REFERENCES `polling_station` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bof_tv_fk_04` FOREIGN KEY (`user_id`) REFERENCES `security`.`user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `bof_getall_tenderedvotes`(in token varchar(100))
BEGIN

	declare uname varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    
    set uname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    select id into userid from security.user where username=uname and organization_id=orgid;

    if (security.fn_validate_token(token)=1) then
		 SELECT id as id, 
			polling_station_id as pollingstationid,
            electionid as eid,
            elector_number as electornumber,
			voter_name as votername,
            isalready_marked as ismarked,
            'success' as response  
			FROM psm.bof_tendered_votes where user_id=userid;
    else
		select null as id,
			null as pollingstationid,
            null as eid,
            null as electornumber,
            null as votername,
			null as ismarked,
			'unauthorized' as response;
    end if;
    
	
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `bof_addto_tenderedvotes`(in token varchar(100),
	in pollingstationid int(11),in eid int(11),
    in votername varchar(100),in electornumber int(11),
    in ismarked int(1))
BEGIN    
	declare uname varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    
    set uname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    select id into userid from security.user where username=uname and organization_id=orgid;

    if (security.fn_validate_token(token)=1) then
		if not exists(select * from psm.bof_tendered_votes where organization_id=orgid 
			and polling_station_id=pollingstationid and user_id=userid
			and elector_number=electornumber and electionid=eid ) then
				insert into psm.bof_tendered_votes(organization_id,polling_station_id,user_id,electionid,
					voter_name,elector_number,isalready_marked) 
					values (orgid, pollingstationid,userid,eid,
					votername,electornumber,ismarked);
			select 'success' as response;
        else
			select 'duplicate' as response;
        end if;    
    else
		select 'unauthorized' as response;
    end if;
    
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `bof_getbyid_tenderedvotes`(in token varchar(100),
	in tvid int(11))
BEGIN
	declare uname varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    
    set uname=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    select id into userid from security.user where username=uname and organization_id=orgid;

    if (security.fn_validate_token(token)=1) then            
         SELECT id as id, 
			polling_station_id as pollingstationid,
            elector_number as electornumber,
			voter_name as votername,
            isalready_marked as ismarked,
            'success' as response   
			FROM psm.bof_tendered_votes where user_id=userid and id=tvid;   
    else
		select null as id,
			null as pollingstationid,
            null as electornumber,
            null as votername,
			null as ismarked,
			'unauthorized' as response;
    end if;
    
	
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `bof_update_tenderedvotes`(in token varchar(100),
    in votername varchar(100),in electornumber int(11),
    in ismarked int(1),in tvid int(11))
BEGIN

	declare orgid int(11);
    declare psid int(11);
    declare uid int(11);    
    declare eid int(11);
	
	SELECT organization_id, polling_station_id, user_id, electionid 
	INTO orgid, psid, uid, eid from psm.bof_tendered_votes WHERE id=tvid;
	
    IF (security.fn_validate_token(token)=1) THEN		
		IF NOT EXISTS(
			SELECT * FROM psm.bof_tendered_votes
			WHERE organization_id=orgid 
            AND polling_station_id=psid AND user_id=uid 
            AND elector_number=electornumber AND electionid=eid
		) THEN
			UPDATE psm.bof_tendered_votes 
			SET elector_number=electornumber,  voter_name= votername, isalready_marked=ismarked
			WHERE id=tvid;
			
			SELECT 'success' AS response;
		ELSE
			SELECT 'duplicate' AS response;
        END IF;
    ELSE
		SELECT 'unauthorized' AS response;
    END IF;
    
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `bof_delete_tenderedvotes`(in token varchar(100),in tvid int(11))
BEGIN    
    if (security.fn_validate_token(token)=1) then
			delete from psm.bof_tendered_votes where id=tvid;
			select 'success' as response;
    else
		select 'unauthorized' as response;
    end if;
    
END$$
DELIMITER ;


