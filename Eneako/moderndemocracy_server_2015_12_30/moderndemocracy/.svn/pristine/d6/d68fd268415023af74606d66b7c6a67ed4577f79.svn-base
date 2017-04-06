package com.moderndemocracy.jetty.handler;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.anaeko.utils.io.MarshalerException;

public class FileUploadHandler extends ModernDemocracyHandler {
  
    private final String UPLOAD_DIRECTORY = "/var/www/moderndemocracy/en_GB/uploads";
    private static final Logger logger = Logger.getLogger(FileUploadHandler.class);
      
  @Override
	protected String getSupportedMethods() {
		return "POST";
	}
   @Override
    protected void handlePost(String target, HttpServletRequest request, HttpServletResponse response)
            throws MarshalerException, IOException {
      logger.debug("GET UPLOAD -");
        //process only if its multipart content
      String fileName = "";
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(
                                         new DiskFileItemFactory()).parseRequest(request);
              
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        String name = new File(item.getName()).getName();
                        item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
                        fileName = name;
                    }
                }
                
               //File uploaded successfully
               request.setAttribute("message", "File Uploaded Successfully");
            } catch (Exception ex) {
               request.setAttribute("message", "File Upload Failed due to " + ex);
            }          
         
        }else{
            request.setAttribute("message",
                                 "Sorry this Servlet only handles file upload request");
        }
    
      //  request.getRequestDispatcher("/result.jsp").forward(request, response);
     
    }
  
}
