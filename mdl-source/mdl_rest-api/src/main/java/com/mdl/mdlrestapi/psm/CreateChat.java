package com.mdl.mdlrestapi.psm;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
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

import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.PsmQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.entities.User;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;

@Path("/chatservices")
public class CreateChat {

	private static final Logger logger = Logger.getLogger(CreateChat.class);
	Properties props = new Properties();
	public CreateChat() {
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
	@Path("/createchat")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response uploadFile(@FormDataParam("file") InputStream uploadedInputStream,
			@FormDataParam("file") FormDataContentDisposition fileDetail, @QueryParam("issueid") String issueid,
			@QueryParam("pollingstationid") String pollingstationid, @QueryParam("chatmessage") String chatmessage,
			@QueryParam("token") String token) throws UnauthorizedException, MDLServerException {
		logger.info("createchat request recieved,token:" + token);
		String respStatus="";
			if(!TokenValidation.ValidateToken(token)){
				logger.warn("Invalid token,token:" + token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
		try {

			String path = props.getProperty("uploadFilePath");
			if(fileDetail.getFileName()!=null){
				String uploadedFileLocation = path + fileDetail.getFileName();
				// save it
				int chatId = saveToDbChat(uploadedFileLocation, issueid, pollingstationid, chatmessage, token);
				if (chatId > 0) {
				writeToFile(uploadedInputStream, uploadedFileLocation);
				respStatus = "File uploaded to : " + uploadedFileLocation;

				//create issue notifications
				} else {
					throw new Exception("saved to db failed");
				}

			}else {
				int chatId = saveToDbChat(null, issueid, pollingstationid, chatmessage, token);
				if(chatId > 0){
				////create issue notifications
					createIssueNotificationsForChat(token,Integer.parseInt(issueid),chatId);

					respStatus="success";
				}else{
					respStatus="error";
				}


			}
		} catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", respStatus);
			return Response.status(200).entity(responseobj.toString()).build();

	}

	private boolean createIssueNotificationsForChat(String token,int issueId,int chatId) throws Exception{

		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);

			//is this issue already assigned to someone?
			User assignedUser = PsmQuerryHandler.getAssignedUserToIssue(issueId);
			String usersToNotify = "Issue Resolver,Polling Station Inspector,Election Manager";
			List<User> users = new ArrayList<User>();
			if(assignedUser != null){
				usersToNotify = "Polling Station Inspector,Election Manager";
				users.add(assignedUser);
			}
			List<User> users1 = SecurityQuerryHandler.getUsersByRoles(usersToNotify, orgId);
			users.addAll(users1);

			//insert into issue_tracking
			for(User u:users){
				PsmQuerryHandler.createIssueTrackingNotification(issueId, u.getId(), chatId);
			}
		return true;

	}

	/*public Response uploadFile(
			@FormDataParam("file") InputStream uploadedInputStream,
			@FormDataParam("file") FormDataContentDisposition attachtment_url,
			@QueryParam("issueid") String issueid,
			@QueryParam("pollingstationid") String pollingstationid,
			@QueryParam("chatmessage") String chatmessage,
			@QueryParam("token") String token) {
		String respStatus="";

		//token validation
		try{
			if(!TokenValidation.ValidateToken(token)){
				respStatus="unauthorized";
			}
			String path = props.getProperty("uploadFilePath");
			if(attachtment_url.getFileName()!=null){
				String uploadedFileLocation = path + attachtment_url.getFileName();
				// save it
				saveToDbChat(uploadedFileLocation, issueid, pollingstationid, chatmessage, token);
				writeToFile(uploadedInputStream, uploadedFileLocation);
				String output = "File uploaded to : " + uploadedFileLocation;
				//			return Response.status(200).entity(output).build();
			}
			else{
				saveToDbChat(null, issueid, pollingstationid, chatmessage, token);
			}
		}catch(Exception ex){
			System.out.println(ex);
			respStatus="Error";
		}finally{
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", respStatus);
			return Response.status(200).entity(responseobj.toString()).build();
		}
	}*/

	// save uploaded file to new location
	private void writeToFile(InputStream uploadedInputStream, String relativePath) throws Exception{

		String path = props.getProperty("baseUrl");
		StringBuilder sb = new StringBuilder();
		sb.append(path+relativePath);
		String uploadedFileLocation = sb.toString();
		OutputStream out = new FileOutputStream(new File(uploadedFileLocation));
		try {

			int read = 0;
			byte[] bytes = new byte[1024];

			while ((read = uploadedInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
			logger.info("Write to file suceeed.File:" + uploadedFileLocation);
		} finally{
			out.flush();
			out.close();
		}
	}

	private int saveToDbChat(String uploadedFileLocation, String issueid, String pollingstationid, String chatmessage,
			String token) throws Exception {
		int organizationid = SubscriptionQuerryHandler.getOrganizationId(token);
		int userid = SecurityQuerryHandler.getUserId(token, organizationid);

		if (!pollingstationid.equals("-1")) {
			// message will be sent only for a single polling station
			String singleStationInsert = "insert into psm.chat"
					+ "(userid, issueid, organizationid, pollingstationid, chatmessage, attachtment_url, createdon )"
					+ "values(" + userid + "," + issueid + "," + organizationid + "," + pollingstationid + ",'"
					+ chatmessage + "','" + uploadedFileLocation + "',CURRENT_TIMESTAMP);";
			Statement statement = null;
			Statement s2 = null;
			Connection conn = null;
			ResultSet rs1 = null;

			try {
				conn = DatabaseConnectionManager.getConnection();
				statement = conn.createStatement();
				int insertCount = statement.executeUpdate(singleStationInsert);
				if (insertCount == 1) {
					logger.info("successfully saved to DB Chat, token :" + token);

					s2 = conn.createStatement();
					rs1 = s2.executeQuery("SELECT LAST_INSERT_ID() as id;");
					while (rs1.next()) {
						return rs1.getInt("id");
					}

				}

			} finally {

				if (statement != null) {
					statement.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (s2 != null) {
					s2.close();
				}
				if (conn != null) {
					conn.close();
				}

			}
		}
		logger.info("Fail saving to DB Chat, token :" + token);
		return -1;
	}
}
