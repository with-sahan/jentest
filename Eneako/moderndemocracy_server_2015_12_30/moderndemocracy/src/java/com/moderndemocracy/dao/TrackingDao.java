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
import com.moderndemocracy.pojo.Tracking;

public class TrackingDao {
	

	protected static final Logger logger = LogManager.getLogger(TrackingDao.class);
	
	static final int START_TRACKING       = 1;
	static final int TRACKING_IN_PROGRESS = 2;
	static final int TRACKING_COMPLETED   = 3;

	/********/
	/* SQL */
	/******/
	private static final String SQL_UPDATE_TRACKING = 
			"UPDATE tracking set "	
			+ " status=?, "
			+ " lat=?, "
			+ " lng=? "
			+ " WHERE station_id=? and council_id=? ";
										
	private static final String SQL_SELECT_BY_COUNCIL_ID =
			TrackingExtractor.SQL
			+ " WHERE T.station_id=S.id and "
			+ " S.polling_place_id=PP.id and "
			+ " PP.polling_district_id=PD.id and "
			+ " PD.polling_ward_id=W.id and "
			+ " W.council_id=? "
			+ " order by S.id";
//			+ " order by cast(S.ballot_box_no as int)";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public TrackingDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	
	/**
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<Tracking> getByCouncilId(final Integer councilId) throws SQLException {
		CacheableQuery<Tracking> query = new CacheableQuery<Tracking>(pool);
	
		List<Tracking> found = query.execute(SQL_SELECT_BY_COUNCIL_ID,
				new TrackingExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						
						statement.setInt(1, councilId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
	
	/**
	 * Get All Station Setup item
	 * 
	 * @return
	 * @throws SQLException
	 */
	public boolean updateByStationIdAndCouncilId( DataSource source, int stationId, int councilId, int status, double lat, double lng) throws SQLException {

		CacheableUpdate createQuery = new CacheableUpdate(pool);
		
		// Params for SQL
		SetTrackingUpdateParams params = new SetTrackingUpdateParams( stationId, councilId, status, lat, lng );
		
		logger.debug("About to update tracking");
		int effected = createQuery.execute( SQL_UPDATE_TRACKING, params );
		
		StationSetupStatusDao stationDao = new StationSetupStatusDao(source);
		
		// Update Dispatched or Delivered time
		if (status==START_TRACKING) {
			stationDao.insertDispatchedTime(source, stationId);
		}
		else if (status==TRACKING_COMPLETED) {
			stationDao.insertDeliveredTime(source, stationId);
		}
		
		if( effected > 0 ) {
			logger.debug("Successfully updated tracking info for station "+stationId);
			return true;
		} else {
			logger.error("Failed to update tracking info for station "+stationId);
			return false;
		}
	}
	
	
	
	
	private final class SetTrackingUpdateParams implements ParameterDelegate {
		int stationId;
		int councilId;
		int status;
        double lat;
        double lng;
        
        public SetTrackingUpdateParams(int stationId, int councilId, int status, double lat, double lng) {
        	this.stationId = stationId;
        	this.councilId = councilId;
        	this.status = status;
            this.lat = lat;
            this.lng=lng;
        }

        @Override
        public void setParameters(PreparedStatement statement) throws SQLException {
        	statement.setInt(1, status);     
            statement.setDouble(2, lat);
            statement.setDouble(3, lng);;
            statement.setInt(4, stationId);
            statement.setInt(5, councilId);
        }
    }
	
}
