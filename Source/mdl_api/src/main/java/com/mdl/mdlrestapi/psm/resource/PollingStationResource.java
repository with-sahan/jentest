package com.mdl.mdlrestapi.psm.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.apache.log4j.Logger;

import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.utils.RequestValidationUtil;
import com.mdl.mdlrestapi.psm.service.PollingStationService;
import com.mdl.mdlrestapi.psm.service.impl.PollingStationServiceImpl;

/**
 * Created with IntelliJ IDEA. User: AnushaP Date: 2/21/17 Time: 5:04 PM To
 * change this template use File | Settings | File Templates.
 */
@Path("/polling-station")
public class PollingStationResource {
	private static final Logger logger = Logger.getLogger(PollingStationResource.class);

	private PollingStationService pollingStationService = new PollingStationServiceImpl();

	@POST
	@Path("/bpa-status")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getBPAStatus(ElectionStatusRequest request) {
		if (!inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getBPAStatus(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/open-station")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response openStation(PollingStationRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.openPollingStation(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/close-station")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response closeStation(PollingStationRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.closePollingStation(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/post-poll-activity")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getPostPollActivity(PostPollingActivityRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getPostPollActivity(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/bpa-station-by-station")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getBPAStationByStation(StationRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getBPAStationByStation(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/bpa-generate")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response generateBPA(ElectionStatusRequest request) {
		if (!inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.generateBPA(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/election-status")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getElectionStatus(ElectionStatusRequest request) {
		if (!inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getElectionStatus(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	private boolean inputValidation(ElectionStatusRequest request) {
		if (request == null) {
			return false;
		} else if (request.getToken() == null || request.getToken().isEmpty()) {
			return false;
		} else if (request.getStationid() == 0) {
			return false;
		}
		return true;
	}

	@POST
	@Path("/pre-poll-activity")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updatePrePollingActivity(PrePollingActivity request) {
		if (!inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.updatePrePollingActivity(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/pre-poll-activities")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getPrePollingActivity(PrePollingActivity request) {
		if (!inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getPrePollActivity(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	private boolean inputValidation(PrePollingActivity request) {

		if (request == null) {
			return false;
		} else if (request.getToken() == null || request.getToken().isEmpty()) {
			return false;
		} else if (request.getPollingstationid() == 0) {
			return false;
		}
		return true;
	}

	@POST
	@Path("/elections-station")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getElectionsOfStation(StationRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getElectionsByStation(request.getToken(), request.getStationid());
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/stations")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getStations(TokenRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getPollingStations(request.getToken());
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/closed-status")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getClosedStatus(StationRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getPollingStationsClosedStatus(request.getToken(), request.getStationid());
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/close-stat")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateCloseStat(CloseStationStatRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.updateStationCloseStat(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/contact")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getPollingContact(TokenRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getPollingContact(request.getToken());
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/completeprogresssequence")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response completeProgressSequence(PollingStationRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.completeProgressSequence(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/getprogress")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getProgress(BallotCloseStatRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getProgress(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/updateprogress")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateProgress(UpdateProgressRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.updateProgress(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/findbyid")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response getStationById(StationRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.getPollingStationByStationId(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

	@POST
	@Path("/update")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response updateStation(StationUpdateRequest request) {
		if (!RequestValidationUtil.inputValidation(request)) {
			return Response.status(Response.Status.BAD_REQUEST.getStatusCode()).build();
		}
		String result = null;
		try {
			result = pollingStationService.updateStation(request);
		} catch (Exception e) {
			logger.error(e);
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()).entity(e.getMessage())
					.build();
		}
		return Response.status(Response.Status.OK.getStatusCode()).entity(result).build();
	}

}
