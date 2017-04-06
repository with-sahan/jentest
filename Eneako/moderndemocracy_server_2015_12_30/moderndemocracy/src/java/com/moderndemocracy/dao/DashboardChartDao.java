package com.moderndemocracy.dao;

//import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.error.AnaekoRuntimeException;
import com.anaeko.utils.jdbc.CacheableQuery;
import com.anaeko.utils.jdbc.ParameterDelegate;
import com.moderndemocracy.pojo.DashboardChart;

public class DashboardChartDao {
	

	protected static final Logger logger = LogManager.getLogger(DashboardChartDao.class);


	/********/
	/* SQL */
	/******/
	private static final String SQL_SELECT_DOWNLOADS = DashboardChartExtractor.SQL1 +
			"from track_install t " +
			"where t.created_on >= ? and t.created_on < ? and " +
			"t.council_id=? " +
			"group by interval " +
			"order by interval";
	
	private static final String SQL_SELECT_USERS = DashboardChartExtractor.SQL2 +
			"from users " +
			"where users.updated_on >= ? and users.updated_on < ? and " +
			"users.role_id=1 and " +
			"users.council_id=? " +
			"group by interval " +
			"order by interval";
	
	private static final String SQL_SELECT_REGISTRATIONS = DashboardChartExtractor.SQL1 +
			"from track_register t, users " +
			"where t.created_on >= ? and t.created_on < ? and " +
			"t.user_id=users.id and " + 
			"users.role_id=1 and " +
			"t.council_id=? " +
			"group by interval " +
			"order by interval";
	
	private static final String SQL_SELECT_SOCIALSHARES = DashboardChartExtractor.SQL1 +
			"from track_socialnetwork t, users " +
			"where t.created_on >= ? and t.created_on < ? and " +
			"t.user_id=users.id and " +
			"users.role_id=1 and " +
			"t.council_id=? " +
			"group by interval " +
			"order by interval";
	
	private DataSource pool;

	/**
	 * Constructor.
	 * 
	 * @param pool
	 *            The datasource.
	 */
	public DashboardChartDao(DataSource pool) {
		if (null == pool)
			throw new AnaekoRuntimeException(
					"Cannot create a DAO without a database connection");
		this.pool = pool;
	}

	
	/**
	 * Get Chart info on Downloads
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardChart> getDownloads(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardChart> query = new CacheableQuery<DashboardChart>(pool);
		
		List<DashboardChart> found = query.execute(SQL_SELECT_DOWNLOADS, 
				new DashboardChartExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setTimestamp(1, start);
				statement.setTimestamp(2, end);
				statement.setInt(3, councilId);
			}
		});
		

		return fillEmptyPoints(found,start,end);

	}
	
	
	/**
	 * Get Chart info on Users
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardChart> getUsers(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardChart> query = new CacheableQuery<DashboardChart>(pool);
		
		logger.debug("councilId="+councilId+" start="+start+", end="+end);
		
		List<DashboardChart> found = query.execute(SQL_SELECT_USERS, 
				new DashboardChartExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setTimestamp(1, start);
				statement.setTimestamp(2, end);
				statement.setInt(3, councilId);
			}
		});
		
		
		logger.debug("found originDashboardChart size = "+found.size());
		
		return fillEmptyPoints(found,start,end);

	}
	
	/**
	 * Get Chart info on Registrations
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardChart> getRegistrations(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardChart> query = new CacheableQuery<DashboardChart>(pool);
		
		List<DashboardChart> found = query.execute(SQL_SELECT_REGISTRATIONS, 
				new DashboardChartExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setTimestamp(1, start);
				statement.setTimestamp(2, end);
				statement.setInt(3,councilId);
			}
		});
		

		return fillEmptyPoints(found,start,end);

	}
	
	/**
	 * Get Chart info on Socialshares
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<DashboardChart> getSocialshares(
			final Integer councilId,
			final Timestamp start, 
			final Timestamp end) throws SQLException {
		
		CacheableQuery<DashboardChart> query = new CacheableQuery<DashboardChart>(pool);
		
		List<DashboardChart> found = query.execute(SQL_SELECT_SOCIALSHARES, 
				new DashboardChartExtractor(), new ParameterDelegate() {
			@Override
			public void setParameters(PreparedStatement statement) throws SQLException {
				statement.setTimestamp(1, start);
				statement.setTimestamp(2, end);
				statement.setInt(3,councilId);
			}
		});
		
		return fillEmptyPoints(found,start,end);
	}
	

	protected List<DashboardChart> fillEmptyPoints(
			final List<DashboardChart> originDashboardChart,
			final Timestamp start, 
			final Timestamp end) {
		
		List<DashboardChart> newDashboardChart = new ArrayList<DashboardChart>();
		
		Calendar startCalendar = Calendar.getInstance();
		Calendar endCalendar = Calendar.getInstance();
		
		startCalendar.setTime(new java.sql.Date(start.getTime()));
		endCalendar.setTime(new java.sql.Date(end.getTime()));
		
		SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
		
		////String startDate = ft.format(startCalendar.getTime()); logger.debug("Start="+startDate);
		////String endDate = ft.format(endCalendar.getTime()); logger.debug("End="+endDate);

		// Loop through the Original Dashboard Chart List
		int originalDashboardChartTracking = 0;
		
		while (!startCalendar.after(endCalendar)) {
			
			long secondsSinceEpoch = startCalendar.getTimeInMillis();
			
			String targetDate = ft.format(startCalendar.getTime());
			////logger.debug("Target="+targetDate);
			
			if (originDashboardChart.size()>originalDashboardChartTracking) {
				
				logger.debug("Comparing X="+originDashboardChart.get(originalDashboardChartTracking).getX()+" <=> "+targetDate);
				
				if (originDashboardChart.get(originalDashboardChartTracking).getX().equals(targetDate)) {
					
					logger.debug("Found entry in originDashboardChart("+originDashboardChart.get(originalDashboardChartTracking).getX()+") = "+originDashboardChart.get(originalDashboardChartTracking).getY());
					
					// Insert existing data points
					newDashboardChart.add(originDashboardChart.get(originalDashboardChartTracking));
					
					originalDashboardChartTracking++;
				}
				else {
					
					////logger.debug("Inserting zero into newDashboardChart");
					
					// Insert data point with value = 0
					DashboardChart tmpDashboardChart = new DashboardChart();
					
					//tmpDashboardChart.setX(targetDate);
					tmpDashboardChart.setXepoch(secondsSinceEpoch);
					
					tmpDashboardChart.setY(0);
					
					newDashboardChart.add(tmpDashboardChart);
				}
				
			}
			else {
				////logger.debug("Inserting zero into newDashboardChart");
				
				// Insert data point with value = 0
				DashboardChart tmpDashboardChart = new DashboardChart();
				
				//tmpDashboardChart.setX(targetDate);
				tmpDashboardChart.setXepoch(secondsSinceEpoch);
				
				tmpDashboardChart.setY(0);
				newDashboardChart.add(tmpDashboardChart);
			}

			startCalendar.add(Calendar.DATE, 1);
		}
		
		return newDashboardChart;
	}
	
}
