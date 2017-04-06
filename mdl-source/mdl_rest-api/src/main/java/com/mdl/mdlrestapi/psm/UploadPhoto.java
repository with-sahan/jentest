package com.mdl.mdlrestapi.psm;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import java.util.UUID;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.xml.bind.DatatypeConverter;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;

@Path("/photo")
public class UploadPhoto {
	private static final Logger logger = Logger.getLogger(UploadPhoto.class);

	Properties props = new Properties();
	public UploadPhoto() {
		try {
			logger.info("Load config.properties");
			Thread currentThread = Thread.currentThread();
			ClassLoader contextClassLoader = currentThread.getContextClassLoader();
			props.load(contextClassLoader.getResourceAsStream("config.properties"));
		} catch (Exception e) {
			logger.error(e);
			//e.printStackTrace();
		}
	}

	@SuppressWarnings("finally")
	@POST
	@Path("/upload")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response uploadFile(@FormDataParam("file") InputStream uploadedInputStream,
			@FormDataParam("file") FormDataContentDisposition fileDetail, @QueryParam("stationId") String stationId,
			@QueryParam("notificationId") String notificationId, @QueryParam("token") String token)
					throws MDLServerException, UnauthorizedException {

		//token validation
			if(!TokenValidation.ValidateToken(token)){
				logger.warn("Invalid token,token:" + token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
			}
		try {
			logger.info("Query parameters for upload file in 'UploadPhoto' : stationId :" + stationId
					+ " notificationId" + notificationId + " token" + token);

			String path = props.getProperty("uploadFilePath");
			String uploadedFileLocation = path + fileDetail.getFileName();

			// save it
			writeToFile(uploadedInputStream, uploadedFileLocation);
			saveToDbNotification(uploadedFileLocation,notificationId,token);

			String output = "File uploaded to : " + uploadedFileLocation;
			return Response.status(200).entity(output).build();
		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	@SuppressWarnings("finally")
	@POST
	@Path("/uploadImage")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response uploadImage(@FormDataParam("file") String base64encoded, @QueryParam("stationId") String stationId,
			@QueryParam("token") String token) throws UnauthorizedException, MDLServerException {
		//token validation
			if(!TokenValidation.ValidateToken(token)){
			logger.warn("Invalid token,token:" + token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
			}
		try {
			String path = props.getProperty("uploadFilePath");

			//generating random string to take it as the name when saving the file
			UUID uuid = UUID.randomUUID();
			String fileName = uuid.toString();

			String uploadedFileLocation = path + fileName + ".jpeg";
			String decodebyteArr=new String(DatatypeConverter.parseBase64Binary(base64encoded) , "UTF-8");
			byte[] sourceData = DatatypeConverter
					.parseBase64Binary(decodebyteArr.substring(decodebyteArr.indexOf(",") + 1));
			InputStream is = new ByteArrayInputStream(sourceData);
			// save it

			writeToFile(is, uploadedFileLocation);
			saveToDbCamera(uploadedFileLocation,stationId,token);
			//System.out.println(ex);
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "success");
			return Response.status(200).entity(responseobj.toString()).build();
		} catch (Exception ex) {
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	// save uploaded file to new location
	private void writeToFile(InputStream uploadedInputStream, String relativePath) throws Exception {

			String path = props.getProperty("baseUrl");
			StringBuilder sb = new StringBuilder();
			sb.append(path+relativePath);
			String uploadedFileLocation = sb.toString();
		OutputStream out = null;
		try {
			logger.info("Saving location of uploaded file :"+uploadedFileLocation);
			out = new FileOutputStream(new File(uploadedFileLocation));
			int read = 0;
			byte[] bytes = new byte[1024];

			out = new FileOutputStream(new File(uploadedFileLocation));
			while ((read = uploadedInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
		} finally {
			if (out != null) {
			out.flush();
			out.close();
			}
		}
	}

	private void saveToDbCamera(String uploadedFileLocation,String stationId,String token) throws Exception {
		int resultvalue;

		int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
		String query1 = "select el.id as electionid from psm.election el inner join psm.polling_station_election pse "
				+ "on pse.election_id=el.id where date(election_date_start)=date(current_date) and "
				+ "el.organization_id=" + orgid + " and pse.organization_id=" + orgid + "  and pse.polling_station_id="
				+ stationId;
		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		ResultSet rs1 = null;
		try {
			conn= DatabaseConnectionManager.getConnection();
			statement1= conn.createStatement();
			rs1 = statement1.executeQuery(query1);
			while(rs1.next()){
				int eid = rs1.getInt("electionid");
				String query2 = "insert into psm.station_photo"
						+ "(organization_id, station_id,election_id,image_url,createdon )" + "values(" + orgid + ","
						+ Integer.parseInt(stationId) + "," + eid + ",'" + uploadedFileLocation
						+ "',CURRENT_TIMESTAMP)";
				statement2 = conn.createStatement();
				resultvalue = statement2.executeUpdate(query2);
				if(resultvalue!=1)
					logger.warn("Upload Failed!");
					//System.out.println("Upload Failed!");
			}

			//sqle.printStackTrace();
		} finally {
			if(rs1!= null){
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
		}
			if (statement2 != null) {
				statement2.close();
		}
			if(conn != null){
			conn.close();
			}
	}
	}


	private void saveToDbNotification(String uploadedFileLocation, String notification_id, String token)
			throws Exception {
		int resultvalue;
		int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
		logger.info("Parameters for 'saveToDbNotification': uploadedFileLocation: " + uploadedFileLocation
				+ " notification_id :" + notification_id + " token");
		String query = "update psm.notification set  attachtment_url ='" + uploadedFileLocation + "' where id ="
				+ notification_id + " and organization_id=" + orgid;
		Connection conn = null;
		Statement statement1 = null;
		try {
			conn = DatabaseConnectionManager.getConnection();
			statement1 = conn.createStatement();
			resultvalue = statement1.executeUpdate(query);
			if(resultvalue!=1)
				logger.info("Upload Failed!");

		} finally {
			if (statement1 != null) {
				statement1.close();
			}
			if(conn != null){
			conn.close();
			}
		}
	}


	// Working database method call
//	@Path("/test")
//	@POST
//	@Consumes("application/json")
//	@Produces(MediaType.APPLICATION_JSON)
//	public Response TestMethod() throws SQLException {
//		String result = ("{\"test\":\""+writeToDatabase()+"\"}");
//		return Response.status(200).entity(result).build();
//	}
//
//	private String writeToDatabase() throws SQLException{
//		String query = "";
//		ResultSet rs = null;
//		String result = "";
//		try {
//			MysqlConnector msqlcn = new MysqlConnector();
//			query = "SELECT name FROM psm.polling_station where id=1";
//			rs = msqlcn.query(query);
//			while(rs.next()){
//				result = rs.getString("name");
//			}
//			query = "Success!! "+result.toString();
//		}
//		catch (Exception sqle) {
//			query = "Error";
//			sqle.printStackTrace();
//		}
//		return query;
//	}

}
