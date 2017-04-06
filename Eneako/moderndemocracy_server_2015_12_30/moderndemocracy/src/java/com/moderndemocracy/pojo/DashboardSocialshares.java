package com.moderndemocracy.pojo;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.DashboardSocialsharesMarshaler;

public class DashboardSocialshares implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(DashboardSocialshares.class);

	public static final String CHART  = "chart";
	public static final String TOTAL  = "total";
	public static final String AGE    = "age";
	public static final String GENDER = "gender";
	public static final String CLICKS = "socialClicks";
	
	public static final String NEWS = "news";
	public static final String EVENTS = "events";
	public static final String CANDIDATES = "candidates";
	public static final String REGISTERS = "registers";
	
	private List<DashboardChart> dashboardChart;
	private DashboardTotal dashboardTotal;
	private List<DashboardAge> dashboardAge;
	private List<DashboardGender> dashboardGender;
	
	private List<Socialshares> news;
	private List<Socialshares> events;
	private List<Socialshares> candidates;
	private List<Socialshares> registers;
	
	private SocialsharesClicks dashboardSocialsharesClicks;
	

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
	
	public SocialsharesClicks getDashboardSocialsharesClicks() {
		return dashboardSocialsharesClicks;
	}

	public void setDashboardSocialsharesClicks(
			SocialsharesClicks dashboardSocialsharesClicks) {
		this.dashboardSocialsharesClicks = dashboardSocialsharesClicks;
	}
	
	public List<Socialshares> getNews() {
		return news;
	}

	public void setNews(List<Socialshares> news) {
		this.news = news;
	}

	public List<Socialshares> getEvents() {
		return events;
	}

	public void setEvents(List<Socialshares> events) {
		this.events = events;
	}

	public List<Socialshares> getCandidates() {
		return candidates;
	}

	public void setCandidates(List<Socialshares> candidates) {
		this.candidates = candidates;
	}

	public List<Socialshares> getRegisters() {
		return registers;
	}

	public void setRegisters(List<Socialshares> registers) {
		this.registers = registers;
	}

	@Override
	public String toString() {
		
		return " DashboardSocialshares [ "
				
				+ ", chart=" + dashboardChart
				+ ", total=" + dashboardTotal
				+ ", age=" + dashboardAge
				+ ", gender=" + dashboardGender
				+ ", news=" + news
				+ ", events=" + events
				+ ", candidates=" + candidates
				+ ", registers=" + registers
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new DashboardSocialsharesMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
