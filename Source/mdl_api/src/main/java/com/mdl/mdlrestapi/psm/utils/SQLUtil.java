package com.mdl.mdlrestapi.psm.utils;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/23/17
 * Time: 8:54 PM
 * To change this template use File | Settings | File Templates.
 */
public class SQLUtil {
    public static final String GET_POLLING_STATIONS = "{call psm.getpollingstations(?)}";
    public static final String GET_POLLING_STATION_CLOSED_STATUS = "{call psm.getpollingstationclosedstatus(?,?)}";
    public static final String GET_ELECTIONS_BY_STATION =  "{call psm.getelectionsbystationid(?,?)}";
    public static final String UPDATE_PRE_POLL_ACTIVITY = "{call psm.updateprepollactivity(?,?,?,?)}";
    public static final String GET_ELECTION_STATUS = "{call psm.getelectionstatus(?,?,?)}";
    // need to update SP , no result returns in current query
    public static final String GENERATE_BPA = "{call psm.generatebpa(?,?,?)}";
    public static final String GET_POST_POLL_ACTIVITIES = "{call psm.getpostpollactivities(?,?,?)}";
    public static final String GET_BPA_STATUS_BY_STATION = "{call psm.getbpastatusbystation(?,?)}";
    public static final String GET_BPA_STATUS   = "{call psm.getbpastatus(?,?,?)}";
    public static final String CLOSE_POLLING_STATION = "{call psm.closepollingstation(?,?)}";
    public static final String GET_PRE_POLL_ACTIVITY = "{call psm.getprepollactivities_v2(?,?)}";
    public static final String GET_BALLOT_TYPE_COUNT = "{call psm.getballottypecount(?,?)}";
    public static final String GET_BALLOT_PAPER_NAMES = "{call psm.getballotpapernames(?,?)}";
    public static final String GET_BALLOT_CLOSE_STAT = "{call psm.getclosestats(?,?,?)}";
    public static final String OPEN_POLLING_STATION = "{call psm.openstation(?,?)}";
    public static final String UPDATE_CLOSE_STATION_STAT = "call psm.updateclosestats(?, ?, ?, ?, ?, ?, ?, ?, ?);";
    public static final String GET_POLLING_STATION_STATUS= "call psm.getpollingstationstatus(?,?);";
    public static final String GET_ORGANIZATION_INFO = "call subscription.getorginfo(?);";
    public static final String GET_NOTIFICATION_PULSE = "call psm.getnewnotificationpulse(?);";
    public static final String GET_NOTIFICATION_TOP = "call psm.gettopnotifications(?);";
    public static final String GET_NOTIFICATION_ALL = "call psm.getallnotifications(?);";
    public static final String GET_NOTIFICATION_READ = "call psm.readnotification(?,?);";
    public static final String GET_POLLING_CONTACT = "call psm.getpollingcontacts(?);";
    public static final String GET_CHAT = "call psm.getChat(?,?);";
    public static final String UPDATE_CHAT_RESOLVE_ISSUE = "call psm.chatresolveissue(?,?,?,?);";
    public static final String GET_ISSUE_LIST = "call psm.getissuelist(?);";
    public static final String GET_ISSUE_ALL = "call psm.getallissues_v2(?,?);";
    public static final String ADD_ISSUE_REPORT = "call psm.reportissue(?,?,?,?,?,?);";
    public static final String GET_VOTER_LIST = "call psm.getvoter('test');";
    public static final String ADD_VOTER = "call psm.createvoter(?, ?, ?, ?, ?, ?);";
    public static final String DELETE_VOTER = "call psm.deletevoter(?,?);";
    public static final String GET_ASSIGNMENT_COUNT_ALERT = "call psm.getassignmentcountalert(?);";
    public static final String GET_CHAT_COUNTER_ALERT = "call psm.getchatcountalert_v2(?);";
    public static final String GET_RECORD_CLOSE_BUTTON_SHOW = "call psm.getrecordclosebuttonshow(?,?,?);"; //Token, electionid, stationid
    public static final String GET_ELECTION_BY_ID = "call psm.getelectionbyid(?,?);"; // Token, Electionid
    public static final String GET_POLLING_STATION_ELECTION_DETAILS = "call psm.getpollingstationelectiondetails(?,?,?);"; // Token, electionid, stationid
    public static final String COMPLETE_PROGRESS_SEQUENCE = "call psm.completeprogresssequence(?,?);"; // Token, Stationid
    public static final String GET_UNCLOSED_ELECTIONS_BY_STATION_ID = "call psm.getunclosedelectionsbystationid(?,?,?);"; // Token, Stationid, Electionid
    public static final String CLOSE_ELECTION = "call psm.closeelection(?,?,?,?);"; // Token, Electionid, StatusId, ElectionStatus
    public static final String COLLECT_POSTAL_PACKS = "call psm.collectpostalpacks_v2(?,?,?,?);"; // Token, StationID, ElectionID, PersonName
    public static final String GET_MAP_CENTER = "call psm.getmapcenter(?)"; //Token
    public static final String START_TRACK = "call psm.starttrack(?,?,?);"; //Token, Longitude, Latitude
    public static final String UPDATE_TRACK = "call psm.updatetrack(?,?,?);"; //Token, Longitude, Latitude
    public static final String CLOSE_TRACK = "call psm.closetrack(?);"; //Token
    public static final String GET_NOTIFICATION_COUNT = "call psm.getnotificationcountgraphstats(?);"; //Token
    public static final String UPDATE_ELECTION_STATION = "call psm.updateelection(?,?,?,?,?,?,?,?,?,?,?,?);"; //Token
    public static final String GET_ELECTION = "call psm.getelection(?);"; //Token
    public static final String CREATE_ELECTION = "call psm.createelection(?,?,?,?,?,?,?,?,?,?,?);";
    public static final String DELETE_ELECTION = "call psm.deleteelection(?,?);";
    public static final String GET_ELECTION_FILE_UPLOAD_DATA = "call psm.getelectionfileuploaddetails(?,?);";
    public static final String GET_POLLING_STATIONS_BY_ELECTION_ID = "call psm.getpollingstationsDetailsbyelectionid(?,?);";
    public static final String GET_STATION_BY_STATION_ID = "call psm.getpollingstationsDetailsbyStationid(?,?);";
    public static final String UPDATE_STATION = "call psm.updatestation(?,?,?,?,?);";
    public static final String GET_ALL_ISSUES_EM = "call psm.getallissues(?);"; //Token
    public static final String UPDATE_ISSUE = "call psm.updateissue(?,?,?,?,?,?);"; //Token, Issueid, Userid, Status, Priority, Comment
    public static final String GET_ISSUE_RESOLVE_GRAPH_STATS = "call psm.getissueresolvegraphstats(?);"; //Token
    public static final String GET_ISSUE_CATEGORY_GRAPH_STATS = "call psm.getissuecategorygraphstats(?);"; //Token
    public static final String GET_ISSUE_BY_ID = "call psm.getissuebyid(?,?);"; //Token, Issueid
    public static final String GET_ALL_USERS_BY_ISSUE_ID = "call psm.getallusersbyissueid(?,?);"; //Token, Issueid
    public static final String GET_ALL_USERS = "call psm.getallusers(?);"; //Token
    public static final String RESOLVE_ISSUE = "call psm.resolveissue(?,?,?);"; //Token, Issueid, Description
    public static final String GET_UNTRACKED_ISSUE_NOTIFICATIONS = "{call psm.getUnTrackedIssueNotifications(?)}"; //Token
    public static final String MARK_ISSUE_NOTIFICATIONS_AS_WATCHED = "{call psm.markIssueNotificationsAsWatched(?,?)}"; //Token
    public static final String GET_POLLING_STATIONS_V2 = "{call psm.getpollingstations_v2(?)}"; //Token
    public static final String GET_FILE_REPORT = "{call psm.getfilereport(?,?)};"; //Token, electionId
	/*User and Role Management*/
	public static final String ADD_USER = "call security.adduser(?,?,?,?,?,?,?);";//Token, Firstname, Lastname, Email, Username, Userpassword, Language_id
    public static final String GET_ALL_SECURITY_USERS = "call security.getallusers(?)"; //Token
    public static final String UPDATE_USER = "call security.updateuser(?,?,?,?,?,?,?)";//Token, Userid, Firstname, Lastname, Email, Username, Roleid
    public static final String GET_USER_BY_ID = "call security.getuserbyid(?,?)";//Token, Userid,
    public static final String DELETE_USER = "call security.deleteuser (?,?)";//Token, Userid,
    public static final String UPDATE_PASSWORD = "call security.updatepassword(?,?,?,?)";//Token, Userid, NewPassword, AdminPassword
    public static final String GET_ALL_ROLES = "call security.getallroles(?)";//Token
    public static final String ADD_ROLE = "call security.addrole(?,?,?)";//Token, Rolename, Description
    public static final String UPDATE_ROLE = "call security.updaterole(?,?,?,?)";//Token, Roleid, Rolename, Description
    public static final String GET_ROLE_BY_ID = "call security.getrolebyid(?,?)";//Token, Roleid
    public static final String DELETE_ROLE = "call security.deleterole(?,?,?)";//Token, Oldroleid, NewRoleId
    public static final String GET_ALL_CLOSE_STAT_V2 = "{call psm.getallclosestats_v2(?,?)};"; //Token, electionId
    public static final String GET_ALL_CLOSE_STAT_SUMMARY = "{call psm.getallclosestatssummary_v2(?,?)};"; //Token, electionId
    public static final String CSV_BALLOT_ACCOUNT_EXPORT = "call psm.csvballotaccountexport(?,?);"; //Token, electionid, stationid
    public static final String GET_NOTIFICATION_BY_ID = "call psm.getnotificationbyid(?,?);"; //Token,  notificationid
    public static final String GET_PLACES_LIST = "call psm.getplaceslist(?);"; //Token
    public static final String GET_PSI_CHECK_LIST = "call psm.getpsichecklist(?,?);"; //Token,  placeid
    public static final String GET_UNIQUE_PSI_CHECK_LIST_CATEGORIES = "call psm.getuniquepsichecklistcategories(?,?);"; //Token,  placeid
    public static final String GET_CHAT_COUNTER_ALERT_V1 = "call psm.getchatcountalert(?);";
    public static final String GET_GLOBAL_NOTIFICATION = "call psm.getglobalnotifications(?);";
    public static final String GET_PROGRESS = "call psm.getprogress(?,?,?);";
    public static final String UPDATE_PROGRESS = "call psm.updateprogress(?,?,?,?,?,?);";
    public static final String GET_ISSUE_COUNT_GRAPH_STATS = "call psm.getissuecountgraphstats(?)";//Token
    public static final String GET_POSTAL_PACK_POGRESS = "call psm.getupliftingperson(?,?,?);";
    public static final String ASSIGN_ISSUE = "call psm.assignissue(?,?,?);";

    public static final String BOF_GETALL_TENDEREDVOTES = "call psm.bof_getall_tenderedvotes(?);";
    public static final String BOF_GETBYID_TENDEREDVOTES = "call psm.bof_getbyid_tenderedvotes(?,?);";
    public static final String BOF_ADDTO_TENDEREDVOTES = "call psm.bof_addto_tenderedvotes(?,?,?,?,?,?);";
    public static final String BOF_UPDATE_TENDEREDVOTES = "call psm.bof_update_tenderedvotes(?,?,?,?,?);";
    public static final String BOF_DELETE_TENDEREDVOTES = "call psm.bof_delete_tenderedvotes(?,?);";

}
