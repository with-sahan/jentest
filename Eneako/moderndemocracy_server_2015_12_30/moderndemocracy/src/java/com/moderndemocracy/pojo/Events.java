package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.EventsMarshaler;

public class Events implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Events.class);

	public static final String ID = "id";
	public static final String TITLE = "title";
	public static final String SUMMARY = "summary";
	public static final String CONTENT = "content";
	public static final String PUBLIC_URL = "publicUrl";
	public static final String TITLE_IMAGE = "titleImage";
	public static final String CONTENT_IMAGE = "contentImage";
	public static final String CREATED = "date";
	
	private int id;
	private String title;
	private String summary;
	private String content;
	private String publicUrl;
	private String titleImage;
	private String contentImage;
	private Timestamp created;
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPublicUrl() {
		return publicUrl;
	}

	public void setPublicUrl(String publicUrl) {
		this.publicUrl = publicUrl;
	}

	public String getTitleImage() {
		return titleImage;
	}

	public void setTitleImage(String titleImage) {
		this.titleImage = titleImage;
	}

	public String getContentImage() {
		return contentImage;
	}

	public void setContentImage(String contentImage) {
		this.contentImage = contentImage;
	}

	public Timestamp getCreated() {
		return created;
	}

	public void setCreated(Timestamp created) {
		this.created = created;
	}

	@Override
	public String toString() {
		
		return " Events [ "
				
				+ ", id=" + id
				+ ", title=" + title
				+ ", summary=" + summary
				+ ", content=" + content
				+ ", publicUrl=" + publicUrl
				+ ", titleImage" + titleImage
				+ ", contentImage" + contentImage
				+ ", created=" + created
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new EventsMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
