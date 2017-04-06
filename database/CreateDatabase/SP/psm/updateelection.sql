DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `updateelection`(in token varchar(255), in election_id int, in ename varchar(255), in election_date varchar(55),
in start_time varchar(55), in end_time varchar(55), in counting_center_name varchar(45),
in counting_center_address varchar(100), in counting_center_latitude varchar(45),
in counting_center_longitude varchar(45), in BPAidentifier int,in ballot_type_count int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare organizationid int(11);
    declare electionid int(11);
    declare userid int(11);
    declare added_counting_center_id int(11);
	declare current_time_short varchar(10);
    declare current_time_short_modified varchar(10);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    set spcode = 'updateelection';
    
    select id into organizationid from subscription.organization where code = orgcode;
    select id into electionid from psm.election where id = election_id;
    
    SELECT id into added_counting_center_id FROM psm.counting_center cc where cc.election_id=election_id;
	
	select LEFT(CURTIME() , 5) into current_time_short;
	
	if(UNIX_TIMESTAMP(election_date) > UNIX_TIMESTAMP(CURDATE())) then
    
		if (security.fn_validate_token(token)=1) then
        
			if(select exists 
					(					
						select * FROM psm.election where election_name=ename and organization_id=organizationid
                        and id!=electionid
						) 
				) then
				select 'dataduplicate' as response;
			else
				#update psm.election
				update psm.election
				set election_name=ename, election_date_start=CONCAT(election_date,' ',start_time),
				election_date_end=CONCAT(election_date,' ',end_time), status=0, BPA_identifier=BPAidentifier,ballot_type_count=ballot_type_count
				where id=electionid;
				
				#update psm.counting_center
				update psm.counting_center
				set name=counting_center_name, latitude=counting_center_latitude, longitude=counting_center_longitude, address=counting_center_address
				where id=added_counting_center_id;
				
				select 'success' as response;
			end if;
		else
			select 'unauthorized' as response;
		end if;
		
	elseif(UNIX_TIMESTAMP(election_date) = UNIX_TIMESTAMP(CURDATE())) then
	
		if(start_time >= current_time_short) then
		
			if (security.fn_validate_token(token)=1) then
            
				if(select exists 
						(					
							select * FROM psm.election where election_name=ename and organization_id=organizationid
							and id!=electionid
							) 
					) then
					select 'dataduplicate' as response;
				else
					#update psm.election
					update psm.election
					set election_name=ename, election_date_start=CONCAT(election_date,' ',start_time),
					election_date_end=CONCAT(election_date,' ',end_time), status=0, BPA_identifier=BPAidentifier,ballot_type_count=ballot_type_count
					where id=electionid;
					
					#update psm.counting_center
					update psm.counting_center
					set name=counting_center_name, latitude=counting_center_latitude, longitude=counting_center_longitude, address=counting_center_address
					where id=added_counting_center_id;
					
					select 'success' as response;
				end if;
				
			else
				select 'unauthorized' as response;
			end if;
		else
			select 'notcurrenttime' as response;
		end if;	
	else
		select 'notcurrentdate' as response;
	end if;
END$$
DELIMITER ;
