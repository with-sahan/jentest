package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.OrdinaryMarshaler;

public class Ordinary implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Ordinary.class);

	public static final String ORDINARY_TOTAL_BALLOT_PAPER_ISSUED                 = "totalIssued";
	public static final String ORDINARY_SPOILT_BALLOT_PAPERS_REPLACEMENTS_ISSUED  = "numberOfReplacements";
	public static final String ORDINARY_TOTAL_BALLOT_PAPERS_ISSUED_AND_NOT_SPOILT = "calcIssuedAndNotSpoilt";
	public static final String ORDINARY_TOTAL_UNUSED_BALLOT_PAPERS                = "totalUnused";
	
	private int ordinaryTotalIssued;
	private int ordinaryNumberOfReplacements;
	private int ordinaryCalsIssuedAndNotSpoilt;
	private int ordinaryTotalUnused;
	

	public int getOrdinaryTotalIssued() {
		return ordinaryTotalIssued;
	}

	public void setOrdinaryTotalIssued(int ordinaryTotalIssued) {
		this.ordinaryTotalIssued = ordinaryTotalIssued;
	}

	public int getOrdinaryNumberOfReplacements() {
		return ordinaryNumberOfReplacements;
	}

	public void setOrdinaryNumberOfReplacements(int ordinaryNumberOfReplacements) {
		this.ordinaryNumberOfReplacements = ordinaryNumberOfReplacements;
	}

	public int getOrdinaryCalsIssuedAndNotSpoilt() {
		return ordinaryCalsIssuedAndNotSpoilt;
	}

	public void setOrdinaryCalsIssuedAndNotSpoilt(int ordinaryCalsIssuedAndNotSpoilt) {
		this.ordinaryCalsIssuedAndNotSpoilt = ordinaryCalsIssuedAndNotSpoilt;
	}

	public int getOrdinaryTotalUnused() {
		return ordinaryTotalUnused;
	}

	public void setOrdinaryTotalUnused(int ordinaryTotalUnused) {
		this.ordinaryTotalUnused = ordinaryTotalUnused;
	}


	@Override
	public String toString() {
		return " StationSetupList ["
				+ "  ordinaryTotalIssued=" + ordinaryTotalIssued 
				+ ", ordinaryNumberOfReplacements=" + ordinaryNumberOfReplacements 
				+ ", ordinaryCalsIssuedAndNotSpoilt=" + ordinaryCalsIssuedAndNotSpoilt 
				+ ", ordinaryTotalUnused=" + ordinaryTotalUnused
				+ "] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new OrdinaryMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
