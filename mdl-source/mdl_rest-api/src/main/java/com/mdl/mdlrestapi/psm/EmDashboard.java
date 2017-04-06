package com.mdl.mdlrestapi.psm;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
import com.mdl.mdlrestapi.util.database.psm.entities.HierarchyValue;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.mdl.mdlrestapi.util.models.CloseStatsDto;
import com.mdl.mdlrestapi.util.models.ElectionDto;
import com.mdl.mdlrestapi.util.models.EmDashboardDto;
import com.mdl.mdlrestapi.util.models.EmDashboardGridData;
import com.mdl.mdlrestapi.util.models.EmIssueWithStationCount;
import com.mdl.mdlrestapi.util.models.GraphBallotStatsDto;
import com.mdl.mdlrestapi.util.models.PollingStationElectionDto;


@Path("/emdashboard")
public class EmDashboard {
	private static final Logger logger = Logger.getLogger(EmDashboard.class);
	public EmDashboard(){
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
	@Path("/getelectionsbyhierarchy")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response GetElectionsByHierarchy(SimpleRequest request) throws UnauthorizedException, MDLServerException {
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if(!TokenValidation.ValidateToken(request.token)){
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		} else {
			try {
				Gson gson=new Gson();
				List<ElectionDto> elList = new ArrayList<ElectionDto>();
				elList = getElectionList(request.hierarchyId, request.token);
				return Response.ok(gson.toJson(elList)).build();


			}catch(Exception ex){
				logger.error(ex);
				throw new MDLServerException(ex);
			}
		}
	}

	@POST
	@Path("/getsumstats")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response GetSumStats(SimpleRequest request) throws UnauthorizedException, MDLServerException {
		if(request == null){
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:"+ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if(!TokenValidation.ValidateToken(request.token)){
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		} else {
			try {
				List<EmDashboardGridData> statList = new ArrayList<EmDashboardGridData>();
				statList = getAllSumStats(request.token, request.hierarchyId, request.electionId);
				Gson gson=new Gson();

				return Response.ok(gson.toJson(statList)).build();


			} catch (Exception ex) {
				logger.error(ex);
				throw new MDLServerException(ex);
			}
		}
	}

	private ArrayList<EmDashboardGridData> getAllSumStats(String token, int hierarchyId, int electionId)
			throws SQLException, Exception {
		// TODO Auto-generated method stub
		// logger.info("getAllSumStats parameters :"+token+"hierarchyId:
		// "+hierarchyId+"electionId :"+electionId);

		ArrayList<EmDashboardGridData> elList = new ArrayList<>();
		EmDashboardGridData dto = new EmDashboardGridData();
		int totalturnout = 0;

		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try {
			conn = DatabaseConnectionManager.getConnection();

			int orgid = SubscriptionQuerryHandler.getOrganizationId(token);
			String stationList = getPollingStationList(hierarchyId, orgid).replaceAll(",$", "");

			if (stationList != null && stationList.length() > 0 && orgid > 0 && electionId >0 ) {
				String query1 = "SELECT sum((pse.ballotend+1)-pse.ballotstart) as turnouts FROM psm.polling_station_election pse "
						+ "inner join psm.polling_station ps on ps.id=pse.polling_station_id "
						+ "where pse.polling_station_id in (" + stationList + ") and pse.election_id=" + electionId
						+ ";";

				// logger.info("query1 :"+query1);
				statement1 = conn.createStatement();
				rs1 = statement1.executeQuery(query1);
				while (rs1.next()) {
					totalturnout = rs1.getInt("turnouts");
				}

				String query2 = "select sum(es.ballotpaper) as totballot,sum(es.postalpack) as totpostal,sum(es.postalpack_collected) as totcollected,"
						+ "el.election_name as electionname from psm.election_stats es "
						+ "inner join psm.election el on es.electionid=el.id " + "where el.id=" + electionId
						+ " and es.organization_id=" + orgid + " and es.polling_station_id in (" + stationList
						+ ") and " + "date(el.election_date_start)=current_date() group by el.election_name;";

				// logger.info("query2 :"+query2);
				statement2 = conn.createStatement();
				rs2 = statement2.executeQuery(query2);
				while (rs2.next()) {
					int turnout = rs2.getInt("totballot");
					dto.ballotPapers = turnout;
					dto.packestobecollected = (rs2.getInt("totpostal") - rs2.getInt("totcollected"));
					dto.electionname = rs2.getString("electionname");
					double percentage = ((totalturnout == 0) ? 0
							: (double) 100.0 * (((double) turnout) / ((double) totalturnout)));
					dto.voterturnout = percentage;
				}
				elList.add(dto);
			}

		} finally {
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
			if (conn != null) {
				conn.close();
			}
		}

		return elList;
	}

	@POST
	@Path("/getstatsbyelection")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getStatsByElection(SimpleRequest request) throws UnauthorizedException, MDLServerException{
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
		else{
			try{
				List<EmDashboardDto> statList = new ArrayList<EmDashboardDto>();
				statList=GetStats(request.hierarchyId,request.token,request.electionId);
				Gson gson=new Gson();
				return Response.ok(gson.toJson(statList)).build();

			}catch(Exception ex){
				logger.error(ex);
				throw new MDLServerException(ex);
			}
		}
	}

	private ArrayList<ElectionDto> getElectionList(int hierarchyId, String token) throws SQLException, Exception {
		// gets the election list on selected polling stastions that are running
		// today
		ArrayList<ElectionDto> elList = new ArrayList<>();
		if (hierarchyId > 0 && token != null && token.length() > 0) {
			Connection conn = null;
			Statement statement1 = null;
			ResultSet rs1 = null;
			try {
				conn = DatabaseConnectionManager.getConnection();
				int orgid = 0;

				// get the organization id
				orgid = SubscriptionQuerryHandler.getOrganizationId(token);
				// logger.info("Organization ID"+orgid);

				String stationList = getPollingStationList(hierarchyId, orgid).replaceAll(",$", "");
				if(stationList != null && stationList.length() > 0 && orgid >0  ){
					String query1 = "select distinct(el.id),el.election_name from psm.polling_station_election pse inner "
							+ "join psm.election el on pse.election_id=el.id where el.organization_id=" + orgid
							+ " and pse.organization_id=" + orgid + "  and " + "pse.polling_station_id in (" + stationList
							+ ") and " + "date(el.election_date_start)=date(current_date);";

					// logger.info("query1 :"+query1);
					statement1 = conn.createStatement();
					rs1 = statement1.executeQuery(query1);
					while (rs1.next()) {
						ElectionDto dto = new ElectionDto();
						dto.electionName = rs1.getString("election_name");
						dto.id = rs1.getInt("id");
						elList.add(dto);
					}
				}


			} finally {
				if (rs1 != null) {
					rs1.close();
				}
				if (statement1 != null) {
					statement1.close();
				}
				if (conn != null) {
					conn.close();
				}
			}

		}

		return elList;
	}

	static String getPollingStationList(int hierarchyId,int orgId) throws Exception{
		StringBuilder sb=new StringBuilder();
		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try{
			conn = DatabaseConnectionManager.getConnection();

			int selHrc=0;
			//first get all the polling stations under this hierarchy
			String query0 = "SELECT id FROM psm.polling_station where hierarchy_value_id="+ hierarchyId +" and organization_id=" + orgId + ";";
			//add all the polling station ids
			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(query0);
			while(rs1.next()){
				sb.append(rs1.getInt("id")+ ",");
			}

			//now check child hierarchies for this hierachy and recurse
			String query1 = "SELECT id FROM psm.hierarchy_value where parent_id="+ hierarchyId +" and organization_id=" + orgId + ";";

			statement2 = conn.createStatement();
			rs2 = statement2.executeQuery(query1);
			while(rs2.next()){
				selHrc = rs2.getInt("id");
				sb.append(getPollingStationList(selHrc,orgId)) ;
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


	private ArrayList<EmDashboardDto> GetStats(int hierarchyId, String token, int electionId) throws Exception {
		int orgid = 0;
		Connection conn = null;
		Statement statement1 = null;
		ResultSet rs1 = null;
		ArrayList<EmDashboardDto> resList = new ArrayList<EmDashboardDto>();
		try {
			// get the organization id
			orgid = SubscriptionQuerryHandler.getOrganizationId(token);
			conn = DatabaseConnectionManager.getConnection();

			String stationList = getPollingStationList(hierarchyId, orgid).replaceAll(",$", "");
			if (stationList != null && stationList.length() > 0 && electionId > 0) {
				logger.info("Organization ID :" + orgid + " , Station List :" + stationList);
				String blrQry = "select ps.id as stationid,ps.name as pollingstation,hv.value as parentHierarchyName,pse.isopen as stationopenstatus,pse.isclose as stationclosestatus,(sum(es.ballotpaper)) as ballotpapers,sum(es.postalpack) as postalreceived,"
						+ "sum(es.postalpack_collected) as postalcollected "
						+ "from psm.election_stats es inner join psm.polling_station ps on es.polling_station_id=ps.id "
						+ "inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id "
						+ "inner join psm.polling_station_election pse on pse.election_id=es.electionid and pse.polling_station_id=es.polling_station_id "
						+ "where es.electionid=" + electionId + " and pse.polling_station_id in (" + stationList + ") "
						+ "and es.organization_id=" + orgid + " and ps.organization_id=" + orgid + " group by ps.name;";

				statement1 = conn.createStatement();
				rs1 = statement1.executeQuery(blrQry);

				while (rs1.next()) {
					EmDashboardDto dbd = new EmDashboardDto();
					dbd.parentHierarchyName = rs1.getString("parentHierarchyName");
					dbd.ballotPapersIssued = rs1.getInt("ballotpapers");
					dbd.postalPackesCollected = rs1.getInt("postalcollected");
					dbd.postalPackesRecevied = rs1.getInt("postalreceived");
					dbd.stationName = rs1.getString("pollingstation");
					dbd.status = rs1.getInt("stationopenstatus");
					dbd.stationid = rs1.getInt("stationid");
					dbd.openStatus = rs1.getInt("stationopenstatus");
					dbd.closeStatus = rs1.getInt("stationclosestatus");
					dbd.photoUrl = getPhotoUrl(rs1.getInt("stationid"), electionId, orgid);
					resList.add(dbd);
				}
			}

			// sqle.printStackTrace();
		} finally {
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return resList;
	}


	@POST
	@Path("/getissuecountgraphstats")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response GetIssueCountGraphStats(SimpleRequest request) throws  UnauthorizedException, MDLServerException{
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
			String data =  getIssueCountGraphStats(request);
			return Response.ok(data).build();
		}catch(Exception e){
			logger.error(e);
			throw new MDLServerException(e);
		}
	}
	private String getIssueCountGraphStats(SimpleRequest request) throws Exception{
		int orgid = 0;

		StringBuffer sb = new StringBuffer();
		EmIssueWithStationCount obj = new EmIssueWithStationCount();
		Connection conn = null;
		Statement statement1 = null;
		Statement statement2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		PreparedStatement preparedStatement = null;
		try{
			//conn = DatabaseConnectionManager.getConnection();
			//get the organization id
			orgid=SubscriptionQuerryHandler.getOrganizationId(request.token);
			String stationList=getPollingStationList(request.hierarchyId,orgid).replaceAll(",$", "");

			if(stationList != null && stationList.length() > 0 && orgid > 0){
				String querry = "call psm.isopenisclosed(?)";
				conn = DatabaseConnectionManager.getConnection();
				preparedStatement = conn.prepareStatement(querry);
				preparedStatement.setString(1, stationList);
				rs1 = preparedStatement.executeQuery();
				while(rs1.next()){
					obj.opencount = rs1.getInt("opened");
					obj.closecount = rs1.getInt("closed");
				}
				String blrQry="select count(isu.id) as openissues,'success' as response from psm.issue isu "
						+	"where isu.pollingstation_id in (" + stationList + ") and "
						+	"isu.status in (0,3,4) and  isu.organization_id="+orgid+" and date(isu.createdon) =date(current_date);";

				statement2 = conn.createStatement();
				rs2 = statement2.executeQuery(blrQry);

				while(rs2.next()){
					obj.response=rs2.getString("response");
					obj.openissues=rs2.getInt("openissues");
				}

				Gson gson=new Gson();
				sb.append("{\"result\": {\"entry\": "+gson.toJson(obj)+"}}");
			}
			else{
				logger.warn("stationList : " + stationList +" and orgid : "+ orgid);
			}

			return sb.toString();

		}
		finally {
			if (rs1 != null) {
				rs1.close();
			}
			if (statement1 != null) {
				statement1.close();
			}
			if (preparedStatement != null) {
				preparedStatement.close();
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
	}


	private String getPhotoUrl(int stationId,int electionId,int orgId) throws Exception{
		String query0 = "select image_url from psm.station_photo where organization_id=" + orgId + " and station_id=" + stationId + " and election_id=" + electionId;
		String photo="";
		Connection conn = null;
		Statement statement1 = null;
		ResultSet rs1 = null;
		try {
			conn = DatabaseConnectionManager.getConnection();

			statement1 = conn.createStatement();
			rs1 = statement1.executeQuery(query0);
			while(rs1.next()){
				photo = rs1.getString("image_url");
			}
		}
		catch (Exception sqle) {
			logger.error(sqle);
			throw sqle;
		}
		finally {
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
		return photo;
	}
	@POST
	@Path("/getpollingstationdetails")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getPollingStationDetails(SimpleRequest request) throws UnauthorizedException, MDLServerException {
		if (request == null) {
			logger.warn("Request is null");
			JSONObject responseobj = new JSONObject();
			responseobj.put("response", "Error:" + ErrorCodes.INVALID_DATA);
			return Response.ok(responseobj.toString()).build();
		}
		if (!TokenValidation.ValidateToken(request.token)) {
			logger.warn("Invalid token,token:" + request.token);
			throw new UnauthorizedException(new Throwable("Invalid token"));
		}
		try {
			List<PollingStationElectionDto> pollingStationElections = processGetPollingStationDetails_v2(request.token,
					request.hierarchyId);
			return Response.ok(new Gson().toJson(pollingStationElections)).build();
		} catch (Exception e) {
			logger.error(e);
			throw new MDLServerException(e);
		}
	}
	private List<PollingStationElectionDto> processGetPollingStationDetails_v2(String token, int hierarchyId)
			throws Exception {
		List<PollingStationElectionDto> pollingStationElections = new ArrayList<PollingStationElectionDto>();
		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		String stationList = getPollingStationList(hierarchyId, orgId).replaceAll(",$", "");

		if (orgId > 0 && hierarchyId > 0 && stationList != null) {
			Connection conn = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			try {
				String query = "select ps.id as id, ps.name as stationname, hv.value as place, "
						+ "psm.isopen(ps.id) as openstatus "
						+ "from psm.polling_station ps "
						+ "inner join psm.hierarchy_value hv on ps.hierarchy_value_id=hv.id "
						+ "where ps.organization_id=? and ps.id in ("+stationList+");";
				conn = DatabaseConnectionManager.getConnection();
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setInt(1, orgId);
				rs = preparedStatement.executeQuery();
				while (rs.next()) {
					PollingStationElectionDto pdt = new PollingStationElectionDto();
					pdt.place = rs.getString("place");
					pdt.pollingStation = rs.getString("stationname");
					pdt.keyContactName = "";			//TODO Values hardcoded due to unimplemented functionality
					pdt.contactDetails = "";
					pdt.openStatus = rs.getString("openstatus");

					pollingStationElections.add(pdt);
				}
			} finally {
				if (rs != null) {
					rs.close();
				}
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (conn != null) {
					conn.close();
				}
			}
		}
		return pollingStationElections;
	}


	private List<PollingStationElectionDto> processGetPollingStationDetails(String token, int hierarchyId)
			throws Exception {
		List<PollingStationElectionDto> pollingStationElections = new ArrayList<PollingStationElectionDto>();
		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		List<Integer> hierarchyValueIdList = findHierarchyValueIds(orgId, hierarchyId);
		if (orgId > 0 && hierarchyValueIdList != null && hierarchyValueIdList.size() > 0) {
			pollingStationElections = findPollingStationDetails(orgId, hierarchyValueIdList);
		}
		return pollingStationElections;
	}
	private List<PollingStationElectionDto> findPollingStationDetails(int orgId, List<Integer> hierarchyValueIdList)
			throws Exception {
		List<PollingStationElectionDto> pollingStationDetails = new ArrayList<PollingStationElectionDto>();
		if (orgId > 0 && hierarchyValueIdList != null && hierarchyValueIdList.size() > 0) {
			Connection conn = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			try {
				StringBuffer sb = new StringBuffer();
				for(int i=0;i<hierarchyValueIdList.size();i++){
					sb.append(hierarchyValueIdList.get(i));
					if(i != hierarchyValueIdList.size() -1 ){
						sb.append(",");
					}
				}
				String hvStringList = sb.toString();
				if (hvStringList.length() > 0) {
					String querry = "call psm.findPollingStationDetails(?)";
					conn = DatabaseConnectionManager.getConnection();
					preparedStatement = conn.prepareStatement(querry);
					preparedStatement.setString(1, hvStringList);
					rs = preparedStatement.executeQuery();
					while (rs.next()) {
						PollingStationElectionDto pse = new PollingStationElectionDto();
						pse.place = rs.getString("place");
						pse.pollingStation = rs.getString("polling_station");
						int isOpen = rs.getInt("is_open");
						int isClose = rs.getInt("is_close");
						if (isOpen == 0 && isClose == 0) {
							pse.stationStatus = "CLOSED";
						} else if (isOpen == 1 && isClose == 0) {
							pse.stationStatus = "OPEN";
						} else if (isOpen == 1 && isClose == 1) {
							pse.stationStatus = "CLOSED";
						}
						pollingStationDetails.add(pse);
					}
				}
			} finally {
				if (rs != null) {
					rs.close();
				}
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (conn != null) {
					conn.close();
				}
			}
		}
		return pollingStationDetails;
	}
	private List<Integer> findHierarchyValueIds(int orgId, int hierarchyId) throws Exception {
		List<Integer> hierarchyValueIdList = new ArrayList<Integer>();
		if (orgId > 0 && hierarchyId > 0) {
			Connection conn = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			try {
				String query = "SELECT id FROM psm.hierarchy_value where organization_id =? and hierarchy_id=?";
				conn = DatabaseConnectionManager.getConnection();
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setInt(1, orgId);
				preparedStatement.setInt(2, hierarchyId);
				rs = preparedStatement.executeQuery();
				while (rs.next()) {
					int hierarchyValueId = rs.getInt("id");
					hierarchyValueIdList.add(hierarchyValueId);
				}
			} finally {
				if (rs != null) {
					rs.close();
				}
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (conn != null) {
					conn.close();
				}
			}
		}
		return hierarchyValueIdList;
	}



	@POST
	@Path("/getballotissuegraphstats_v2")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getBallotIssueGraphStats(SimpleRequest request) throws MDLServerException, UnauthorizedException{
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
			Gson gson = new Gson();
			ArrayList<GraphBallotStatsDto> resultMap=getBallotGraphStats(request.token,request.hierarchyId);
			return Response.ok(gson.toJson(resultMap)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}


	private ArrayList<GraphBallotStatsDto> getBallotGraphStats(String token,int hierarchyId) throws Exception {
		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		ArrayList<GraphBallotStatsDto> statsDetails = new ArrayList<GraphBallotStatsDto>();

		if (orgId > 0 && hierarchyId >0 ) {
			Connection conn = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			try{
				String stationList = EmDashboard.getPollingStationList(hierarchyId, orgId).replaceAll(",$", "");

				String query = "select el.election_name as electionname,HOUR(est.updatedon) as issuehour, "
						+ "sum(ballotpaper) as ballotpaperissued,"
						+ "'success' as response from psm.election_stats  est "
						+ "inner join psm.election el on el.id=est.electionid "
						+ "where date(el.election_date_start)=date(current_date) and "
						+ "est.organization_id=? and el.organization_id=? "
						+ "and est.polling_station_id in ("+stationList+") "
						+ "group by el.id, el.election_name, HOUR(est.updatedon); ";
				conn = DatabaseConnectionManager.getConnection();
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setInt(1, orgId);
				preparedStatement.setInt(2, orgId);
				rs = preparedStatement.executeQuery();

				while (rs.next()) {
					GraphBallotStatsDto csd = new GraphBallotStatsDto();
					csd.electionname = rs.getString("electionname");
					csd.issuehour = rs.getString("issuehour");
					csd.ballotpaperissued = rs.getString("ballotpaperissued");
					csd.response = rs.getString("response");
					statsDetails.add(csd);
				}

			}finally {
				if (rs != null) {
					rs.close();
				}if (preparedStatement != null) {
					preparedStatement.close();
				}if (conn != null) {
					conn.close();
				}
			}

		}else{
			logger.warn("orgid(" + orgId + ") or hierarchyid(" + hierarchyId + ")  is not defined");
		}
		return statsDetails;
	}





	@POST
	@Path("/getpostalcollectgraphstats_v2")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getPostalCollectGraphStats(SimpleRequest request) throws MDLServerException, UnauthorizedException{
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
			Gson gson = new Gson();
			ArrayList<GraphBallotStatsDto> resultMap=getPostalGraphStats(request.token,request.hierarchyId);
			return Response.ok(gson.toJson(resultMap)).build();

		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}
	}


	private ArrayList<GraphBallotStatsDto> getPostalGraphStats(String token,int hierarchyId) throws Exception {
		int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
		ArrayList<GraphBallotStatsDto> statsDetails = new ArrayList<GraphBallotStatsDto>();

		if (orgId > 0 && hierarchyId >0 ) {
			Connection conn = null;
			PreparedStatement preparedStatement = null;
			ResultSet rs = null;
			try{
				String stationList = EmDashboard.getPollingStationList(hierarchyId, orgId).replaceAll(",$", "");

				String query = "select el.election_name as electionname,HOUR(est.updatedon) as issuehour,"
						+ " sum(postalpack_collected) as postalcollected,'success' as response "
						+ "from psm.election_stats  est "
						+ "inner join psm.election el on el.id=est.electionid "
						+ "where date(el.election_date_start)=date(current_date) "
						+ "and est.organization_id=? and el.organization_id=? "
						+ "and est.polling_station_id in ("+stationList+") "
						+ "group by el.election_name, HOUR(est.updatedon);";
				conn = DatabaseConnectionManager.getConnection();
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setInt(1, orgId);
				preparedStatement.setInt(2, orgId);
				rs = preparedStatement.executeQuery();

				while (rs.next()) {
					GraphBallotStatsDto csd = new GraphBallotStatsDto();
					csd.electionname = rs.getString("electionname");
					csd.issuehour = rs.getString("issuehour");
					csd.postalcollected = rs.getString("postalcollected");
					csd.response = rs.getString("response");
					statsDetails.add(csd);
				}

			}finally {
				if (rs != null) {
					rs.close();
				}if (preparedStatement != null) {
					preparedStatement.close();
				}if (conn != null) {
					conn.close();
				}
			}

		}else{
			logger.warn("orgid(" + orgId + ") or hierarchyid(" + hierarchyId + ")  is not defined");
		}
		return statsDetails;
	}
}
