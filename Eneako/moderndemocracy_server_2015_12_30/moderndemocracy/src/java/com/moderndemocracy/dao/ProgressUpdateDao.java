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
import com.moderndemocracy.pojo.ProgressUpdate;

public class ProgressUpdateDao {
	

	protected static final Logger logger = LogManager.getLogger(ProgressUpdateDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_PROGRESS_UPDATE_BY_STATION_ID = ProgressUpdateExtractor.SQL
			+ "WHERE id=? ";
	
	private static final String SQL_INSERT_STATION_PROGRESS = 
			"UPDATE polling_station set "					
			+ " ballot_papers_issued=?, "				
			+ " postal_packs_received=?, "
			+ " postal_packs_awaiting_collection=? "
			+ " WHERE id = ? ";
															
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public ProgressUpdateDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}
	

	/**
	 * 
	 * @param stationId
	 * @return
	 * @throws SQLException
	 */
	public ProgressUpdate getProgressUpdateByStationId(final int stationId) throws SQLException {
		
		CacheableQuery<ProgressUpdate> query = new CacheableQuery<ProgressUpdate>(pool);
	
		logger.debug("GetProgressUpdateByStationId("+stationId+")");
		
		List<ProgressUpdate> found = query.execute(SQL_SELECT_PROGRESS_UPDATE_BY_STATION_ID,
				new ProgressUpdateExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement) throws SQLException {
						statement.setInt(1, stationId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found.get(0);
		}
	}

	/**
	 * Insert Station ProgressUpdate
	 * 
	 * @return
	 * @throws SQLException
	 */
	public boolean insertProgressUpdate( DataSource source, int stationId, int numberPapersIssued, int numberPostalPacksReceived, int numberPostalPacksAwaitingCollection ) throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetProgressUpdateInsertParams params = new SetProgressUpdateInsertParams( stationId, numberPapersIssued, numberPostalPacksReceived, numberPostalPacksAwaitingCollection );
		
		logger.debug("About to insert progress update");
		int effected = createQuery.execute( SQL_INSERT_STATION_PROGRESS, params );
		
		if( effected > 0 ) {
			logger.debug("Progress update insertion success");
			return true;
		} else {
			logger.error("Progress update insertion fail");
			return false;
		}
	}
	
	
	private final class SetProgressUpdateInsertParams implements ParameterDelegate {
		
		int stationId;
		int numberPapersIssued;
        int numberPostalPacksReceived;
        int numberPostalPacksAwaitingCollection;
        
        public SetProgressUpdateInsertParams(int stationId, int numberPapersIssued, int numberPostalPacksReceived, int numberPostalPacksAwaitingCollection) {
        	this.stationId = stationId;
        	this.numberPapersIssued = numberPapersIssued;
            this.numberPostalPacksReceived = numberPostalPacksReceived;
            this.numberPostalPacksAwaitingCollection = numberPostalPacksAwaitingCollection;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, numberPapersIssued);     
            statement.setInt(2, numberPostalPacksReceived);
            statement.setInt(3, numberPostalPacksAwaitingCollection);
            statement.setInt(4, stationId);
        }
    }
}
