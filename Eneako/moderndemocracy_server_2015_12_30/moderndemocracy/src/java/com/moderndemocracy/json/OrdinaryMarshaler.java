package com.moderndemocracy.json;

import java.io.IOException;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonReader;
import com.anaeko.utils.json.JsonReader.JsonToken;
import com.moderndemocracy.pojo.Ordinary;

public final class OrdinaryMarshaler extends DefaultJsonMarshaler {

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.anaeko.utils.data.mime.json.DefaultJsonMarshaler#unmarshal(com.anaeko
	 * .utils.data.mime.json.JsonReader)
	 */
	@Override
	public Object unmarshal(JsonReader reader) throws IOException,
			MarshalerException {

		while ((reader.getCurrentToken() != JsonToken.START_ARRAY)
				&& (reader.getCurrentToken() != JsonToken.START_OBJECT)) {
			reader.nextToken();
		}

		if (reader.getCurrentToken() == JsonToken.START_OBJECT) {
			return readOrdinary(reader);
		} 
		return null;
	}


	private Ordinary readOrdinary(JsonReader reader)
			throws IOException {

		Ordinary ordinary = new Ordinary();
		
		while (reader.nextToken() != JsonToken.END_OBJECT) {
			
			String name = reader.getCurrentName();
			reader.nextToken();

			if (Ordinary.ORDINARY_TOTAL_BALLOT_PAPER_ISSUED.equals(name)) {
				ordinary.setOrdinaryTotalIssued(reader.getIntValue());
			}
			else if (Ordinary.ORDINARY_SPOILT_BALLOT_PAPERS_REPLACEMENTS_ISSUED.equals(name)) {
				ordinary.setOrdinaryNumberOfReplacements(reader.getIntValue());
			} 
			else if (Ordinary.ORDINARY_TOTAL_BALLOT_PAPERS_ISSUED_AND_NOT_SPOILT.equals(name)) {
				ordinary.setOrdinaryCalsIssuedAndNotSpoilt(reader.getIntValue());
			} 
			else if (Ordinary.ORDINARY_TOTAL_UNUSED_BALLOT_PAPERS.equals(name)) {
				ordinary.setOrdinaryTotalUnused(reader.getIntValue());
			}

		}
		return ordinary;
	}

}