package com.mdl.mdlrestapi.util;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({"electionname","stationname","ballotstartnumber","ballotendnumber","tenderstartnumber","tenderendnumber","rowstatus"})
public class CsvStructureOneFileTwoDetails {
	public String electionname;
	public String stationname;
	public String ballotstartnumber;
	public String ballotendnumber;
	public String tenderstartnumber;
	public String tenderendnumber;
	public String rowstatus;
}
