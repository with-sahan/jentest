SET @orgid = 9;


delete FROM psm.chat where organizationid=@orgid;
delete FROM psm.compliance_election where organization_id=@orgid;
delete FROM psm.counting_center where organization_id=@orgid;
delete FROM psm.csv_upload where organization_id=@orgid;
delete FROM psm.election_stats where organization_id=@orgid;
delete FROM psm.polling_station_election_counting where organization_id=@orgid;
delete FROM security.user_role where organization_id=@orgid;
delete FROM psm.user_election where organization_id=@orgid;
delete FROM security.access_token where organization_id=@orgid;
delete FROM psm.issue_comment where organization_id=@orgid;
delete FROM psm.issue_assignment where organization_id=@orgid;
delete FROM psm.issue where organization_id=@orgid;
delete FROM psm.notification_status where organization_id=@orgid;
delete FROM psm.notification where organization_id=@orgid;
delete FROM security.user where organization_id=@orgid;
delete FROM psm.polling_station_election where organization_id=@orgid;
delete FROM psm.tracking where organization_id=@orgid;
delete FROM psm.election_close_stats where organization_id=@orgid;
delete FROM psm.open_close_election where organization_id=@orgid;
delete FROM psm.list where organization_id=@orgid;
delete FROM psm.list_category where organization_id=@orgid;
delete FROM psm.station_photo where organization_id=@orgid;
delete FROM psm.voter_list where organizationid=@orgid;
delete FROM psm.polling_station where organization_id=@orgid;
delete FROM psm.hierarchy_value where organization_id=@orgid;
delete FROM psm.hierarchy where organization_id=@orgid;
delete FROM psm.election where organization_id=@orgid;
delete FROM security.role_permission where organization_id=@orgid;
delete FROM security.role where organization_id=@orgid;
delete FROM subscription.organization where id=@orgid;

