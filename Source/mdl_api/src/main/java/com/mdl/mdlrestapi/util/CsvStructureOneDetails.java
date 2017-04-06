package com.mdl.mdlrestapi.util;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({"constituency","ward","district","place","stationname","address","contact","keyholder","ballotboxnumber","presidingofficer","username","passwords"})
public class CsvStructureOneDetails {
	public String address;
	public String ballotboxnumber;
	public String constituency;
	public String contact;
	public String district;
	public String passwords;
	public String place;
	public String presidingofficer;
	public String stationname;
	public String username;
	public String ward;
	public String keyholder;
	public String rowstatus;
}
