package com.mdl.mdlrestapi.psm.dao.impl;

import com.mdl.mdlrestapi.psm.dao.PSICheckListDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.models.CheckListUpdateEntry;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by lasantha on 3/7/2017.
 */
public class PSICheckListDaoImpl implements PSICheckListDao {

    private static final Logger logger = Logger.getLogger(PSICheckListDaoImpl.class);

    public boolean performUpdateCheckList(String token, List<CheckListUpdateEntry> dataList) throws MDLDBException {
        boolean allUpdatedSucessfully = false;
        try (Connection conn = DatabaseConnectionManager.getConnection()) {
            for (CheckListUpdateEntry entry : dataList) {
                String query = "call psm.updatepsichecklist(?, ?, ?,?)";
                try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                    preparedStatement.setString(1, token);
                    preparedStatement.setInt(2, entry.placeId);
                    preparedStatement.setInt(3, entry.activityId);
                    preparedStatement.setInt(4, entry.isCompleted);
                    try (ResultSet rs = preparedStatement.executeQuery()) {
                        while (rs.next()) {
                            String result = rs.getString("response");
                            if (result.equalsIgnoreCase("success")) {
                                allUpdatedSucessfully = true;
                            } else {
                                return false;
                            }
                        }
                    }
                }
            }
        } catch (SQLException | MDLDBException e) {
            logger.error("Error : "+ e.getMessage());
            throw new MDLDBException("DB Exception " + e.getMessage());
        }
        return allUpdatedSucessfully;
    }
}
