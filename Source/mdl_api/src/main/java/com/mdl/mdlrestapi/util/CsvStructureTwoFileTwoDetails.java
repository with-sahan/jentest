package com.mdl.mdlrestapi.util;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({"place","stationname","role","firstname","lastname","username","passwords","rowstatus"})
public class CsvStructureTwoFileTwoDetails {
	public String place;
	public String stationname;
	public String role;
	public String firstname;
	public String lastname;
	public String passwords;
	public String username;
	public String rowstatus;
}