package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.NotificationDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.NotificationDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.IssueReportAllStationRequest;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.NotificationService;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.util.models.NotificationDto;
import com.mdl.mdlrestapi.util.models.NotificationResultDto;
import com.mdl.mdlrestapi.util.models.PollingStationDto;
import org.apache.log4j.Logger;

import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 2:36 PM
 * To change this template use File | Settings | File Templates.
 */
public class NotificationServiceImpl implements NotificationService {
    private static final Logger logger = Logger.getLogger(NotificationServiceImpl.class);

	CommonDao commonDao = new CommonDaoImpl();
    NotificationDao notificationDao = new NotificationDaoImpl();

    @Override
    public String getNotificationPulse(String token) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] = token;
        return commonDao.getResultStringObject(SQLUtil.GET_NOTIFICATION_PULSE, params);
    }

    /**
     * Get Top notifications
     *
     * @param token
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getNotificationTop(String token) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] = token;
        return commonDao.getResultStringArray(SQLUtil.GET_NOTIFICATION_TOP, params);
    }

    /**
     * Get All notifications
     *
     * @param token
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getNotificationAll(String token) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] = token;
        return commonDao.getResultStringArray(SQLUtil.GET_NOTIFICATION_ALL, params);

    }

    /**
     * @param token
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getNotificationRead(String token, int notificationId) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] = token;
        params[1] = notificationId;
        return commonDao.getResultStringObject(SQLUtil.GET_NOTIFICATION_READ, params);
    }
    
    
    @Override
	public String getNotificationCount(TokenRequest request) throws MDLDBException {
    	Object [] params = new Object[1];
        params[0] = request.getToken();
        return commonDao.getResultStringObject(SQLUtil.GET_NOTIFICATION_COUNT, params);
	}

    /**
     * @param token
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getNotificationById(String token, int notificationId) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] = token;
        params[1] = notificationId;
        return commonDao.getResultStringObject(SQLUtil.GET_NOTIFICATION_BY_ID, params);
    }

    /**
     * Get global notifications
     *
     * @param token
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getGlobalNotifications(String token) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] = token;
        return commonDao.getResultStringArray(SQLUtil.GET_GLOBAL_NOTIFICATION, params);
    }

    // save uploaded file to new location
    public void writeToFile(InputStream uploadedInputStream,
                             String relativePath) {

        //String path = props.getProperty("baseUrl");
        StringBuilder sb = new StringBuilder();
        sb.append(ConfigUtil.BASE_URL + relativePath);
        String uploadedFileLocation = sb.toString();

        try {
            int read = 0;
            byte[] bytes = new byte[1024];

            OutputStream out = new FileOutputStream(new File(uploadedFileLocation));
            while ((read = uploadedInputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e);
            //e.printStackTrace();
        }
    }

    @Override
    public ArrayList<NotificationDto> getFilteredResults(int hierarchyId, String token) throws Exception {
        return notificationDao.getFilteredResults(hierarchyId,token);
    }

    @Override
    public void saveToDbNotification(String uploadedFileLocation,String station_id, String hierarchyId, String description, String token) throws Exception{
        notificationDao.saveToDbNotification(uploadedFileLocation,station_id ,hierarchyId, description, token);
    }

    @Override
    public ArrayList<Integer> getUserIdList(int orgId, int stationId) throws Exception {
        return notificationDao.getUserIdList(orgId,stationId);
    }

    @Override
    public String getAllPollingStationList(int hierarchyId,int orgId) throws Exception {
        return notificationDao.getAllPollingStationList(hierarchyId,orgId);
    }

    @Override
    public ArrayList<PollingStationDto> getActivePollingStationList(int hierarchyId, String token) throws Exception {
        return notificationDao.getActivePollingStationList(hierarchyId,token);
    }

    @Override
    public String getActivePollingStationListString(int hierarchyId,String token) throws Exception {
        return notificationDao.getActivePollingStationListString(hierarchyId,token);
    }

    @Override
    public String getActiveUserListForStationList(String stationList,int orgId) throws Exception {
        return notificationDao.getActiveUserListForStationList(stationList,orgId);
    }

    @Override
    public ArrayList<Integer> getActiveUserIdArrayForStationList(String stationList,int orgId) throws Exception {
        return notificationDao.getActiveUserIdArrayForStationList(stationList,orgId);
    }
}
