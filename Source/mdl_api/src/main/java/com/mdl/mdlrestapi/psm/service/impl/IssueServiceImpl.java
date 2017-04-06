package com.mdl.mdlrestapi.psm.service.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.IssueDao;
import com.mdl.mdlrestapi.psm.dao.impl.CommonDaoImpl;
import com.mdl.mdlrestapi.psm.dao.impl.IssueDaoImpl;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.service.IssueService;
import com.mdl.mdlrestapi.psm.utils.SQLUtil;
import com.mdl.mdlrestapi.util.models.IssueDtoEntry;
import com.mdl.mdlrestapi.util.models.ReportIssueAllStationsRequest;
import com.mdl.mdlrestapi.util.models.UserDto;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 8:11 PM
 * To change this template use File | Settings | File Templates.
 */
public class IssueServiceImpl implements IssueService {
    CommonDao commonDao = new CommonDaoImpl();
    IssueDao issueDao = new IssueDaoImpl();
    /**
     * update issue status
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String updateIssueStatus(ChatIssueResolveRequest request) throws MDLDBException {
        Object [] params = new Object[4];
        params[0] =  request.getToken();
        params[1] =  request.getIssueid();
        params[2] =  request.getIssuestatus();
        params[3] =  request.getDescription();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_CHAT_RESOLVE_ISSUE, params);
    }

    /**
     * Get Chat Issues
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getChatIssue(ChatIssueRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getIssueid();
        return commonDao.getResultStringArray(SQLUtil.GET_CHAT, params);
    }

    /**
     * Get Issues
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getIssues(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ISSUE_LIST, params);
    }

    /**
     * Get All Issues
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getAllIssues(StationRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getStationid();
        return commonDao.getResultStringArray(SQLUtil.GET_ISSUE_ALL, params);
    }

    @Override
	public String getAllIssuesEM(TokenRequest request) throws MDLDBException {
    	Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ALL_ISSUES_EM, params);
	}

	/**
     * Save Report issue
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String saveIssueReport(IssueReportRequest request) throws MDLDBException {
        Object [] params = new Object[6];
        params[0] =  request.getToken();
        params[1] =  request.getElectionid();
        params[2] =  request.getPollingstationid();
        params[3] =  request.getIssueid();
        params[4] =  request.getDescription();
        params[5] =  request.getPriority();
        return commonDao.getResultStringObject(SQLUtil.ADD_ISSUE_REPORT, params);
    }

    /**
     * Get assignment counter alert
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getAssignmentCounterAlert(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringObject(SQLUtil.GET_ASSIGNMENT_COUNT_ALERT, params);
    }

    /**
     * update Issue
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     */
    @Override
    public String updateIssue(IssueRequest request) throws MDLDBException {
        Object [] params = new Object[6];
        params[0] =  request.getToken();
        params[1] =  request.getIssueid();
        params[2] =  request.getUserid();
        params[3] =  request.getStatus();
        params[4] =  request.getPriority();
        params[5] =  request.getComment();
        return commonDao.getResultStringObject(SQLUtil.UPDATE_ISSUE, params);
    }

    /**
     * Get Issue Resolve Graphstats
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getResolveGraphStats(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ISSUE_RESOLVE_GRAPH_STATS, params);
    }


    /**
     * Get Issue Resolve Graphstats
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getCategoryGraphStats(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ISSUE_CATEGORY_GRAPH_STATS, params);
    }

    /**
     * Get Issue ById
     * @param request
     * @return
     * @throws MDLDBException
     */
    @Override
    public String getIssueById(UserIssueRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getIssueid();
        return commonDao.getResultStringObject(SQLUtil.GET_ISSUE_BY_ID, params);
    }

    /**
     * Get All Users By Issue Id
     * @param request
     * @return
     * @throws MDLDBException
     */
    @Override
    public String getAllUsersByIssueId(UserIssueRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getIssueid();
        return commonDao.getResultStringArray(SQLUtil.GET_ALL_USERS_BY_ISSUE_ID, params);
    }

    /**
     * Get All Users
     * @param request
     * @return
     * @throws MDLDBException
     */
    @Override
    public String getAllUsers(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ALL_USERS, params);
    }

    /**
     * Get All Users By Issue Id
     * @param request
     * @return
     * @throws MDLDBException
     */
    @Override
    public String resolveIssue(IssueDescriptionRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] =  request.getIssueid();
        params[2] =  request.getDescription();
        return commonDao.getResultStringArray(SQLUtil.RESOLVE_ISSUE, params);
    }

    /**
     * Get UnTracked Notifications
     * @param request
     * @return
     * @throws MDLDBException
     */
    @Override
    public String getUnTrackedNotifications(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_UNTRACKED_ISSUE_NOTIFICATIONS, params);
    }

    /**
     * Get UnTracked Notifications
     * @param request
     * @return
     * @throws MDLDBException
     */
    @Override
    public String markIssueNotificationAsWatched(IssueNotificationRequest request) throws MDLDBException {
        Object [] params = new Object[2];
        params[0] =  request.getToken();
        params[1] =  request.getIssuenotificationid();
        return commonDao.getResultStringArray(SQLUtil.MARK_ISSUE_NOTIFICATIONS_AS_WATCHED, params);
    }

    /**
     * Get Polling Stations
     * @param request
     * @return
     * @throws MDLDBException
     */
    @Override
    public String getPollingStations(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_POLLING_STATIONS_V2, params);

    }

    /**
     * Get Issues Count Graph Stats
     *
     * @param request
     * @return
     * @throws com.mdl.mdlrestapi.psm.exception.MDLDBException
     *
     */
    @Override
    public String getIssueCountGraphStats(TokenRequest request) throws MDLDBException {
        Object [] params = new Object[1];
        params[0] =  request.getToken();
        return commonDao.getResultStringArray(SQLUtil.GET_ISSUE_COUNT_GRAPH_STATS, params);
    }

    /**
     * @param token
     * @param hierarchyId
     * @return
     * @throws Exception
     */
    @Override
    public ArrayList<IssueDtoEntry> getFilterResults(String token, int hierarchyId) throws Exception {
        return issueDao.getFilterResults(token,hierarchyId);
    }

    /**
     * @param token
     * @param issueId
     * @return
     * @throws Exception
     */
    public List<UserDto> processIssueResolvers(String token, int issueId) throws Exception{
        return issueDao.processIssueResolvers(token,issueId);
    }

    @Override
    public String reportIssueToAllStations(IssueReportAllStationRequest request) throws Exception {
        String response = issueDao.reportIssueToAllStations(request);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("response", response);
        

        return jsonObject.toString();
    }

    @Override
    public String assignIssue(AssignIssueRequest request) throws MDLDBException {
        Object [] params = new Object[3];
        params[0] =  request.getToken();
        params[1] =  request.getIssueId();
        params[2] =  request.getUserId();
        return commonDao.getResultStringObject(SQLUtil.ASSIGN_ISSUE, params);
    }

    @Override
    public boolean performAssignIssue(AssignIssueRequest request) throws MDLDBException{
        return issueDao.performAssignIssue(request);
    }

    @Override
    public boolean performReportIssue(ReportIssueAllStationsRequest request) throws MDLDBException{
        return issueDao.performReportIssue(request);
    }
}
