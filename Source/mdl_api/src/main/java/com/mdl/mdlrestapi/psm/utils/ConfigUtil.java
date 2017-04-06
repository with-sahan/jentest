package com.mdl.mdlrestapi.psm.utils;

import org.apache.log4j.Logger;

import java.util.Properties;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/7/17
 * Time: 12:07 PM
 * To change this template use File | Settings | File Templates.
 */
public class ConfigUtil {

    private static final Logger logger = Logger.getLogger(SecurityUtility.class);
    static Properties props = new Properties();
    public static int EXPIRE_TIME =  3600000;
    public static String SECRET_KEY;
    public static String UPLOAD_FILE_PATH;
    public static String BASE_URL;
    public static String DOWNLOAD_FILE_PATH ;
    public static String SMTP_HOST ;
    public static String EMAIL_FROM ;
    public static String GMAIL_USERNAME ;
    public static String GMAIL_PASSWORD ;
    public static String DOMAINS;


    static {
        try {
            Thread currentThread = Thread.currentThread();
            ClassLoader contextClassLoader = currentThread.getContextClassLoader();
            props.load(contextClassLoader.getResourceAsStream("config.properties"));
            SECRET_KEY = props.getProperty("jwt-secret");
            EXPIRE_TIME = Integer.valueOf(props.getProperty("jwt-expire-time"));
            UPLOAD_FILE_PATH = props.getProperty("uploadFilePath");
            BASE_URL = props.getProperty("baseUrl");
            DOWNLOAD_FILE_PATH = props.getProperty("downloadPath");
            SMTP_HOST = props.getProperty("smtphost");
            EMAIL_FROM = props.getProperty("mailsenderaddress");
            GMAIL_USERNAME =  props.getProperty("gmailusername");
            GMAIL_PASSWORD = props.getProperty("gmailpassword");
            DOMAINS = props.getProperty("allowed-origin");
        } catch (Exception e) {
            logger.error(e);
        }
    }

}
