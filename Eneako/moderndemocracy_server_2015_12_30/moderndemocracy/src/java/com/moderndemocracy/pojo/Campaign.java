package com.moderndemocracy.pojo;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.CampaignMarshaler;

public class Campaign implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Campaign.class);
	
	public static final String TOTAL_BALLOT_PAPERS_ISSUED = "totalBallotPapersIssued";
	public static final String TOTAL_POSTAL_PACKS = "totalPostalPacks";
	public static final String ORDINARY_TOTAL_ISSUED = "ordinaryTotalIssued";
	public static final String ORDINARY_NUMBER_OF_REPLACEMENTS = "ordinaryNumberOfReplacements";
	public static final String ORDINARY_CALS_ISSUED_AND_NOT_SPOILT = "ordinaryCalsIssuedAndNotSpoilt";
	public static final String ORDINARY_TOTAL_UNUSED = "ordinaryTotalUnused";
	public static final String TENDERED_TOTAL_ISSUED = "tenderedTotalIssued";
	public static final String TENDERED_TOTAL_SPOILT = "tenderedTotalSpoilt";
	public static final String TENDERED_TOTAL_UNUSED = "tenderedTotalUnused";
	
	
	public static final String WARDS = "wards";
	
	private int totalBallotPapersIssued = 0;
	private int totalPostalPacks = 0;
	private int ordinaryTotalIssued = 0;
	private int ordinaryNumberOfReplacements = 0;
	private int ordinaryCalsIssuedAndNotSpoilt = 0;
	private int ordinaryTotalUnused = 0;
	private int tenderedTotalIssued = 0;
	private int tenderedTotalSpoilt = 0;
	private int tenderedTotalUnused = 0;
	private List<Ward> wards;


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

	public List<Ward> getWards() {
		return wards;
	}

	public void setWards(List<Ward> wards) {
		this.wards = wards;
	}
	
	@Override
	public String toString() {
		return " Ward [ "
				+ " totalBallotPapersIssued=" + totalBallotPapersIssued
				+ " totalPostalPacks=" + totalPostalPacks
				+ " ordinaryTotalIssued=" + ordinaryTotalIssued
				+ " ordinaryNumberOfReplacements=" + ordinaryNumberOfReplacements
				+ " ordinaryCalsIssuedAndNotSpoilt=" + ordinaryCalsIssuedAndNotSpoilt
				+ " ordinaryTotalUnused=" + ordinaryTotalUnused
				+ " tenderedTotalIssued=" + tenderedTotalIssued
				+ " tenderedTotalSpoilt=" + tenderedTotalSpoilt
				+ " tenderedTotalUnused=" + tenderedTotalUnused
				+ " wards=" + wards.toString()
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new CampaignMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
