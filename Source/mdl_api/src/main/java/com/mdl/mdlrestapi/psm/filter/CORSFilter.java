package com.mdl.mdlrestapi.psm.filter;

import com.mdl.mdlrestapi.psm.utils.ConfigUtil;
import com.sun.jersey.spi.container.ContainerRequest;
import com.sun.jersey.spi.container.ContainerResponse;
import com.sun.jersey.spi.container.ContainerResponseFilter;
import org.apache.log4j.Logger;

public class CORSFilter implements ContainerResponseFilter {
    private static final Logger logger = Logger.getLogger(CORSFilter.class);

    @Override
    public ContainerResponse filter(ContainerRequest request,
            ContainerResponse response) {

        String origin = request.getHeaderValue("Origin");
        if(origin != null && !origin.isEmpty()) {
            if (ConfigUtil.DOMAINS.contains(origin)) {
                response.getHttpHeaders().add("Access-Control-Allow-Origin", origin);
            }
        }
        if(response.getHttpHeaders().containsKey("Content-Disposition")) {
            response.getHttpHeaders().add("Access-Control-Allow-Headers",
                    "origin, content-type, accept, authorization, Content-Disposition");
            response.getHttpHeaders().add("Access-Control-Expose-Headers", "Content-Disposition");
        }
        else {
            response.getHttpHeaders().add("Access-Control-Allow-Headers",
                    "origin, content-type, accept, authorization");
        }
        response.getHttpHeaders().add("Access-Control-Allow-Credentials", "true");
        response.getHttpHeaders().add("Access-Control-Allow-Methods",
                "GET, POST, OPTIONS");

        return response;
    }


}
