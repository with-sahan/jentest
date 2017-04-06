package com.mdl.mdlrestapi.psm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.mdl.mdlrestapi.psm.dao.UserDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;

/**
 * Created by AnushaP on 3/22/2017.
 */
public class UserDaoImpl implements UserDao {
    @Override
    public Map<Integer, String> getPermissions(int roleId) throws MDLDBException {
        String SqlQuery = " select p.id as id, p.url as url from security.url_permission p inner join security.role_url_permission rp\n" +
                "on p.id = rp.permission_id where rp.role_id= ?;";
        Map<Integer, String> permMap = new HashMap<>();

            try (Connection conn = DatabaseConnectionManager.getConnection();
                PreparedStatement preparedStatement = conn.prepareStatement(SqlQuery)) {
                preparedStatement.setInt(1, roleId);
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    while (rs.next()) {
                       permMap.put(rs.getInt("id"),rs.getString("url") );
                    }
                }
            } catch (MDLDBException |SQLException e) {
           throw new MDLDBException(e.getMessage());
        }
        return permMap;
    }
}
