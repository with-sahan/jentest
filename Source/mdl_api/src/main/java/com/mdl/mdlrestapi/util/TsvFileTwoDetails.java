package com.mdl.mdlrestapi.util;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({"fname","surname","username","passwords","rowstatus"})
public class TsvFileTwoDetails {
	public String fname;
	public String surname;
	public String username;
	public String passwords;
	public String rowstatus;
}
