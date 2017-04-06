package com.moderndemocracy.pojo;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.WardsMarshaler;

public class Ward implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Ward.class);
	
	public static final String WARD_ID = "wardId";
	public static final String WARD_NAME = "wardName";
	public static final String PLACE_NAME = "placeName";
	public static final String DISTRICTS = "districts";
	public static final String TOTAL_BALLOT_PAPER_ISSUED = "totalBallotPaperIssued";
	public static final String TOTAL_POSTAL_PACKS = "totalPostalPacks";
	
	private int totalBallotPapersIssued = 0;
	private int totalPostalPacks = 0;
	private int id;
	private String wardName;
	
	private int wardTotalBallotPapersIssued = 0;
	private int wardTotalPostalPackReceived = 0;
	
	private List<District> districts;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTotalBallotPapersIssued() {
		return totalBallotPapersIssued;
	}

	public void setTotalBallotPapersIssued(int totalBallotPapersIssued) {
		this.totalBallotPapersIssued = totalBallotPapersIssued;
	}

	public int getTotalPostalPacks() {
		return totalPostalPacks;
	}

	public void setTotalPostalPacks(int totalPostalPacks) {
		this.totalPostalPacks = totalPostalPacks;
	}

	public String getWardName() {
		return wardName;
	}

	public void setWardName(String wardName) {
		this.wardName = wardName;
	}
	
	public int getWardTotalBallotPapersIssued() {
		return wardTotalBallotPapersIssued;
	}

	public void setWardTotalBallotPapersIssued(int wardTotalBallotPapersIssued) {
		this.wardTotalBallotPapersIssued = wardTotalBallotPapersIssued;
	}

	public int getWardTotalPostalPackReceived() {
		return wardTotalPostalPackReceived;
	}

	public void setWardTotalPostalPackReceived(int wardTotalPostalPackReceived) {
		this.wardTotalPostalPackReceived = wardTotalPostalPackReceived;
	}

	public List<District> getDistricts() {
		return districts;
	}

	public void setDistricts(List<District> districts) {
		this.districts = districts;
	}

	@Override
	public String toString() {
		return " Ward [ "
				+ " totalBallotPapersIssued=" + totalBallotPapersIssued
				+ " totalPostalPacks=" + totalPostalPacks
				+ " wardName=" + wardName
				+ " districts=" + districts.toString()
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new WardsMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
