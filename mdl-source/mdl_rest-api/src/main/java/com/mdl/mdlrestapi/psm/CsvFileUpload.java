package com.mdl.mdlrestapi.psm;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.MappingIterator;
import com.fasterxml.jackson.dataformat.csv.CsvMapper;
import com.fasterxml.jackson.dataformat.csv.CsvSchema;
import com.google.gson.Gson;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.csv.CsvS1FileTwoUtil;
import com.mdl.mdlrestapi.util.csv.CsvS2FileTwoUtil;
import com.mdl.mdlrestapi.util.csv.CsvStructureOneUtil;
import com.mdl.mdlrestapi.util.csv.CsvStructureTwoUtil;
import com.mdl.mdlrestapi.util.csv.TsvFileTwo;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;

@Path("/csvfileservice")
public class CsvFileUpload {
	private static final Logger logger = Logger.getLogger(CsvFileUpload.class);
	CsvStructureOneUtil csvs1f1 = new CsvStructureOneUtil();
	CsvStructureTwoUtil csvs2f1 = new CsvStructureTwoUtil();
	CsvS1FileTwoUtil csvs1f2 = new CsvS1FileTwoUtil();
	CsvS2FileTwoUtil csvs2f2 = new CsvS2FileTwoUtil();
	TsvFileTwo tsvf2 = new TsvFileTwo();
	Properties props = new Properties();
	public CsvFileUpload()
	{
		try {
			Thread currentThread = Thread.currentThread();
			ClassLoader contextClassLoader = currentThread.getContextClassLoader();
			props.load(contextClassLoader.getResourceAsStream("config.properties"));
		} catch (Exception e) {
			logger.error(e);
		}
	}

	//Upload the csv file to the server
	@SuppressWarnings("finally")
	@POST 
	@Path("/uploadcsv")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response csvFileUpload(@FormDataParam("file") InputStream uploadedInputStream,
			@FormDataParam("file") FormDataContentDisposition fileDetail) throws MDLServerException {
		String respStatus="";
		String uploadedFileLocation = "";
		try{
			String path = props.getProperty("uploadFilePath");
			String basePath = props.getProperty("baseUrl");
			if(fileDetail.getFileName()!=null){
				StringBuilder sb = new StringBuilder();
				sb.append(basePath+path + fileDetail.getFileName());
				uploadedFileLocation = sb.toString();

				writeToFile(uploadedInputStream, uploadedFileLocation);
				respStatus = "success";
			}
		}catch(Exception ex){
			logger.error(ex);
			throw new MDLServerException(ex);
		}

		JSONObject responseobj = new JSONObject();
		responseobj.put("response", respStatus);
		responseobj.put("path", uploadedFileLocation);
		return Response.status(Status.OK).entity(responseobj.toString()).build();

	}

	/*after uploading choosing the correct 
	csv file structure and update the database */
	@POST
	@Path("/uploadedcsv")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response UploadedCsv(SimpleRequest request) throws Exception{
		JSONObject responseobj = new JSONObject();
		try{
			Gson gson=new Gson();

			File input = new File(request.path);
			if(getFileType(request.path).toLowerCase().equals("csv")){
				List<Map<?, ?>> data = readObjectsFromFile(input,',');

				String json = gson.toJson(data);
				JSONArray readary = new JSONArray(json);
				JSONObject oneobj = readary.getJSONObject(0);
				//TO DO 
				if((oneobj.has(props.getProperty("f1_s1_constituency"))) && (request.electionId!=-1) && (getCsvStructureid(request.token)==1)){
					responseobj = csvs1f1.processStructure(readary,request.token,request.electionId);
				}else if(oneobj.has((props.getProperty("f1_s2_ward"))) && (request.electionId!=-1) && (getCsvStructureid(request.token)==2)){
					responseobj = csvs2f1.processCsvStructureTwo(readary,request.token,request.electionId);
				}else if((oneobj.has(props.getProperty("f2_ballotstartnumber"))) && (getCsvStructureid(request.token)==1)){
					responseobj = csvs1f2.processFileTwo(readary,request.token);
				}else if((oneobj.has(props.getProperty("f2_s2_role"))) && (getCsvStructureid(request.token)==2)){
					responseobj = csvs2f2.processFileTwo(readary,request.token,request.electionId);
				}else{
					responseobj.put("response", "notsupported");		
				}
			}else if(getFileType(request.path).toLowerCase().equals("tsv")){
				List<Map<?, ?>> data = readObjectsFromFile(input,'\t');

				String json = gson.toJson(data);
				JSONArray readary = new JSONArray(json);
				JSONObject oneobj = readary.getJSONObject(0);
				
				//TO DO get the structure values from db.
				if((oneobj.has(props.getProperty("tsv_f1_areaward"))) && (getCsvStructureid(request.token)==3)){
//					responseobj = csvs1f1.processStructure(readary,request.token,request.electionId);
//				}else if(oneobj.has((props.getProperty("tsv_f2_surname"))) && (getCsvStructureid(request.token)==3)){
				}else if(oneobj.has((props.getProperty("tsv_f2_surname"))) ){
					responseobj = tsvf2.processFileTwo(readary,request.token,request.electionId);
				}				
				responseobj.put("response", "notsupported");
			}else{
				responseobj.put("response", "notsupported");
			}
		}catch(Exception e){
			logger.error(e);
			throw new MDLServerException(e);
		}
		return Response.ok(responseobj.toString()).build();
	}
	private static List<Map<?, ?>> readObjectsFromFile(File file,char seperator) throws IOException {
		CsvSchema bootstrap = CsvSchema.emptySchema().withHeader().withColumnSeparator(seperator);
		CsvMapper csvMapper = new CsvMapper();
		MappingIterator<Map<?, ?>> mappingIterator = csvMapper.reader(Map.class).with(bootstrap).readValues(file);
		return mappingIterator.readAll();
	}
	private String getFileType(String path){
		String[] splited = path.split("\\.");
		return splited[1];
	}

	// save uploaded file to new location
	private void writeToFile(InputStream uploadedInputStream,
			String uploadedFileLocation) throws Exception {

		OutputStream out = new FileOutputStream(new File(
				uploadedFileLocation));
		try {
			int read = 0;
			byte[] bytes = new byte[1024];

			out = new FileOutputStream(new File(uploadedFileLocation));
			while ((read = uploadedInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
		}
		finally{
			out.flush();
			out.close();

		}
	}


	//get the csv structure id
	private int getCsvStructureid(String token) throws Exception {
		Connection conn = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		int res=0;
		//stored procedure calling statement
		String callString = "{call psm.getcsvstructureid(?)}";
		try {
			conn = DatabaseConnectionManager.getConnection();
			cs = conn.prepareCall(callString);
			// Adding items to arrayList
			cs.setString(1,token);			
			rs = cs.executeQuery();
			while(rs.next()){
				res = rs.getInt("csvstructureid");
			}
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
		return res;
	}

}
