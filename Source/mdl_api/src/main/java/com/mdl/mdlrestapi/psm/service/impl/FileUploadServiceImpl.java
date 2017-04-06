package com.mdl.mdlrestapi.psm.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import org.apache.commons.codec.binary.Base64;

import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.service.FileUploadService;
import com.mdl.mdlrestapi.psm.exception.MDLServiceException;

/**
 * Created by Anuja on 2017-03-06.
 */
public class FileUploadServiceImpl implements FileUploadService {
    @Override
    public String getFileString(String filename) throws MDLServiceException {

        File file = new File(ConfigUtil.DOWNLOAD_FILE_PATH + filename);
        String encodedFile = null;
        try (FileInputStream fileInputStreamReader = new FileInputStream(file)){
            byte[] bytes = new byte[(int) file.length()];
            int count = 0;
            while ((count = fileInputStreamReader.read(bytes)) != -1){
            }
            encodedFile = new String(Base64.encodeBase64(bytes), "UTF-8");
        } catch (IOException e) {
            throw new MDLServiceException(e.getMessage());
        }
        return encodedFile;
    }

}
