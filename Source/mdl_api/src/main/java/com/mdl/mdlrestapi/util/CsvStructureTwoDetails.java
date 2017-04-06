package com.mdl.mdlrestapi.util;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({ "district", "ward", "place", "stationname", "ballotstartnumber", "ballotendnumber", "ballotboxnumber", "tenderstartnumber","tenderendnumber", "rowstatus" })
public class CsvStructureTwoDetails {
	public String ballotboxnumber;
	public String district;
	public String place;
	public String stationname;
	public String ward;
	public String ballotstartnumber;
	public String ballotendnumber;
	public String tenderstartnumber;
	public String tenderendnumber;
	public String rowstatus;	
}
