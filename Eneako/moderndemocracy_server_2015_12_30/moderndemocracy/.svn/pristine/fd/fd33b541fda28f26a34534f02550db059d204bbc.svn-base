package com.moderndemocracy.pojo;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.DashboardUsersMarshaler;

public class DashboardUsers implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(DashboardUsers.class);

	public static final String CHART  = "chart";
	public static final String TOTAL  = "total";
	public static final String AGE    = "age";
	public static final String GENDER = "gender";
	
	private List<DashboardChart> dashboardChart;
	private DashboardTotal dashboardTotal;
	private List<DashboardAge> dashboardAge;
	private List<DashboardGender> dashboardGender;
	

	public List<DashboardChart> getDashboardChart() {
		return dashboardChart;
	}

	public void setDashboardChart(List<DashboardChart> dashboardChart) {
		this.dashboardChart = dashboardChart;
	}

	public DashboardTotal getDashboardTotal() {
		return dashboardTotal;
	}

	public void setDashboardTotal(DashboardTotal dashboardTotal) {
		this.dashboardTotal = dashboardTotal;
	}

	public List<DashboardAge> getDashboardAge() {
		return dashboardAge;
	}

	public void setDashboardAge(List<DashboardAge> dashboardAge) {
		this.dashboardAge = dashboardAge;
	}

	public List<DashboardGender> getDashboardGender() {
		return dashboardGender;
	}

	public void setDashboardGender(List<DashboardGender> dashboardGender) {
		this.dashboardGender = dashboardGender;
	}

	@Override
	public String toString() {
		
		return " DashboardUsers [ "
				
				+ ", chart=" + dashboardChart
				+ ", total=" + dashboardTotal
				+ ", age=" + dashboardAge
				+ ", gender=" + dashboardGender
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new DashboardUsersMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
