package com.mdl.mdlrestapi.util.csv;

import java.io.File;
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

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.dataformat.csv.CsvMapper;
import com.fasterxml.jackson.dataformat.csv.CsvSchema;
import com.mdl.mdlrestapi.util.CsvStructureOneDetails;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;

public class CsvStructureOneUtil {

	//First structure of csv which uploads users and polling satations
	public JSONObject processStructure(JSONArray readary,String token, int electionId) throws Exception{
		JSONObject oneobj = new JSONObject();
		JSONObject responseobj = new JSONObject();
		String respStatus="ERROR";
		int status = 0; //status from the psm.csv_upload table
		List<CsvStructureOneDetails> reportList = getHeaderList(readary);

		if(!reportList.get(0).constituency.equals("CODE0000")){
			status = 3;
			for (int i = 0; i < readary.length(); i++) {
				oneobj = readary.getJSONObject(i);

				CsvStructureOneDetails innerRequest = new CsvStructureOneDetails();

				innerRequest.address = oneobj.getString(FileColumnNameUtil.FILE1_S1_ADDRESS);
				innerRequest.constituency = oneobj.getString(FileColumnNameUtil.FILE1_CONSTITUENCY);
				innerRequest.ward = oneobj.getString(FileColumnNameUtil.FILE1_S1_WARD);
				innerRequest.passwords = oneobj.getString(FileColumnNameUtil.FILE1_S1_PASSWORD);
				innerRequest.username = oneobj.getString(FileColumnNameUtil.FILE1_S1_USERNAME);
				innerRequest.stationname = oneobj.getString(FileColumnNameUtil.FILE1_S1_STATION_NAME);
				innerRequest.ballotboxnumber = oneobj.getString(FileColumnNameUtil.FILE1_S1_BALLOT_BOX_NUMBER);
				innerRequest.contact = oneobj.getString(FileColumnNameUtil.FILE1_S1_CONTACT);
				innerRequest.presidingofficer = oneobj.getString(FileColumnNameUtil.FILE1_S1_PRESIDING_OFFICER);
				innerRequest.place = oneobj.getString(FileColumnNameUtil.FILE1_S1_PLACE);
				innerRequest.district = oneobj.getString(FileColumnNameUtil.FILE1_S1_DISTRICT);
				innerRequest.keyholder = oneobj.getString(FileColumnNameUtil.FILE1_S1_KEY_HOLDER);

				if(oneobj.getString(FileColumnNameUtil.FILE1_CONSTITUENCY).isEmpty()){
					innerRequest.rowstatus = "CODE0001";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_DISTRICT).isEmpty()){
					innerRequest.rowstatus = "CODE0002";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_WARD).isEmpty()){
					innerRequest.rowstatus = "CODE0003";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_PLACE).isEmpty()){
					innerRequest.rowstatus = "CODE0004";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_STATION_NAME).isEmpty()){
					innerRequest.rowstatus = "CODE0005";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_BALLOT_BOX_NUMBER).isEmpty()){
					innerRequest.rowstatus = "CODE0006";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_KEY_HOLDER).isEmpty()){
					innerRequest.rowstatus = "CODE0007";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_ADDRESS).isEmpty()){
					innerRequest.rowstatus = "CODE0008";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_USERNAME).isEmpty()){
					innerRequest.rowstatus = "CODE0016";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_PASSWORD).isEmpty()){
					innerRequest.rowstatus = "CODE0017";
					status = 2;
				}else if (oneobj.getString(FileColumnNameUtil.FILE1_S1_PRESIDING_OFFICER).isEmpty()){
					innerRequest.rowstatus = "CODE0018";
					status = 2;
				}else{
					int resp = UploadRow(token,innerRequest,electionId);
					respStatus="Success";
					//check duplicate data
					if(resp==0){
						innerRequest.rowstatus = "CODE0015";
						status = 2;
					}else{
						innerRequest.rowstatus = "SUCCESS";
					}
				}
				reportList.add(innerRequest);
			}
		}
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString();
		String pathToDb = ConfigUtil.UPLOAD_FILE_PATH;
		String basePath = ConfigUtil.BASE_URL;

		String saveLocation = basePath+pathToDb+"StructureO_" + fileName + ".csv";
		writeToCsvReport(reportList,saveLocation,CsvStructureOneDetails.class);
		saveToDb(token,(pathToDb+"StructureO_" + fileName + ".csv"),electionId,status);

		responseobj.put("response", respStatus);
		return responseobj;			
	}

	private List<CsvStructureOneDetails> getHeaderList(JSONArray readary){

		List<CsvStructureOneDetails> headerList= new ArrayList<CsvStructureOneDetails>();
		CsvStructureOneDetails wrightcsvheader = new CsvStructureOneDetails();

		JSONObject oneobj = readary.getJSONObject(0);
		if(oneobj.has(FileColumnNameUtil.FILE1_CONSTITUENCY)
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_WARD))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_DISTRICT))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_PLACE))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_STATION_NAME))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_ADDRESS))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_USERNAME))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_PASSWORD))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_BALLOT_BOX_NUMBER))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_CONTACT))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_KEY_HOLDER))
				&& (oneobj.has(FileColumnNameUtil.FILE1_S1_PRESIDING_OFFICER))
				){
			wrightcsvheader.constituency = FileColumnNameUtil.FILE1_CONSTITUENCY;
			wrightcsvheader.ward = FileColumnNameUtil.FILE1_S1_WARD;
			wrightcsvheader.district = FileColumnNameUtil.FILE1_S1_DISTRICT;
			wrightcsvheader.place = FileColumnNameUtil.FILE1_S1_PLACE;
			wrightcsvheader.stationname = FileColumnNameUtil.FILE1_S1_STATION_NAME;
			wrightcsvheader.ballotboxnumber = FileColumnNameUtil.FILE1_S1_BALLOT_BOX_NUMBER;
			wrightcsvheader.contact = FileColumnNameUtil.FILE1_S1_CONTACT;
			wrightcsvheader.username = FileColumnNameUtil.FILE1_S1_USERNAME;
			wrightcsvheader.passwords = FileColumnNameUtil.FILE1_S1_PASSWORD;
			wrightcsvheader.presidingofficer = FileColumnNameUtil.FILE1_S1_PRESIDING_OFFICER;
			wrightcsvheader.address = FileColumnNameUtil.FILE1_S1_ADDRESS;
			wrightcsvheader.keyholder = FileColumnNameUtil.FILE1_S1_KEY_HOLDER;
			wrightcsvheader.rowstatus = "Status";
			headerList.add(wrightcsvheader);
		}		
		else{
			wrightcsvheader.constituency = "CODE0000";
			headerList.add(wrightcsvheader);
		}
		return headerList;
	}

	private int UploadRow(String token,CsvStructureOneDetails request,int electionId) throws Exception {
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;	
		int resp = 0;
		try {
			//stored procedure calling statement
			String callString = "{call psm.csvhierarchyandpollingstations(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			String firstname = "-";
			String lastname = "-";
			conn = DatabaseConnectionManager.getConnection();
			cs = conn.prepareCall(callString);
			// Adding items to arrayList
			cs.setString(1,token);
			cs.setString(2,request.address);
			cs.setString(3,request.district);
			cs.setString(4,request.constituency);
			cs.setString(5,request.stationname);
			cs.setString(6,request.ward);
			cs.setString(7,request.place);
			cs.setString(8,electionId+"");
			cs.setString(9,request.ballotboxnumber);

			if(!request.presidingofficer.equals("")){
				String[] splited = request.presidingofficer.split(" ");
				firstname = splited[0];
				lastname = splited[1];
			}

			cs.setString(10,firstname);
			cs.setString(11,lastname);
			cs.setString(12,request.username);
			cs.setString(13,request.passwords);

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

	@SuppressWarnings("rawtypes")
	static void writeToCsvReport(List<?> csvrowarray,String path,Class mapperclass) throws JsonGenerationException, JsonMappingException, IOException {
		CsvMapper mapper = new CsvMapper();
		CsvSchema schema = mapper.schemaFor(mapperclass);
		ObjectWriter writer = mapper
				.writer(schema.withLineSeparator("\n"));
		writer.writeValue(new File(path), csvrowarray);
	}
	
	@SuppressWarnings("rawtypes")
	static void writeToTsvReport(List<?> tsvrowarray,String path,Class mapperclass) throws JsonGenerationException, JsonMappingException, IOException {
		CsvMapper mapper = new CsvMapper();
		CsvSchema schema = mapper.schemaFor(mapperclass);
		ObjectWriter writer = mapper
				.writer(schema.withLineSeparator("\n").withColumnSeparator('\t'));
		writer.writeValue(new File(path), tsvrowarray);
	}

	static void saveToDb(String token,String path,int electionId,int status) throws Exception {
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		//stored procedure calling statement
		String callString = "{call psm.csvsavereport(?,?,?,?)}";
		try {
			conn = DatabaseConnectionManager.getConnection();
			cs = conn.prepareCall(callString);
			// Adding items to arrayList
			cs.setString(1,token);
			cs.setString(2,path);
			cs.setString(3,electionId+"");
			cs.setString(4,status+"");
			
			rs = cs.executeQuery();
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
		
	}
}
