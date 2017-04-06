package com.mdl.mdlrestapi.psm;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
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
import com.mdl.mdlrestapi.util.models.NotificationDto;
import com.mdl.mdlrestapi.util.models.NotificationEntryDto;
import com.mdl.mdlrestapi.util.models.NotificationResultDto;
import com.mdl.mdlrestapi.util.models.PollingStationDto;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;


@Path("/services")
public class MakeNotification {

	private static final Logger logger = Logger.getLogger(MakeNotification.class);
	Properties props = new Properties();
	public MakeNotification()
	{
		try {
			logger.info("Load config.properties");
			Thread currentThread = Thread.currentThread();
			ClassLoader contextClassLoader = currentThread.getContextClassLoader();
			props.load(contextClassLoader.getResourceAsStream("config.properties"));
		} catch (IOException e) {
			logger.error(e);
		}
	}

	@SuppressWarnings("finally")
	@POST
	@Path("/makenotification")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response uploadFile(
			@FormDataParam("file") InputStream uploadedInputStream,
			@FormDataParam("file") FormDataContentDisposition fileDetail,
			@QueryParam("description") String description,
			@QueryParam("stationId") String stationId,
			@QueryParam("hierarchyId") String hierarchyId,
			@QueryParam("token") String token) throws UnauthorizedException, MDLServerException {

		logger.info("Parameters for upload file in make notifications :"+description+" "+stationId+" "+hierarchyId+" "+token);
		String respStatus="";
		//token validation
			if(!TokenValidation.ValidateToken(token)){
				logger.warn("Invalid token,token:" + token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
			}
		try{
			String path = props.getProperty("uploadFilePath");
			if(fileDetail.getFileName()!=null){
				String uploadedFileLocation = path + fileDetail.getFileName();
				// save it
				saveToDbNotification(uploadedFileLocation,stationId,hierarchyId,description,token);
				writeToFile(uploadedInputStream, uploadedFileLocation);
				logger.info("File uploaded to : " + uploadedFileLocation);
				//			return Response.status(200).entity(output).build();
			}
			else{
				saveToDbNotification(null,stationId,hierarchyId,description,token);
			}
		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", respStatus);
			return Response.status(200).entity(responseobj.toString()).build();
	}

	@POST
	@Path("/getpollingstationsbyhierarchy")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response GetPollingStationsByHierarchy(SimpleRequest request) throws UnauthorizedException, MDLServerException{

			logger.info("Request for GetPollingStationsByHierarchy : "+request);
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
			ArrayList<PollingStationDto> statList=GetActivePollingStationList(request.hierarchyId, request.token);
			Gson gson=new Gson();

			return Response.ok(gson.toJson(statList)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	@POST
	@Path("/notificationsbyhierarchy")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response GetNotificationsByHierarchy(SimpleRequest request) throws UnauthorizedException, MDLServerException{
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
			NotificationResultDto result=getFilteredResults(request.hierarchyId, request.token);
			Gson gson=new Gson();

			return Response.ok(gson.toJson(result)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	private NotificationResultDto getFilteredResults(int hierarchyId, String token) throws Exception{
		Connection conn = null;
		Statement statement1 = null;
		ResultSet rs1 = null;
		Statement statement2 = null;
		ResultSet rs2 = null;
		Statement statement3 = null;
		ResultSet rs3 = null;
		NotificationResultDto nr=new NotificationResultDto();
		int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
		logger.info("Organization Id :"+orgid);
		try {
			String stations=GetActivePollingStationListString(hierarchyId, token);
			String userList=getActiveUserListForStationList(stations, orgid);
			if (!stations.equals("")) {
				String sql="select distinct(noti.id),noti.message,noti.attachtment_url, noti.createdon from psm.notification noti "
						+ "inner join psm.notification_status ns on noti.id=ns.notificationid "
						+ "where noti.organization_id=" + orgid + " and ns.organization_id=" + orgid + " and userid in (" + userList + ") and date(noti.createdon)=date(current_date);";
				conn = DatabaseConnectionManager.getConnection();
				statement1 = conn.createStatement();
				rs1 = statement1.executeQuery(sql);
				nr.result=new NotificationEntryDto();
				nr.result.entry=new ArrayList<NotificationDto>();

				while(rs1.next()){
					//get the counts
					int readCount=0;
					int unReadCount=0;
					NotificationDto dto=new NotificationDto();
					String readCnt="(select count(id) as reccount from psm.notification_status where notificationid=" + rs1.getInt("id") + " and organization_id=" + orgid + " and status=1);";
					statement2 = conn.createStatement();
					rs2 = statement2.executeQuery(readCnt);
					while(rs2.next()){
						readCount=rs2.getInt("reccount");
					}

					String unReadCnt="(select count(id) as reccount from psm.notification_status where notificationid=" + rs1.getInt("id") + " and organization_id=" + orgid + " and status=0);";
					statement3 = conn.createStatement();
					rs3 = statement3.executeQuery(unReadCnt);
					while(rs3.next()){
						unReadCount=rs3.getInt("reccount");
					}

					dto.attachtment=rs1.getString("attachtment_url");
					dto.id=String.valueOf(rs1.getInt("id"));
					dto.message=rs1.getString("message");
					dto.response="success";

					StringBuffer sb = new StringBuffer();
					String timesent = String.valueOf(rs1.getTimestamp("createdon"));
					String[] splited = timesent.split(" ");
					sb.append(splited[0]+"T"+splited[1]+"00+00:00");
					dto.senton=sb.toString();

					dto.status=readCount + "/" + (readCount+unReadCount);
					nr.result.entry.add(dto);
					sb.setLength(0);
				}

			}


			//e.printStackTrace();
		}finally {
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
			if (rs3 != null) {
				rs3.close();
			}
			if (statement3 != null) {
				statement3.close();
			}
			if(conn != null){
			conn.close();
			}
		}

		return nr;
	}

	// save uploaded file to new location
	private void writeToFile(InputStream uploadedInputStream,
			String relativePath) {

		String path = props.getProperty("baseUrl");
		StringBuilder sb = new StringBuilder();
		sb.append(path+relativePath);
		String uploadedFileLocation = sb.toString();
		try {
			OutputStream out = new FileOutputStream(new File(
					uploadedFileLocation));
			int read = 0;
			byte[] bytes = new byte[1024];

			out = new FileOutputStream(new File(uploadedFileLocation));
			while ((read = uploadedInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			logger.error(e);
			//e.printStackTrace();
		}
	}

	private void saveToDbNotification(String uploadedFileLocation,String station_id,String hierarchyId,String description, String token) throws Exception {
		int notificationid = 0;
		ResultSet rs1 = null;
		int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		Statement statement3 = null;
		try {
			logger.info("Parameters for saveToDbNotification : uploadedFileLocation "+uploadedFileLocation+" station_id "+station_id+" hierarchyId "+hierarchyId+" description "+description+" token "+token);
			if(!station_id.equals("-1")){
				//message will be sent only for a single polling station
				String singleStationInsert = "insert into psm.notification" +
						"(organization_id,message,attachtment_url,createdon )" +
						"values("+ orgid +",'"+ description +"','" + uploadedFileLocation +"',CURRENT_TIMESTAMP);";
				logger.info("Insert query for sending message to a single polling station :"+singleStationInsert );
				//System.out.println(singleStationInsert);
				conn = DatabaseConnectionManager.getConnection();
				statement1 = conn.createStatement();
				statement1.executeUpdate(singleStationInsert);

				statement2 = conn.createStatement();
				rs1 = statement2.executeQuery("SELECT LAST_INSERT_ID() as id;");
				while(rs1.next()){
					notificationid = rs1.getInt("id");
				}

				//notification is created. Now send the message to all users as a private message
				ArrayList<Integer> userIdList=getUserIdList(orgid,Integer.parseInt(station_id));
				for (Integer usrId : userIdList) {
					String statQry = "insert into psm.notification_status" +
							"(organization_id,notificationid,userid,status,isprivate)" +
							"values("+ orgid +",'"+ notificationid + "',"+ usrId +",0,1)";
					statement3 = conn.createStatement();
					statement3.executeUpdate(statQry);
				}

			}else{
				//message will be sent to all the stations in the hierarchy
				String stationList=GetActivePollingStationListString(Integer.parseInt(hierarchyId), token);
				ArrayList<Integer> userList=getActiveUserIdArrayForStationList(stationList, orgid);
				String stsationQry = "insert into psm.notification" +
						"(organization_id,message,attachtment_url,createdon )" +
						"values("+ orgid + ",'"+ description + "','" + uploadedFileLocation +"',CURRENT_TIMESTAMP);";
				//System.out.println(stsationQry);
				logger.info("Insert query for sending message to all the stations in the hierarchy :"+stsationQry );
				conn = DatabaseConnectionManager.getConnection();
				statement1 = conn.createStatement();
				statement1.executeUpdate(stsationQry);

				statement2 = conn.createStatement();
				rs1 = statement2.executeQuery("SELECT LAST_INSERT_ID() as id;");
				while(rs1.next()){
					notificationid = rs1.getInt("id");
				}
				for (int usrId : userList) {
					String statQry = "insert into psm.notification_status" +
							"(organization_id,notificationid,userid,status,isprivate)" +
							"values("+ orgid +",'"+ notificationid + "',"+ usrId +",0,0)";

					statement3 = conn.createStatement();
					statement3.executeUpdate(statQry);
				}
			}
			//sqle.printStackTrace();
		}
		finally {
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if (statement2 != null) {
				statement2.close();
			}
			if (statement3 != null) {
				statement3.close();
			}
			if(conn != null){
			conn.close();
			}
		}
	}

	private ArrayList<Integer> getUserIdList(int orgId,int stationId) throws SQLException{
		ArrayList<Integer> userList=new ArrayList<Integer>();
		Connection conn = null;
		Statement statement1 = null;
		ResultSet rs1 = null;
		try {
			logger.info("Parameters for getUserIdList :"+orgId+" "+stationId);
			String sql="select distinct(eu.user_id) from psm.user_election eu inner join psm.election el "
					+ "on el.id=eu.election_id where date(el.election_date_start)=date(current_date) "
					+ "and eu.pollingstation_id =" + stationId + " and eu.organization_id=" + orgId + " and el.organization_id=" + orgId + ";";
			conn = DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(sql);
			while(rs1.next()){
				userList.add(rs1.getInt("user_id"));
			}

		} catch (Exception sqle) {
			logger.error(sqle);
			//sqle.printStackTrace();
		}finally {
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
		return userList;
	}



	private String GetAllPollingStationList(int hierarchyId,int orgId) throws Exception{
		StringBuilder sb=new StringBuilder();
		Connection conn = null;
		Statement statement1 = null;
		ResultSet rs1 = null;
		Statement statement2 = null;
		ResultSet rs2 = null;
		try{
			logger.info("Got parameters for GetAllPollingStationList :"+hierarchyId+" "+orgId);
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
			rs2 = statement1.executeQuery(query1);
			while(rs2.next()){
				selHrc = rs2.getInt("id");
				sb.append(GetAllPollingStationList(selHrc,orgId)) ;
			}

			//ex.printStackTrace();
		}
		finally {
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
		return sb.toString();
	}

	private ArrayList<PollingStationDto> GetActivePollingStationList(int hierarchyId,String token) throws Exception{
		//gets the election list on selected polling stastions that are running today
		ArrayList<PollingStationDto> elList=new ArrayList<PollingStationDto>();
		Connection conn = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			logger.info("Got Parameters for GetActivePollingStationList :"+hierarchyId+" "+token);
			int orgid = 0;
			orgid=SubscriptionQuerryHandler.getOrganizationId(token);
			String stationList=GetAllPollingStationList(hierarchyId,orgid).replaceAll(",$", "");
			String query1 = "select distinct(pse.polling_station_id) as stationid,ps.name as stationname from psm.polling_station_election pse inner "
					+ "join psm.election el on pse.election_id=el.id "
					+ "inner join psm.polling_station ps on ps.id=pse.polling_station_id "
					+ "where el.organization_id=" + orgid + " and pse.organization_id=" + orgid + "  and "
							+ "pse.polling_station_id in (" + stationList + ") and "
					+ "date(el.election_date_start)=date(current_date);";
			conn = DatabaseConnectionManager.getConnection();
			statement = conn.createStatement();
			rs = statement.executeQuery(query1);
			while(rs.next()){
				PollingStationDto dto=new PollingStationDto();
				dto.stationId=rs.getInt("stationid");
				dto.stationName=rs.getString("stationname");
				elList.add(dto);
			}
			//ex.printStackTrace();
		}
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
		return elList;
	}
	private String GetActivePollingStationListString(int hierarchyId,String token) throws Exception{
		String elList="";
		StringBuilder sb=new StringBuilder();
		Connection conn = null;
		Statement statement = null;
			ResultSet rs = null;
		try {
			logger.info("Got Parameters for GetActivePollingStationListString :"+hierarchyId+" "+token);
			int orgid = 0;
			//get the organization id
			orgid=SubscriptionQuerryHandler.getOrganizationId(token);


			String stationList=GetAllPollingStationList(hierarchyId,orgid).replaceAll(",$", "");
			String query1 = "select distinct(pse.polling_station_id) as stationid,ps.name as stationname from psm.polling_station_election pse inner "
					+ "join psm.election el on pse.election_id=el.id "
					+ "inner join psm.polling_station ps on ps.id=pse.polling_station_id "
					+ "where el.organization_id=" + orgid + " and pse.organization_id=" + orgid + "  and "
							+ "pse.polling_station_id in (" + stationList + ") and "
					+ "date(el.election_date_start)=date(current_date);";
			conn = DatabaseConnectionManager.getConnection();
			statement = conn.createStatement();
			rs = statement.executeQuery(query1);
			while(rs.next()){
				sb.append(rs.getInt("stationid") + ",");
			}

			elList=sb.toString().replaceAll(",$", "");
			//ex.printStackTrace();

		}
		finally {
			if (rs != null) {
				rs.close();
	}
			if (statement != null) {
		//gets the election list on selected polling stastions that are running today
			//get the organization id
				statement.close();

			}
			if(conn != null){
			conn.close();
			}
		}
		return elList;
	}

	private String getActiveUserListForStationList(String stationList,int orgId) throws Exception{
		String ulList="";
		StringBuilder sb=new StringBuilder();
		Connection conn = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			logger.info("Parameters for getActiveUserListForStationList: "+stationList+" "+orgId);
			String sql="select distinct(ue.user_id) from  psm.user_election ue inner "
					+ "join psm.election el on el.id=ue.election_id where ue.pollingstation_id in (" + stationList + ") and date(el.election_date_start)=date(current_date) "
					+ "and el.organization_id=" + orgId + " and ue.organization_id=" + orgId + ";" ;
			conn = DatabaseConnectionManager.getConnection();
			statement = conn.createStatement();
			rs = statement.executeQuery(sql);
			while(rs.next()){
				sb.append(rs.getInt("user_id") + ",");
			}

			ulList=sb.toString().replaceAll(",$", "");
			//ex.printStackTrace();
		}
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
		return ulList;
	}

	private ArrayList<Integer> getActiveUserIdArrayForStationList(String stationList,int orgId) throws Exception{
		ArrayList<Integer> ulist=new ArrayList<>();
		Connection conn = null;
		Statement statement = null;
		ResultSet rs = null;
		try {

			logger.info("Parameters for getActiveUserIdArrayForStationList :"+stationList+" "+orgId);
			String sql="select distinct(ue.user_id) from  psm.user_election ue inner "
					+ "join psm.election el on el.id=ue.election_id where ue.pollingstation_id in (" + stationList + ") and date(el.election_date_start)=date(current_date) "
					+ "and el.organization_id=" + orgId + " and ue.organization_id=" + orgId + ";" ;
			conn = DatabaseConnectionManager.getConnection();
			statement = conn.createStatement();
			rs = statement.executeQuery(sql);
			while(rs.next()){
				ulist.add(rs.getInt("user_id"));
			}

		}
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
		return ulist;
	}


}
