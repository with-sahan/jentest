package com.mdl.mdlrestapi.psm;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.ElectionDto;
import com.mdl.mdlrestapi.util.models.PsmDashboardDto;
import com.mdl.mdlrestapi.util.models.PsmDashboardNotification;
import com.mdl.mdlrestapi.util.models.PsmDashboardStationData;
import com.mdl.mdlrestapi.util.models.UpdatePrePollingActivityRequest;

@Path("/psmdashboard")
public class PsmDashboard {
	private static final Logger logger = Logger.getLogger(PsmDashboard.class);
	public PsmDashboard(){
		//CTOR
	}

	//this is need to avoid the CORS issues when calling options
	@OPTIONS
	@Path("{path : .*}")
	public Response options() {
	    return Response.ok("")
	            .header("Access-Control-Allow-Origin", "*")
	            .header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization")
	            .header("Access-Control-Allow-Credentials", "true")
	            .header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
	            .header("Access-Control-Max-Age", "1209600")
	            .build();
	}

	@POST
	@Path("/getstats")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response GetStats(SimpleRequest request) throws UnauthorizedException, MDLServerException{
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
			if(!TokenValidation.ValidateToken(request.token)){
				logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
			}
		try{
			PsmDashboardDto resultObj=new PsmDashboardDto();
			//get the ballot stats
			resultObj=UpdateBallotDetails(resultObj,request.token,request.electionId);
			//now get the ballot details by station
			resultObj=UpdateBallotDetailsByStation(resultObj,request.token,request.electionId);
			//now get the top notifications
			resultObj=UpdateTopNotifications(resultObj,request.token,request.electionId);
			Gson gson=new Gson();
			//JSONObject responseobj = new JSONObject();
			//responseobj.put("response", gson.toJson(resultObj));
			return Response.ok(gson.toJson(resultObj)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	@POST
	@Path("/getelectionsbyuser")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response GetElectionsByUser(SimpleRequest request) throws UnauthorizedException, MDLServerException{
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
			if(!TokenValidation.ValidateToken(request.token)){
				logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
			}
		try{
			ArrayList<ElectionDto> elList=GetElectionList(request.token);

			Gson gson=new Gson();

			return Response.ok(gson.toJson(elList)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	private PsmDashboardDto UpdateBallotDetails(PsmDashboardDto resultObj,String token,int electionId) throws Exception{
		int orgid = 0;
		int userid = 0;
		int totturnout = 0;
		int turnout = 0;

		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try {
			//get the organization id
			orgid=SubscriptionQuerryHandler.getOrganizationId(token);
			userid = getUserId(token,orgid);
			logger.info("Parameters for UpdateBallotDetails : token: " +token+" electionId :"+electionId+" orgid"+orgid+" userid"+userid);

			String pcnQry="SELECT  sum((pse.ballotend+1)-pse.ballotstart) as turnouts FROM psm.polling_station_election pse "
					+ "inner join psm.user_election ue on ue.pollingstation_id=pse.polling_station_id "
					+ "where pse.election_id = " + electionId +" and ue.election_id=" + electionId +" and ue.user_id="+userid+";";
			conn = DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(pcnQry);
			while(rs1.next()){
				totturnout=rs1.getInt("turnouts");
			}


			String blrQry="select sum(es.ballotpaper) as ballotpapers,(sum(es.postalpack)-sum(es.postalpack_collected)) as postalreceived "
						+ "from psm.election_stats es "
						+ "inner join psm.user_election ue on ue.election_id=es.electionid and es.polling_station_id=ue.pollingstation_id "
						+ "where es.electionid=" + electionId + " and ue.election_id=" + electionId + " and es.organization_id=" + orgid +  " and ue.user_id="+userid+";";

			statement2 = conn.createStatement();
			rs2 = statement2.executeQuery(blrQry);
			while(rs2.next()){
				turnout = rs2.getInt("ballotpapers");
				resultObj.ballotPapers=rs2.getInt("ballotpapers");
				resultObj.postalPacks=rs2.getInt("postalreceived");
				resultObj.percentage= ((totturnout==0) ? 0 : (double)100.0*(((double)turnout)/((double)totturnout)) );
			}

		}
			//sqle.printStackTrace();
		finally {
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if (rs2 != null) {
				rs1.close();
			}
			if (statement2 != null) {
				statement1.close();
			}
			if(conn != null){
			conn.close();
			}
		}
		return resultObj;
	}

	private PsmDashboardDto UpdateBallotDetailsByStation(PsmDashboardDto resultObj,String token,int electionId) throws Exception{
		int orgid = 0;
		int userid = 0;
		Connection conn = null;
		Statement statement1 = null;
		ResultSet rs1 = null;
		try {

			//get the organization id
			orgid=SubscriptionQuerryHandler.getOrganizationId(token);
			userid=getUserId(token,orgid);
			//get the ballot details
			logger.info("Parameters for UpdateBallotDetailsByStation : token: " +token+" electionId :"+electionId+" orgid"+orgid+" userid"+userid);


			String blrQry="select ps.id,ps.name as pollingstation,pse.isopen as stationstatus,(sum(es.ballotpaper)) as ballotpapers,sum(es.postalpack) as postalreceived,"
					+ "sum(es.postalpack_collected) as postalcollected "
					+ "from psm.election_stats es inner join psm.polling_station ps on es.polling_station_id=ps.id "
					+ "inner join psm.polling_station_election pse on pse.election_id=es.electionid and pse.polling_station_id=es.polling_station_id "
					+ "inner join psm.user_election ue on ue.pollingstation_id=es.polling_station_id "
					+ "inner join security.user usr on usr.id=ue.user_id "
					+ "where es.electionid=" + electionId + " and ue.user_id=" + userid + " and ue.election_id=" + electionId
					+ " and es.organization_id=" + orgid + " and ps.organization_id=" + orgid + " group by ps.name;";
			conn= DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(blrQry);
			resultObj.dashboardData=new ArrayList<PsmDashboardStationData>();
			while(rs1.next()){
				PsmDashboardStationData dbd=new PsmDashboardStationData();
				dbd.ballotPapersIssued=rs1.getInt("ballotpapers");
				dbd.postalPackesCollected=rs1.getInt("postalcollected");
				dbd.postalPackesRecevied=rs1.getInt("postalreceived");
				dbd.stationName=rs1.getString("pollingstation");
				dbd.status=rs1.getInt("stationstatus");
				dbd.issueStatus=getIssueStatus(rs1.getInt("id"), orgid);
				resultObj.dashboardData.add(dbd);
			}


			//sqle.printStackTrace();
		}
		finally{
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if(conn != null){
			conn.close();
			}
		}
		return resultObj;
	}

	private String getIssueStatus(int ststionId,int orgId) throws SQLException{
		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		int solveCount=0;
		int total=0;
		String issueStatus="";
		try {
			logger.info("Parameters for getIssueStatus : ststionId "+ststionId+" orgId :"+orgId);
			//get resolve count
			String qry="select count(isu.id) as isucount from psm.issue isu where isu.organization_id=" + orgId
					+ " and isu.pollingstation_id=" + ststionId + " and date(isu.createdon)=date(current_date) and isu.status in (1,2);";
			conn = DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(qry);
			while (rs1.next()) {
				solveCount=rs1.getInt("isucount");
			}

			//get total count
			qry="select count(isu.id) as isucount from psm.issue isu where isu.organization_id=" + orgId
					+ " and isu.pollingstation_id=" + ststionId + " and date(isu.createdon)=date(current_date);";
			statement2 = conn.createStatement();
			rs2 = statement2.executeQuery(qry);
			while (rs2.next()) {
				total=rs2.getInt("isucount");
			}


			issueStatus=(total-solveCount) + "/" + total;

		} catch (Exception e) {
			logger.error(e);
			//e.printStackTrace();
		}
		finally{
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if (rs2 != null) {
				rs2.close();
			}
			if (statement2 != null) {
				statement2.close();
			}
			if(conn != null){
			conn.close();
			}
		}
		return issueStatus;
	}

	private PsmDashboardDto UpdateTopNotifications(PsmDashboardDto resultObj,String token,int electionId) throws Exception{
		int orgid = 0;
		int userId = 0;
		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try {
			//get the organization id

			String[] splited = token.split("\\|");

			String userName = splited[0];
			orgid=SubscriptionQuerryHandler.getOrganizationId(token);
			logger.info("Parameters got for UpdateTopNotifications : electionId "+electionId+" token :"+token+" userName :"+userName +" orgid :"+orgid);

			String query1 = "SELECT id FROM security.user where username='"+userName+"' and organization_id=" +  orgid + ";";
			conn =  DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(query1);
			while(rs1.next()){
				userId = rs1.getInt("id");
			}

			//get the ballot details


			String blrQry="select noti.id,ns.isprivate as privatemessage,noti.message as message,noti.createdon as messagetime from psm.notification_status ns "
					+ "inner join psm.notification noti on ns.notificationid=noti.id "
					+ "where ns.userid=" + userId + " and ns.organization_id=" + orgid + " and date(noti.createdon)=date(current_date)  "
					+ " order by noti.createdon desc limit 5;" ;


			statement2 = conn.createStatement();
			rs2 = statement2.executeQuery(blrQry);
			resultObj.dashboardNotifications=new ArrayList<PsmDashboardNotification>();
			while(rs2.next()){
				PsmDashboardNotification dbd=new PsmDashboardNotification();

				dbd.id=rs2.getInt("id");
				dbd.message=rs2.getString("message");
				dbd.messageTime=rs2.getTimestamp("messagetime").toString();
				if(rs2.getInt("privatemessage")==0){
					dbd.messageType="Global";
				}else{
					dbd.messageType="Private";
				}

				resultObj.dashboardNotifications.add(dbd);
			}

			//sqle.printStackTrace();
		}
		finally{
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if (rs2 != null) {
				rs2.close();
			}
			if (statement2 != null) {
				statement2.close();
			}
			if(conn != null){
			conn.close();
			}
		}
		return resultObj;
	}

	private ArrayList<ElectionDto> GetElectionList(String token) throws Exception{
		int orgid = 0;
		int userId = 0;
		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ArrayList<ElectionDto> elList=new ArrayList<ElectionDto>();
		try{
			//get the organization id
			String[] splited = token.split("\\|");
			String userName = splited[0];

			orgid=SubscriptionQuerryHandler.getOrganizationId(token);

			String query1 = "SELECT id FROM security.user where username='"+userName+"' and organization_id=" +  orgid + ";";
			conn = DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(query1);
			while(rs1.next()){
				userId = rs1.getInt("id");
			}
			if( userId <= 0 || orgid <= 0 ){
				logger.warn("userId :"+ userId +" and orgid "+ orgid);
				return elList;
			}

			String qruElection = "SELECT distinct(el.id),el.election_name FROM psm.user_election ue inner join psm.election el on "
					+ "ue.election_id=el.id where ue.user_id=" + userId + " and ue.organization_id=" + orgid + " and el.organization_id=" + orgid + " and "
					+ "date(current_date)=date(el.election_date_start);";
			statement2 = conn.createStatement();
			rs2 = statement2.executeQuery(qruElection);
			while(rs2.next()){
				ElectionDto dto=new ElectionDto();
				dto.electionName= rs2.getString("election_name");
				dto.id=rs2.getInt("id");
				elList.add(dto);
			}
		}finally{
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if (rs2 != null) {
				rs2.close();
			}
			if (statement2 != null) {
				statement2.close();
			}
			if(conn != null){
			conn.close();
			}
		}
		return elList;
	}

	private int getUserId(String token,int orgid) throws Exception{
		int userid = 0;
		String[] splited = token.split("\\|");
		String username = splited[0];
		String query0 = "SELECT id FROM security.user where username='"+username+"' and organization_id="+orgid;
		Connection conn = null;
		Statement statement1 = null;
		ResultSet rs1 = null;
		try {
			conn= DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1= statement1.executeQuery(query0);
			while(rs1.next()){
				userid = rs1.getInt("id");
			}
		}finally{
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if(conn != null){
			conn.close();
			}
		}
		return userid;
	}
	@POST
	@Path("/updateprepollingactivity")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updatePrePollingActivity(List<UpdatePrePollingActivityRequest> updateList) throws MDLServerException  {
		JSONObject responseobj = new JSONObject();
		JSONObject responseobj1 = new JSONObject();
		String respStatus = "Error";
		try{
			respStatus = performUpdatePrePollingActivity(updateList);
		}catch(Exception e){
			logger.error(e);
			throw new MDLServerException(e);
		}
		JSONObject responseobj2 = new JSONObject();
		responseobj1.put("response", respStatus);
		responseobj2.put("entry", responseobj1);
		responseobj.put("result", responseobj2);
		return Response.ok(responseobj.toString()).build();
	}
	private String performUpdatePrePollingActivity(List<UpdatePrePollingActivityRequest> updateList) throws Exception{
		String respStatus = "";
		Connection conn = null;
		Statement statement1 = null;
		CallableStatement cs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try {
			conn = DatabaseConnectionManager.getConnection();
			String callString = "{call psm.updateprepollactivity(?,?,?,?)}";
			List<UpdatePrePollingActivityRequest> toBeUpdated = new ArrayList<UpdatePrePollingActivityRequest>();
			for (UpdatePrePollingActivityRequest updateActivity : updateList) {
				String query = "SELECT iscompleted from psm.open_close_election where polling_station_id = "+updateActivity.pollingstation_id+" and list_id="+updateActivity.activity_id;
				statement1 = conn.createStatement();
				rs1 = statement1.executeQuery(query);
				while (rs1.next()) {
					Integer result = rs1.getInt("iscompleted");
					if (result != updateActivity.status) {
						toBeUpdated.add(updateActivity);
					}
				}
			}
			for (UpdatePrePollingActivityRequest updateActivity : updateList) {
				String token = updateActivity.token;
				String pollingstation_id = Integer.toString(updateActivity.pollingstation_id);
				String activity_id = Integer.toString(updateActivity.activity_id);
				String status = Integer.toString(updateActivity.status);

				cs = conn.prepareCall(callString);
				cs.setString(1, token);
				cs.setString(2, pollingstation_id);
				cs.setString(3, activity_id);
				cs.setString(4, status);

				rs2 = cs.executeQuery();
				if (rs2 == null) {
					respStatus = "failed";
				} else {
					boolean allSuccess = true;
					while (rs2.next()) {
						String res = rs2.getString("response");
						if (res.equals("unauthorized")) {
							respStatus = "failed";
							allSuccess = false;
							break;
						}
						if (!res.equals("success")) {
							allSuccess = false;
							respStatus = res;
							break;
						}
					}
					if (allSuccess) {
						respStatus = "success";
					}
				}
			}
			return respStatus;
			//System.out.println(ex);
		} finally {
				if (rs1 != null) {
					rs1.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if(statement1 != null){
					statement1.close();
			}
				if(cs != null){
					cs.close();
				}
				if(conn != null){
				conn.close();
				}
		}
	}
}
