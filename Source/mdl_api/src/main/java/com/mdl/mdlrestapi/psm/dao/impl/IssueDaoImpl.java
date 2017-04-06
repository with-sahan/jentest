package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.dao.IssueDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.model.UserRole;
import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.resource.dto.AssignIssueRequest;
import com.mdl.mdlrestapi.psm.utils.QueryUtil;
import com.mdl.mdlrestapi.psm.utils.ResultSetUtil;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.psm.PsmQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.SecurityQuerryHandler;
import com.mdl.mdlrestapi.util.database.security.entities.Role;
import com.mdl.mdlrestapi.util.database.security.entities.User;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import com.mdl.mdlrestapi.util.models.*;
import org.apache.log4j.Logger;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lasantha on 3/7/2017.
 */
public class IssueDaoImpl implements IssueDao {
    private static final Logger logger = Logger.getLogger(IssueDaoImpl.class);
    private static final String issueResolverList = UserRole.ISSUE_RESOLVER.getRoleName() + "," + UserRole.POLLING_STATION_INSPECTOR.getRoleName() + "," + UserRole.ELECTION_MANAGER.getRoleName();
    private CommonDao commonDao = new CommonDaoImpl();

    public ArrayList<IssueDtoEntry> getFilterResults(String token, int hierarchyId) throws MDLDBException {
        int orgid = 0;
        ArrayList<IssueDtoEntry> issueDtoEntryList = new ArrayList<IssueDtoEntry>();
        //get the organization id
        orgid = SubscriptionQuerryHandler.getOrganizationId(token);
        int userId = SecurityQuerryHandler.getUserId(token, orgid);
        //preapre the polling station list based on the hierarchy
        String stationList = commonDao.getPollingStationList(hierarchyId, orgid, userId).replaceAll(",$", "");
        if (logger.isDebugEnabled()) {
            logger.debug("Get issues by filtering for hierarchyId :" + hierarchyId + "orgid :" + orgid);
        }
        if (stationList != null && stationList.length() > 0) {
            String blrQry = "select isu.id as id,lst.list_value as reason,isu.description as description,isu.priority  "
                    + "as priority,ps.name as pollingstation,ps.id as pollingstationid,ps.hierarchy_value_id as pollingstationhierarchyid,isu.status "
                    + "as issuestatus,concat(usr.firstname,' ',usr.lastname) as asignee,usr.id as userid,isu.createdon as issuedate,'success' as response from psm.issue isu inner join psm.list lst "
                    + "on lst.id=isu.issue_list_id inner join psm.polling_station ps on isu.pollingstation_id=ps.id left outer join psm.issue_assignment ism "
                    + "on isu.id=ism.issue_id left outer join security.user usr on ism.user_id=usr.id "
                    + "where "
//						+ "where  UNIX_TIMESTAMP(isu.createdon) > UNIX_TIMESTAMP(CURDATE())  and  "
                    + "isu.pollingstation_id in (" + stationList + ") and "
                    + "isu.organization_id=? and lst.organization_id=? and ps.organization_id=? order by isu.createdon desc;";

            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement preparedStatement = conn.prepareStatement(blrQry)) {
                preparedStatement.setInt(1, orgid);
                preparedStatement.setInt(2, orgid);
                preparedStatement.setInt(3, orgid);
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    while (rs.next()) {
                        IssueDtoEntry entry = new IssueDtoEntry();
                        entry.asignee = rs.getString("asignee");
                        entry.userid = rs.getString("userid");
                        entry.description = rs.getString("description");
                        entry.id = String.valueOf(rs.getInt("id"));
                        entry.issuestatus = String.valueOf(rs.getInt("issuestatus"));
                        entry.pollingstation = rs.getString("pollingstation");
                        entry.pollingstationhierarchyid = String.valueOf(rs.getInt("pollingstationhierarchyid"));
                        entry.pollingstationid = String.valueOf(rs.getInt("pollingstationid"));
                        entry.priority = String.valueOf(rs.getInt("priority"));
                        entry.reason = rs.getString("reason");
                        entry.issuedate = String.valueOf(rs.getTimestamp("issuedate"));
                        entry.response = rs.getString("response");
                        issueDtoEntryList.add(entry);
                    }
                }
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : " + e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return issueDtoEntryList;
    }

    public List<UserDto> processIssueResolvers(String token, int issueId) throws MDLDBException {
        List<UserDto> users = new ArrayList<UserDto>();
        String[] roleList = {UserRole.ELECTION_MANAGER.getRoleName(), UserRole.POLLING_STATION_INSPECTOR.getRoleName(), UserRole.ISSUE_RESOLVER.getRoleName()};
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
        if (orgId > 0) {
            List<Role> roles = SecurityQuerryHandler.getAllRolesByOrganizationId(orgId, roleList);
            if (roles != null && roles.size() > 0) {
                StringBuffer sb = new StringBuffer();
                boolean firstElement = true;
                for (Role role : roles) {
                    if (issueResolverList.contains(role.getName())) {
                        // add
                        if (!firstElement) {
                            sb.append(",");
                        } else {
                            firstElement = false;
                        }
                        sb.append(role.getId());
                    }
                }
                String roleIdString = sb.toString();
                if (roleIdString != null && roleIdString.length() > 0) {
                    String querry = "call psm.getUsersByRoleIds(?,?)";
                    try (Connection conn = DatabaseConnectionManager.getConnection();
                         PreparedStatement ps = conn.prepareStatement(querry)) {
                        ps.setString(1, token);
                        ps.setString(2, roleIdString);
                        try (ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                UserDto u = new UserDto();
                                u.firstName = rs.getString("firstname");
                                u.lastName = rs.getString("lastname");
                                u.userName = rs.getString("username");
                                u.userId = rs.getInt("id");
                                users.add(u);
                            }
                        }
                        querry = "call psm.getuserbyissueid(?,?)";
                        try (PreparedStatement ps2 = conn.prepareStatement(querry)) {
                            ps2.setInt(1, orgId);
                            ps2.setInt(2, issueId);
                            try (ResultSet rs2 = ps2.executeQuery()) {
                                while (rs2.next()) {
                                    UserDto u = new UserDto();
                                    u.firstName = rs2.getString("firstName");
                                    u.lastName = rs2.getString("lastName");
                                    u.userName = rs2.getString("userName");
                                    u.userId = rs2.getInt("userId");
                                    users.add(u);
                                }
                            }
                        }
                    } catch (SQLException | MDLDBException e) {
                        logger.error("Error : " + e.getMessage());
                        throw new MDLDBException("DB Exception " + e.getMessage());
                    }
                }
            }
        }
        return users;
    }

    @Override
    public String reportIssueToAllStations(IssueReportAllStationRequest request) throws MDLDBException {
        int orgid;
        String username;
        orgid = SubscriptionQuerryHandler.getOrganizationId(request.token);
        String[] splited = (request.token).split("\\|");
        username = splited[0];
        try (Connection conn = DatabaseConnectionManager.getConnection()) {
            String query = QueryUtil.ADD_PSM_ISSUE;
            if (request.pollingstation_id_list.length > 0) {
                for (int station : request.pollingstation_id_list) {
                    try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                        preparedStatement.setInt(1, orgid);
                        preparedStatement.setInt(2, station);
                        preparedStatement.setInt(3, request.issue_list_id);
                        preparedStatement.setString(4, request.description);
                        preparedStatement.setInt(5, request.priority);
                        preparedStatement.setString(6, username);
                        preparedStatement.execute();
                    }
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : " + e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return ResultSetUtil.SUCCESS;
    }


    public boolean performReportIssue(ReportIssueAllStationsRequest request) throws MDLDBException {

        int orgId = SubscriptionQuerryHandler.getOrganizationId(request.token);
        List<User> users = SecurityQuerryHandler
                .getUsersByRoles("Issue Resolver,Polling Station Inspector,Election Manager", orgId);
        if (request.pollingstation_id_list != null) {

            String query = "call psm.reportissue_v2(?,?,?,?,?,?)";
            try (Connection conn = DatabaseConnectionManager.getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {

                StringBuilder stringForQueryUserList = new StringBuilder();
                List<Integer> userId = new ArrayList<Integer>();

                for (User u : users) {
                    if (stringForQueryUserList.length() == 0) {
                        stringForQueryUserList.append(u.getId().toString());
                    } else {
                        stringForQueryUserList.append("," + u.getId().toString());
                    }
                }

                // get user list contain only users assign to selected station
                String queryUserList = "SELECT user_id FROM psm.user_election " + "WHERE pollingstation_id = ? "
                        + "AND user_id IN (" + stringForQueryUserList + ")";
                try (PreparedStatement ps2 = conn.prepareStatement(queryUserList);) {
                    ps2.setInt(1, request.pollingstation_id_list[0]);
                    try (ResultSet rs2 = ps2.executeQuery();) {

                        while (rs2.next()) {
                            userId.add(rs2.getInt("user_id"));
                        }
                    }
                }

                for (int pollingStationId : request.pollingstation_id_list) {
                	
					int electionid = -1;
					if (request.electionid > 0) {
						electionid = request.electionid;
					}

//                    if (!(request.eletioneventid > 0)) {
//                        logger.warn("eletioneventid is null");
//                    }
                    ps.setString(1, request.token);
                    ps.setInt(2, electionid);
                    ps.setInt(3, pollingStationId);
                    ps.setInt(4, request.issue_list_id);
                    ps.setString(5, request.description);
                    ps.setInt(6, request.priority);

                    try (ResultSet rs = ps.executeQuery()) {
                        int issueId = -1;
                        while (rs.next()) {
                            issueId = rs.getInt("response");
                        }
                        if (issueId <= 0) {
                            return false;
                        } else {

                            for (Integer uid : userId) {
                                PsmQuerryHandler.createIssueTrackingNotification(issueId, uid, -1);
                            }

                        }
                    }
                }
                return true;
            } catch (SQLException | MDLDBException e) {
                logger.error("Error : " + e.getMessage());
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return false;
    }


    public boolean performAssignIssue(AssignIssueRequest request) throws MDLDBException {

        int orgId = SubscriptionQuerryHandler.getOrganizationId(request.getToken());
        String userIdList = Integer.toString(request.getUserId());
        List<User> assignedUser = SecurityQuerryHandler.getUsersByUserId(userIdList, orgId);
        List<User> users = SecurityQuerryHandler
                .getUsersByRoles("Issue Resolver,Polling Station Inspector,Election Manager", orgId);
        users.addAll(assignedUser);

        String query = "call psm.assignissue(?,?,?)";

        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, request.getToken());
            ps.setInt(2, request.getIssueId());
            ps.setInt(3, request.getUserId());

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String result = rs.getString("response");
                    if (!result.equalsIgnoreCase("success")) {
                        return false;
                    }

                }
                // insert into issue_tracking
                for (User u : users) {
                    PsmQuerryHandler.createIssueTrackingNotification(request.getIssueId(), u.getId(), -1);
                }
                return true;
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : " + e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
    }


}
