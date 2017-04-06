package com.moderndemocracy.json;

import java.io.IOException;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonReader;
import com.anaeko.utils.json.JsonReader.JsonToken;
import com.moderndemocracy.pojo.Tendered;

public final class TenderedMarshaler extends DefaultJsonMarshaler {

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
			return readTendered(reader);
		} 
		return null;
	}


	private Tendered readTendered(JsonReader reader)
			throws IOException {

		Tendered tendered = new Tendered();
		
		while (reader.nextToken() != JsonToken.END_OBJECT) {
			
			String name = reader.getCurrentName();
			reader.nextToken();

			if (Tendered.TENDERED_TOTAL_BALLOT_PAPERS_ISSUED.equals(name)) {
				tendered.setTenderedTotalIssued(reader.getIntValue());
			}
			else if (Tendered.TENDERED_TOTAL_SPOILT_BALLOT_PAPERS.equals(name)) {
				tendered.setTenderedTotalSpoilt(reader.getIntValue());
			} 
			else if (Tendered.TENDERED_TOTAL_UNUSED_BALLOT_PAPERS.equals(name)) {
				tendered.setTenderedTotalUnused(reader.getIntValue());
			} 
		}
		return tendered;
	}

}