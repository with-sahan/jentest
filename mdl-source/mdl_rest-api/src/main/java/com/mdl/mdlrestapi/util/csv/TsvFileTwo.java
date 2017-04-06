package com.mdl.mdlrestapi.util.csv;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mdl.mdlrestapi.util.CsvStructureTwoFileTwoDetails;
import com.mdl.mdlrestapi.util.TsvFileTwoDetails;

public class TsvFileTwo {
	Properties props = new Properties();
	public TsvFileTwo()
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

		List<TsvFileTwoDetails> reportList = getHeaderList(readary);

		if(!reportList.get(0).fname.equals("CODE0000")){
			status = 3;
			for (int i = 0; i < readary.length(); i++) {
				oneobj = readary.getJSONObject(i);
				TsvFileTwoDetails innerRequest = new TsvFileTwoDetails();
				if(oneobj.has(props.getProperty("tsv_f2_fname"))){
					innerRequest.fname = oneobj.getString(props.getProperty("tsv_f2_fname"));
					innerRequest.surname = oneobj.getString(props.getProperty("tsv_f2_surname"));

					if((oneobj.getString(props.getProperty("tsv_f2_fname")).isEmpty()) 
							&& (oneobj.getString(props.getProperty("tsv_f2_surname")).isEmpty()) 
							){
					}else if(oneobj.getString(props.getProperty("tsv_f2_fname")).isEmpty() ||
							(oneobj.getString(props.getProperty("tsv_f2_surname")).isEmpty())
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
		String pathToDb = props.getProperty("uploadFilePath");
		String basePath = props.getProperty("baseUrl");

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
		if(oneobj.has(props.getProperty("tsv_f2_surname")) 
				&& (oneobj.has(props.getProperty("tsv_f2_fname")))
				){
			wrightcsvheader.fname = props.getProperty("tsv_f2_fname");
			wrightcsvheader.surname = props.getProperty("tsv_f2_surname");
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
		String tempName = readary.getJSONObject(i).getString(props.getProperty("tsv_f2_fname")) + readary.getJSONObject(i).getString(props.getProperty("tsv_f2_surname"));
		if(tempName.equals(name)){
			return true;
		}else if(i==0){		
			return false;
		}else{
			return isPrevioulyDefined((i-1),readary,name);
		}
	}
}
