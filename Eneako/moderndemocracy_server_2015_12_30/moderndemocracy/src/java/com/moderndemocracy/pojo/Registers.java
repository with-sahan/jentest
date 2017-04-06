package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.RegistersMarshaler;

public class Registers implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Registers.class);

	public static final String ID = "id";
	public static final String TITLE = "title";
	public static final String SUMMARY = "summary";
	public static final String CONTENT = "content";
	public static final String CREATED = "created";
	
	private int id;
	private String title;
	private String summary;
	private String content;
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

	public Timestamp getCreated() {
		return created;
	}

	public void setCreated(Timestamp created) {
		this.created = created;
	}

	@Override
	public String toString() {
		
		return " Registers [ "
				
				+ ", id=" + id
				+ ", title=" + title
				+ ", summary=" + summary
				+ ", content=" + content
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
		return new RegistersMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
