package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.CandidatesMarshaler;

public class Candidates implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Candidates.class);

	public static final String ID = "id";
	public static final String TITLE = "title";
	public static final String SUMMARY = "summary";
	public static final String CONTENT = "content";
	public static final String PUBLIC_URL = "publicUrl";
	public static final String TITLE_IMAGE = "titleImage";
	public static final String FLAG_IMAGE = "flagImage";
	public static final String PARTY_NAME = "partyName";
	public static final String WARD_NAME = "wardName";
	public static final String CREATED = "created";
	
	private int id;
	private String title;
	private String summary;
	private String content;
	private String publicUrl;
	private String titleImage;
	private String flagImage;
	private String partyName;
	private String wardName;
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

	public String getPublicUrl() {
		return publicUrl;
	}

	public void setPublicUrl(String publicUrl) {
		this.publicUrl = publicUrl;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitleImage() {
		return titleImage;
	}

	public void setTitleImage(String titleImage) {
		this.titleImage = titleImage;
	}

	public String getFlagImage() {
		return flagImage;
	}

	public void setFlagImage(String flagImage) {
		this.flagImage = flagImage;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getWardName() {
		return wardName;
	}

	public void setWardName(String wardName) {
		this.wardName = wardName;
	}

	public Timestamp getCreated() {
		return created;
	}

	public void setCreated(Timestamp created) {
		this.created = created;
	}

	@Override
	public String toString() {
		
		return " Candidates [ "
				
				+ ", id=" + id
				+ ", title=" + title
				+ ", summary=" + summary
				+ ", content=" + content
				+ ", publicUrl=" + publicUrl
				+ ", image_1" + titleImage
				+ ", image_2" + flagImage
				+ ", party_name" + partyName
				+ ", ward_name" + wardName
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
		return new CandidatesMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
