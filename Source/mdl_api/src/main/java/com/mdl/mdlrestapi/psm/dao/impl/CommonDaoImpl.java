package com.mdl.mdlrestapi.psm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mdl.mdlrestapi.psm.model.UserRole;
import com.mdl.mdlrestapi.psm.dao.CommonDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;

public class CommonDaoImpl implements CommonDao {
    private static final Logger logger = Logger.getLogger(CommonDaoImpl.class);

    @Override
    public String getResultStringArray(String query, Object[] objects) throws MDLDBException {
        final JSONArray jsonArray = new JSONArray();
        DataSource dataSource = null;
        try {
            dataSource = DatabaseConnectionManager.getDataSource();
            QueryRunner run = new QueryRunner(dataSource);
            ResultSetHandler<Object[]> handler = new ResultSetHandler<Object[]>() {
                public Object[] handle(ResultSet rs) throws SQLException {
                    int total_rows = rs.getMetaData().getColumnCount();
                    while (rs.next()) {
                        JSONObject obj = new JSONObject();
                        for (int i = 0; i < total_rows; i++) {
                            obj.put(rs.getMetaData().getColumnLabel(i + 1)
                                    .toLowerCase(), rs.getObject(i + 1));
                        }
                        jsonArray.put(obj);
                    }
                    return null;
                }

                ;
            };
            run.query(query, handler, objects);
            return jsonArray.toString();
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException(e);
        }
    }

    @Override
    public String getResultStringObject(String query, Object[] objects) throws MDLDBException {
        final JSONObject jsonObject = new JSONObject();
        DataSource dataSource = null;
        try {
            dataSource = DatabaseConnectionManager.getDataSource();
            QueryRunner run = new QueryRunner(dataSource);
            ResultSetHandler<Object[]> handler = new ResultSetHandler<Object[]>() {
                public Object[] handle(ResultSet rs) throws SQLException {
                    if (!rs.next()) {
                        return null;
                    }
                    int total_rows = rs.getMetaData().getColumnCount();
                    for (int i = 0; i < total_rows; i++) {
                        jsonObject.put(rs.getMetaData().getColumnLabel(i + 1)
                                .toLowerCase(), rs.getObject(i + 1));
                    }
                    return null;
                }
            };
            run.query(query, handler, objects);
            return jsonObject.toString();
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException(e.getMessage());
        }
    }

	@Override
	public <T> String getResultStringByDto(String query,Object[] objects,T resultDto) throws MDLDBException {
		
		JSONArray jsonArray = null;
		DataSource dataSource = null;
		
		try{
			dataSource = DatabaseConnectionManager.getDataSource();
			QueryRunner run = new QueryRunner(dataSource);
			
			ResultSetHandler<List<T>> h = new BeanListHandler<T>((Class<T>)resultDto.getClass());
			
			List<T> resultSet = run.query(query, h , objects);
			jsonArray = new JSONArray(resultSet);
			return jsonArray.toString();
		}catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException(e.getMessage());
        }
	}

	@Override
	public <T> List<T> getResultListByDto(String query, T resultDto) throws MDLDBException {
		DataSource dataSource = null;
		List<T> result;
		
		try{
			dataSource = DatabaseConnectionManager.getDataSource();
			QueryRunner run = new QueryRunner(dataSource);			
			
			ResultSetHandler<List<T>> h = new BeanListHandler<T>((Class<T>) resultDto.getClass());
			
			result = run.query(query, h);
			
			return result;
		} catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException(e.getMessage());
        }
		
	}

    public  String getPollingStationList(int hierarchyId, int orgId, int userId) throws MDLDBException {
        String role = null;
        String resultString = null;
        boolean isadmin = false;
        String query0 = "SELECT r.name as name FROM security.user_role ur " +
                "inner join security.role r on r.id=ur.role_id " +
                " where ur.user_id=?; ";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement statement1 = conn.prepareStatement(query0)) {
            statement1.setInt(1, userId);
            try (ResultSet rs1 = statement1.executeQuery()) {
                while (rs1.next()) {
                    role = rs1.getString("name");
                }
            }
            if (role.equals(UserRole.SUPER_ADMIN.getRoleName())) {
                isadmin = true;
            }
            resultString = getRecursiveStationList(hierarchyId, orgId, userId, isadmin);
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : " + e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return resultString;
    }

    private  String getRecursiveStationList(int hierarchyId, int orgId, int userId, boolean isAdmin) throws MDLDBException {
        StringBuilder sb = new StringBuilder();
        String query = null;
        int selHrc = 0;
        if (isAdmin) {
            query = "SELECT id FROM psm.polling_station where hierarchy_value_id= ? and organization_id= ?;";
        } else {
            query = "SELECT * FROM psm.polling_station ps " +
                    "inner join psm.user_election ue on ps.id=ue.pollingstation_id " +
                    "where ps.hierarchy_value_id= ? and ps.organization_id= ? and ue.user_id= ? group by pollingstation_id;";
        }
        try (Connection conn = DatabaseConnectionManager.getConnection();         //add all the polling station ids
             PreparedStatement statement1 = conn.prepareStatement(query)) {
            if (isAdmin == true) {
                statement1.setInt(1, hierarchyId);
                statement1.setInt(2, orgId);
            } else {
                statement1.setInt(1, hierarchyId);
                statement1.setInt(2, orgId);
                statement1.setInt(3, userId);
            }
            try (ResultSet rs1 = statement1.executeQuery()) {
                while (rs1.next()) {
                    sb.append(rs1.getInt("id") + ",");
                }
            }
            //now check child hierarchies for this hierachy and recurse
            String query1 = "SELECT id FROM psm.hierarchy_value where parent_id= ? and organization_id= ? ;";
            try (PreparedStatement statement2 = conn.prepareStatement(query1)) {

                statement2.setInt(1, hierarchyId);
                statement2.setInt(2, orgId);
                try (ResultSet rs2 = statement2.executeQuery()) {
                    while (rs2.next()) {
                        selHrc = rs2.getInt("id");
                        sb.append(getRecursiveStationList(selHrc, orgId, userId, isAdmin));
                    }
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : " + e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return sb.toString();
    }




}
