DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `closepollingstation`(in token varchar(255),in pollingstationid int)
BEGIN
	declare spcode varchar(45);
    declare username varchar(45);
    declare orgcode varchar(45);
    declare orgid int(11);
    
    set username=security.SPLIT_STR(token,'|',1);
    set orgcode=security.SPLIT_STR(token,'|',2);
    
    set spcode='closepollingstation';
    
    select id into orgid from subscription.organization where code=orgcode;
    
    if (security.fn_validate_token(token)=1 and security.fn_validate_permission(token,spcode,'PSM')=1) then
		/** check whether the station is opned first **/
        if(select exists(
						select * from psm.polling_station_election pse 
						inner join election e on pse.election_id = e.id 
                        where pse.organization_id=orgid 
                        and pse.polling_station_id=pollingstationid 
                        and date(e.election_date_start)=date(current_date)
                        and pse.isopen=1 )) then
                        
							update psm.polling_station_election pse 
							inner join election e on pse.election_id = e.id 
							set pse.isclose=1, pse.closedat=CURRENT_TIMESTAMP 
							where pse.organization_id=orgid and pse.polling_station_id=pollingstationid 
							and date(e.election_date_start)=date(current_date) and pse.isopen=1;
            
            select 'success' as response;
        else
			select 'Station not opened' as response;
        end if;
   /* else
		select 'unauthorized' as response;*/
    end if;
END$$
DELIMITER ;
