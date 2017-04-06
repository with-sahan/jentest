package com.mdl.mdlrestapi.psm;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.mdl.mdlrestapi.util.exception.MDLServerException;

@Path("/heartbeat")
public class Heartbeat {
	private static final Logger logger = Logger.getLogger(Heartbeat.class);
	
	@POST
	@Path("/getheartbeat")
	@Produces(MediaType.APPLICATION_JSON)
	public Response GetGroHierarchy() throws MDLServerException {
		JSONObject responseobj = new JSONObject();
		try{
			
			String result="I'm alive";
			responseobj.put("response", result);
			
		}catch(Exception ex){
			logger.error(ex);
			// Do No throw Exception here
		}
		return Response.status(200).entity(responseobj.toString()).build();
	}
}
