package com.moderndemocracy.pojo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.json.JsonMarshaler;
import com.anaeko.utils.json.ToJSON;
import com.moderndemocracy.json.ProgressUpdateMarshaler;

public class ProgressUpdate implements ToJSON {

	protected static final Logger logger = LogManager.getLogger(ProgressUpdate.class);

	public static final String PAPER_ISSUED          = "paperIssued";
	public static final String POSTAL_PACKS_RECEIVED = "postalPacksReceived";
	public static final String POSTAL_PACKS_AWAITING_COLLECTION = "postalPacksAwaitingCollection";
	
	private int papersIssued;
	private int postalPacksReceived;
	private int postalPacksAwaitingCollection;
	
	
	public int getPapersIssued() {
		return papersIssued;
	}

	public void setPapersIssued(int papersIssued) {
		this.papersIssued = papersIssued;
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

	@Override
	public String toString() {
		return " ProgressUpdate ["
				+ " paperIssued=" + papersIssued
				+ ", postalPacksReceived=" + postalPacksReceived
				+ ", postalPacksAwaitingCollection=" + postalPacksAwaitingCollection
				+ "] ";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.json.ToJSON#createMarshaller()
	 */
	@Override
	public JsonMarshaler createMarshaller() {
		return new ProgressUpdateMarshaler();
	}

	public static final class Marshaler extends DefaultJsonMarshaler {
	}

}
