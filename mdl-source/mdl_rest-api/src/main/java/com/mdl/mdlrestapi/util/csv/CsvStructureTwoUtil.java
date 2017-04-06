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

import com.mdl.mdlrestapi.util.CsvStructureTwoDetails;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;

public class CsvStructureTwoUtil {
	Properties props = new Properties();
	public CsvStructureTwoUtil()
	{
		try {
			Thread currentThread = Thread.currentThread();
			ClassLoader contextClassLoader = currentThread.getContextClassLoader();
			props.load(contextClassLoader.getResourceAsStream("config.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//Second structure of csv which uploads users and polling stations
	public JSONObject processCsvStructureTwo(JSONArray readary,String token, int electionId) throws Exception{
		JSONObject oneobj = new JSONObject();
		JSONObject responseobj = new JSONObject();
		String respStatus="ERROR";
		int status = 0; //status from the psm.csv_upload table

		List<CsvStructureTwoDetails> reportList = getHeaderListStructureTwo(readary);
		if(!reportList.get(0).ward.equals("CODE0000")){
			status = 3;
			for (int i = 0; i < readary.length(); i++) {
				oneobj = readary.getJSONObject(i);

				CsvStructureTwoDetails innerRow = new CsvStructureTwoDetails();

				innerRow.ward = oneobj.getString(props.getProperty("f1_s2_ward"));
				innerRow.district = oneobj.getString(props.getProperty("f1_s2_district"));
				innerRow.place = oneobj.getString(props.getProperty("f1_s2_place"));				
				innerRow.stationname = oneobj.getString(props.getProperty("f1_s2_stationname"));
				innerRow.ballotboxnumber = oneobj.getString(props.getProperty("f1_s2_ballotboxnumber"));
				innerRow.ballotstartnumber = oneobj.getString(props.getProperty("f1_s2_ballotstartnumber"));
				innerRow.ballotendnumber = oneobj.getString(props.getProperty("f1_s2_ballotendnumber"));
				innerRow.tenderstartnumber = oneobj.getString(props.getProperty("f1_s2_tenderstartnumber"));
				innerRow.tenderendnumber = oneobj.getString(props.getProperty("f1_s2_tenderendnumber"));

				if(oneobj.getString(props.getProperty("f1_s2_ward")).isEmpty()){
					innerRow.rowstatus = "CODE0003";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f1_s2_district")).isEmpty()){
					innerRow.rowstatus = "CODE0002";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f1_s2_place")).isEmpty()){
					innerRow.rowstatus = "CODE0004";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f1_s2_stationname")).isEmpty()){
					innerRow.rowstatus = "CODE0005";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f1_s2_ballotboxnumber")).isEmpty()){
					innerRow.rowstatus = "CODE0006";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f1_s2_ballotstartnumber")).isEmpty()){
					innerRow.rowstatus = "CODE0010";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f1_s2_ballotendnumber")).isEmpty()){
					innerRow.rowstatus = "CODE0011";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f1_s2_tenderstartnumber")).isEmpty()){
					innerRow.rowstatus = "CODE0012";
					status = 2;
				}else if (oneobj.getString(props.getProperty("f1_s2_tenderendnumber")).isEmpty()){
					innerRow.rowstatus = "CODE0013";
					status = 2;
				}else{
					int resp = UploadRow(token,innerRow,electionId);
					respStatus="Success";
					if(resp==0){
						innerRow.rowstatus = "CODE0015";
						status = 2;
					}else{
						innerRow.rowstatus = "SUCCESS";
					}
				}
				reportList.add(innerRow);
			}
		}
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString();
		String pathToDb = props.getProperty("uploadFilePath");
		String basePath = props.getProperty("baseUrl");
		
		String saveLocation = basePath+pathToDb+"StructureT_" + fileName + ".csv";
		CsvStructureOneUtil.writeToCsvReport(reportList,saveLocation,CsvStructureTwoDetails.class);
		CsvStructureOneUtil.saveToDb(token,(pathToDb+"StructureT_" + fileName + ".csv"),electionId,status);
		responseobj.put("response", respStatus);
		return responseobj;		
	}

	private List<CsvStructureTwoDetails> getHeaderListStructureTwo(JSONArray readary){

		List<CsvStructureTwoDetails> headerList= new ArrayList<CsvStructureTwoDetails>();
		CsvStructureTwoDetails wrightcsvheader = new CsvStructureTwoDetails();

		JSONObject oneobj = readary.getJSONObject(0);
		if(oneobj.has(props.getProperty("f1_s2_ward")) 
				&& (oneobj.has(props.getProperty("f1_s2_district")))
				&& (oneobj.has(props.getProperty("f1_s2_place")))
				&& (oneobj.has(props.getProperty("f1_s2_stationname")))
				&& (oneobj.has(props.getProperty("f1_s2_ballotboxnumber")))
				&& (oneobj.has(props.getProperty("f1_s2_ballotstartnumber")))
				&& (oneobj.has(props.getProperty("f1_s2_ballotendnumber")))
				&& (oneobj.has(props.getProperty("f1_s2_tenderstartnumber")))
				&& (oneobj.has(props.getProperty("f1_s2_tenderendnumber")))
				){
			wrightcsvheader.ward = props.getProperty("f1_s2_ward");
			wrightcsvheader.district = props.getProperty("f1_s2_district");
			wrightcsvheader.place = props.getProperty("f1_s2_place");
			wrightcsvheader.stationname = props.getProperty("f1_s2_stationname");
			wrightcsvheader.ballotboxnumber = props.getProperty("f1_s2_ballotboxnumber");
			wrightcsvheader.ballotstartnumber = props.getProperty("f1_s2_ballotstartnumber");
			wrightcsvheader.ballotendnumber = props.getProperty("f1_s2_ballotendnumber");
			wrightcsvheader.tenderstartnumber = props.getProperty("f1_s2_tenderstartnumber");
			wrightcsvheader.tenderendnumber = props.getProperty("f1_s2_tenderendnumber");
			wrightcsvheader.rowstatus = "Status";
			headerList.add(wrightcsvheader);
		}		
		else{
			wrightcsvheader.ward = "CODE0000";
			headerList.add(wrightcsvheader);
		}
		return headerList;
	}
	
	private int UploadRow(String token,CsvStructureTwoDetails request,int electionId) throws Exception {
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;	
		int resp = 0;
		try {
			//stored procedure calling statement
			String callString = "{call psm.csvsecondstructure(?,?,?,?,?,?,?,?,?,?,?)}";
			conn = DatabaseConnectionManager.getConnection();
			cs = conn.prepareCall(callString);
			// Adding items to arrayList
			cs.setString(1,token);
			cs.setString(2,request.ward);
			cs.setString(3,request.district);
			cs.setString(4,request.place);
			cs.setString(5,request.stationname);
			cs.setString(6,request.ballotstartnumber);
			cs.setString(7,request.ballotendnumber);
			cs.setString(8,request.ballotboxnumber);
			cs.setString(9,request.tenderstartnumber);
			cs.setString(10,request.tenderendnumber);
			cs.setString(11,electionId+"");

			//assigning resluts to ResultSet
			rs = cs.executeQuery();

			while(rs.next()){
				String res = rs.getString("response");
				if (res.equals("success")) resp++;
				else if(res.equals("duplicatedata")) {}
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
