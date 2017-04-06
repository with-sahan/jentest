package com.mdl.mdlrestapi.psm.dao.impl;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mdl.mdlrestapi.psm.dao.LoginDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.psm.model.JWTAccessToken;
import com.mdl.mdlrestapi.psm.model.JWTTokenStatus;
import com.mdl.mdlrestapi.psm.model.User;
import com.mdl.mdlrestapi.psm.model.UserStatus;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import org.apache.log4j.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/16/17
 * Time: 1:00 PM
 * To change this template use File | Settings | File Templates.
 */
public class LoginDaoImpl implements LoginDao {

    private static final Logger logger = Logger.getLogger(LoginDaoImpl.class);


    /**
     * @param username
     * @param organizationName
     * @param password
     * @return
     * @throws Exception
     */
    @Override
    public boolean validatePassword(String username, String organizationName, String password) throws MDLDBException {
        /**
         * TO Do validate password, currently it is done by the Stored procedures (security.login_v2), so not necessary
         * at the moments
         */
        return true;
    }

    /**
     * @param jwtAccessToken
     * @return
     * @throws Exception
     */
    @Override
    public void saveJWTTokenInfo(JWTAccessToken jwtAccessToken) throws MDLDBException {

        String sqlQuery = "INSERT INTO `security`.`jwt_access_token`\n" +
                "(" +
                "`user_name`,\n" +
                "`organization_code`,\n" +
                "`token`,\n" +
                "`status`,\n" +
                "`time_created`,\n" +
                "`validity`)\n" +
                " VALUES (?,?,?,?,?,?)";

        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            ps.setString(1, jwtAccessToken.getUserName());
            ps.setString(2, jwtAccessToken.getOrganizationCode());
            ps.setString(3, jwtAccessToken.getToken());
            ps.setInt(4, jwtAccessToken.getStatus());
            ps.setTimestamp(5, jwtAccessToken.getTimeCreated());
            ps.setInt(6, jwtAccessToken.getValidity());
            ps.execute();
        } catch (Exception e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
    }

    /**
     * @param username
     * @param organizationName
     * @return
     * @throws Exception
     */
    @Override
    public List<JWTAccessToken> getJWTTokenInfo(String username, String organizationName, String tokenSignature) throws MDLDBException {

        JWTAccessToken jwtAccessToken = null;
        List<JWTAccessToken> jwtAccessTokenList = new ArrayList<>();

        String sqlQuery = "\n" +
                "SELECT `user_name` as username,\n" +
                "    `organization_code` as organization,\n" +
                "    `token` as token ,\n" +
                "    `status` as status,\n" +
                "    `time_created` as timeCreated,\n" +
                "    `validity` as validity \n" +
                "FROM `security`.`jwt_access_token` " +
                "where (`user_name` = ? and `organization_code` = ? and token = ? and status = ? )  ";

        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            ps.setString(1, username);
            ps.setString(2, organizationName);
            ps.setString(3, tokenSignature);
            ps.setInt(4, JWTTokenStatus.ACTIVE.getCode());
            try ( ResultSet rs = ps.executeQuery()){
                while (rs.next()) {
                    jwtAccessToken = new JWTAccessToken();
                    jwtAccessToken.setUserName((String) rs.getString("username"));
                    jwtAccessToken.setOrganizationCode((String) rs.getString("organization"));
                    jwtAccessToken.setToken((String) rs.getString("token"));
                    jwtAccessToken.setStatus(rs.getInt("status"));
                    jwtAccessToken.setTimeCreated((Timestamp) rs.getTimestamp("timeCreated"));
                    jwtAccessToken.setValidity(rs.getInt("validity"));
                    jwtAccessTokenList.add(jwtAccessToken);
                }
            }
        } catch (SQLException | MDLDBException  e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return jwtAccessTokenList;
    }

    /**
     * @param username
     * @param organizationName
     * @param password
     * @return
     * @throws Exception
     */
    @Override
    public String createAccessToken(String username, String organizationName, String password) throws MDLDBException {

        String token = null;
        try ( Connection conn = DatabaseConnectionManager.getConnection();
              PreparedStatement ps = conn.prepareCall("{call security.login(?,?,?)}")){
            ps.setString(1, username);
            ps.setString(2, organizationName);
            ps.setString(3, password);
            try (ResultSet rs = ps.executeQuery()){
                while (rs.next()) {
                    token = rs.getString("response");
                }
            }
        } catch (SQLException | MDLDBException  e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return token;

    }

    @Override
    public void deleteJWTToken(String username, String organizationName, String tokenSignature) throws MDLDBException {
        String sqlQuery = "DELETE FROM `security`.`jwt_access_token`\n" +
                " where `user_name` = ? and `organization_code` = ? and token = ?  ";
        try (Connection conn = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sqlQuery)){
            ps.setString(1, username);
            ps.setString(2, organizationName);
            ps.setString(3, tokenSignature);
            ps.executeUpdate();
        } catch (SQLException | MDLDBException  e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Connection Exception " + e.getMessage());
        }
    }

    @Override
    public User findUser(String username, String organizationName) throws MDLDBException {
        String sqlQuery = "\n" +
                " SELECT username, role.roleid as roleId from security.user user  inner join security.user_role userrole on \n" +
                " user.id =userrole.user_id inner join subscription.organization  \n" +
                " organization on organization.id= userrole.organization_id \n" +
                "inner join security.role role on role.id = userrole.role_id" +
                " where  user.username = ? and organization.name=? and user.is_deleted=?";

        User user = null;
        try ( Connection conn = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            ps.setString(1, username);
            ps.setString(2, organizationName);
            ps.setInt(3, UserStatus.ACTIVE.getCode());
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    user = new User();
                    user.setUsername(rs.getString("username"));
                    user.setRoleId(rs.getInt("roleId"));
                }
                if (user == null) {
                    logger.error("No User Found");
                    throw new MDLDBException("No User Found");
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return user;
    }
}
