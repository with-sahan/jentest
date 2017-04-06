package com.mdl.mdlrestapi.util.csv;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mdl.mdlrestapi.util.CsvStructureOneFileTwoDetails;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;

public class CsvS1FileTwoUtil {
	Properties props = new Properties();
	public CsvS1FileTwoUtil()
	{
		try {
			Thread currentThread = Thread.currentThread();
			ClassLoader contextClassLoader = currentThread.getContextClassLoader();
			props.load(contextClassLoader.getResourceAsStream("config.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}



	//Second File of structure one csv which uploads ballot start and end numbers
	public JSONObject processFileTwo(JSONArray readary,String token) throws Exception{
		JSONObject oneobj = new JSONObject();
		JSONObject responseobj = new JSONObject();
		String respStatus="ERROR";
		int status = 0;
		List<CsvStructureOneFileTwoDetails> reportList = getHeaderList(readary);

		if(!reportList.get(0).electionname.equals("CODE0000")){
			status = 3;
			for (int i = 0; i < readary.length(); i++) {
				oneobj = readary.getJSONObject(i);
				
				CsvStructureOneFileTwoDetails innerRequest = new CsvStructureOneFileTwoDetails();
				
				innerRequest.electionname = oneobj.getString(props.getProperty("f2_electionname"));
				innerRequest.stationname = oneobj.getString(props.getProperty("f2_stationname"));
				innerRequest.ballotstartnumber = oneobj.getString(props.getProperty("f2_ballotstartnumber"));
				innerRequest.ballotendnumber = oneobj.getString(props.getProperty("f2_ballotendnumber"));
				innerRequest.tenderstartnumber = oneobj.getString(props.getProperty("f2_tenderstartnumber"));
				innerRequest.tenderendnumber = oneobj.getString(props.getProperty("f2_tenderendnumber"));
				
				if(oneobj.getString(props.getProperty("f2_electionname")).isEmpty()){
					innerRequest.rowstatus = "CODE0009";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f2_stationname")).isEmpty()){
					innerRequest.rowstatus = "CODE0005";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f2_ballotstartnumber")).isEmpty()){
					innerRequest.rowstatus = "CODE0010";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f2_ballotendnumber")).isEmpty()){
					innerRequest.rowstatus = "CODE0011";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f2_tenderstartnumber")).isEmpty()){
					innerRequest.rowstatus = "CODE0012";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f2_tenderendnumber")).isEmpty()){
					innerRequest.rowstatus = "CODE0013";
					status = 2;
				}else{
					int resp = UploadRow(token,innerRequest);
					respStatus="Success";
					//check duplicate data
					if(resp==0){
						innerRequest.rowstatus = "CODE0015";
						status = 2;
					}else if(resp==1){
						innerRequest.rowstatus = "SUCCESS";
					}else if(resp==2){
						innerRequest.rowstatus = "CODE0021";
						status = 2;
					}else if(resp==3){
						innerRequest.rowstatus = "CODE0020";
						status = 2;
					}else{
						innerRequest.rowstatus = "E";
						status = 2;
					}
				}
				reportList.add(innerRequest);
			}
		}
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString();
		String pathToDb = props.getProperty("uploadFilePath");
		String basePath = props.getProperty("baseUrl");
		
		String saveLocation = basePath+pathToDb+"FileT_" + fileName + ".csv";
		CsvStructureOneUtil.writeToCsvReport(reportList,saveLocation,CsvStructureOneFileTwoDetails.class);
		//TO DO
		CsvStructureOneUtil.saveToDb(token,(pathToDb+"FileT_" + fileName + ".csv"),-1,status);
		responseobj.put("response", respStatus);
		return responseobj;		
	}

	private List<CsvStructureOneFileTwoDetails> getHeaderList(JSONArray readary){

		List<CsvStructureOneFileTwoDetails> headerList= new ArrayList<CsvStructureOneFileTwoDetails>();
		CsvStructureOneFileTwoDetails wrightcsvheader = new CsvStructureOneFileTwoDetails();

		JSONObject oneobj = readary.getJSONObject(0);
		if(oneobj.has(props.getProperty("f2_electionname")) 
				&& (oneobj.has(props.getProperty("f2_stationname")))
				&& (oneobj.has(props.getProperty("f2_ballotstartnumber")))
				&& (oneobj.has(props.getProperty("f2_ballotendnumber")))
				&& (oneobj.has(props.getProperty("f2_tenderstartnumber")))
				&& (oneobj.has(props.getProperty("f2_tenderendnumber")))
				){
			wrightcsvheader.electionname = props.getProperty("f2_electionname");
			wrightcsvheader.stationname = props.getProperty("f2_stationname");
			wrightcsvheader.ballotstartnumber = props.getProperty("f2_ballotstartnumber");
			wrightcsvheader.ballotendnumber = props.getProperty("f2_ballotendnumber");
			wrightcsvheader.tenderstartnumber = props.getProperty("f2_tenderstartnumber");
			wrightcsvheader.tenderendnumber = props.getProperty("f2_tenderendnumber");			
			wrightcsvheader.rowstatus = "Status";
			headerList.add(wrightcsvheader);
		}else{
			wrightcsvheader.electionname = "CODE0000";
			headerList.add(wrightcsvheader);
		}
		return headerList;
	}

	private int UploadRow(String token,CsvStructureOneFileTwoDetails request) throws Exception {
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;	
		int resp = 0;
		try {
			//stored procedure calling statement
			String callString = "{call psm.csvballotstartupdate(?,?,?,?,?,?,?)}";
			conn = DatabaseConnectionManager.getConnection();
			cs = conn.prepareCall(callString);
			// Adding items to arrayList
			cs.setString(1,token);
			cs.setString(2,request.electionname);
			cs.setString(3,request.stationname);
			cs.setString(4,request.ballotstartnumber);
			cs.setString(5,request.ballotendnumber);
			cs.setString(6,request.tenderstartnumber);
			cs.setString(7,request.tenderendnumber);

			//assigning resluts to ResultSet
			rs = cs.executeQuery();

			while(rs.next()){
				String res = rs.getString("response");
				if (res.equals("success")) resp=1;
				else if(res.equals("errorename")) resp=2;
				else if(res.equals("errorstationname")) resp=3;
				else return -1;
			}

			// TODO Auto-generated catch block
		}
		finally {
			if (rs != null) {
				rs.close();
			}
			if (cs != null) {
				cs.close();
			}
			if(conn != null){
				conn.close();
			}
		}
		return resp;
	}	
}
