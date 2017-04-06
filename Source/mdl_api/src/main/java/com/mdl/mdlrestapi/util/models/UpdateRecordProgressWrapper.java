package com.mdl.mdlrestapi.util.models;

import java.util.List;

public class UpdateRecordProgressWrapper {

	public String token;
	public int electionId;
	public int pollingStationId;
	public List<RecordProgressDto> recordProgressDtoList;
}
