package com.moderndemocracy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.anaeko.utils.jdbc.ResultExtractor;
import com.moderndemocracy.pojo.Station;

public class StationExtractor implements ResultExtractor<Station> {

	public static final String SQL =
			"select S.id, S.name as stationName, S.polling_place_id, "
			+ " S.ballot_papers_issued as ballotPapersIssued, "
			+ " S.postal_packs_received as postalPacksReceived, "
			+ " S.postal_packs_awaiting_collection as postalPacksAwaitingCollection, "
			+ " S.ordinary_total_issued as totalIssued, "
			+ " S.ordinary_number_of_replacements as numberOfReplacements, "
			+ " S.ordinary_cals_issued_and_not_spoilt as calcIssuedAndNotSpoilt, "
			+ " S.ordinary_total_unused as totalUnused, "
			+ " S.tendered_total_issued as totalIssued, "
			+ " S.tendered_total_spoilt as totalSpoilt, "
			+ " S.tendered_total_unused as totalUnused, "
			+ " S.ballot_box_no, "
			+ " SSS.status, "
			+ " S.dispatch_time as dispatchTime, "
			+ " S.deliver_time as deliverTime, "
			+ " S.eta as eta "
			+ " FROM polling_station S, station_setup_status SSS ";
	
	
	Logger logger = LogManager.getLogger(StationExtractor.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.anaeko.utils.jdbc.ResultExtractor#extract(java.sql.ResultSet,
	 * int)
	 */
	@Override
	public Station extract(ResultSet data, int index) throws SQLException {

		Station extracted = new Station();
		int i=1;
		
		extracted.setId(data.getInt(i++));
		extracted.setStationName(data.getString(i++));
		extracted.setPlaceId(data.getInt(i++));
		
		extracted.setBallotPapersIssued(data.getInt(i++));
		extracted.setPostalPacksReceived(data.getInt(i++));
		extracted.setPostalPacksAwaitingCollection(data.getInt(i++));
		
		extracted.setOrdinaryTotalIssued(data.getInt(i++));
		extracted.setOrdinaryNumberOfReplacements(data.getInt(i++));
		extracted.setOrdinaryCalsIssuedAndNotSpoilt(data.getInt(i++));
		extracted.setOrdinaryTotalUnused(data.getInt(i++));
		
		extracted.setTenderedTotalIssued(data.getInt(i++));
		extracted.setTenderedTotalSpoilt(data.getInt(i++));
		extracted.setTenderedTotalUnused(data.getInt(i++));
		
		extracted.setBallot_box_no(data.getString(i++));
		
		extracted.setStationOpen(data.getBoolean(i++));
		
		extracted.setDispatchTime(data.getTimestamp(i++));
		extracted.setDeliverTime(data.getTimestamp(i++));
		extracted.setEta(data.getTimestamp(i++));

		return extracted;
	}

}
