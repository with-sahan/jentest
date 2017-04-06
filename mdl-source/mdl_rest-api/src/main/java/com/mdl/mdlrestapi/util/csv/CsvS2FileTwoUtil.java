package com.mdl.mdlrestapi.util.csv;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.mdl.mdlrestapi.util.CsvStructureOneFileTwoDetails;
import com.mdl.mdlrestapi.util.CsvStructureTwoFileTwoDetails;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;

public class CsvS2FileTwoUtil {
	Properties props = new Properties();
	public CsvS2FileTwoUtil()
	{
		try {
			Thread currentThread = Thread.currentThread();
			ClassLoader contextClassLoader = currentThread.getContextClassLoader();
			props.load(contextClassLoader.getResourceAsStream("config.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//Second File of structure two csv which uploads the users
	public JSONObject processFileTwo(JSONArray readary,String token,int electionid) throws Exception{
		JSONObject oneobj = new JSONObject();
		JSONObject responseobj = new JSONObject();
		Random random = new Random();
		String respStatus="ERROR";
		int status = 0;

		List<CsvStructureTwoFileTwoDetails> reportList = getHeaderList(readary);

		if(!reportList.get(0).place.equals("CODE0000")){
			status = 3;
			for (int i = 0; i < readary.length(); i++) {
				oneobj = readary.getJSONObject(i);

				CsvStructureTwoFileTwoDetails innerRequest = new CsvStructureTwoFileTwoDetails();
				if(oneobj.has(props.getProperty("f2_s2_stationname"))){

					innerRequest.place = oneobj.getString(props.getProperty("f2_s2_place"));
					innerRequest.stationname = oneobj.getString(props.getProperty("f2_s2_stationname"));
					innerRequest.role = oneobj.getString(props.getProperty("f2_s2_role"));
					innerRequest.firstname = oneobj.getString(props.getProperty("f2_s2_firstname"));
					innerRequest.lastname = oneobj.getString(props.getProperty("f2_s2_lastname"));

					if((oneobj.getString(props.getProperty("f2_s2_place")).isEmpty()) 
							&& (oneobj.getString(props.getProperty("f2_s2_stationname")).isEmpty()) 
							&& (oneobj.getString(props.getProperty("f2_s2_role")).isEmpty()) 
							){
					}else if(oneobj.getString(props.getProperty("f2_s2_place")).isEmpty()){
						innerRequest.rowstatus = "CODE0004";
						status = 2;
					}else if (oneobj.getString(props.getProperty("f2_s2_stationname")).isEmpty()){
						innerRequest.rowstatus = "CODE0005";
						status = 2;
					}else if (oneobj.getString(props.getProperty("f2_s2_role")).isEmpty()){
						innerRequest.rowstatus = "CODE0019";
						status = 2;
					}else if (!((oneobj.getString(props.getProperty("f2_s2_role")).equals("Presiding Officer "))
							||(oneobj.getString(props.getProperty("f2_s2_role")).equals("Presiding Officer Number 1")))){
						innerRequest.rowstatus = "CODE0019";
						status = 2;
					}else if ( //Checking on of the username or password is not defined
							!(oneobj.getString(props.getProperty("f2_s2_firstname")).isEmpty()) 
							&& (oneobj.getString(props.getProperty("f2_s2_lastname")).isEmpty()) 
							||
							!(oneobj.getString(props.getProperty("f2_s2_lastname")).isEmpty()) 
							&& (oneobj.getString(props.getProperty("f2_s2_firstname")).isEmpty())  							
							){
						innerRequest.rowstatus = "CODE0018";
						status = 2;
					}else{
						innerRequest.firstname = getPrevious(i,readary,"f2_s2_firstname");
						innerRequest.lastname = getPrevious(i,readary,"f2_s2_lastname");
						innerRequest.username = innerRequest.firstname.substring(0, Math.min(innerRequest.firstname.length(), 1))+ innerRequest.lastname;

						if(i!=0){
							if((innerRequest.firstname.equals(getPrevious((i-1),readary,"f2_s2_firstname")))
									&& (innerRequest.lastname.equals(getPrevious((i-1),readary,"f2_s2_lastname")))){}
							else{
								//creating the password with 6 characters 
								innerRequest.passwords = String.valueOf(random.nextInt(999999));
							}
						}else{
							//creating the password with 6 characters 
							innerRequest.passwords = String.valueOf(random.nextInt(999999));
						}

						int resp = UploadRow(token,innerRequest,electionid);
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
		}
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString();
		String pathToDb = props.getProperty("uploadFilePath");
		String basePath = props.getProperty("baseUrl");

		String saveLocation = basePath+pathToDb+"FileT_" + fileName + ".csv";
		CsvStructureOneUtil.writeToCsvReport(reportList,saveLocation,CsvStructureTwoFileTwoDetails.class);
		//TO DO
		CsvStructureOneUtil.saveToDb(token,(pathToDb+"FileT_" + fileName + ".csv"),-1,status);

		responseobj.put("response", respStatus);
		return responseobj;		
	}

	private List<CsvStructureTwoFileTwoDetails> getHeaderList(JSONArray readary){

		List<CsvStructureTwoFileTwoDetails> headerList= new ArrayList<CsvStructureTwoFileTwoDetails>();
		CsvStructureTwoFileTwoDetails wrightcsvheader = new CsvStructureTwoFileTwoDetails();

		JSONObject oneobj = readary.getJSONObject(0);
		if(oneobj.has(props.getProperty("f2_s2_place")) 
				&& (oneobj.has(props.getProperty("f2_s2_stationname")))
				&& (oneobj.has(props.getProperty("f2_s2_role")))
				&& (oneobj.has(props.getProperty("f2_s2_firstname")))
				&& (oneobj.has(props.getProperty("f2_s2_lastname")))
				){
			wrightcsvheader.place = props.getProperty("f2_s2_place");
			wrightcsvheader.stationname = props.getProperty("f2_s2_stationname");
			wrightcsvheader.role = props.getProperty("f2_s2_role");
			wrightcsvheader.firstname = props.getProperty("f2_s2_firstname");
			wrightcsvheader.lastname = props.getProperty("f2_s2_lastname");
			wrightcsvheader.username = "Username";	
			wrightcsvheader.passwords = "Password";
			wrightcsvheader.rowstatus = "Status";
			headerList.add(wrightcsvheader);
		}else{
			wrightcsvheader.place = "CODE0000";
			headerList.add(wrightcsvheader);
		}
		return headerList;
	}

	private int UploadRow(String token,CsvStructureTwoFileTwoDetails request,int electionid) throws Exception {
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;	
		int resp = 0;
		try {
			//stored procedure calling statement
			String callString = "{call psm.csvsecondstructure_v2(?,?,?,?,?,?,?,?,?)}";
			conn = DatabaseConnectionManager.getConnection();
			cs = conn.prepareCall(callString);
			// Adding items to arrayList
			cs.setString(1,token);
			cs.setString(2,request.place);
			cs.setString(3,request.stationname);
			cs.setString(4,request.role);
			cs.setString(5,request.firstname);
			cs.setString(6,request.lastname);
			cs.setString(7,request.username);
			cs.setString(8,request.passwords);	
			cs.setString(9,electionid+"");			

			//assigning resluts to ResultSet
			rs = cs.executeQuery();

			while(rs.next()){
				String res = rs.getString("response");
				if (res.equals("success")) resp=1;
				else if(res.equals("errorename")) resp=2;
				else if(res.equals("errorstationname")) resp=3;
				else return -1;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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

	private String genaratePass(String ramdom){
		SecureRandom rnd = new SecureRandom();
		int len = 6; //set password length
		StringBuilder sb = new StringBuilder( len );
		for( int i = 0; i < len; i++ ) 
			sb.append( ramdom.charAt( rnd.nextInt(ramdom.length()) ) );
		return sb.toString();
	}

	private String getPrevious(int i,JSONArray readary,String Property){
		String value = readary.getJSONObject(i).getString(props.getProperty(Property));
		if(i==0){
			return value;
		}else if(value.isEmpty()){			
			return getPrevious((i-1),readary,Property);
		}
		return value;
	}

}