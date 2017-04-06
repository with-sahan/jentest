package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableQuery;
import com.anaeko.utils.jdbc.CacheableUpdate;
import com.anaeko.utils.jdbc.ParameterDelegate;
import com.moderndemocracy.pojo.Issue;

public class IssueDao {
	

	protected static final Logger logger = LogManager.getLogger(IssueDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_INSERT_NEW_ISSUE = 
			"INSERT into issues (council_id, station_id, reason, description, priority) "
			+ " VALUES (?,?,?,?,?)";

	private static final String SQL_UPDATE_ISSUE_STATUS = 
			"UPDATE issues set resolution=?, status=? "
			+ " WHERE id=?";

	private static final String SQL_SELECT_BY_COUNCIL_ID =
			IssueExtractor.SQL
			//+ " WHERE U.station_id=S.id and "
			+ " WHERE I.station_id= S.id and "
			+ " S.polling_place_id=PP.id and "
			+ " PP.polling_district_id=PD.id and "
			+ " PD.polling_ward_id=W.id and "
			//+ " I.user_id=U.id and "
			+ " I.council_id=? "
			+ " ORDER BY created_on desc";
	
			
	
	private static final String SQL_SELECT_ISSUES_BY_STATION_ID =
			IssueExtractor.SQL
			//+ " WHERE U.station_id=S.id and "
			+ " WHERE I.station_id= S.id and "
			+ " S.polling_place_id=PP.id and "
			+ " PP.polling_district_id=PD.id and "
			+ " PD.polling_ward_id=W.id and "
			+ " S.id=? "
			//+ " I.user_id=U.id "
			+ " ORDER BY created_on desc";

	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public IssueDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException("Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	/**
	 * Insert New Issue
	 * 
	 * @return
	 * @throws SQLException
	 */
	public boolean insertIssue( DataSource source, int councilId, int stationId, String reason, String description, String priority ) 
			throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetIssueInsertParams params = new SetIssueInsertParams( councilId, stationId, reason, description, priority );
		
		logger.debug("About to insert new issue");
		int effected = createQuery.execute( SQL_INSERT_NEW_ISSUE, params );
		
		if( effected > 0 ) {
			logger.debug("Successfully inserted new issue");
			return true;
		} else {
			logger.error("Failed to insert new issue");
			return false;
		}
	}
	
	/**
	 * Update Issue Status
	 * 
	 * @param source
	 * @param issueId
	 * @param status
	 * @return
	 * @throws SQLException
	 */
	public boolean updateStatus( DataSource source, Integer issueId, String resolution, Boolean status ) 
			throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetIssueUpdateStatusParams params = new SetIssueUpdateStatusParams( issueId, resolution, status );
		
		logger.debug("About to update issue status - params = "+issueId+","+resolution+","+status);
		int effected = createQuery.execute( SQL_UPDATE_ISSUE_STATUS, params );
		
		if( effected > 0 ) {
			logger.debug("Successfully updated issue "+issueId+" status to "+status);
			return true;
		} else {
			logger.error("Failed to update issue "+issueId+" status to "+status);
			return false;
		}
	}
	
	/**
	 * Get All Issues 
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<Issue> getByCouncilId(final Integer councilId) throws SQLException {
		CacheableQuery<Issue> query = new CacheableQuery<Issue>(pool);
	
		List<Issue> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new IssueExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setInt(1,  councilId);;
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
	
	
	/**
	 * Get by station 
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<Issue> getByStationId(final int id) throws SQLException {
		CacheableQuery<Issue> query = new CacheableQuery<Issue>(pool);
	
		List<Issue> found = query.execute(SQL_SELECT_ISSUES_BY_STATION_ID,
				new IssueExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						statement.setInt(1, id);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
	
	
	/***************/
	/* SET PARAMS */
	/*************/
	
	private final class SetIssueInsertParams implements ParameterDelegate {
		
		int councilId;
		int stationId;
		String reason;
		String description;
		String priority;
        
        public SetIssueInsertParams(int CouncilId, int stationId, String reason, String description, String priority) {

        	this.councilId = CouncilId;
        	this.stationId=stationId;
        	this.reason = reason;
            this.description = description;
            this.priority = priority;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, councilId);
        	statement.setInt(2, stationId);
            statement.setString(3, reason);     
            statement.setString(4, description);
            statement.setString(5, priority);
        }
    }
	
	private final class SetIssueUpdateStatusParams implements ParameterDelegate {
		
		int issueId;
		String resolution;
		boolean status;
        
        public SetIssueUpdateStatusParams(Integer issueId, String resolution, Boolean status ) {
        	this.issueId=issueId;
        	this.status=status;
        	this.resolution=resolution;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setString(1, resolution);
        	statement.setBoolean(2, status);     
            statement.setInt(3, issueId);
        }
    }
	
}
