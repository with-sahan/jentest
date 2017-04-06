-------------------------
-- Reset Database data --
-------------------------
delete from notifications where user_id>40000 and user_id<50000;

delete from notifications_received where user_id>40000 and user_id<50000;

update station_setup_status set status=false where station_id>40000 and station_id<50000;

update polling_station 
set ballot_papers_issued=NULL,
    postal_packs_received=NULL,
    ordinary_total_issued=NULL,
    ordinary_number_of_replacements=NULL,
    ordinary_cals_issued_and_not_spoilt=NULL,
	ordinary_total_unused=NULL,
	tendered_total_issued=NULL,
	tendered_total_spoilt=NULL,
	tendered_total_unused=NULL,
	postal_packs_awaiting_collection=NULL,
	dispatch_time=null,
	deliver_time=null
where id>40000 and id<50000;

delete from issues where council_id>40000 and council_id<50000;

update tracking set lat=0,lng=0, status=0 where station_id>40000 and station_id<50000;


--------------------------------------------------------------------------------------
-- Remember to clear UploadedFileViaNotification and UploadedPhotoViaPollingStation --
--------------------------------------------------------------------------------------
mv src/static/en_GB/uploads src/static/en_GB/uploads.1
mkdir src/static/en_GB/uploads


------------------------------------------
-- Switch IssueList Email to Real users --
------------------------------------------
update issue_list set status=false
where email='scoyle@moderndemocracy.com' and
council_id>40000 and council_id<50000;

update issue_list set status=false
where email<>'scoyle@moderndemocracy.com' and
council_id>40000 and council_id<50000;