package com.mdl.mdlrestapi.psm.utils;

import org.apache.log4j.Logger;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 3/7/17
 * Time: 12:07 PM
 * To change this template use File | Settings | File Templates.
 */
 public class FileColumnNameUtil {

        private static final Logger logger = Logger.getLogger(FileColumnNameUtil.class);
        static Properties props = new Properties();
        public static String FILE1_CONSTITUENCY ;
        public static String FILE1_S2_WARD ;
        public static String FILE2_BALLOT_START ;
        public static String FILE2_S2_ROLE ;
        public static String FILE1_TSV_AREAWARD ;
        public static String FILE2_TSV_SURNAME;
        public static String FILE2_ELECTION_NAME;
        public static String FILE2_STATION_NAME;
        public static String FILE2_BALLOT_END ;
        public static String FILE2_TENDERS_START;
        public static String FILE2_TENDERS_END;
        public static String FILE2_S2_STATION_NAME;
        public static String FILE2_S2_PLACE;
        public static String FILE2_S2_FIRSTNAME ;
        public static String FILE2_S2_LASTNAME;
        public static String FILE1_S1_ADDRESS;
        public static String FILE1_S1_WARD ;
        public static String FILE1_S1_PLACE;
        public static String FILE1_S1_STATION_NAME;
        public static String FILE1_S1_PASSWORD;
        public static String FILE1_S1_DISTRICT;
        public static String FILE1_S1_KEY_HOLDER;
        public static String FILE1_S1_PRESIDING_OFFICER;
        public static String FILE1_S1_USERNAME;
        public static String FILE1_S1_BALLOT_BOX_NUMBER;
        public static String FILE1_S1_CONTACT;
        public static String FILE1_S2_DISTRICT;
        public static String FILE1_S2_PLACE;
        public static String FILE1_S2_STATION_NAME;
        public static String FILE1_S2_BALLOT_BOX_NO;
        public static String FILE1_S2_BALLOT_START;
        public static String FILE1_S2_BALLOT_END;
        public static String FILE1_S2_TENDER_START;
        public static String FILE1_S2_TENDER_END;
        public static String TVS_F2_FNAME;
        public static String TVS_F2_SURNAME;
        public static Map<String, String> COLUMNS_MAP = new HashMap<>() ;

        static {
            try {
                Thread currentThread = Thread.currentThread();
                ClassLoader contextClassLoader = currentThread.getContextClassLoader();
                props.load(contextClassLoader.getResourceAsStream("filedata.properties"));

                FILE1_CONSTITUENCY = props.getProperty("f1_s1_constituency");
                FILE1_S1_WARD = props.getProperty("f1_s1_ward");
                FILE1_S2_WARD = props.getProperty("f1_s2_ward");
                FILE1_S2_DISTRICT = props.getProperty("f1_s2_district");
                FILE1_S2_PLACE = props.getProperty("f1_s2_place");
                FILE2_BALLOT_START = props.getProperty("f2_ballotstartnumber");
                FILE2_S2_ROLE = props.getProperty("f2_s2_role");
                FILE1_TSV_AREAWARD = props.getProperty("tsv_f1_areaward");
                FILE2_TSV_SURNAME = props.getProperty("tsv_f2_surname");
                FILE2_ELECTION_NAME = props.getProperty("f2_electionname");
                FILE2_STATION_NAME = props.getProperty("f2_stationname");
                FILE2_BALLOT_END = props.getProperty("f2_ballotendnumber");
                FILE2_TENDERS_START = props.getProperty("f2_tenderstartnumber");
                FILE2_TENDERS_END = props.getProperty("f2_tenderendnumber");
                FILE2_S2_STATION_NAME = props.getProperty("f2_s2_stationname");
                FILE2_S2_PLACE = props.getProperty("f2_s2_place");
                FILE2_S2_FIRSTNAME = props.getProperty("f2_s2_firstname");
                FILE2_S2_LASTNAME = props.getProperty("f2_s2_lastname");
                FILE1_S1_ADDRESS = props.getProperty("f1_s1_address");
                FILE1_S1_PLACE = props.getProperty("f1_s1_place");
                FILE1_S1_STATION_NAME = props.getProperty("f1_s1_stationname");
                FILE1_S1_PASSWORD = props.getProperty("f1_s1_passwords");
                FILE1_S1_DISTRICT= props.getProperty("f1_s1_district");
                FILE1_S1_KEY_HOLDER= props.getProperty("f1_s1_keyholder");
                FILE1_S1_PRESIDING_OFFICER = props.getProperty("f1_s1_presidingofficer");
                FILE1_S1_USERNAME= props.getProperty("f1_s1_username");
                FILE1_S1_BALLOT_BOX_NUMBER = props.getProperty("f1_s1_ballotboxnumber");
                FILE1_S1_CONTACT = props.getProperty("f1_s1_contact");
                FILE1_S2_STATION_NAME= props.getProperty("f1_s2_stationname");
                FILE1_S2_BALLOT_BOX_NO = props.getProperty("f1_s2_ballotboxnumber");
                FILE1_S2_BALLOT_START = props.getProperty("f1_s2_ballotstartnumber");
                FILE1_S2_BALLOT_END = props.getProperty("f1_s2_ballotendnumber");
                FILE1_S2_TENDER_START = props.getProperty("f1_s2_tenderstartnumber");
                FILE1_S2_TENDER_END = props.getProperty("f1_s2_tenderendnumber");
                TVS_F2_FNAME= props.getProperty("tsv_f2_fname");
                TVS_F2_SURNAME= props.getProperty("tsv_f2_surname");


                for (Map.Entry<Object, Object> element : props.entrySet()) {
                    COLUMNS_MAP.put(element.getKey().toString(), element.getValue()
                            .toString());
                }

             } catch (Exception e) {
                logger.error("Error in loading filedata.properties file " + e.getMessage());
            }
        }

    }
