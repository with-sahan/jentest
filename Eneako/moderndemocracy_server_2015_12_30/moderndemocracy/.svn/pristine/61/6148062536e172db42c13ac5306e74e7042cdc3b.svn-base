package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.DashboardGenderMarshaler;

public class DashboardGender implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(DashboardGender.class);

	public static final String GENDER = "gender";
	public static final String TOTAL = "total";
	
	private String gender;
	private Integer total;
	

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	@Override
	public String toString() {
		
		return " DashboardTotal [ "
				
				+ ", gender=" + gender
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
		return new DashboardGenderMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
