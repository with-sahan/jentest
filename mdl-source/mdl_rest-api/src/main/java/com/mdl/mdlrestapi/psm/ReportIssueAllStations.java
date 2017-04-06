package com.mdl.mdlrestapi.psm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.PsmQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.entities.User;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.AssignIssueRequest;
import com.mdl.mdlrestapi.util.models.ReportIssueAllStationsRequest;

@Path("/reportissueservices")
public class ReportIssueAllStations {
	private static final Logger logger = Logger.getLogger(ReportIssueAllStations.class);
	//this is need to avoid the CORS issues when calling options
	/*@OPTIONS
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
	*/
	/*@POST
	@Path("/test")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response ReportingIssueToAllStations1(ReportIssueAllStationsRequest request){

		JSONObject responseobj = new JSONObject();
		responseobj.put("response", "success");
		return Response.ok(responseobj.toString()).build();
	}*/

	@POST
	@Path("/reportissueallstations")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response ReportingIssueToAllStations(ReportIssueAllStationsRequest request) throws MDLServerException, UnauthorizedException {
		String status = "error";
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if (!TokenValidation.ValidateToken(request.token)) {
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
		try{
			status = performReportIssuToAllStations(request);
		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}

		JSONObject responseobj = new JSONObject();
		responseobj.put("response", status);
		return Response.ok(responseobj.toString()).build();
	}
	private String performReportIssuToAllStations(ReportIssueAllStationsRequest request) throws Exception{
		int orgid = 0;
		String username = "";
		Statement statement = null;
		Connection conn = null;

		try{

			orgid=SubscriptionQuerryHandler.getOrganizationId(request.token);

			String[] splited = (request.token).split("\\|");
			username = splited[0];

			String updateQuery2 = "";

			List<String> strList = new ArrayList<String>();

			if(request.pollingstation_id_list.length > 0){
				//String s ="";
				//List<String> strList = new ArrayList<String>();
				for(int station:request.pollingstation_id_list){
					String s = "(" + "'" + orgid + "'" + "," + "'" + station + "'" + "," + "'" + request.issue_list_id + "'" + "," + "'" + request.description + "'" + "," + "'" + request.priority + "'" + ",0," + "'" + username + "'" + ")";
					//String s = "('2',"+ station +",'7','Description Comment','1',0,'admin')";
					strList.add(s);

				}
			}

			String t ="";
			for(int i=0;i<strList.size();i++){
				t = t + strList.get(i);
				if(i != strList.size()-1){
					t=t+",";
				}

			}
			updateQuery2 = "insert into psm.issue(organization_id, pollingstation_id,issue_list_id, description,priority, status,reportedby) values "+ t +";";

			conn = DatabaseConnectionManager.getConnection();
			statement = conn.createStatement();
	        statement.executeUpdate(updateQuery2);
			/*for (int i=0; i<=pollingStationListLength; i++) {
				updateQuery[i] = "insert into psm.issue(organization_id, pollingstation_id,issue_list_id, description,priority, status,reportedby) values "
						+orgid+","+request.pollingstation_id_list[i]+","+request.issue_list_id+","+request.description+","+request.priority+",0,"+username;
				msqlcn.insert(updateQuery[i]);
			}*/
			return "success";

			//System.out.println(ex);
		}
		finally {
			if (statement != null) {
				statement.close();
			}
			if(conn != null){
			conn.close();
			}
		}
	}

	@POST
	@Path("/reportissue")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response reportIssue(ReportIssueAllStationsRequest request) throws UnauthorizedException, MDLServerException{
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if (!TokenValidation.ValidateToken(request.token)) {
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}

		try{
			boolean suceed = performReportIssue(request);
			JSONObject responseobj = new JSONObject();

			if(suceed){
				responseobj.put("response", "Success");
				return Response.ok(responseobj.toString()).build();

			}else{
				responseobj.put("response", "Error");
				return Response.ok(responseobj.toString()).build();

			}
		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	@POST
	@Path("/assignissue")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response assignIssue(AssignIssueRequest request) throws MDLServerException, UnauthorizedException {
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if (!TokenValidation.ValidateToken(request.token)) {
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
		try{
			boolean suceed = performAssignIssue(request);
			JSONObject responseobj = new JSONObject();

			if(suceed){
				responseobj.put("response", "Success");
				return Response.ok(responseobj.toString()).build();

			}else{
				responseobj.put("response", "Error");
				return Response.ok(responseobj.toString()).build();

			}
		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}



	private boolean performReportIssue(ReportIssueAllStationsRequest request) throws Exception {

		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			int orgId = SubscriptionQuerryHandler.getOrganizationId(request.token);
			List<User> users = SecurityQuerryHandler.getUsersByRoles("Issue Resolver,Polling Station Inspector,Election Manager", orgId);
			if (request.pollingstation_id_list != null) {
				for(int pollingStationId : request.pollingstation_id_list){

					conn = DatabaseConnectionManager.getConnection();
					int electionid = -1;
					if (request.electionid > 0) {
						electionid = request.electionid;
					}

					String query = "call psm.reportissue_v2(?,?,?,?,?,?)";
					ps = conn.prepareStatement(query);
					ps.setString(1, request.token);
					ps.setInt(2, electionid);
					ps.setInt(3, pollingStationId);
					ps.setInt(4, request.issue_list_id);
					ps.setString(5, request.description);
					ps.setInt(6, request.priority);
					rs = ps.executeQuery();
					int issueId = -1;
					while (rs.next()) {
						issueId = rs.getInt("response");
					}
					if(issueId<= 0){
						return false;
					}else{
						//insert into issue_tracking
						for(User u:users){
							PsmQuerryHandler.createIssueTrackingNotification(issueId, u.getId(), -1);
						}

					}
				}
				return true;



			}
		} finally {

			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return false;
	}


	 private boolean performAssignIssue(AssignIssueRequest request) throws Exception{
		 Connection conn = null;
		ResultSet rs = null;
			PreparedStatement ps = null;

			try{
				int orgId = SubscriptionQuerryHandler.getOrganizationId(request.token);
				String userIdList = Integer.toString(request.userId);
				List<User> assignedUser = SecurityQuerryHandler.getUsersByUserId(userIdList, orgId);
				List<User> users = SecurityQuerryHandler.getUsersByRoles("Issue Resolver,Polling Station Inspector,Election Manager", orgId);
				users.addAll(assignedUser);

				conn = DatabaseConnectionManager.getConnection();
				String query = "call psm.assignissue(?,?,?)";
				ps = conn.prepareStatement(query);
				ps.setString(1, request.token);
				ps.setInt(2, request.issueId);
				ps.setInt(3, request.userId);

				rs =ps.executeQuery();
				while(rs.next()){
					String result = rs.getString("response");
					if(!result.equalsIgnoreCase("success")){
						return false;
					}

				}
				//insert into issue_tracking
				for(User u:users){
					PsmQuerryHandler.createIssueTrackingNotification(request.issueId, u.getId(), -1);
				}
				return true;

			}finally{

				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			}
	 }
}
