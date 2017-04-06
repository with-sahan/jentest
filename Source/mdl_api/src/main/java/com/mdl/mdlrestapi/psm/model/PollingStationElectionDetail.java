package com.mdl.mdlrestapi.psm.model;

public class PollingStationElectionDetail 
{
	private Integer ballotStart;
	private Integer ballotEnd;
	private Integer tenderStart;
	private Integer tenderEnd;
	
	public PollingStationElectionDetail() 
	{

	}

	public Integer getBallotStart() {
		return ballotStart;
	}

	public void setBallotStart(Integer ballotStart) {
		this.ballotStart = ballotStart;
	}

	public Integer getBallotEnd() {
		return ballotEnd;
	}

	public void setBallotEnd(Integer ballotEnd) {
		this.ballotEnd = ballotEnd;
	}

	public Integer getTenderStart() {
		return tenderStart;
	}

	public void setTenderStart(Integer tenderStart) {
		this.tenderStart = tenderStart;
	}

	public Integer getTenderEnd() {
		return tenderEnd;
	}

	public void setTenderEnd(Integer tenderEnd) {
		this.tenderEnd = tenderEnd;
	}
	
	

}
