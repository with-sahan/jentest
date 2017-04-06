package com.mdl.mdlrestapi.util.database.security;

import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.model.UserRole;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.database.security.entities.Role;
import com.mdl.mdlrestapi.util.database.security.entities.User;
import com.mdl.mdlrestapi.util.database.subscription.SubscriptionQuerryHandler;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SecurityQuerryHandler {
    private static final Logger logger = Logger.getLogger(SecurityQuerryHandler.class);

    /**
     * @param token
     * @return
     * @throws SQLException
     */
    public static int getUserId(String token, int orgid) throws MDLDBException {
        int userid = -1;
        String[] splited = token.split("\\|");
        String username = splited[0];
        if (username != null && username.length() > 0) {
            String query = "SELECT id FROM security.user where username=? and organization_id=?";
            try (Connection conn = DatabaseConnectionManager.getConnection()) {
                try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                    preparedStatement.setString(1, username);
                    preparedStatement.setInt(2, orgid);
                    try (ResultSet rs = preparedStatement.executeQuery()) {
                        while (rs.next()) {
                            userid = rs.getInt("id");
                        }
                        //e.printStackTrace();
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return userid;
    }

    public static boolean isPSIUser(String token) throws Exception {
        String[] splited = token.split("\\|");
        String username = splited[0];
        int orgId = SubscriptionQuerryHandler.getOrganizationId(token);
        int userRoeId = SecurityQuerryHandler.getRoleIdByUserNameAndOrganizationId(username, orgId);
        int pollingStationInspectorRoleId = SecurityQuerryHandler.getPollingStationInspectorRoleIdByOrganizationId(orgId);

        if (userRoeId == pollingStationInspectorRoleId) {
            return true;
        }
        return false;
    }

    public static int getRoleIdByUserNameAndOrganizationId(String userName, int organizationId) throws MDLDBException {
        int roleId = -1;
        if (userName != null && userName.length() > 0 && organizationId > 0) {
            String query = "SELECT ur.role_id FROM security.user as u inner join security.user_role as ur on u.id=ur.user_id and u.organization_id=ur.organization_id where u.username=? and u.organization_id=?";
            try (Connection conn = DatabaseConnectionManager.getConnection()) {
                try (PreparedStatement statement = conn.prepareStatement(query)) {
                    statement.setString(1, userName);
                    statement.setInt(2, organizationId);
                    try (ResultSet rs = statement.executeQuery()) {
                        while (rs.next()) {
                            roleId = rs.getInt("role_id");
                        }
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return roleId;
    }

    public static List<User> getUsersByUserId(String userIdList, int orgId) throws MDLDBException {
        List<User> users = new ArrayList<User>();
        if (orgId > 0 && userIdList != null && userIdList.length() > 0) {

            String query = "SELECT * FROM security.user  where FIND_IN_SET(id, ?) and organization_id=?";
            try (Connection conn = DatabaseConnectionManager.getConnection()) {
                try (PreparedStatement ps = conn.prepareStatement(query)) {
                    ps.setString(1, userIdList);
                    ps.setInt(2, orgId);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            User user = new User();
                            user.setId(rs.getInt("id"));
                            user.setFirstName(rs.getString("firstName"));
                            user.setLastName(rs.getString("lastName"));
                            user.setEmail("email");
                            user.setOrganizationId(rs.getInt("organization_id"));
                            users.add(user);
                        }
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return users;
    }

    public static List<User> getUsersByRoles(String roleList, int orgId) throws MDLDBException {
        List<User> users = new ArrayList<User>();
        if (orgId > 0 && roleList != null && roleList.length() > 0) {
            String query = "SELECT u.* FROM security.role  r inner join security.user_role ur on ur.role_id = r.id inner join security.user u on u.id= ur.user_id where FIND_IN_SET(r.name, ?) and r.organization_id=?";
            try (Connection conn = DatabaseConnectionManager.getConnection()) {
                try (PreparedStatement ps = conn.prepareStatement(query)) {
                    ps.setString(1, roleList);
                    ps.setInt(2, orgId);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            User user = new User();
                            user.setId(rs.getInt("id"));
                            user.setFirstName(rs.getString("firstName"));
                            user.setLastName(rs.getString("lastName"));
                            user.setEmail("email");
                            user.setOrganizationId(rs.getInt("organization_id"));
                            users.add(user);
                        }
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return users;
    }


    public static int getPollingStationInspectorRoleIdByOrganizationId(int orgId) throws MDLDBException {
        int roleId = -1;
        if (orgId > 0) {
            String query = "SELECT id FROM security.role where name=? and organization_id=?;";

            try (Connection conn = DatabaseConnectionManager.getConnection()) {
                try (PreparedStatement ps = conn.prepareStatement(query)) {
                    ps.setString(1, UserRole.POLLING_STATION_INSPECTOR.getRoleName());
                    ps.setInt(2, orgId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            roleId = rs.getInt("id");
                        }
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return roleId;
    }

    /**
     * If List<String> roleList is empty or null, which is giving all roles related to that organization as the output
     * If List<String> roleList is not empty or not null, which is giving all roles related to that organization and roleList as the output
     *
     * @param orgId
     * @return
     * @throws Exception
     */
    public static List<Role> getAllRolesByOrganizationId(int orgId, String[] roleList) throws MDLDBException {
        List<Role> roles = new ArrayList<Role>();
        if (orgId > 0) {
            String query = "";

            if (roleList == null || roleList.length <= 0) {
                query = "SELECT * FROM security.role where organization_id=?";
            } else {
                int lengthOfRoleList = roleList.length;
                query = "SELECT * FROM security.role where organization_id=? and name in (";

                for (int i = 0; i < lengthOfRoleList; i++) {
                    if (i == (lengthOfRoleList - 1)) {
                        query = query.concat("?)");
                    } else {
                        query = query.concat("?,");
                    }
                }
            }

            try (Connection conn = DatabaseConnectionManager.getConnection()) {
                try (PreparedStatement statement = conn.prepareStatement(query)) {
                    statement.setInt(1, orgId);
                    if (roleList != null && roleList.length != 0) {

                    for (int i = 0; i < roleList.length; i++) {
                        statement.setString(i + 2, roleList[i]);
                    }
                    }

                    try (ResultSet rs = statement.executeQuery()) {
                        while (rs.next()) {
                            Role role = new Role();
                            role.setId(rs.getInt("id"));
                            role.setName(rs.getString("name"));
                            role.setOrganizationId(rs.getInt("organization_id"));
                            roles.add(role);
                        }
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return roles;
    }

    /**
     * If List<String> userNames is empty or null, which is giving all users related to that organization as the output
     * If List<String> userNames is not empty or not null, which is giving all users related to that organization and userNames as the output
     *
     * @param orgId
     * @return
     * @throws Exception
     */
    public static List<User> getUsersByUserNames(int orgId, List<String> userNames) throws MDLDBException {
        List<User> users = new ArrayList<User>();
        if (orgId > 0) {
            String query = "";

            if (userNames == null || userNames.isEmpty()) {
                query = "SELECT * FROM security.user where organization_id=?";
            } else {
                int lengthOfUserNames = userNames.size();
                query = "SELECT * FROM security.user where organization_id=? and username in (";

                for (int i = 0; i < lengthOfUserNames; i++) {
                    if (i == (lengthOfUserNames - 1)) {
                        query = query.concat("?)");
                    } else {
                        query = query.concat("?,");
                    }
                }
            }

            try (Connection conn = DatabaseConnectionManager.getConnection()) {
                try (PreparedStatement statement = conn.prepareStatement(query)) {
                    statement.setInt(1, orgId);
                    if (userNames != null && !userNames.isEmpty()) {
                        for (int i = 0; i < userNames.size(); i++) {
                            statement.setString(i + 2, userNames.get(i));
                        }
                    }
                    try (ResultSet rs = statement.executeQuery()) {
                        while (rs.next()) {
                            User user = new User();
                            user.setId(rs.getInt("id"));
                            user.setFirstName(rs.getString("firstName"));
                            user.setLastName(rs.getString("lastName"));
                            user.setEmail("email");
                            user.setOrganizationId(rs.getInt("organization_id"));
                            users.add(user);
                        }
                    }
                }
            } catch (Exception e) {
                throw new MDLDBException("DB Exception " + e.getMessage());
            }
        }
        return users;
    }

}
