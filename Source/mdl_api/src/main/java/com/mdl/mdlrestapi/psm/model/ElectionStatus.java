package com.mdl.mdlrestapi.psm.model;

public class ElectionStatus 
{
	private String status;
	private Integer electionStatus;
	private Integer ballotTurnout;
	private Integer tendTurnout;
	
	public ElectionStatus() 
	{

	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getElectionStatus() {
		return electionStatus;
	}

	public void setElectionStatus(Integer electionStatus) {
		this.electionStatus = electionStatus;
	}

	public Integer getBallotTurnout() {
		return ballotTurnout;
	}

	public void setBallotTurnout(Integer ballotTurnout) {
		this.ballotTurnout = ballotTurnout;
	}

	public Integer getTendTurnout() {
		return tendTurnout;
	}

	public void setTendTurnout(Integer tendTurnout) {
		this.tendTurnout = tendTurnout;
	}
	
	

}
