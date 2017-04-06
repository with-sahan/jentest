DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `csvhierarchyandpollingstations`(in token varchar(255),
in address varchar(255), in district varchar(255),
in constituency varchar(255), in stationname varchar(255),
in ward varchar(255), in place varchar(255), in electionid varchar(11),in ballotboxnumber varchar(55),
in first_name varchar(255), in last_name varchar(255),in user_name varchar(255),in passwords varchar(255))
BEGIN
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    declare pollstationid int(11);
    declare st_elec_id int(11);
    declare st_ward_id int(11);
    declare st_dist_id int(11);
    declare st_plac_id int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    select id into orgid from subscription.organization where code=orgcode;
    select id into st_elec_id FROM psm.hierarchy where organization_id=orgid and name='Electorate';
    select id into st_ward_id FROM psm.hierarchy where organization_id=orgid and name='Ward';
	select id into st_dist_id FROM psm.hierarchy where organization_id=orgid and name='District';
    select id into st_plac_id FROM psm.hierarchy where organization_id=orgid and name='Place';
    
    if (security.fn_validate_token(token)=1) then
    
		if(select not exists (select * FROM psm.hierarchy_value hv 
              where hv.hierarchy_id=st_elec_id and hv.organization_id=orgid and hv.value=constituency and hv.hierarchy_id=st_elec_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon) 
			values (orgid,st_elec_id,constituency,current_timestamp);
		end if;
        
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_ward_id and hv.organization_id=orgid and hv.value=ward and hv.hierarchy_id=st_ward_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_ward_id,ward,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=constituency;
		end if;  
        
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_dist_id and hv.organization_id=orgid and hv.value=district and hv.hierarchy_id=st_dist_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_dist_id,district,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=ward;
		end if;  
        
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_plac_id and hv.organization_id=orgid and hv.value=place and hv.hierarchy_id=st_plac_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_plac_id,place,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=district;
		end if; 
        
        
        if(select not exists (SELECT * FROM psm.polling_station
				where organization_id=orgid and name=stationname) 
		)then
			insert into psm.polling_station (organization_id,name,address,createdon,hierarchy_value_id) 
			select orgid,stationname,address,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=place and hierarchy_id=st_plac_id;
            
            select LAST_INSERT_ID() into pollstationid; 
            call psm.csvelection(orgid,electionid,ballotboxnumber,pollstationid,user_name,first_name,last_name,passwords);
            
        ELSEIF(select not exists (SELECT * FROM psm.polling_station_election pse 
				inner join psm.polling_station ps on ps.id=pse.polling_station_id
				where pse.organization_id=orgid and pse.election_id=electionid and ps.organization_id=orgid 
                and ps.name=stationname) 
		)then
			select id into pollstationid from psm.polling_station where organization_id=orgid 
			and name=stationname; 
            call psm.csvelection(orgid,electionid,ballotboxnumber,pollstationid,user_name,first_name,last_name,passwords);
            
        else
			select 'duplicatedata' as response;
		end if; 
    else
		select 'unauthorized' as response;
    end if;
END$$
DELIMITER ;
