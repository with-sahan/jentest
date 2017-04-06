package com.moderndemocracy.jetty.handler;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.anaeko.utils.app.Configuration;
import com.anaeko.utils.http.Code;
import com.anaeko.utils.io.MarshalerException;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.core.util.MultivaluedMapImpl; 
import javax.ws.rs.core.MediaType;
import org.apache.log4j.Logger;

public class SendMailHandler extends ModernDemocracyHandler {

    private static final Logger logger = Logger.getLogger(SendMailHandler.class);
    private static final String MAIL_FROM = "mail_from";
    private static final String MAIL_TO = "mail_to";
    private static final String MAIL_SUBJECT = "mail_subject";
    private static final String MAIL_BODY = "mail_body";   

    @Override
    protected String getSupportedMethods() {
        return "POST";
    }

    @Override
    protected void handlePost(String target, HttpServletRequest request, HttpServletResponse response)
            throws MarshalerException, IOException {
        logger.debug("SEND EMAIL -");

        try {

            Configuration payload = readStream(request).asConfiguration();

            String mail_from = payload.getProperty(MAIL_FROM, "");
            String mail_to = payload.getProperty(MAIL_TO, "");
            String mail_subject = payload.getProperty(MAIL_SUBJECT, "");
            String mail_body = payload.getProperty(MAIL_BODY, "");
            
            SendSimpleMessage(mail_from, mail_to, mail_subject, mail_body);
            
        } catch (Exception e) {
            logger.error("Unexpected Exception", e);
            send(request, response).status(Code.SERVER_ERROR_INTERNAL);
        }

    }

    public static ClientResponse SendSimpleMessage(String mail_from, String mail_to, String mail_subject, String mail_body) {
        Client client = Client.create();
        client.addFilter(new HTTPBasicAuthFilter("api","key-510b5d59c84239ae0f67514d7bce74f2"));
        WebResource webResource
                = client.resource("https://api.mailgun.net/v3/alerts.pollingstationmanager.co.uk"
                        + "/messages");
        MultivaluedMapImpl formData = new MultivaluedMapImpl();
        formData.add("from", mail_from);
        formData.add("to", mail_to);        
        formData.add("subject", mail_subject);
        formData.add("text", mail_body);
         ClientResponse clientResponse = webResource.type(MediaType.APPLICATION_FORM_URLENCODED).post(ClientResponse.class, formData);
        String output = clientResponse.getEntity(String.class);
        logger.info("Email sent successfully : " + output);
        return clientResponse;               
        
    }

}
