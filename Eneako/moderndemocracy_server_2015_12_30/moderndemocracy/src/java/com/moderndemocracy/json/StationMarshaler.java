package com.moderndemocracy.json;

import java.io.IOException;
import java.util.List;

import com.anaeko.utils.data.mime.json.DefaultJsonMarshaler;
import com.anaeko.utils.io.MarshalerException;
import com.anaeko.utils.json.JsonWriter;
import com.moderndemocracy.pojo.Station;

public final class StationMarshaler extends DefaultJsonMarshaler {	
	
	@SuppressWarnings("unchecked")
	@Override
	public void marshal(Object object, JsonWriter writer)
			throws IOException, MarshalerException {

		if (object instanceof List) {
			
			writer.writeStartArray();

			for (Station station : (Iterable<Station>) object) {
				
				if (station!=null) {
					marshalStation(station, writer);
				}
			}

			writer.writeEndArray();
			
		} else {
			if (object!=null) {
				marshalStation((Station) object, writer);
			}
		}
	}

	private void marshalStation(Station station, JsonWriter writer)
			throws IOException {

		writer.writeStartObject();
		
		writer.writeField(Station.STATION_ID, station.getId());
		writer.writeField(Station.STATION_NAME, station.getStationName());
		writer.writeField(Station.PLACE_ID, station.getPlaceId());
		writer.writeField(Station.BALLOT_PAPERS_ISSUED, station.getBallotPapersIssued());
		writer.writeField(Station.POSTAL_PACKS_RECEIVED, station.getPostalPacksReceived());
		writer.writeField(Station.POSTAL_PACKS_AWAITING_COLLECTION, station.getPostalPacksAwaitingCollection());
		
		writer.writeField(Station.ORDINARY_TOTAL_BALLOT_PAPER_ISSUED, station.getOrdinaryTotalIssued());
		writer.writeField(Station.ORDINARY_SPOILT_BALLOT_PAPERS_REPLACEMENTS_ISSUED, station.getOrdinaryNumberOfReplacements());
		writer.writeField(Station.ORDINARY_TOTAL_BALLOT_PAPERS_ISSUED_AND_NOT_SPOILT, station.getOrdinaryCalsIssuedAndNotSpoilt());
		writer.writeField(Station.ORDINARY_TOTAL_UNUSED_BALLOT_PAPERS, station.getOrdinaryTotalUnused());
		writer.writeField(Station.TENDERED_TOTAL_BALLOT_PAPERS_ISSUED, station.getTenderedTotalIssued());
		writer.writeField(Station.TENDERED_TOTAL_SPOILT_BALLOT_PAPERS, station.getTenderedTotalSpoilt());
		writer.writeField(Station.TENDERED_TOTAL_UNUSED_BALLOT_PAPERS, station.getTenderedTotalUnused());
		
		writer.writeField(Station.DISPATCH_TIME, station.getDispatchTime());
		writer.writeField(Station.DELIVER_TIME, station.getDeliverTime());
		writer.writeField(Station.ETA, station.getEta());
		
		writer.writeField(Station.BALLOT_BOX_NUMBER, station.getBallot_box_no());
		
		writer.writeField(Station.STATION_OPEN, station.isStationOpen());
		writer.writeField(Station.STATION_STATUS, station.getStationStatus());

		writer.writeEndObject();
	}
	
}