package com.mdl.mdlrestapi.psm.utils;

/**
 * Created by Thara on 3/9/2017.
 */
public class QueryUtil {

    /*Database column names*/
    public static final String PSM_POLLING_STATION_ELECTION_TURNOUTS="turnouts";
    public static final String PSM_BALLOT_DETAILS_BALLOTPAPERS="ballotpapers";
    public static final String PSM_BALLOT_DETAILS_POSTALRECEIVED="postalreceived";
    public static final String PSM_BALLOT_DETAILS_POSTALCOLLECTED="postalcollected";
    public static final String PSM_BALLOT_DETAILS_POLLINGSTATION="pollingstation";
    public static final String PSM_BALLOT_DETAILS_STATIONSTATUS="stationstatus";
    public static final String ID="id";
    public static final String MESSAGE="message";
    public static final String MESSAGETIME="messagetime";
    public static final String PRIVATEMESSAGE="privatemessage";
    public static final String GLOBAL="Global";
    public static final String PRIVATE="Private";
    public static final String ELECTION_NAME="election_name";
    public static final String ISSUE_COUNT="isucount";

    /*Database prepared statements - PSM Dashboard*/
    public static final String GET_PSM_TOTAL_TURNOUTS="SELECT  sum((pse.ballotend+1)-pse.ballotstart) as turnouts FROM psm.polling_station_election pse "
            + "inner join psm.user_election ue on ue.pollingstation_id=pse.polling_station_id "
            + "where pse.election_id=? and ue.election_id=? and ue.user_id=?;";
    public static final String GET_PSM_BALLOT_DETAILS="select sum(es.ballotpaper) as ballotpapers,(sum(es.postalpack)-sum(es.postalpack_collected)) as postalreceived "
            + "from psm.election_stats es "
            + "inner join psm.user_election ue on ue.election_id=es.electionid and es.polling_station_id=ue.pollingstation_id "
            + "where es.electionid=? and ue.election_id=? and es.organization_id=? and ue.user_id=?;";
    public static final String GET_PSM_BALLOT_DETAILS_BY_STATION="select ps.id,ps.name as pollingstation,pse.isopen as stationstatus,(sum(es.ballotpaper)) as ballotpapers,sum(es.postalpack) as postalreceived,"
            + "sum(es.postalpack_collected) as postalcollected "
            + "from psm.election_stats es inner join psm.polling_station ps on es.polling_station_id=ps.id "
            + "inner join psm.polling_station_election pse on pse.election_id=es.electionid and pse.polling_station_id=es.polling_station_id "
            + "inner join psm.user_election ue on ue.pollingstation_id=es.polling_station_id "
            + "inner join security.user usr on usr.id=ue.user_id "
            + "where es.electionid=? and ue.user_id=? and ue.election_id=?"
            + " and es.organization_id=? and ps.organization_id=? group by ps.name;";
    public static final String UPDATE_TOP_NOTIFICATION="select noti.id,ns.isprivate as privatemessage,noti.message as message,noti.createdon as messagetime from psm.notification_status ns "
            + "inner join psm.notification noti on ns.notificationid=noti.id "
            + "where ns.userid=? and ns.organization_id=?"
//					+ "where ns.userid=" + userId + " and ns.organization_id=" + orgid + " and date(noti.createdon)=date(current_date)  "
            + " order by noti.createdon desc limit 5;" ;
    public static final String GET_ELECTION_DETAILS="SELECT distinct(el.id),el.election_name FROM psm.user_election ue inner join psm.election el on "
            + "ue.election_id=el.id where ue.user_id=? and ue.organization_id=? and el.organization_id=? and "
            + "date(current_date)=date(el.election_date_start);";
    public static final String GET_ISSUE_COUNT="select count(isu.id) as isucount from psm.issue isu where isu.organization_id=?"
            + " and isu.pollingstation_id=? and isu.status in (1,2);";
    public static final String GET_ALL_ISSUE_COUNT="select count(isu.id) as isucount from psm.issue isu where isu.organization_id=?"
            + " and isu.pollingstation_id=?;";
    public static final String ADD_PSM_ISSUE="insert into psm.issue(organization_id, pollingstation_id,issue_list_id, description,priority, status,reportedby) values (?,?,?,?,?,0,?);";

}
