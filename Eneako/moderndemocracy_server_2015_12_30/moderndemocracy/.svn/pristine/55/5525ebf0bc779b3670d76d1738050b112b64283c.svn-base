package com.moderndemocracy.pojo;

import java.sql.Timestamp;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.StationMarshaler;

public class Station implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(Station.class);

	public static final String STATION_ID = "stationId";
	public static final String STATION_NAME = "stationName";
	public static final String PLACE_ID = "placeId";
	
	public static final String BALLOT_PAPERS_ISSUED = "ballotPapersIssued";
	public static final String POSTAL_PACKS_RECEIVED = "postalPacksReceived";
	public static final String POSTAL_PACKS_AWAITING_COLLECTION = "postalPacksAwaitingCollection";
	
	public static final String ORDINARY_TOTAL_BALLOT_PAPER_ISSUED                 = "totalOrdinaryIssued";
	public static final String ORDINARY_SPOILT_BALLOT_PAPERS_REPLACEMENTS_ISSUED  = "numberOfReplacements";
	public static final String ORDINARY_TOTAL_BALLOT_PAPERS_ISSUED_AND_NOT_SPOILT = "calcIssuedAndNotSpoilt";
	public static final String ORDINARY_TOTAL_UNUSED_BALLOT_PAPERS                = "totalOrdinaryUnused";
	
	public static final String TENDERED_TOTAL_BALLOT_PAPERS_ISSUED = "totalTenderedIssued";
	public static final String TENDERED_TOTAL_SPOILT_BALLOT_PAPERS = "totalSpoilt";
	public static final String TENDERED_TOTAL_UNUSED_BALLOT_PAPERS = "totalTenderedUnused";
	
	public static final String DISPATCH_TIME = "dispatchTime";
	public static final String DELIVER_TIME = "deliverTime";
	public static final String ETA = "eta";
	
	public static final String BALLOT_BOX_NUMBER = "ballot_box_number";
	
	public static final String STATION_OPEN = "stationOpen";
	public static final String STATION_STATUS = "stationStatus";
	
	public static final String RED    = "red";
	public static final String ORANGE = "orange";
	public static final String GREEN  = "green";
	
	private int id;
	private String stationName;
	private int placeId;
	
	private int ballotPapersIssued;
	private int postalPacksReceived;
	private int postalPacksAwaitingCollection;
	
	private int ordinaryTotalIssued;
	private int ordinaryNumberOfReplacements;
	private int ordinaryCalsIssuedAndNotSpoilt;
	private int ordinaryTotalUnused;
	
	private int tenderedTotalIssued;
	private int tenderedTotalSpoilt;
	private int tenderedTotalUnused;
	
	private Timestamp dispatchTime;
	private Timestamp deliverTime;
	private Timestamp eta;
	
	private String ballot_box_no;
	
	private boolean stationOpen;
	private String stationStatus;
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public int getPlaceId() {
		return placeId;
	}

	public void setPlaceId(int placeId) {
		this.placeId = placeId;
	}

	public int getBallotPapersIssued() {
		return ballotPapersIssued;
	}

	public void setBallotPapersIssued(int ballotPapersIssued) {
		this.ballotPapersIssued = ballotPapersIssued;
	}

	public int getPostalPacksReceived() {
		return postalPacksReceived;
	}

	public void setPostalPacksReceived(int postalPacksReceived) {
		this.postalPacksReceived = postalPacksReceived;
	}
	
	public int getPostalPacksAwaitingCollection() {
		return postalPacksAwaitingCollection;
	}

	public void setPostalPacksAwaitingCollection(
			int postalPacksAwaitingCollection) {
		this.postalPacksAwaitingCollection = postalPacksAwaitingCollection;
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

	public Timestamp getDispatchTime() {
		return dispatchTime;
	}

	public void setDispatchTime(Timestamp dispatchTime) {
		this.dispatchTime = dispatchTime;
	}

	public Timestamp getDeliverTime() {
		return deliverTime;
	}

	public void setDeliverTime(Timestamp deliverTime) {
		this.deliverTime = deliverTime;
	}

	public Timestamp getEta() {
		return eta;
	}

	public void setEta(Timestamp eta) {
		this.eta = eta;
	}

	public boolean isStationOpen() {
		return stationOpen;
	}

	public String getBallot_box_no() {
		return ballot_box_no;
	}

	public void setBallot_box_no(String ballot_box_no) {
		this.ballot_box_no = ballot_box_no;
	}

	public void setStationOpen(boolean stationOpen) {
		this.stationOpen = stationOpen;
	}

	public String getStationStatus() {
		return stationStatus;
	}

	public void setStationStatus(String stationStatus) {
		this.stationStatus = stationStatus;
	}

	@Override
	public String toString() {
		
		return " Station [ "
				
				+ ", id=" + id
				+ ", stationName=" + stationName
				+ ", ballotPapersIssued=" + ballotPapersIssued
				+ ", postalPacksReceived=" + postalPacksReceived
				+ ", postalPacksAwaitingCollection=" + postalPacksAwaitingCollection
		
				+ ", ordinaryTotalIssued=" + ordinaryTotalIssued
				+ ", ordinaryNumberOfReplacements=" + ordinaryNumberOfReplacements
				+ ", ordinaryCalsIssuedAndNotSpoilt=" + ordinaryCalsIssuedAndNotSpoilt
				+ ", ordinaryTotalUnused=" + ordinaryTotalUnused
		
				+ ", tenderedTotalIssued=" + tenderedTotalIssued
				+ ", tenderedTotalSpoilt=" + tenderedTotalSpoilt
				+ ", tenderedTotalUnused=" + tenderedTotalUnused
				+ " ] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new StationMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
