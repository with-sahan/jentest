package com.mdl.mdlrestapi.psm.controller;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mdl.mdlrestapi.psm.model.BPNames;
import com.mdl.mdlrestapi.psm.model.ElectionStatus;
import com.mdl.mdlrestapi.psm.model.PollingStationElectionDetail;
import com.mdl.mdlrestapi.psm.utils.ResultSetUtil;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;

public class ProgressController {

	
	private static final Logger logger = Logger.getLogger(ProgressController.class);
	
	public JSONObject getProgress(SimpleRequest request) throws UnauthorizedException, MDLServerException
	{
		int electionId = request.electionId;
		int stationid = request.stationid;
		String token = request.token;
		
		JSONObject resultObject = new JSONObject();
		JSONArray entryArray = new JSONArray();

		ElectionStatus electionStatus = getElectionStatus(token,electionId,stationid);

		if(electionStatus.getStatus().equals(ResultSetUtil.NO_ELECTIONS))
		{
			resultObject.put("status", false);
			resultObject.put("message", ResultSetUtil.NO_ELECTIONS_MSG);
			logger.info(ResultSetUtil.NO_ELECTIONS_MSG + " " + electionId);
		}
		else if(electionStatus.getElectionStatus() == 1)
		{
			resultObject.put("status", false);
			resultObject.put("message", ResultSetUtil.ELECTION_CLOSED_MSG);
			logger.info(ResultSetUtil.ELECTION_CLOSED_MSG + " " + electionId);

		}
		else
		{
			Integer ballotTypeCount = getBallotType(token,electionId);
			BPNames bpNames	= getBallotPaperNames(token,electionId);
			PollingStationElectionDetail psed = getPollingStationElectionDetails(token,electionId,stationid);
			
			try 
			{
				entryArray = getProgressPoressData(request);
			} 
			catch (Exception e) 
			{
				logger.error(e);
				throw new MDLServerException(e);
			}
			
			resultObject.put("status", true);
			
			resultObject.put("electionstatus", electionStatus.getElectionStatus());
			resultObject.put("ballotturnout", electionStatus.getBallotTurnout());
			resultObject.put("tendturnout", electionStatus.getTendTurnout());
			
			resultObject.put("ballottypecount", ballotTypeCount);
			
			resultObject.put("paper1", bpNames.getPaper1());
			resultObject.put("paper2", bpNames.getPaper2());
			
			resultObject.put("ballotstart", psed.getBallotStart());
			resultObject.put("ballotend", psed.getBallotEnd());
			resultObject.put("tenderstart", psed.getTenderEnd());
			resultObject.put("tenderend", psed.getTenderEnd());
			
			resultObject.put("results", entryArray);

		}
		
		logger.info(resultObject.toString());

		return resultObject;
	}
	
	private ElectionStatus getElectionStatus(String token, int electionId,int stationid) throws UnauthorizedException
	{

		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		ElectionStatus electionStatus = null;
		Integer es = null;
		Integer ballotTurnout = null;
		Integer tendTurnout = null;
		
		boolean authorized = true;
		boolean noElections = false;

		try 
		{
			conn = DatabaseConnectionManager.getConnection();
			
			//stored procedure calling statement
			String callString = "{call getelectionstatus(?,?,?)}";

			cs = conn.prepareCall(callString);
			cs.setString(1, token);
			cs.setInt(2, electionId);
			cs.setInt(3, stationid);
			
			rs = cs.executeQuery();
			
			while(rs.next())
			{
				String res = rs.getString(ResultSetUtil.RESPONSE);
				
				if(ResultSetUtil.UNAUTHORIZED.equals(res))
				{
					authorized = false;
					break;
				}
				else if(ResultSetUtil.NO_ELECTIONS.equals(res))
				{
					noElections = true;
					break;
				}
				
				else
				{
					es = rs.getInt("electionstatus");
					ballotTurnout = rs.getInt("ballotturnout");
					tendTurnout = rs.getInt("tendturnout");
				}
	
			}
			
			
			if(!authorized)
			{
				DatabaseConnectionManager.close(conn);
				DatabaseConnectionManager.close(cs);
				DatabaseConnectionManager.close(rs);
				throw new UnauthorizedException(new Throwable("Invalid token"));
			}
			else if(noElections)
			{
				electionStatus = new ElectionStatus();
				electionStatus.setStatus(ResultSetUtil.NO_ELECTIONS);
			}
			else
			{
				electionStatus = new ElectionStatus();
				electionStatus.setStatus(ResultSetUtil.SUCCESS);
				electionStatus.setElectionStatus(es);
				electionStatus.setBallotTurnout(ballotTurnout);
				electionStatus.setTendTurnout(tendTurnout);
			}
			
		} 
		catch (Exception e) 
		{
			logger.error(e);
		}
		finally
		{
			DatabaseConnectionManager.close(conn);
			DatabaseConnectionManager.close(cs);
			DatabaseConnectionManager.close(rs);
		}
		return electionStatus;
	
	}

	private PollingStationElectionDetail getPollingStationElectionDetails(String token, int electionId,int stationid) throws UnauthorizedException
	{

		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		PollingStationElectionDetail psed = null;

		Integer ballotStart= null;
		Integer ballotEnd= null;
		Integer tenderStart= null;
		Integer tenderEnd= null;
		
		boolean authorized = true;

		try 
		{
			conn = DatabaseConnectionManager.getConnection();
			
			//stored procedure calling statement
			String callString = "{call getpollingstationelectiondetails(?,?,?)}";

			cs = conn.prepareCall(callString);
			cs.setString(1, token);
			cs.setInt(2, electionId);
			cs.setInt(3, stationid);
			
			rs = cs.executeQuery();
			
			while(rs.next())
			{
				String res = rs.getString(ResultSetUtil.RESPONSE);
				
				if(ResultSetUtil.UNAUTHORIZED.equals(res))
				{
					authorized = false;
					break;
				}
				
				else
				{
					ballotEnd = rs.getInt("ballotend");
					ballotStart = rs.getInt("ballotstart");
					tenderEnd = rs.getInt("tenderend");
					tenderStart = rs.getInt("tenderstart");
				}
			}
			
			if(!authorized)
			{
				DatabaseConnectionManager.close(conn);
				DatabaseConnectionManager.close(cs);
				DatabaseConnectionManager.close(rs);
				throw new UnauthorizedException(new Throwable("Invalid token"));
			}
			else
			{
				psed = new PollingStationElectionDetail();
				psed.setBallotEnd(ballotEnd);
				psed.setBallotStart(ballotStart);
				psed.setTenderEnd(tenderEnd);
				psed.setTenderStart(tenderStart);
			}

		} 
		catch (Exception e) 
		{
			logger.error(e);
		}
		finally
		{
			DatabaseConnectionManager.close(conn);
			DatabaseConnectionManager.close(cs);
			DatabaseConnectionManager.close(rs);
		}
		return psed;
	
	}

	private BPNames getBallotPaperNames(String token, int electionId) throws UnauthorizedException
	{

		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		BPNames bpNames = null;
		String paper1 = null;
		String paper2 = null;
		
		boolean authorized = true;
		
		try 
		{
			conn = DatabaseConnectionManager.getConnection();
			
			//stored procedure calling statement
			String callString = "{call getballotpapernames(?,?)}";

			cs = conn.prepareCall(callString);
			cs.setString(1, token);
			cs.setInt(2, electionId);
			rs = cs.executeQuery();
			
			while(rs.next())
			{
				String res = rs.getString(ResultSetUtil.RESPONSE);
				
				if(ResultSetUtil.UNAUTHORIZED.equals(res))
				{
					authorized = false;
					break;
				}
				
				else
				{
					paper1 = rs.getString("paper1");
					paper2 = rs.getString("paper2");
				}
	
			}
			
			if(!authorized)
			{
				DatabaseConnectionManager.close(conn);
				DatabaseConnectionManager.close(cs);
				DatabaseConnectionManager.close(rs);
				throw new UnauthorizedException(new Throwable("Invalid token"));
			}
			else
			{
				bpNames = new BPNames();
				bpNames.setPaper1(paper1);
				bpNames.setPaper2(paper2);
			}
		} 
		catch (Exception e) 
		{
			logger.error(e);
		}
		finally
		{
			DatabaseConnectionManager.close(conn);
			DatabaseConnectionManager.close(cs);
			DatabaseConnectionManager.close(rs);
		}
		return bpNames;
	
	}

	private Integer getBallotType(String token, int electionId) throws UnauthorizedException 
	{
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		Integer ballotTypeCount = null;
		
		boolean authorized = true;
		
		try 
		{
			conn = DatabaseConnectionManager.getConnection();
			
			//stored procedure calling statement
			String callString = "{call getballottypecount(?,?)}";

			cs = conn.prepareCall(callString);
			cs.setString(1, token);
			cs.setInt(2, electionId);
			rs = cs.executeQuery();
			
			while(rs.next())
			{
				String res = rs.getString(ResultSetUtil.RESPONSE);
				
				if(ResultSetUtil.UNAUTHORIZED.equals(res))
				{
					authorized = false;
					break;
				}
				
				else
				{
					ballotTypeCount = rs.getInt("typecount");
				}
	
			}
			
			if(!authorized)
			{
				DatabaseConnectionManager.close(conn);
				DatabaseConnectionManager.close(cs);
				DatabaseConnectionManager.close(rs);
				throw new UnauthorizedException(new Throwable("Invalid token"));
			}
			
		} 
		catch (Exception e) 
		{
			logger.error(e);
		}
		finally
		{
			DatabaseConnectionManager.close(conn);
			DatabaseConnectionManager.close(cs);
			DatabaseConnectionManager.close(rs);
		}
		return ballotTypeCount;
	}

	public JSONArray getProgressPoressData(SimpleRequest request) throws Exception
	{
		JSONArray entryarray = new JSONArray();
		JSONObject responseobj = new JSONObject();
		ResultSet rs1 = null;
		List<Map<String,Object>> resultSet=null;
		String respStatus="";

		Connection conn = null;
		CallableStatement cs = null;
		try {
			conn = DatabaseConnectionManager.getConnection();
			respStatus="no data";
			responseobj.put("response", respStatus);
			entryarray.put(0, responseobj);

			//stored procedure calling statement
			String callString = "{call psm.getelectiontimearray(?)}";

			cs = conn.prepareCall(callString);
			// Adding items to arrayList
			cs.setString(1, request.token);
			rs1 = cs.executeQuery();



				respStatus="error";
				int startHour = 0;
				int difference = 0;
				int eid = 0;
				int i = 0;

				while(rs1.next()){
					String res = rs1.getString("response");
					if(res.equals("unauthorized")){
						respStatus="unauthorized";
						responseobj.put("response", respStatus);
						entryarray.put(0, responseobj);
						break;
					}
					startHour = rs1.getInt("starttimehour");
					difference = rs1.getInt("difference");
					eid = rs1.getInt("electionid");

					if(String.valueOf(request.electionId).equals(eid+"")){
						for(int counter = startHour; counter<(startHour+difference) ; counter++){
							resultSet = getProgressHourly(request.token,String.valueOf(request.electionId),String.valueOf(request.stationid),counter);
							logger.info("Result set of 'getProgressHourly' :"+resultSet+"for token: "+request.token+"election ID: "+request.electionId+"Station ID: "+request.stationid);
							JSONObject tempobj = new JSONObject();
							tempobj.put("time", makeTimeString(counter));
							respStatus="success";
							//if rs.next() returns false
							if (resultSet.size() == 0) {
								//then there are no rows.
								//tempobj.put("BPAIdentifier", 0);
								//tempobj.put("ballotstartnum", 0);
								//tempobj.put("ballotendnum", 0);
								//tempobj.put("tenderedstartnum", 0);
								//tempobj.put("tenderedendnum", 0);
								tempobj.put("ballotpapers", 0);
								tempobj.put("postalpacks", 0);
								tempobj.put("postalpackscollected", 0);
								tempobj.put("spoiltballots", 0);
								tempobj.put("tenballotpapers", 0);
								tempobj.put("tenspoiltballots", 0);
								tempobj.put("uplifting_person_name", "");
								tempobj.put("ballotpapers2", 0);
								tempobj.put("postalpacks2", 0);
								tempobj.put("postalpackscollected2", 0);
								tempobj.put("spoiltballots2", 0);
								tempobj.put("tenballotpapers2", 0);
								tempobj.put("tenspoiltballots2", 0);
								tempobj.put("response", respStatus);
								entryarray.put(i++, tempobj);
							}
							else {

								for(Map<String,Object> result:resultSet){
									for(String key:result.keySet()){
										tempobj.put(key,result.get(key));
									}
									tempobj.put("response", respStatus);
									entryarray.put(i++, tempobj);
								}

							}
						}
					}
				}

		}
		finally {
			if (rs1 != null) {
				rs1.close();
			}
			if (cs != null) {
				cs.close();
			}

			if(conn != null){
			conn.close();
			}
		}
		return entryarray;
	}

	public List<Map<String,Object>> getProgressHourly(String token, String electionid, String stationid, int hour)
			throws Exception {
		ResultSet rs = null;
		Connection conn = null;
		CallableStatement cs = null;
		List<Map<String,Object>> resultSet = new ArrayList<Map<String,Object>>();
		//stored procedure calling statement
		try{
			conn = DatabaseConnectionManager.getConnection();
		String callString = "{call psm.getprogressbytime(?,?,?,?)}";

			cs = conn.prepareCall(callString);
		// Adding items to arrayList
			cs.setString(1, token);
			cs.setString(2, electionid);
			cs.setString(3, stationid);
			cs.setString(4, (hour + ""));

			rs = cs.executeQuery();

			while(rs.next()) {
				int BPAIdentifier = rs.getInt("BPAIdentifier");
				int ballotstartnum = rs.getInt("ballotstartnum");
				int ballotendnum = rs.getInt("ballotendnum");
				int tenderedstartnum = rs.getInt("tenderedstartnum");
				int tenderedendnum = rs.getInt("tenderedendnum");
				int ballotpapers = rs.getInt("ballotpapers");
				int ballotpapers2 = rs.getInt("ballotpapers2");
				int postalpacks = rs.getInt("postalpacks");
				int postalpacks2 = rs.getInt("postalpacks2");
				int postalpackscollected = rs.getInt("postalpackscollected");
				int postalpackscollected2 = rs.getInt("postalpackscollected2");
				int spoilt_ballots = rs.getInt("spoilt_ballots");
				int spoilt_ballots2 = rs.getInt("spoilt_ballots2");
				int ten_ballot_papers = rs.getInt("ten_ballot_papers");
				int ten_ballot_papers2 = rs.getInt("ten_ballot_papers2");
				int ten_spoilt_ballots = rs.getInt("ten_spoilt_ballots");
				int ten_spoilt_ballots2 = rs.getInt("ten_spoilt_ballots2");
				String uplifting_person_name = rs.getString("uplifting_person_name");
				Map<String,Object> tempobj = new HashMap<String,Object>();
				tempobj.put("BPAIdentifier", BPAIdentifier);
				tempobj.put("ballotstartnum", ballotstartnum);
				tempobj.put("ballotendnum", ballotendnum);
				tempobj.put("tenderedstartnum", tenderedstartnum);
				tempobj.put("tenderedendnum", tenderedendnum);
				tempobj.put("ballotpapers", ballotpapers);
				tempobj.put("postalpacks", postalpacks);
				tempobj.put("postalpackscollected", postalpackscollected);
				tempobj.put("spoiltballots", spoilt_ballots);
				tempobj.put("tenballotpapers", ten_ballot_papers);
				tempobj.put("tenspoiltballots", ten_spoilt_ballots);
				tempobj.put("ballotpapers2", ballotpapers2);
				tempobj.put("postalpacks2", postalpacks2);
				tempobj.put("postalpackscollected2", postalpackscollected2);
				tempobj.put("spoiltballots2", spoilt_ballots2);
				tempobj.put("tenballotpapers2", ten_ballot_papers2);
				tempobj.put("tenspoiltballots2", ten_spoilt_ballots2);
				tempobj.put("uplifting_person_name", uplifting_person_name);
				resultSet.add(tempobj);
			}

			// TODO Auto-generated catch block
		} finally {
			if (cs != null) {
				cs.close();
			}
			if(rs!= null){
				rs.close();
			}
			if(conn != null){
			conn.close();
			}
		}
		return resultSet;
	}
	
	public String makeTimeString(int hour){
		if(hour<9) return "0" + hour + ":00 - 0" + (hour+1) + ":00";
		else if(hour==9) return "09:00 - 10:00";
		else if(hour<24) return hour + ":00 - " + (hour+1) + ":00";
		else if(hour>24) return makeTimeString(hour-24);
		else return "00:00 - 00:00";
	}
	
	
	public static void main(String[] args) throws UnauthorizedException, MDLServerException 
	{
		SimpleRequest sr = new SimpleRequest();
		sr.electionId = 151;
		sr.stationid = 1693;
		sr.token =  "admin|dev-01|33900a8ab1622dd4e72bc0f81432c5b2";
		
		ProgressController pc = new ProgressController();
		pc.getProgress(sr);
	}
}
