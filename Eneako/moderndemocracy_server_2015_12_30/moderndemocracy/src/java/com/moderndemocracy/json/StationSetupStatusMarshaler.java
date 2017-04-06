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
import com.moderndemocracy.pojo.StationSetupStatus;

public final class StationSetupStatusMarshaler extends DefaultJsonMarshaler {

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (StationSetupStatus stationSetupStatus: (Iterable<StationSetupStatus>) object) {
				marshalStationSetupStatus(stationSetupStatus, writer);
			}

			writer.writeEndArray();
		} else {
			marshalStationSetupStatus((StationSetupStatus) object, writer);
		}
	}

	private void marshalStationSetupStatus(StationSetupStatus stationSetupStatus, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(StationSetupStatus.ID, stationSetupStatus.getId());
		//writer.writeField(StationSetupStatus.STATION_ID, stationSetupStatus.getStationId());
		writer.writeField(StationSetupStatus.TEXT, stationSetupStatus.getText());
		writer.writeField(StationSetupStatus.ORDER_ID, stationSetupStatus.getOrderId());
		writer.writeField(StationSetupStatus.STATION_SETUP_LIST_ID, stationSetupStatus.getStationSetupListId());
		writer.writeField(StationSetupStatus.STATUS, stationSetupStatus.getStatus());

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
			return readStationSetupStatus(reader);
		} else if (reader.getCurrentToken() == JsonToken.START_ARRAY) {
			return readStationSetupListArray(reader);
		}
		return null;
	}

	private List<StationSetupStatus> readStationSetupListArray(JsonReader reader)
			throws IOException {
		
		ArrayList<StationSetupStatus> entries = new ArrayList<StationSetupStatus>();
		
		while (reader.nextToken() != JsonToken.END_ARRAY) {
			if (reader.getCurrentToken() != JsonToken.START_OBJECT) {
				reader.nextToken();
			} else {
				entries.add(readStationSetupStatus(reader));
			}
		}
		
		return entries;
	}

	private StationSetupStatus readStationSetupStatus(JsonReader reader)
			throws IOException {

		StationSetupStatus stationSetupStatus= new StationSetupStatus();
		
		while (reader.nextToken() != JsonToken.END_OBJECT) {
			
			String name = reader.getCurrentName();
			reader.nextToken();

			if (StationSetupList.ID.equals(name)) {
				stationSetupStatus.setId(reader.getIntValue());
			}
			else if (StationSetupList.TEXT.equals(name)) {
				stationSetupStatus.setText(reader.getText());
			} 
			else if (StationSetupList.ORDER_ID.equals(name)) {
				stationSetupStatus.setOrderId(reader.getIntValue());
			} 
			else if (StationSetupList.STATUS.equals(name)) {
				stationSetupStatus.setStatus(reader.getBooleanValue());
			}

		}
		return stationSetupStatus;
	}

}