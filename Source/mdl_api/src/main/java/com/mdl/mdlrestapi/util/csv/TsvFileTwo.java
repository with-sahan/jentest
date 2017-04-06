package com.mdl.mdlrestapi.util.csv;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.utils.FileColumnNameUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mdl.mdlrestapi.util.TsvFileTwoDetails;

public class TsvFileTwo {

	//Second File of structure two csv which uploads the users
	public JSONObject processFileTwo(JSONArray readary,String token,int electionid) throws Exception{
		JSONObject oneobj = new JSONObject();
		JSONObject responseobj = new JSONObject();
		Random random = new Random();
		String respStatus="ERROR";
		int status = 0;

		List<TsvFileTwoDetails> reportList = getHeaderList(readary);

		if(!reportList.get(0).fname.equals("CODE0000")){
			status = 3;
			for (int i = 0; i < readary.length(); i++) {
				oneobj = readary.getJSONObject(i);
				TsvFileTwoDetails innerRequest = new TsvFileTwoDetails();
				if(oneobj.has(FileColumnNameUtil.TVS_F2_FNAME)){
					innerRequest.fname = oneobj.getString(FileColumnNameUtil.TVS_F2_FNAME);
					innerRequest.surname = oneobj.getString(FileColumnNameUtil.TVS_F2_SURNAME);

					if((oneobj.getString(FileColumnNameUtil.TVS_F2_FNAME).isEmpty())
							&& (oneobj.getString(FileColumnNameUtil.TVS_F2_SURNAME).isEmpty())
							){
					}else if(oneobj.getString(FileColumnNameUtil.TVS_F2_FNAME).isEmpty() ||
							(oneobj.getString(FileColumnNameUtil.TVS_F2_SURNAME).isEmpty())
							){
					 	innerRequest.rowstatus = "CODE0016";
						status = 2;
					}else{
						innerRequest.username = innerRequest.fname.substring(0, Math.min(innerRequest.fname.length(), 1))
								+ innerRequest.surname;
						if((i!=0) && 
								(isPrevioulyDefined((i-1),readary,innerRequest.fname+innerRequest.surname))
								){						
						}else{
							innerRequest.passwords = String.valueOf(random.nextInt(999999));
						}
						respStatus="Success";					
					}
					reportList.add(innerRequest);
				}
			}
		}
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString();
		String pathToDb = ConfigUtil.UPLOAD_FILE_PATH;
		String basePath = ConfigUtil.BASE_URL;

		String saveLocation = basePath+pathToDb+"FileTT_" + fileName + ".tsv";
		CsvStructureOneUtil.writeToTsvReport(reportList,saveLocation,TsvFileTwoDetails.class);
		//TO DO
//		CsvStructureOneUtil.saveToDb(token,(pathToDb+"FileTT_" + fileName + ".tsv"),-1,status);

		responseobj.put("response", respStatus);
		return responseobj;	
		
	}

	private List<TsvFileTwoDetails> getHeaderList(JSONArray readary){

		List<TsvFileTwoDetails> headerList= new ArrayList<TsvFileTwoDetails>();
		TsvFileTwoDetails wrightcsvheader = new TsvFileTwoDetails();

		JSONObject oneobj = readary.getJSONObject(0);
		if(oneobj.has(FileColumnNameUtil.TVS_F2_SURNAME)
				&& (oneobj.has(FileColumnNameUtil.TVS_F2_FNAME))
				){
			wrightcsvheader.fname = FileColumnNameUtil.TVS_F2_FNAME;
			wrightcsvheader.surname = FileColumnNameUtil.TVS_F2_SURNAME;
			wrightcsvheader.username = "Username";	
			wrightcsvheader.passwords = "Password";
			wrightcsvheader.rowstatus = "Status";
			headerList.add(wrightcsvheader);
		}else{
			wrightcsvheader.fname = "CODE0000";
			headerList.add(wrightcsvheader);
		}
		return headerList;
	}

	private boolean isPrevioulyDefined(int i,JSONArray readary,String name){
		String tempName = readary.getJSONObject(i).getString(FileColumnNameUtil.TVS_F2_FNAME) + readary.getJSONObject(i).getString(FileColumnNameUtil.TVS_F2_SURNAME);
		if(tempName.equals(name)){
			return true;
		}else if(i==0){		
			return false;
		}else{
			return isPrevioulyDefined((i-1),readary,name);
		}
	}
}
