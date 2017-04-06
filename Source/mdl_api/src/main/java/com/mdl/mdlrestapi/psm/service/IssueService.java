package com.mdl.mdlrestapi.psm.service;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.util.models.IssueDtoEntry;
import com.mdl.mdlrestapi.util.models.IssueResultDto;
import com.mdl.mdlrestapi.util.models.ReportIssueAllStationsRequest;
import com.mdl.mdlrestapi.util.models.UserDto;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 8:11 PM
 * To change this template use File | Settings | File Templates.
 */
public interface IssueService {
    /**
     * update issue status
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String updateIssueStatus(ChatIssueResolveRequest request) throws MDLDBException;

    /**
     * Get Chat Issues
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getChatIssue(ChatIssueRequest request)throws MDLDBException;

    /**
     * Get Issues
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getIssues(TokenRequest request)throws MDLDBException;

    /**
     * Get All Issues
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getAllIssues(StationRequest request)throws MDLDBException;
    
    /**
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getAllIssuesEM(TokenRequest request)throws MDLDBException;

    /**
     * Save Report issue
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String saveIssueReport(IssueReportRequest request)throws MDLDBException;

    /**
     * Get assignment counter alert
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getAssignmentCounterAlert(TokenRequest request)throws MDLDBException;



    /**
     * update Report issue
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String updateIssue(IssueRequest request)throws MDLDBException;

    /**
     * Get Issue Resolve GraphStats
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getResolveGraphStats(TokenRequest request) throws MDLDBException;

    /**
     * Get Issue Category GraphStats
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getCategoryGraphStats(TokenRequest request) throws MDLDBException;

    /**
     * Get Issue By Id
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getIssueById(UserIssueRequest request) throws MDLDBException;

    /**
     * Get AllUsers ByIssueId
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getAllUsersByIssueId(UserIssueRequest request) throws MDLDBException;

    /**
     * Get All Users
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getAllUsers(TokenRequest request) throws MDLDBException;

    /**
     * Resolve Issue
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String resolveIssue(IssueDescriptionRequest request) throws MDLDBException;

    /**
     * Get UnTracked Notifications
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getUnTrackedNotifications(TokenRequest request) throws MDLDBException;

    /**
     * Mark Issue Notifications AsWatched
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String markIssueNotificationAsWatched(IssueNotificationRequest request) throws MDLDBException;

    /**
     * Get polling stations
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getPollingStations(TokenRequest request) throws MDLDBException;

    /**
     * Get Issue Count Graph Stats
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String getIssueCountGraphStats(TokenRequest request) throws MDLDBException;

    /**
     * @param token
     * @param hierarchyId
     * @return
     * @throws Exception
     */
    public ArrayList<IssueDtoEntry> getFilterResults(String token, int hierarchyId) throws Exception;

    /**
     * @param token
     * @param issueId
     * @return
     * @throws Exception
     */
    public List<UserDto> processIssueResolvers(String token, int issueId) throws Exception;

    public String reportIssueToAllStations(IssueReportAllStationRequest request) throws Exception;

    public String assignIssue(AssignIssueRequest request) throws MDLDBException;

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public boolean performAssignIssue(AssignIssueRequest request) throws MDLDBException;

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public boolean performReportIssue(ReportIssueAllStationsRequest request) throws MDLDBException;
}
