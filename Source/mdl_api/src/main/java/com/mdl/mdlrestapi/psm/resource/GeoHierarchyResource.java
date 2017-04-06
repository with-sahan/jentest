package com.mdl.mdlrestapi.psm.resource;

import com.google.gson.Gson;
import com.mdl.mdlrestapi.psm.service.GeoHierarchyService;
import com.mdl.mdlrestapi.psm.service.impl.GeoHierarchyServiceImpl;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.util.SimpleRequest;
import org.apache.log4j.Logger;

import javax.ws.rs.OPTIONS;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import java.util.ArrayList;

/**
 * Created by lasantha on 3/8/2017.
 */
@Path("/geohierarchy")
public class GeoHierarchyResource {
    private static final Logger logger = Logger.getLogger(GeoHierarchyResource.class);
    GeoHierarchyService geoHierarchyService = new GeoHierarchyServiceImpl();

    @POST
    @Path("getgeohierarchy")
    public Response FilterByHierarchy(SimpleRequest request) {
        if (!RequestValidationUtil.inputValidationToken(request)) {
            return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
        }else {
            try {
                Gson gson = new Gson();
                ArrayList<String> resultMap = geoHierarchyService.prepareHierarchy(request.token);
                return Response.ok(gson.toJson(resultMap)).build();
            } catch (Exception e) {
                logger.error(e.getMessage());
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).build();
            }
        }
    }
}
