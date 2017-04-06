package com.mdl.mdlrestapi.psm.resource;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.resource.dto.ElectionResponse;
import com.mdl.mdlrestapi.psm.resource.dto.GetStatsRequest;
import com.mdl.mdlrestapi.psm.resource.dto.GetStatsResponse;
import com.mdl.mdlrestapi.psm.resource.dto.TokenRequest;
import com.mdl.mdlrestapi.psm.service.PSMDashBoardService;
import com.mdl.mdlrestapi.psm.service.impl.PSMDashBoardServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;


import com.mdl.mdlrestapi.util.models.UpdatePrePollingActivityRequest;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;


/**
 * Created by Thara on 3/7/2017.
 */
@Path("/psmdashboard")
public class PSMDashBoardResource {
    PSMDashBoardService psmDashBoardService =new PSMDashBoardServiceImpl();
    private static final Logger logger = Logger.getLogger(PSMDashBoardResource.class);

    @POST
    @Path("/getstats")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response GetStats(GetStatsRequest request){
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();

        } else {
            try {
                Gson gson = new Gson();
                GetStatsResponse getStatsResponse=psmDashBoardService.getStats(request);
                return Response.ok(gson.toJson(getStatsResponse)).build();
            } catch (Exception ex) {
                logger.error(ex.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }

    @POST
    @Path("/getelectionsbyuser")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response GetElectionsByUser(TokenRequest request) {
        if (!RequestValidationUtil.inputValidation(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();

        } else {
        try {
            Gson gson = new Gson();
            ArrayList<ElectionResponse> electionList=psmDashBoardService.getElectionList(request);
            return Response.ok(gson.toJson(electionList)).build();
        } catch (Exception ex) {
            logger.error(ex.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
        }
        }
    }

    @POST
    @Path("/updateprepollingactivity")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updatePrePollingActivity(List<UpdatePrePollingActivityRequest> updateList){
        String result = "Error";
        if (!RequestValidationUtil.listValidate(updateList)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }
        try {
            result = psmDashBoardService.updatePrePollingActivity(updateList);
        } catch (Exception e) {
            logger.error(e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage()).build();
        }
        return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
    }
}
