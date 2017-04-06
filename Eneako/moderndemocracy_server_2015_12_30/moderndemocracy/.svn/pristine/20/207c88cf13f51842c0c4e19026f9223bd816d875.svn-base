package com.moderndemocracy.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableQuery;
import com.anaeko.utils.jdbc.ParameterDelegate;
import com.moderndemocracy.pojo.NotificationList;

public class NotificationListDao {
	

	protected static final Logger logger = LogManager.getLogger(NotificationListDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_BY_WEB_DASHBOARD_USER_ID = 
			NotificationListExtractor.SQL
			//+ "WHERE user_id=? and "
			+ "WHERE "
			+ "N.council_id=? and "
			+ "N.station_id=PS.id and "
			+ "PS.polling_place_id=PP.id and "
			+ "PP.polling_district_id=PD.id and "
			+ "PD.polling_ward_id=W.id "
			+ "ORDER by id desc";
	
	private static final String SQL_SELECT_BY_TABLET_STATION_ID = 
			NotificationListExtractor.SQL
			+ "WHERE (station_id=0 or station_id=?) and "
			+ "N.council_id=? and "
			+ "N.station_id=PS.id and "
			+ "PS.polling_place_id=PP.id and "
			+ "PP.polling_district_id=PD.id and "
			+ "PD.polling_ward_id=W.id "
			+ "ORDER by id desc";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public NotificationListDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	/**
	 * Get All IsseuList item
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<NotificationList> getByWebDashboardUserId(final Integer userId, final Integer councilId) throws SQLException {
		
		CacheableQuery<NotificationList> query = new CacheableQuery<NotificationList>(pool);
	
		List<NotificationList> found = query.execute(SQL_SELECT_BY_WEB_DASHBOARD_USER_ID,
				new NotificationListExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						
//						statement.setInt(1, userId);
//						statement.setInt(2, councilId);
						
						statement.setInt(1, councilId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
	public List<NotificationList> getByTabletStationId(final Integer councilId, final Integer station_id) throws SQLException {
		
		CacheableQuery<NotificationList> query = new CacheableQuery<NotificationList>(pool);
		
		List<NotificationList> found = query.execute(SQL_SELECT_BY_TABLET_STATION_ID,
				new NotificationListExtractor(), new ParameterDelegate() {
					@Override
					public void setParameters(PreparedStatement statement)
							throws SQLException {
						
						statement.setInt(1, station_id);
						statement.setInt(2, councilId);
					}
				});
		
		if (found.isEmpty()) {
			return null;
		} else {
			return found;
		}
	}
	
}
