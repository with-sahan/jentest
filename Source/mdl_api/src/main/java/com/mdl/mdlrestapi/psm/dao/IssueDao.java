package com.mdl.mdlrestapi.psm.dao;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.resource.dto.AssignIssueRequest;
import com.mdl.mdlrestapi.util.models.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lasantha on 3/7/2017.
 */
public interface IssueDao {

    /**
     * @param token
     * @param hierarchyId
     * @return
     * @throws MDLDBException
     */
    public ArrayList<IssueDtoEntry> getFilterResults(String token, int hierarchyId) throws MDLDBException;

    /**
     * @param token
     * @param issueId
     * @return
     * @throws MDLDBException
     */
    public List<UserDto> processIssueResolvers(String token, int issueId) throws MDLDBException;

    /**
     *
     * @param request
     * @return
     * @throws MDLDBException
     */
    public String reportIssueToAllStations(IssueReportAllStationRequest request)throws MDLDBException;

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public boolean performReportIssue(ReportIssueAllStationsRequest request) throws MDLDBException;

    /**
     * @param request
     * @return
     * @throws Exception
     */
    public boolean performAssignIssue(AssignIssueRequest request) throws MDLDBException;
}
