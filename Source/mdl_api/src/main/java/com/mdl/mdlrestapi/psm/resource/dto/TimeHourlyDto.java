package com.mdl.mdlrestapi.psm.resource.dto;

import java.util.List;

public class TimeHourlyDto {
	private String hour;
	private int totalcount;
	private int runningtotal;
	private List<HourlyPapersDto> papersissued;

	public String getHour() {
		return hour;
	}

	public void setHour(String hour) {
		this.hour = hour;
	}

	public int getRunningtotal() {
		return runningtotal;
	}

	public void setRunningtotal(int runningtotal) {
		this.runningtotal = runningtotal;
	}

	public int getTotalcount() {
		return totalcount;
	}

	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}

	public List<HourlyPapersDto> getPapersissued() {
		return papersissued;
	}

	public void setPapersissued(List<HourlyPapersDto> papersissued) {
		this.papersissued = papersissued;
	}
}
