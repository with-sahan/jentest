package com.mdl.mdlrestapi.psm.resource.dto;

public class ElectionStartEndDto {
	
	private String ename;
	private int starttime;
	private int endtime;

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public int getStarttime() {
		return starttime;
	}

	public void setStarttime(int starttime) {
		this.starttime = starttime;
	}

	public int getEndtime() {
		return endtime;
	}

	public void setEndtime(int endtime) {
		this.endtime = endtime;
	}

}
