package com.mdl.mdlrestapi.psm.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.dbutils.DbUtils;
import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.psm.dao.ProgressDao;
import com.mdl.mdlrestapi.psm.exception.MDLDBException;
import com.mdl.mdlrestapi.util.database.DatabaseConnectionManager;
import com.mdl.mdlrestapi.util.models.RecordProgressDto;
import com.mdl.mdlrestapi.util.models.UpdateRecordProgressWrapper;

/**
 * Created by lasantha on 3/13/2017.
 */
public class ProgressDaoImpl implements ProgressDao {
    private static final Logger logger = Logger.getLogger(ProgressDaoImpl.class);
    
    
    public boolean performUpdateProgress(UpdateRecordProgressWrapper request)
            throws MDLDBException, SQLException{
    	 Connection conn = null; 
    	 try {
    		 conn = DatabaseConnectionManager.getConnection();       	        
    		 conn.setAutoCommit(false);
    		 for(RecordProgressDto dto : request.recordProgressDtoList){

    		 String result = performUpdateProgress( conn, request.token, request.electionId, request.pollingStationId, dto);
    		 if (!result.equalsIgnoreCase("success")) {
    			 conn.rollback();    		
    		 } 
    		 }
    		 conn.commit();
    		 return true;
    	 } catch (SQLException | MDLDBException e) {
    		 conn.rollback();    	 
             logger.error("Error : "+ e.getMessage());
             throw new MDLDBException("DB Exception " + e.getMessage());
         }finally {
        	DbUtils.close(conn);
         }  		 
    	
    }

	private String performUpdateProgress(Connection conn, String token, int electionId, int pollingStationId,
			RecordProgressDto row) throws MDLDBException {
		String callString = "{call psm.updateprogress_v2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		String res = "";

		try (CallableStatement cs = conn.prepareCall(callString)) {
			// Adding items to arrayList
			cs.setString(1, token);
			cs.setInt(2, electionId);
			cs.setInt(3, pollingStationId);
			cs.setInt(4, row.ballotPapers);
			cs.setInt(5, row.postalPacks);
			cs.setInt(6, row.postalPacksCollected);
			cs.setInt(7, row.spoiltBallots);
			cs.setInt(8, row.tenBallotPapers);
			cs.setInt(9, row.tenSpoiltBallots);
			cs.setInt(10, row.updateTime);
			cs.setInt(11, row.ballotPapers2);
			cs.setInt(12, row.postalPacks2);
			cs.setInt(13, row.postalPacksCollected2);
			cs.setInt(14, row.spoiltBallots2);
			cs.setInt(15, row.tenBallotPapers2);
			cs.setInt(16, row.tenSpoiltBallots2);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					res = rs.getString("response");
				}
			}
		} catch (SQLException e) {
			logger.error("Error : " + e.getMessage());
			throw new MDLDBException("DB Exception " + e.getMessage());
		}
		return res;
	}
}
