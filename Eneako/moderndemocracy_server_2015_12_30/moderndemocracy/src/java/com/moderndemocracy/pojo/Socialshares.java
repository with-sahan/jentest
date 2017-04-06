package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.SocialsharesMarshaler;

public class Socialshares implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Socialshares.class);
	
	public static final String FACEBOOK 	  = "facebook";
	public static final String TWITTER 		  = "twitter";

	public static final String FEED 		  = "feed";
	public static final String TITLE 		  = "title";
	public static final String SOCIAL_NETWORK = "socialnetwork";
	public static final String TOTAL          = "total";
	
	private String feed;
	private String title;
	private String socialNetwork;
	private Integer total;
	

	public String getFeed() {
		return feed;
	}

	public void setFeed(String feed) {
		this.feed = feed;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSocialNetwork() {
		return socialNetwork;
	}

	public void setSocialNetwork(String socialNetwork) {
		this.socialNetwork = socialNetwork;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	@Override
	public String toString() {
		
		return " SocialShares [ "
				
				+ ", title=" + title
				+ ", socialNetwork=" + socialNetwork
				+ ", total=" + total
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new SocialsharesMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
