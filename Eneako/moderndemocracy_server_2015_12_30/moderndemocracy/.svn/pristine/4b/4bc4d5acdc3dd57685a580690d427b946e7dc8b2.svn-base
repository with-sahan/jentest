package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.TenderedMarshaler;

public class Tendered implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Tendered.class);

	public static final String TENDERED_TOTAL_BALLOT_PAPERS_ISSUED = "totalIssued";
	public static final String TENDERED_TOTAL_SPOILT_BALLOT_PAPERS = "totalSpoilt";
	public static final String TENDERED_TOTAL_UNUSED_BALLOT_PAPERS = "totalUnused";
	
	private int tenderedTotalIssued;
	private int tenderedTotalSpoilt;
	private int tenderedTotalUnused;
	

	public int getTenderedTotalIssued() {
		return tenderedTotalIssued;
	}

	public void setTenderedTotalIssued(int tenderedTotalIssued) {
		this.tenderedTotalIssued = tenderedTotalIssued;
	}

	public int getTenderedTotalSpoilt() {
		return tenderedTotalSpoilt;
	}

	public void setTenderedTotalSpoilt(int tenderedTotalSpoilt) {
		this.tenderedTotalSpoilt = tenderedTotalSpoilt;
	}

	public int getTenderedTotalUnused() {
		return tenderedTotalUnused;
	}

	public void setTenderedTotalUnused(int tenderedTotalUnused) {
		this.tenderedTotalUnused = tenderedTotalUnused;
	}

	@Override
	public String toString() {
		return " StationSetupList ["
				+ ", tenderedTotalIssued=" + tenderedTotalIssued
				+ ", tenderedTotalSpoilt=" + tenderedTotalSpoilt
				+ ", tenderedTotalUnused=" + tenderedTotalUnused
				
				+ "] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new TenderedMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
