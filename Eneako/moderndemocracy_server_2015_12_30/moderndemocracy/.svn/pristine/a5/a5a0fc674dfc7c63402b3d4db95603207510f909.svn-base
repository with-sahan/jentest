package com.moderndemocracy.json;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonReader;
import com.anaeko.utils.json.JsonReader.JsonToken;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.StationSetupList;
import com.moderndemocracy.pojo.Tracking;

public final class TrackingMarshaler extends DefaultJsonMarshaler {

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (Tracking tracking : (Iterable<Tracking>) object) {
				marshalTracking(tracking, writer);
			}

			writer.writeEndArray();
		} else {
			
			writer.writeStartArray();
			marshalTracking((Tracking) object, writer);
			writer.writeEndArray();
		}
	}

	private void marshalTracking(Tracking tracking, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(Tracking.STATION, tracking.getStation());
		writer.writeField(Tracking.LAT, tracking.getLat());
		writer.writeField(Tracking.LNG, tracking.getLng());
		writer.writeField(Tracking.STATUS, tracking.getStatus());
		writer.writeField(Tracking.CREATED_ON, tracking.getCreatedOn());
		writer.writeField(Tracking.UPDATED_ON, tracking.getUpdatedOn());
		
		if( tracking.getDispatchTime() != null ) {
			writer.writeField(Tracking.DISPATCH_TIME, tracking.getDispatchTime() );
		}
		
		if( tracking.getDeliverTime() != null ) {
			writer.writeField(Tracking.DELIVER_TIME, tracking.getDeliverTime() );
		}
		if( tracking.getEta() != null ) {
			writer.writeField(Tracking.ETA, tracking.getEta());
		}
		
		writer.writeField(Tracking.BALLOT_BOX_NUMBER, tracking.getBallotBoxNo());

		writer.writeEndObject();
	}
	
	
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
			return readStationSetupList(reader);
		} else if (reader.getCurrentToken() == JsonToken.START_ARRAY) {
			return readStationSetupListArray(reader);
		}
		return null;
	}

	private List<StationSetupList> readStationSetupListArray(JsonReader reader)
			throws IOException {
		
		ArrayList<StationSetupList> entries = new ArrayList<StationSetupList>();
		
		while (reader.nextToken() != JsonToken.END_ARRAY) {
			if (reader.getCurrentToken() != JsonToken.START_OBJECT) {
				reader.nextToken();
			} else {
				entries.add(readStationSetupList(reader));
			}
		}
		
		return entries;
	}

	private StationSetupList readStationSetupList(JsonReader reader)
			throws IOException {

		StationSetupList stationSetupList = new StationSetupList();
		
		while (reader.nextToken() != JsonToken.END_OBJECT) {
			
			String name = reader.getCurrentName();
			reader.nextToken();

			if (StationSetupList.ID.equals(name)) {
				stationSetupList.setId(reader.getIntValue());
			}
			else if (StationSetupList.TEXT.equals(name)) {
				stationSetupList.setText(reader.getText());
			} 
			else if (StationSetupList.ORDER_ID.equals(name)) {
				stationSetupList.setOrderId(reader.getIntValue());
			} 
			else if (StationSetupList.STATUS.equals(name)) {
				stationSetupList.setStatus(reader.getBooleanValue());
			}

		}
		return stationSetupList;
	}

}