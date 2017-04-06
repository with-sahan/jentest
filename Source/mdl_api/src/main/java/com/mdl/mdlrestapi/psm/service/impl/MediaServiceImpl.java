package com.mdl.mdlrestapi.psm.service.impl;

import com.fasterxml.jackson.databind.MappingIterator;
import com.fasterxml.jackson.dataformat.csv.CsvMapper;
import com.fasterxml.jackson.dataformat.csv.CsvSchema;
import com.mdl.mdlrestapi.psm.dao.MediaDao;
import com.mdl.mdlrestapi.psm.dao.impl.MediaDaoImpl;
import com.mdl.mdlrestapi.psm.service.MediaService;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.util.models.UserDto;
import org.apache.log4j.Logger;

import java.io.*;
import java.util.List;
import java.util.Map;

/**
 * Created by lasantha on 3/9/2017.
 */
public class MediaServiceImpl implements MediaService {
    private static final Logger logger = Logger.getLogger(MediaServiceImpl.class);
    MediaDao mediaDao = new MediaDaoImpl();

    public void saveToDbCamera(String uploadedFileLocation,String stationId,String token) throws Exception {
        mediaDao.saveToDbCamera(uploadedFileLocation,stationId, token);
    }

    public void saveToDbNotification(String uploadedFileLocation, String notification_id, String token) throws Exception {
        mediaDao.saveToDbNotification(uploadedFileLocation,notification_id, token);
    }

    public int getCsvStructureId(String token) throws Exception {
        return mediaDao.getCsvStructureId(token);
    }

    // save uploaded file to new location
    public void writeToFile(InputStream uploadedInputStream, String relativePath) throws Exception {

        StringBuilder sb = new StringBuilder();
        sb.append(ConfigUtil.BASE_URL + relativePath);
        String uploadedFileLocation = sb.toString();
        OutputStream out = null;
        try {
            if(logger.isDebugEnabled()){
            logger.debug("Saving location of uploaded file :"+uploadedFileLocation);
            }

            int read = 0;
            byte[] bytes = new byte[1024];

            out = new FileOutputStream(new File(uploadedFileLocation));
            while ((read = uploadedInputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
        } finally {
            if (out != null) {
                out.flush();
                out.close();
            }
        }
    }

    public String getFileType(String path){


        int length = path.length();
        String fileExt = path.substring(length-3);
        //String[] splited = path.split("\\.");
        return fileExt;
    }

    // save uploaded file to new location
    public void writeToFileCSV(InputStream uploadedInputStream,
                             String uploadedFileLocation) throws Exception {

        OutputStream out = null;
        try {
            int read = 0;
            byte[] bytes = new byte[1024];

            out = new FileOutputStream(new File(uploadedFileLocation));
            while ((read = uploadedInputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
        }
        finally{
            if (out != null) {
                out.flush();
                out.close();
            }
        }
    }



}
