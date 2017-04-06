DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `createelection`(in token varchar(255),
in ename varchar(255), in election_date varchar(55),
in start_time varchar(55), in end_time varchar(55), in counting_center_name varchar(45),
in counting_center_address varchar(100), in counting_center_latitude varchar(45),
in counting_center_longitude varchar(45), in BPA_identifier int,in ballot_type_count int)
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare csvstructure int(11);
    declare added_election_id int(11);
    declare current_time_short varchar(10);
    declare current_time_short_modified varchar(10);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    SELECT csvstructureid into csvstructure FROM subscription.organization where id=orgid;
    select LEFT(CURTIME() , 5) into current_time_short;
    select REPLACE(current_time_short, ':', '.') into current_time_short_modified;
    
    if(UNIX_TIMESTAMP(election_date) > UNIX_TIMESTAMP(CURDATE())) then
    
		if (security.fn_validate_token(token)=1) then
		
			if(select exists 
					(					
						select * FROM psm.election where election_name=ename and DATE(election_date_start) = election_date and organization_id=orgid
						) 
				) then
				select 'dataduplicate' as response;
			else
				#insert to psm.election
				insert into psm.election (organization_id,election_name,election_date_start,election_date_end,status,BPA_identifier,ballot_type_count) 
				values (orgid,ename,CONCAT(election_date,' ',start_time),CONCAT(election_date,' ',end_time),0,BPA_identifier,ballot_type_count);
				
				set added_election_id = (SELECT id FROM psm.election ORDER BY id DESC LIMIT 1);
				#insert to psm.counting_center
				insert into psm.counting_center (name,organization_id,election_id,latitude,longitude,address) 
				values (counting_center_name,orgid,added_election_id,counting_center_latitude,counting_center_longitude,counting_center_address);
				
				#insert to psm.ballot_paper_type
                if(csvstructure=1) then
					insert into psm.ballot_paper_type (election_id,organization_id) values(added_election_id,orgid);
                else
					insert into psm.ballot_paper_type (election_id,organization_id,value_1,value_2) values(added_election_id,orgid,'CONSTITUENCY PAPER','REGIONAL PAPER');
                end if;
                
				select 'success' as response;
				#select current_time_short_modified as response;
			end if;
		else
			select 'unauthorized' as response;
		end if;
	elseif(UNIX_TIMESTAMP(election_date) = UNIX_TIMESTAMP(CURDATE())) then
    
		#if(UNIX_TIMESTAMP(start_time) >= UNIX_TIMESTAMP(CURTIME())) then
        if(start_time >= current_time_short_modified) then
        
			if (security.fn_validate_token(token)=1) then
			
				if(select exists 
						(					
							select * FROM psm.election where election_name=ename and DATE(election_date_start) = election_date and organization_id=orgid
							) 
					) then
					select 'dataduplicate' as response;
				else
					#insert to psm.election
					insert into psm.election (organization_id,election_name,election_date_start,election_date_end,status,BPA_identifier,ballot_type_count) 
					values (orgid,ename,CONCAT(election_date,' ',start_time),CONCAT(election_date,' ',end_time),0,BPA_identifier,ballot_type_count);
					
					set added_election_id = (SELECT id FROM psm.election ORDER BY id DESC LIMIT 1);
					#insert to psm.counting_center
					insert into psm.counting_center (name,organization_id,election_id,latitude,longitude,address) 
					values (counting_center_name,orgid,added_election_id,counting_center_latitude,counting_center_longitude,counting_center_address);
                    
						#insert to psm.ballot_paper_type
					if(csvstructure=1) then
						insert into psm.ballot_paper_type (election_id,organization_id) values(added_election_id,orgid);
					else
						insert into psm.ballot_paper_type (election_id,organization_id,value_1,value_2) values(added_election_id,orgid,'CONSTITUENCY PAPER','REGIONAL PAPER');
					end if;
					select 'success' as response;
                    #select current_time_short_modified as response;
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
