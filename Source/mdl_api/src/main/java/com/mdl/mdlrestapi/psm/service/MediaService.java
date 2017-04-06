package com.mdl.mdlrestapi.psm.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 * Created by lasantha on 3/9/2017.
 */
public interface MediaService {

    /**
     * @param uploadedFileLocation
     * @param stationId
     * @param token
     * @throws Exception
     */
    public void saveToDbCamera(String uploadedFileLocation,String stationId,String token) throws Exception;

    /**
     * @param uploadedFileLocation
     * @param notification_id
     * @param token
     * @throws Exception
     */
    public void saveToDbNotification(String uploadedFileLocation, String notification_id, String token) throws Exception;

    /**
     * @param uploadedInputStream
     * @param relativePath
     * @throws Exception
     */
    public void writeToFile(InputStream uploadedInputStream, String relativePath) throws Exception;

    public String getFileType(String path);

    public void writeToFileCSV(InputStream uploadedInputStream,
                               String uploadedFileLocation) throws Exception;

    public int getCsvStructureId(String token) throws Exception;


}
