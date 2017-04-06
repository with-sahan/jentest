DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `csvsecondstructure`(in token varchar(255),
in ward varchar(255), in district varchar(255),
in place varchar(255), in stationname varchar(255),
in ballotstartnumber int(11), in ballotendnumber int(11), in ballotboxnumber varchar(55),
in tenderstartnumber int(11), in tenderendnumber int(11),in eid int(11))
BEGIN
	declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    declare userid int(11);
    declare pollstationid int(11);
    declare st_elec_id int(11);
    declare st_elec_value_id int(11);
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
    select id into st_elec_value_id from psm.hierarchy_value where hierarchy_id=st_elec_id and organization_id=orgid;

	if (security.fn_validate_token(token)=1) then
		/* inserting ward value */
		if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_ward_id and hv.organization_id=orgid and hv.value=ward and hv.hierarchy_id=st_ward_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			values (orgid,st_ward_id,ward,current_timestamp,st_elec_value_id);
		end if;
        
        /* inserting district value */
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_dist_id and hv.organization_id=orgid and hv.value=district and hv.hierarchy_id=st_dist_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_dist_id,district,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=ward;
		end if;  
        
        /* inserting place value */
        if(select not exists (select * FROM psm.hierarchy_value hv 
				where hv.hierarchy_id=st_plac_id and hv.organization_id=orgid and hv.value=place and hv.hierarchy_id=st_plac_id) 
		)then
			insert into psm.hierarchy_value (organization_id,hierarchy_id,value,createdon,parent_id) 
			select orgid,st_plac_id,place,current_timestamp,id from psm.hierarchy_value 
			where organization_id=orgid and value=district;
		end if;
        
        
        
        /* inserting unique Station value */
        if(select not exists (SELECT * FROM psm.polling_station
				where organization_id=orgid and name=stationname) 
		)then
			insert into psm.polling_station (organization_id,name,createdon,hierarchy_value_id) 
			select orgid,stationname,current_timestamp,hv.id from psm.hierarchy_value hv
			where hv.organization_id=orgid and hv.value=place and hv.hierarchy_id=st_plac_id;
            
            select LAST_INSERT_ID() into pollstationid; 
           call psm.csvelection_v2(orgid,eid,ballotboxnumber,pollstationid,ballotstartnumber,ballotendnumber,tenderstartnumber,tenderendnumber);
        ELSEIF(select not exists (SELECT * FROM psm.polling_station_election pse 
				inner join psm.polling_station ps on ps.id=pse.polling_station_id
				where pse.organization_id=orgid and pse.election_id=eid and ps.organization_id=orgid 
                and ps.name=stationname) 
		)then
			select id into pollstationid from psm.polling_station where organization_id=orgid 
			and name=stationname; 
           call psm.csvelection_v2(orgid,eid,ballotboxnumber,pollstationid,ballotstartnumber,ballotendnumber,tenderstartnumber,tenderendnumber);
        else
			select 'duplicatedata' as response;
		end if;
        
    else
		select 'unauthorized' as response;
    end if;    
        
END$$
DELIMITER ;
