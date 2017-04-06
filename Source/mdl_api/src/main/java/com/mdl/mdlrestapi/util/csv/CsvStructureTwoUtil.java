package com.mdl.mdlrestapi.util.csv;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.utils.FileColumnNameUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mdl.mdlrestapi.util.CsvStructureTwoDetails;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;

public class CsvStructureTwoUtil {

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

				innerRow.ward = oneobj.getString(FileColumnNameUtil.FILE1_S2_WARD);
				innerRow.district = oneobj.getString(FileColumnNameUtil.FILE1_S2_DISTRICT);
				innerRow.place = oneobj.getString(FileColumnNameUtil.FILE1_S2_PLACE);
				innerRow.stationname = oneobj.getString(FileColumnNameUtil.FILE1_S2_STATION_NAME);
				innerRow.ballotboxnumber = oneobj.getString(FileColumnNameUtil.FILE1_S2_BALLOT_BOX_NO);
				innerRow.ballotstartnumber = oneobj.getString(FileColumnNameUtil.FILE1_S2_BALLOT_START);
				innerRow.ballotendnumber = oneobj.getString(FileColumnNameUtil.FILE1_S2_BALLOT_END);
				innerRow.tenderstartnumber = oneobj.getString(FileColumnNameUtil.FILE1_S2_TENDER_START);
				innerRow.tenderendnumber = oneobj.getString(FileColumnNameUtil.FILE1_S2_TENDER_END);

				if(oneobj.getString(FileColumnNameUtil.FILE1_S2_WARD).isEmpty()){
					innerRow.rowstatus = "CODE0003";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S2_DISTRICT).isEmpty()){
					innerRow.rowstatus = "CODE0002";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S2_PLACE).isEmpty()){
					innerRow.rowstatus = "CODE0004";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S2_STATION_NAME).isEmpty()){
					innerRow.rowstatus = "CODE0005";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S2_BALLOT_BOX_NO).isEmpty()){
					innerRow.rowstatus = "CODE0006";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S2_BALLOT_START).isEmpty()){
					innerRow.rowstatus = "CODE0010";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S2_BALLOT_END).isEmpty()){
					innerRow.rowstatus = "CODE0011";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S2_TENDER_START).isEmpty()){
					innerRow.rowstatus = "CODE0012";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S2_TENDER_END).isEmpty()){
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
		String pathToDb = ConfigUtil.UPLOAD_FILE_PATH;
		String basePath = ConfigUtil.BASE_URL;
		
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
		if(oneobj.has(FileColumnNameUtil.FILE1_S2_WARD)
				&& (oneobj.has(FileColumnNameUtil.FILE1_S2_DISTRICT))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S2_PLACE))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S2_STATION_NAME))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S2_BALLOT_BOX_NO))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S2_BALLOT_START))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S2_BALLOT_END))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S2_TENDER_START))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S2_TENDER_END))
				){
			wrightcsvheader.ward = FileColumnNameUtil.FILE1_S2_WARD;
			wrightcsvheader.district = FileColumnNameUtil.FILE1_S2_DISTRICT;
			wrightcsvheader.place = FileColumnNameUtil.FILE1_S2_PLACE;
			wrightcsvheader.stationname = FileColumnNameUtil.FILE1_S2_STATION_NAME;
			wrightcsvheader.ballotboxnumber = FileColumnNameUtil.FILE1_S2_BALLOT_BOX_NO;
			wrightcsvheader.ballotstartnumber = FileColumnNameUtil.FILE1_S2_BALLOT_START;
			wrightcsvheader.ballotendnumber = FileColumnNameUtil.FILE1_S2_BALLOT_END;
			wrightcsvheader.tenderstartnumber = FileColumnNameUtil.FILE1_S2_TENDER_START;
			wrightcsvheader.tenderendnumber = FileColumnNameUtil.FILE1_S2_TENDER_END;
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
