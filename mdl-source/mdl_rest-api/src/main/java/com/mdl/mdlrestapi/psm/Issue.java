package com.mdl.mdlrestapi.psm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.mdl.mdlrestapi.util.GoogleMail;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.PsmQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.entities.Role;
import com.mdl.mdlrestapi.util.database.security.entities.User;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.IssueDto;
import com.mdl.mdlrestapi.util.models.IssueDtoEntry;
import com.mdl.mdlrestapi.util.models.IssueResultDto;
import com.mdl.mdlrestapi.util.models.UserDto;


@Path("/issue")
public class Issue {
	private static final Logger logger = Logger.getLogger(Issue.class);
	private static final String issueResolverList = "Issue Resolver,Polling Station Inspector,Election Manager";
	public Issue(){
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
	@Path("/filterbyhierarchy")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response filterByHierarchy(SimpleRequest request) throws UnauthorizedException, MDLServerException{
		logger.info("Request for 'FilterByHierarchy': "+request);
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
			Gson gson=new Gson();
			IssueResultDto resultObj=GetFilterResults(request.token,request.hierarchyId);
			logger.info("Fitered result :"+resultObj+"for token :"+request.token+"hierarchyId :"+request.hierarchyId);
			return Response.ok(gson.toJson(resultObj)).build();

		}catch(Exception ex){
			//System.out.println(ex);
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	@POST
	@Path("/getisseresolvers")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getIssueResolvers(SimpleRequest request) throws UnauthorizedException, MDLServerException{
		logger.info("Request for 'FilterByHierarchy': "+request);
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
			Gson gson=new Gson();
			List<UserDto> result = processIssueResolvers(request.token,request.issueId);
			return Response.ok(gson.toJson(result)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	private List<UserDto> processIssueResolvers(String token,int issueId) throws Exception {
		List<UserDto> users = new ArrayList<UserDto>();
		String[] roleList = { "Election Manager", "Polling Station Inspector", "Issue Resolver" };
		
	
		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		if (orgId > 0) {
			List<Role> roles = SecurityQuerryHandler.getAllRolesByOrganizationId(orgId, roleList);
		
			if (roles != null && roles.size() > 0) {
				StringBuffer sb = new StringBuffer();
				boolean firstElement = true;
				for (Role role : roles) {
					if (issueResolverList.contains(role.getName())) {
						// add
						if (!firstElement) {
							sb.append(",");
						} else {
							firstElement = false;
						}
						sb.append(role.getId());
					}
				}

				String roleIdString = sb.toString();

				if (roleIdString != null && roleIdString.length() > 0) {
					Connection conn = null;
					PreparedStatement ps = null,ps2 = null;
					ResultSet rs = null,rs2 = null;
					
					try {
						String querry = "call psm.getUsersByRoleIds(?,?)";
						conn = DatabaseConnectionManager.getConnection();
						ps = conn.prepareStatement(querry);
						ps.setString(1, token);
						ps.setString(2, roleIdString);
						rs = ps.executeQuery();

						while (rs.next()) {
							UserDto u = new UserDto();
							u.firstName = rs.getString("firstname");
							u.lastName = rs.getString("lastname");
							u.userName = rs.getString("username");
							u.userId = rs.getInt("id");
							users.add(u);
						}
						
						querry = "call psm.getuserbyissueid(?,?)";
						ps2 = conn.prepareStatement(querry);
						ps2.setInt(1, orgId);
						ps2.setInt(2, issueId);
						rs2 = ps2.executeQuery();

						while (rs2.next()) {
							UserDto u = new UserDto();
							u.firstName = rs2.getString("firstName");
							u.lastName = rs2.getString("lastName");
							u.userName = rs2.getString("userName");
							u.userId = rs2.getInt("userId");
							users.add(u);
						}
						
						
					} finally {
						if (rs != null) {
							rs.close();
						}
						if (ps != null) {
							ps.close();
						}
						if (rs2 != null) {
							rs2.close();
						}
						if (ps2 != null) {
							ps2.close();
						}
						if (conn != null) {
							conn.close();
						}
					}
				}
			}
		}
		return users;
	}

	@POST
	@Path("/sendemail")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response SendEmail(SimpleRequest request) throws UnauthorizedException, MDLServerException{
		logger.info("Request for 'SendEmail': "+request);
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
			//sending the email
			//EmailSender.SendEmail(request.emailTo, request.emailSubject, request.emailBody);
			GoogleMail.Send(request.emailTo, request.emailSubject, request.emailBody);
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "success");
			return Response.ok(responseobj.toString()).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	private IssueResultDto GetFilterResults(String token,int hierarchyId) throws Exception{
		int orgid = 0;
		IssueResultDto ird=new IssueResultDto();
		Statement statement = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			//get the organization id

			orgid=SubscriptionQuerryHandler.getOrganizationId(token);
			//preapre the polling station list based on the hierarchy
//			String stationList=GetPollingStationList(hierarchyId,orgid).replaceAll(",$", "");
			String stationList = EmDashboard.getPollingStationList(hierarchyId, orgid).replaceAll(",$", "");
			logger.info("Get issues by filtering for hierarchyId :"+hierarchyId+"orgid :"+orgid);
			if(stationList != null && stationList.length() > 0){
				String blrQry="select isu.id as id,lst.list_value as reason,isu.description as description,isu.priority  "
						+ "as priority,ps.name as pollingstation,ps.id as pollingstationid,ps.hierarchy_value_id as pollingstationhierarchyid,isu.status "
						+ "as issuestatus,concat(usr.firstname,' ',usr.lastname) as asignee,usr.id as userid,isu.createdon as issuedate,'success' as response from psm.issue isu inner join psm.list lst "
						+ "on lst.id=isu.issue_list_id inner join psm.polling_station ps on isu.pollingstation_id=ps.id left outer join psm.issue_assignment ism "
						+ "on isu.id=ism.issue_id left outer join security.user usr on ism.user_id=usr.id "
						+ "where  UNIX_TIMESTAMP(isu.createdon) > UNIX_TIMESTAMP(CURDATE())  and  "
						+ "isu.pollingstation_id in (" + stationList + ") and "
						+ "isu.organization_id=" + orgid + " and lst.organization_id=" + orgid + " and ps.organization_id=" + orgid + " order by isu.createdon desc;";

				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();
				//System.out.println(blrQry);
				rs = statement.executeQuery(blrQry);
				ird.result=new IssueDto();
				ird.result.entry=new ArrayList<IssueDtoEntry>();
				while(rs.next()){
					IssueDtoEntry entry=new IssueDtoEntry();
					entry.asignee=rs.getString("asignee");
					entry.userid=rs.getString("userid");
					entry.description=rs.getString("description");
					entry.id=String.valueOf(rs.getInt("id")) ;
					entry.issuestatus=String.valueOf(rs.getInt("issuestatus")) ;
					entry.pollingstation=rs.getString("pollingstation");
					entry.pollingstationhierarchyid=String.valueOf(rs.getInt("pollingstationhierarchyid")) ;
					entry.pollingstationid=String.valueOf(rs.getInt("pollingstationid")) ;
					entry.priority=String.valueOf(rs.getInt("priority")) ;
					entry.reason=rs.getString("reason");
					entry.issuedate=String.valueOf(rs.getTimestamp("issuedate")) ;
					entry.response=rs.getString("response");
					ird.result.entry.add(entry);
			}


			}

		}

			//sqle.printStackTrace();
		finally {
			if (rs != null) {
				rs.close();
			}
			if (statement != null) {
				statement.close();
			}
			if(conn != null){
			conn.close();
			}
		}
		return ird;
	}

	private String GetPollingStationList(int hierarchyId,int orgId) throws Exception{
		StringBuilder sb=new StringBuilder();
		Statement statement1 = null;
		Statement statement2 = null;
		Connection conn = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try{
			logger.info("GetPollingStationList by hierarchyId :"+hierarchyId+"and orgId :"+orgId);
			int selHrc=0;
			//first get all the polling stations under this hierarchy
			String query0 = "SELECT id FROM psm.polling_station where hierarchy_value_id="+ hierarchyId +" and organization_id=" + orgId + ";";
			//add all the polling station ids
			conn = DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(query0);
			while(rs1.next()){
				sb.append(rs1.getInt("id")+ ",");
			}

			//now check child hierarchies for this hierachy and recurse
			String query1 = "SELECT id FROM psm.hierarchy_value where parent_id="+ hierarchyId +" and organization_id=" + orgId + ";";
			statement2 = conn.createStatement();
			rs2 = statement2.executeQuery(query1);
			while(rs1.next()){
				selHrc = rs2.getInt("id");
				sb.append(GetPollingStationList(selHrc,orgId)) ;
			}

		}catch(Exception ex){
			logger.error(ex);
			//ex.printStackTrace();
			throw ex;
		}
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
		return sb.toString();
	}

}
