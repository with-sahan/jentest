package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.DashboardChart;
//import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class DashboardChartExtractor implements ResultExtractor<DashboardChart> {

	public static final String SQL1 =
			"select date_trunc('day',t.created_on)::date as interval, sum(1) ";
	
	public static final String SQL2 =
			"select date_trunc('day',users.updated_on)::date as interval, sum(1) ";
	
	Logger logger = LogManager.getLogger(DashboardChartExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public DashboardChart extract(ResultSet data, int index) throws SQLException {

		DashboardChart extracted = new DashboardChart();
		int i=1;
		
		try {
		
			String xStr = data.getString(i++); 
			extracted.setX(xStr);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date;
			date = sdf.parse(xStr);
			long epoch=date.getTime();
			extracted.setXepoch(epoch);
		
			extracted.setY(data.getInt(i++));
			
			logger.debug("X="+extracted.getX()+", Y="+extracted.getY());

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return extracted;
	}

}
