package com.mdl.mdlrestapi.psm.resource;

import com.fasterxml.jackson.databind.MappingIterator;
import com.fasterxml.jackson.dataformat.csv.CsvMapper;
import com.fasterxml.jackson.dataformat.csv.CsvSchema;
import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;
import com.mdl.mdlrestapi.psm.service.MediaService;
import com.mdl.mdlrestapi.psm.service.impl.MediaServiceImpl;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.utils.FileColumnNameUtil;
import com.mdl.mdlrestapi.psm.utils.SecurityUtility;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.csv.*;
import com.mdl.mdlrestapi.util.exception.MDLServerException;
import com.mdl.mdlrestapi.util.exception.UnauthorizedException;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.xml.bind.DatatypeConverter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created with IntelliJ IDEA.
 * User: Lasantha Sahan
 * Date: 3/09/17
 * Time: 6:23 PM
 * To change this template use File | Settings | File Templates.
 */
@Path("/media")
public class MediaResource {

    private static final Logger logger = Logger.getLogger(MediaResource.class);
    MediaService mediaService = new MediaServiceImpl();

    //Code related to upload a photo
    @SuppressWarnings("finally")
    @POST
    @Path("/upload-photo")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response uploadFile(@FormDataParam("file") InputStream uploadedInputStream,
                               @FormDataParam("file") FormDataContentDisposition fileDetail, @QueryParam("stationId") String stationId,
                               @QueryParam("notificationId") String notificationId, @Context HttpHeaders headers)
            throws MDLServerException, UnauthorizedException {
        String token = "";
        try {
            token = SecurityUtility.getUsernameAndOrganization(headers);
        } catch (MDLServiceException e) {
            throw new UnauthorizedException(new Throwable("Invalid Request"));
        }
        try {
            if(logger.isDebugEnabled()){
            logger.debug("Query parameters for upload file in 'UploadPhoto' : stationId :" + stationId
                    + " notificationId" + notificationId + " token" + token);
            }

            String uploadedFileLocation = ConfigUtil.UPLOAD_FILE_PATH + fileDetail.getFileName();

            // save it
            mediaService.writeToFile(uploadedInputStream, uploadedFileLocation);
            mediaService.saveToDbNotification(uploadedFileLocation,notificationId,token);

            String output = "File uploaded to : " + uploadedFileLocation;
            return Response.status(200).entity(output).build();
        }catch(Exception ex){
            logger.error(ex);
            throw new MDLServerException(ex);
        }
    }

    @SuppressWarnings("finally")
    @POST
    @Path("/upload-image")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response uploadImage(@FormDataParam("file") String base64encoded, @QueryParam("stationId") String stationId,
                                @Context HttpHeaders headers) throws UnauthorizedException, MDLServerException {
        String token = "";
        try {
            token = SecurityUtility.getUsernameAndOrganization(headers);
        } catch (MDLServiceException e) {
            throw new UnauthorizedException(new Throwable("Invalid Request"));
        }

        try {
            //String path = props.getProperty("uploadFilePath");

            //generating random string to take it as the name when saving the file
            UUID uuid = UUID.randomUUID();
            String fileName = uuid.toString();

            String uploadedFileLocation = ConfigUtil.UPLOAD_FILE_PATH + fileName + ".jpeg";
            String decodebyteArr=new String(DatatypeConverter.parseBase64Binary(base64encoded) , "UTF-8");
            byte[] sourceData = DatatypeConverter
                    .parseBase64Binary(decodebyteArr.substring(decodebyteArr.indexOf(",") + 1));
            InputStream is = new ByteArrayInputStream(sourceData);
            // save it
            mediaService.writeToFile(is, uploadedFileLocation);
            mediaService.saveToDbCamera(uploadedFileLocation,stationId,token);
            //System.out.println(ex);
            JSONObject responseobj = new JSONObject();
            responseobj.put("response", "success");
            return Response.status(200).entity(responseobj.toString()).build();
        } catch (Exception ex) {
            logger.error(ex);
            throw new MDLServerException(ex);
        }
    }

    //Code related to upload a csv file
    CsvStructureOneUtil csvs1f1 = new CsvStructureOneUtil();
    CsvStructureTwoUtil csvs2f1 = new CsvStructureTwoUtil();
    CsvS1FileTwoUtil csvs1f2 = new CsvS1FileTwoUtil();
    CsvS2FileTwoUtil csvs2f2 = new CsvS2FileTwoUtil();
    TsvFileTwo tsvf2 = new TsvFileTwo();

    //Upload the csv file to the server
    @SuppressWarnings("finally")
    @POST
    @Path("/uploadcsv")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response csvFileUpload(@FormDataParam("file") InputStream uploadedInputStream,
                                  @FormDataParam("file") FormDataContentDisposition fileDetail, @Context HttpHeaders headers) throws MDLServerException {
        String token = "";
        try {
            token = SecurityUtility.getUsernameAndOrganization(headers);
        } catch (MDLServiceException e) {
            throw new MDLServerException(new Throwable("Invalid Request"));
        }
        String respStatus="";
        String uploadedFileLocation = "";
        try{
            //String path = props.getProperty("uploadFilePath");
            //String basePath = props.getProperty("baseUrl");
            if(fileDetail.getFileName()!=null){
                StringBuilder sb = new StringBuilder();
                sb.append(ConfigUtil.BASE_URL+ ConfigUtil.UPLOAD_FILE_PATH + fileDetail.getFileName());
                uploadedFileLocation = sb.toString();

                mediaService.writeToFileCSV(uploadedInputStream, uploadedFileLocation);
                respStatus = "success";
            }
        }catch(Exception ex){
            logger.error(ex);
            throw new MDLServerException(ex);
        }

        JSONObject responseobj = new JSONObject();
        responseobj.put("response", respStatus);
        responseobj.put("path", uploadedFileLocation);
        return Response.status(Response.Status.OK).entity(responseobj.toString()).build();

    }

    /*after uploading choosing the correct
    csv file structure and update the database */
    @POST
    @Path("/uploadedcsv")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response UploadedCsv(SimpleRequest request, @Context HttpHeaders headers) throws Exception{

        JSONObject responseobj = new JSONObject();
        try{
            Gson gson=new Gson();

            File input = new File(request.path);
            if(logger.isDebugEnabled()){
            logger.debug("File name : " + input.getName());
            }
            String filetype=mediaService.getFileType(request.path).toLowerCase();

            if("csv".equals(filetype)){
                List<Map<?, ?>> data = readObjectsFromFile(input,',');


                String json = gson.toJson(data);
                JSONArray readary = new JSONArray(json);
                JSONObject oneobj = readary.getJSONObject(0);

                int structureid = mediaService.getCsvStructureId(request.token);
                if(logger.isDebugEnabled()){
                logger.debug("Structure Id : " + structureid);
                }


                //TO DO
                if((oneobj.has(FileColumnNameUtil.FILE1_CONSTITUENCY)) && (request.electionId!=-1) && (structureid==1)){
                    responseobj = csvs1f1.processStructure(readary,request.token,request.electionId);
                }else if(oneobj.has((FileColumnNameUtil.FILE1_S2_WARD)) && (request.electionId!=-1) && (structureid==2)){
                    responseobj = csvs2f1.processCsvStructureTwo(readary,request.token,request.electionId);
                }else if((oneobj.has(FileColumnNameUtil.FILE2_BALLOT_START)) && (structureid==1)){
                    responseobj = csvs1f2.processFileTwo(readary,request.token);
                }else if((oneobj.has(FileColumnNameUtil.FILE2_S2_ROLE)) && (structureid==2)){
                    responseobj = csvs2f2.processFileTwo(readary,request.token,request.electionId);
                }else{
                    responseobj.put("response", "notsupported");
                }
            }else if("tsv".equals(filetype)){
                List<Map<?, ?>> data = readObjectsFromFile(input,'\t');

                String json = gson.toJson(data);
                JSONArray readary = new JSONArray(json);
                JSONObject oneobj = readary.getJSONObject(0);

                //TO DO get the structure values from db.
                if((oneobj.has(FileColumnNameUtil.FILE1_TSV_AREAWARD)) && (mediaService.getCsvStructureId(request.token)==3)){
//					responseobj = csvs1f1.processStructure(readary,request.token,request.electionId);
//				}else if(oneobj.has((props.getProperty("tsv_f2_surname"))) && (getCsvStructureid(request.token)==3)){
                }else if(oneobj.has((FileColumnNameUtil.FILE2_TSV_SURNAME)) ){
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

    public static List<Map<?, ?>> readObjectsFromFile(File file, char seperator) throws IOException {
        CsvSchema bootstrap = CsvSchema.emptySchema().withHeader().withColumnSeparator(seperator);
        CsvMapper csvMapper = new CsvMapper();
        MappingIterator<Map<?, ?>> mappingIterator = csvMapper.reader(Map.class).with(bootstrap).readValues(file);
        return mappingIterator.readAll();
    }



}
