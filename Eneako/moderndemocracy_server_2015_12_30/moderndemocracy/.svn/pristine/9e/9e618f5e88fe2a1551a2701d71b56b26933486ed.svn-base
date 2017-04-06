package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.DashboardSocialsharesMarshaler;

public class SocialsharesClicks implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(SocialsharesClicks.class);

	
	public static final String ARTICLE = "article";
	public static final String TOTAL = "total";
	public static final String FACBOOK = "facebook";
	public static final String TWITTER = "twitter";
	
	private String article;
	private Integer total;
	private Integer facebook;
	private Integer twitter;
	

	public String getArticle() {
		return article;
	}

	public void setArticle(String article) {
		this.article = article;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Integer getFacebook() {
		return facebook;
	}

	public void setFacebook(Integer facebook) {
		this.facebook = facebook;
	}

	public Integer getTwitter() {
		return twitter;
	}

	public void setTwitter(Integer twitter) {
		this.twitter = twitter;
	}

	@Override
	public String toString() {
		
		return " DashboardSocialshares [ "
				+ ", article=" + article
				+ ", total=" + total
				+ ", facebook=" + facebook
				+ ", twitter=" + twitter
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
