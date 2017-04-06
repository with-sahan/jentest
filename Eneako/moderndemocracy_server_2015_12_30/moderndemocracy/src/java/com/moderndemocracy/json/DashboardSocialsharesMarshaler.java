package com.moderndemocracy.json;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.DashboardSocialshares;
import com.moderndemocracy.pojo.SocialsharesClicks;
import com.moderndemocracy.pojo.Socialshares;

public final class DashboardSocialsharesMarshaler extends DefaultJsonMarshaler {	
	
	protected static final Logger logger = LogManager.getLogger(DashboardSocialsharesMarshaler.class);
	
	DashboardChartMarshaler dashboardChartMarshaler = new DashboardChartMarshaler();
	DashboardTotalMarshaler dashboardTotalMarshaler = new DashboardTotalMarshaler();
	DashboardAgeMarshaler dashboardAgeMarshaler = new DashboardAgeMarshaler();
	DashboardGenderMarshaler dashboardGenderMarshaler = new DashboardGenderMarshaler();
	
	SocialsharesClicksMarshaler socialsharesClicksMarshaler = new SocialsharesClicksMarshaler();
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (DashboardSocialshares dashboardSocialshares : (Iterable<DashboardSocialshares>) object) {
				marshalDashboardSocialshares(dashboardSocialshares, writer);
			}

			writer.writeEndArray();
			
		} else {
			marshalDashboardSocialshares((DashboardSocialshares) object, writer);
		}
	}

	private void marshalDashboardSocialshares(DashboardSocialshares dashboardSocialshares, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();
		
		// Chart
		if (dashboardSocialshares.getDashboardChart()!=null) {
			writer.writeFieldName(DashboardSocialshares.CHART);
			dashboardChartMarshaler.marshal(dashboardSocialshares.getDashboardChart(), writer);
		}

		// Total
		if (dashboardSocialshares.getDashboardTotal()!=null) {
			writer.writeField(DashboardSocialshares.TOTAL, dashboardSocialshares.getDashboardTotal().getTotal());
		}

		// Age
		if (dashboardSocialshares.getDashboardAge()!=null) {
			writer.writeFieldName(DashboardSocialshares.AGE);
			dashboardAgeMarshaler.marshal(dashboardSocialshares.getDashboardAge(), writer);
		}
		
		// Gender
		if (dashboardSocialshares.getDashboardGender()!=null) {
			writer.writeFieldName(DashboardSocialshares.GENDER);
			dashboardGenderMarshaler.marshal(dashboardSocialshares.getDashboardGender(), writer);
		}
		
		
		/*******************************************************/
		/* Construct SocialNetworkClicks Object for each feed */
		/*****************************************************/
		List<SocialsharesClicks> dashboardSocialsharesClicks = new ArrayList<SocialsharesClicks>();
		
		if (dashboardSocialshares.getNews()!=null) {
			includeSocialsharesClicks(dashboardSocialsharesClicks,dashboardSocialshares.getNews());
		}
		
		if (dashboardSocialshares.getEvents()!=null) {
			includeSocialsharesClicks(dashboardSocialsharesClicks,dashboardSocialshares.getEvents());
		}
		
		if (dashboardSocialshares.getRegisters()!=null) {
			includeSocialsharesClicks(dashboardSocialsharesClicks,dashboardSocialshares.getRegisters());
		}
		
		/************************************************************/
		/* Sort SocialsharesClicks by TotalClicks (Reversed Order) */
		/**********************************************************/
		Collections.sort(dashboardSocialsharesClicks, new Comparator<SocialsharesClicks>() {
		
			public int compare(SocialsharesClicks dashboardSocialsharesClicks1, SocialsharesClicks dashboardSocialsharesClicks2) {
				
				if (dashboardSocialsharesClicks1.getTotal() == dashboardSocialsharesClicks2.getTotal()) {
					return 0;
				}
				
				return dashboardSocialsharesClicks1.getTotal() < dashboardSocialsharesClicks2.getTotal() ? 1 : -1;
			}
			
		});
		
		
		/*************************/
		/* Track Social Network */
		/***********************/
		
		writer.writeFieldName(DashboardSocialshares.CLICKS);
		
		socialsharesClicksMarshaler.marshal(dashboardSocialsharesClicks, writer);
		
		writer.writeEndObject();
	}
	
	private List<SocialsharesClicks> includeSocialsharesClicks(
			
			List<SocialsharesClicks> dashboardSocialsharesClicks,
			List<Socialshares> socialshares) {
		
		String previousTitle = "";
		
		for (Socialshares socialshare : socialshares) {
			
			logger.debug("Dealing with "+socialshare.getFeed()+" - "+socialshare.getTitle());
			
			if (!socialshare.getTitle().equals(previousTitle)) {
				
				// Calculate the TotalClick for previous entry
				if (!previousTitle.equals("")) {
					
					logger.debug("dashboardSocialsharesClicks.size = "+dashboardSocialsharesClicks.size());
					logger.debug("dashboardSocialsharesClicks = "+dashboardSocialsharesClicks);
					
					// Calculate the TotalClicks = ( FacebookClicks + TwitterClicks )
					int facebookClickCount = 0;
					int twitterClickCount =0;
					
					if (dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).getFacebook()!=null) {
						facebookClickCount = dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).getFacebook();
					}
					
					if (dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).getTwitter()!=null) {
						twitterClickCount = dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).getTwitter();
					}
					
					dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).setTotal(facebookClickCount+twitterClickCount);
				}
				
				
				logger.debug("Insert new entry "+socialshare.getTitle());
				
				SocialsharesClicks socialsharesClicks = new SocialsharesClicks();
				socialsharesClicks.setArticle(socialshare.getTitle());
				
				if (socialshare.getSocialNetwork().equals(Socialshares.FACEBOOK)) {
					socialsharesClicks.setFacebook(socialshare.getTotal());
				}
				else if (socialshare.getSocialNetwork().equals(Socialshares.TWITTER)) {
					socialsharesClicks.setTwitter(socialshare.getTotal());
				}
				
				dashboardSocialsharesClicks.add(socialsharesClicks);
				
				previousTitle = socialshare.getTitle();
				
			}
			else {
				
				if (socialshare.getSocialNetwork().equals(Socialshares.FACEBOOK)) {
					dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).setFacebook(socialshare.getTotal());
				}
				else if (socialshare.getSocialNetwork().equals(Socialshares.TWITTER)) {
					dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).setTwitter(socialshare.getTotal());
				}				
			}
		}
		
		logger.debug("dashboardSocialsharesClicks.size = "+dashboardSocialsharesClicks.size());
		logger.debug("dashboardSocialsharesClicks = "+dashboardSocialsharesClicks);
		
		// Calculate the TotalClicks = ( FacebookClicks + TwitterClicks )
		int facebookClickCount = 0;
		int twitterClickCount =0;
		
		if (dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).getFacebook()!=null) {
			facebookClickCount = dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).getFacebook();
		}
		
		if (dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).getTwitter()!=null) {
			twitterClickCount = dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).getTwitter();
		}
		
		dashboardSocialsharesClicks.get(dashboardSocialsharesClicks.size()-1).setTotal(facebookClickCount+twitterClickCount);

		return dashboardSocialsharesClicks;
	}
	
}