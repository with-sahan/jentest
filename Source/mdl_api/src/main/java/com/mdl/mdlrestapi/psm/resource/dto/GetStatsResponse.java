package com.mdl.mdlrestapi.psm.resource.dto;

import com.mdl.mdlrestapi.util.models.PsmDashboardNotification;
import com.mdl.mdlrestapi.util.models.PsmDashboardStationData;

import java.util.List;

/**
 * Created by Thara on 3/8/2017.
 */
public class GetStatsResponse {
    public int ballotPapers;
    public int postalPacks;
    public double percentage;

    public List<PsmDashboardStationData> dashboardData;
    public List<PsmDashboardNotification> dashboardNotifications;


}
