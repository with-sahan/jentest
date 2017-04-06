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

public final class StationSetupListMarshaler extends DefaultJsonMarshaler {

	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {

			writer.writeStartArray();

			for (StationSetupList stationSetupList : (Iterable<StationSetupList>) object) {
				marshalStationSetupList(stationSetupList, writer);
			}

			writer.writeEndArray();
		} else {
			marshalStationSetupList((StationSetupList) object, writer);
		}
	}

	private void marshalStationSetupList(StationSetupList stationSetupList, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();

		writer.writeField(StationSetupList.ID, stationSetupList.getId());
		writer.writeField(StationSetupList.TEXT, stationSetupList.getText());
		writer.writeField(StationSetupList.ORDER_ID, stationSetupList.getOrderId());
		writer.writeField(StationSetupList.STATUS, stationSetupList.getStatus());

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