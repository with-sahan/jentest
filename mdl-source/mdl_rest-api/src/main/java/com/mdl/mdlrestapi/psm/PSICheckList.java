package com.mdl.mdlrestapi.psm;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
import org.json.JSONArray;
import org.json.JSONObject;

import com.mdl.mdlrestapi.util.ErrorCodes;
import com.mdl.mdlrestapi.util.TokenValidation;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.CheckListUpdateDto;
import com.mdl.mdlrestapi.util.models.CheckListUpdateEntry;
import com.mdl.mdlrestapi.util.models.ElectionDto;
import com.mdl.mdlrestapi.util.models.PSICheckListDto;

@Path("/psichecklist")
public class PSICheckList {

	private static final Logger logger = Logger.getLogger(PSICheckList.class);

	public PSICheckList() {
		// CTOR
	}

	// this is need to avoid the CORS issues when calling options
	@OPTIONS
	@Path("{path : .*}")
	public Response options() {
		return Response.ok("").header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization")
				.header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
				.header("Access-Control-Max-Age", "1209600").build();
	}
	
	@POST
	@Path("/getpsichecklist")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getPSICheckList(CheckListUpdateDto data){
		return null;
	}
	
/*	private List<PSICheckListDto> processGetPSICheckList(String token,int placeId) throws Exception{
		
		List<PSICheckListDto> entryList = new ArrayList<PSICheckListDto>();
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs1 = null;
		try{
			conn = DatabaseConnectionManager.getConnection();
			String callString = "{call psm.updateprepollactivity(?,?)}";
			cs = conn.prepareCall(callString);
			cs.setString(1, token);
			cs.setInt(2, placeId);
			
		}finally{
			
		}
		
		return null;
	
		
	}*/

	@POST
	@Path("/psichecklistupdate")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updatePSICheckList(CheckListUpdateDto data) throws UnauthorizedException, MDLServerException {
		if (data == null) {
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:" + ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if (!TokenValidation.ValidateToken(data.token)) {
			logger.warn("Invalid token,token:" + data.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}

		try {
			List<CheckListUpdateEntry> dataList = data.checkListUpdateData;
			boolean allUpdated = performUpdateCheckList(data.token,dataList);
			String status = "failed";
			if(allUpdated){
				status = "success";
			}
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", status);
			return Response.ok(responseobj.toString()).build();

		} catch (Exception ex) {
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}

	private boolean performUpdateCheckList(String token, List<CheckListUpdateEntry> dataList) throws Exception {
		boolean allUpdatedSucessfully = false;
		Connection conn = null;

		try {
			conn = DatabaseConnectionManager.getConnection();

			for (CheckListUpdateEntry entry : dataList) {
				PreparedStatement preparedStatement = null;
				ResultSet rs = null;
				try {

					String query = "call psm.updatepsichecklist(?, ?, ?,?)";
					preparedStatement = conn.prepareStatement(query);
					preparedStatement.setString(1, token);
					preparedStatement.setInt(2, entry.placeId);
					preparedStatement.setInt(3, entry.activityId);
					preparedStatement.setInt(4, entry.isCompleted);

					rs = preparedStatement.executeQuery();
					while (rs.next()) {
						String result = rs.getString("response");
						if (result.equalsIgnoreCase("success")) {
							allUpdatedSucessfully = true;
						} else {
							return false;
						}
					}
				} finally {
					if (preparedStatement != null) {
						preparedStatement.close();
					}
					if (rs != null) {
						rs.close();
					}
				}
			}
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
		return allUpdatedSucessfully;
	}
}
