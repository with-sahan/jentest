package com.mdl.mdlrestapi.util.models;

import java.util.List;

public class PsmDashboardDto {
	public int ballotPapers;
	public int postalPacks;
	public double percentage;
	
	public List<PsmDashboardStationData> dashboardData;
	public List<PsmDashboardNotification> dashboardNotifications;
}
