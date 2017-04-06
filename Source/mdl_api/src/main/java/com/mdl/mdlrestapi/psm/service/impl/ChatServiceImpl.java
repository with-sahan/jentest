package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.ChatDao;
import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.impl.ChatDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.StatisticDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.model.UserRole;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.ChatService;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.util.database.psm.PsmQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.entities.User;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/25/17
 * Time: 12:08 AM
 * To change this template use File | Settings | File Templates.
 */
public class ChatServiceImpl implements ChatService {
    private static final Logger logger = Logger.getLogger(StatisticDaoImpl.class);

    CommonDao commonDao = new CommonDaoImpl();
    ChatDao chatDao = new ChatDaoImpl();
    /**
     * Get Chat count alert
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getChatCountAlert(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringObject(SQLUtil.GET_CHAT_COUNTER_ALERT, params);
    }

    /**
     * Get Chat count alert v1
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getChatCountAlertV1(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringObject(SQLUtil.GET_CHAT_COUNTER_ALERT_V1, params);
    }

    public int saveToDbChat(String uploadedFileLocation, String issueid, String pollingstationid, String chatmessage,
                            String token) throws Exception{
        return chatDao.saveToDbChat(uploadedFileLocation,issueid,pollingstationid,chatmessage,token);
    }



    /**
     * @param token
     * @param issueId
     * @param chatId
     * @return
     * @throws Exception
     */
    public boolean createIssueNotificationsForChat(String token,int issueId,int chatId) throws Exception{

        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);

        //is this issue already assigned to someone?
        User assignedUser = PsmQuerryHandler.getAssignedUserToIssue(issueId);
        String usersToNotify = UserRole.ISSUE_RESOLVER.getRoleName() +","+UserRole.POLLING_STATION_INSPECTOR.getRoleName()+","+UserRole.ELECTION_MANAGER.getRoleName();
        List<User> users = new ArrayList<User>();
        if(assignedUser != null){
            usersToNotify =  UserRole.POLLING_STATION_INSPECTOR.getRoleName()+","+UserRole.ELECTION_MANAGER.getRoleName();
            users.add(assignedUser);
        }
        List<User> users1 = SecurityQuerryHandler.getUsersByRoles(usersToNotify, orgId);
        users.addAll(users1);

        //insert into issue_tracking
        for(User u:users){
            PsmQuerryHandler.createIssueTrackingNotification(issueId, u.getId(), chatId);
        }
        return true;

    }

    /**
     * @param uploadedInputStream
     * @param relativePath
     * @throws Exception
     */
    // save uploaded file to new location
    public void writeToFile(InputStream uploadedInputStream, String relativePath) throws Exception{

        //String path = props.getProperty("baseUrl");
        StringBuilder sb = new StringBuilder();
        sb.append(ConfigUtil.BASE_URL+relativePath);
        String uploadedFileLocation = sb.toString();
        OutputStream out = new FileOutputStream(new File(uploadedFileLocation));
        try {

            int read = 0;
            byte[] bytes = new byte[1024];

            while ((read = uploadedInputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            if(logger.isDebugEnabled()){
            logger.debug("Write to file suceeed.File:" + uploadedFileLocation);
            }
        } finally{
            out.flush();
            out.close();
        }
    }


}
