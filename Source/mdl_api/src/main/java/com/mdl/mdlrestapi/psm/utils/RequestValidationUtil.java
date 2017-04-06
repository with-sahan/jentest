package com.mdl.mdlrestapi.psm.utils;

import com.mdl.mdlrestapi.psm.resource.dto.*;
import com.mdl.mdlrestapi.psm.resource.dto.AssignIssueRequest;
import com.mdl.mdlrestapi.util.SimpleRequest;
import com.mdl.mdlrestapi.util.models.*;


import java.util.List;
import java.util.regex.Pattern;

/**
 * Created with IntelliJ IDEA.
 * User: AnushaP
 * Date: 2/24/17
 * Time: 10:34 PM
 * To change this template use File | Settings | File Templates.
 */
public class RequestValidationUtil {
	/**
	 * The minimum allowed latitude
	 */
	public static float MIN_LATITUDE = Float.valueOf("-90.0000");
	/**
	 * The maximum allowed latitude
	 */
	public static float MAX_LATITUDE = Float.valueOf("90.0000");
	/**
	 * The minimum allowed longitude
	 */
	public static float MIN_LONGITUDE = Float.valueOf("-180.0000");
	/**
	 * The maximum allowed longitude 
	 */
	public static float MAX_LONGITUDE = Float.valueOf("180.0000");

	public static boolean inputValidation(CloseStationStatRequest request) {
		if (request == null) {
			return false;
		}
		return true;
	}

	/**
	 * Returns True if valid
	 * @param request
	 * @returns boolean
	 */
	public static boolean inputValidation(TokenRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		return true;
	}

	public static boolean inputValidation(StationRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getStationid())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(ElectionRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getElectionid())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(PostPollingActivityRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getPolling_station_id())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(ChatIssueRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if(!intValidate(request.getIssueid()))  {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(IssueReportRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getElectionid(), request.getPollingstationid(),request.getIssueid() )){
			return false;
		}
        else if(!descriptionValidate(request.getDescription())){
            return false;
        }
		return true;
	}

	public static boolean inputValidation(IssueReportAllStationRequest request) {
		if (request == null) {
			return false;
		}else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
		}else if (!intValidate(request.getIssue_list_id())) {
			return false;
		}else if (!descriptionValidate(request.getDescription())) {
            return false;
        }else if (!intValidate(request.getPollingstation_id_list())) {
            return false;
        }
		return true;
	}

	public static boolean inputValidation(ChatIssueResolveRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if(!intValidate(request.getIssueid()))  {
			return false;
		}
        else if(!descriptionValidate(request.getDescription())){
            return false;
        }
		return true;
	}

	public static boolean inputValidation(BallotCloseStatRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getElectionid(), request.getPollingstationid())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(ElectionStatusRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getStationid())) {
			return false;
		}
		return true;
	}


	public static boolean inputValidation(PollingStationRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getPollingstationid())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(VoterInfoRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getPolling_station_id())){
			return false;
		}
        else if (!stringValidate(request.getVoter_name())) {
            return false;
        }
        else if (!descriptionValidate(request.getCompanion_address())) {
            return false;
        }
        else if (!stringValidate(request.getCompanion_name())) {
            return false;
        }
		return true;
	}

	public static boolean inputValidation(VoterDeleteRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getVoter_list_id())) {
			return false;
		}
		return true;
	}


	public static boolean inputValidation(StationElectionRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getElectionid(), request.getPollingstationid())) {
			return false;
		}
		return true;
	}


	public static boolean inputValidation(CollectPostalPackRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getElectionid(), request.getPollingstationid())) {
			return false;
		}
		else if (!wordsValidate(request.getperson_name())) {
			return false;
		}
		return true;
	}


	public static boolean inputValidation(CloseElectionRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getElectionid(), request.getPollingstationid())) {
			return false;
		}
		return true;
	}

	/**
	 * Returns True if valid
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(GpsRequest request){

		if(request == null){
			return false;
		} else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
        else if(!(request.getLatitude()>= MIN_LATITUDE) || !(request.getLatitude()<= MAX_LATITUDE)){
			return false;
		}else if(!(request.getLongtitude() >= MIN_LONGITUDE) || !(request.getLongtitude() <= MAX_LONGITUDE)){
			return false;
		}
        return true;
	}

	/* User request input value validation*/
	/**
	 * Returns True if valid AddUserRequest
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(AddUserRequest request) {
		if(request == null){
			return false;
		}else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
        else if(!stringValidate(request.getFirstname())){
			return false;
		}else if(!stringValidate(request.getLastname())){
			return false;
		}else if(!emailValidate(request.getEmail())){
			return false;
		}else if(!stringValidate(request.getUsername())){
			return false;
		}else if(!passwordValidate(request.getUserpassword())){
            return false ;
        }
        else if(!intValidate(request.getLanguage_id())){

			return false;
		}
		return true;

	}

	/**
	 * Returns True if valid UpdateUserRequest
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(UpdateUserRequest request) {
		if(request == null){
			return false;
		}else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
        else if(!stringValidate(request.getFirstname())){
			return false;
		}else if(!stringValidate(request.getLastname())){
			return false;
		}else if(!stringValidate(request.getUsername())){
			return false;
		}else if(!intValidate(request.getUserid())){
			return false;
		}else if(!intValidate(request.getRoleid())){
			return false;
		}
		return true;
	}

	/**
	 * Returns True if valid PasswordUpdateRequest
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(PasswordUpdateRequest request) {
		if(request == null){
			return false;
		} else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
        else if(!passwordValidate(request.getNewpass())){
			return false;
		}else if(!passwordValidate(request.getAdminpass())){
			return false;
		}else if(!intValidate(request.getUserid())){
			return false;
        }
//		else if (!request.getNewpass().equals(request.getAdminpass())){
//            return false;
//        }
		return true;
	}
    
	/**
	 * Returns True if valid GetUserByIdRequest
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(GetUserByIdRequest request) {
		if(request == null){
			return false;
		} else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
		} else if (!intValidate(request.getUserid())){
			return false;
		}
		return true;

	}

	/*Role request input value validation*/

	/**
	 * Returns True if valid AddRoleRequest
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(AddRoleRequest request) {
		if(request == null){
			return false;
		} else if (!stringNullAndEmptyValidate(request.getToken())){
			return false;
		}else if(!descriptionValidate(request.getRolename())){
			return false;
		}else if(!descriptionValidate(request.getDescription())){
			return false;
		}

		return true;

	}

	/**
	 * Returns True if valid UpdateRoleRequest
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(UpdateRoleRequest request) {
		if(request == null){
			return false;
		} else if (!stringNullAndEmptyValidate(request.getToken())){
			return false;
		}else if(!intValidate(request.getRoleid())){
			return false;
		}else if(!descriptionValidate(request.getRolename())){
			return false;
		}else if(!descriptionValidate(request.getDescription())){
			return false;
		}

		return true;

	}

	/**
	 * Returns True if valid GetRoleByIdRequest
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(GetRoleByIdRequest request) {
		if(request == null){
			return false;
		} else if (!stringNullAndEmptyValidate(request.getToken())){
			return false;
		}else if(!intValidate(request.getRoleid())){
			return false;
		}

		return true;

	}

	/**
	 * Returns True if valid DeleteRoleRequest
	 * @param request
	 * @return bolean
	 */
	public static boolean inputValidation(DeleteRoleRequest request) {
		if(request == null){
			return false;
		} else if (!stringNullAndEmptyValidate(request.getToken())){
			return false;
		}else if (!intValidate(request.getNewroleid())){
			return false;
		}else if (!intValidate(request.getOldroleid())){
			return false;
		}
		return true;

	}


    public static boolean inputValidation(LoginRequest request) {

        if(request == null){
            return false;
        }
        if (!stringValidate(request.username)) {
            return false;
        }
        if (!stringValidate(request.organization_code)) {
            return false;
        }
        if (!passwordValidate(request.usersecret)) {
            return false;
        }
        return true;
    }

    public static boolean inputValidation(ElectionCreateUpdateRequest request, boolean isUpdate) {

        if (request == null) {
            return false;
        }
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
//        if (!stringDateValidate(request.getElection_date())) {
//            return false;
//        }
//        if (!stringDateValidate(request.getEnd_time())) {
//            return false;
//        }
//        if (!stringDateValidate(request.getStart_time())) {
//            return false;
//        }
        if (!addressValidate(request.getCounting_center_address())) {
            return false;
        }
        if (!wordsValidate(request.getEname())) {
            return false;
        }
//        if (!stringValidate(request.getCounting_center_latitude())) {
//            return false;
//        }
        if (!wordsValidate(request.getCounting_center_name())) {
            return false;
        }
        return true;
    }

    public static boolean inputValidation(ElectionDeleteRequest request) {
        if (request == null) {
            return false;
        }
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
        else if (!intValidate(request.getElection_Id())) {
            return false;
        }
        return true;
    }

    public static boolean inputValidation(StationUpdateRequest request) {
        if (request == null) {
            return false;
        }
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
        else if (!intValidate(request.getElectionid(), request.getStationid())) {
            return false;
        }
        else if (!wordsValidate(request.getStationname())) {
            return false;
        }
        else if (!stringValidate(request.getBoxnumber())) {
            return false;
        }
        return true;
    }

    public static boolean inputValidation(ElectionFileUploadStatusRequest request) {
        if (request == null) {
            return false;
        }
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
        else if (!intValidate(request.getEid())) {
            return false;
        }
        return true;
    }

	public static boolean inputValidation(IssueRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getIssueid(), request.getUserid())) {
			return false;
		}
        else if (!descriptionValidate(request.getComment())) {
            return false;
        }
		return true;
	}

	public static boolean inputValidation(UserIssueRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getIssueid())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(IssueDescriptionRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getIssueid())) {
			return false;
		}
        else if (!descriptionValidate(request.getDescription())) {
            return false;
        }
		return true;
	}


	public static boolean inputValidation(FileReportRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		return true;
	}

	public static boolean inputValidation(NotificationRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		else if (!intValidate(request.getNotification_id())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(PsiCheckListRequest request) {
		if (request == null) {
			return false;
		}
        else if (!stringNullAndEmptyValidate(request.getToken())) {
            return false;
        }
		return true;
	}

    public static boolean inputValidation(CheckListUpdateDto request) {
        if (request == null) {
            return false;
        }
        else if (!stringNullAndEmptyValidate(request.token)) {
            return false;
        }
        return true;
    }

	public static boolean inputValidation(UpdateProgressRequest request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.getToken())) {
			return false;
		}
		if (!intValidate(request.getElectionid())) {
			return false;
		}
		else if (!intValidate(request.getPollingstationid(), request.getElectionid())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(UpdateRecordProgressWrapper request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.token)) {
			return false;
		}
		if (!intValidate(request.electionId)) {
			return false;
		}
		else if (!intValidate(request.pollingStationId)) {
			return false;
		}
		return true;
	}

    public static boolean inputValidation(SimpleRequest request) {
        if (request == null) {
            return false;
        }
        else if (!stringNullAndEmptyValidate(request.token)) {
            return false;
        }
        if (!intValidate(request.electionId, request.issueId)) {
            return false;
        }
        return true;
    }
	public static boolean inputValidation(GetStatsRequest request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.token)) {
			return false;
		}
		if (!intValidate(request.electionId)) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(ActivationDayRequest request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.token)) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(ReportIssueAllStationsRequest request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.token)) {
			return false;
		}
		if (!intValidate(request.getIssue_list_id())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(TenderedVotesRequest request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.getToken())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidationToken(SimpleRequest request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.token)) {
			return false;
		}
		return true;
	}

    public static boolean inputValidation(int... vals) {
        if (!intValidate(vals)) {
            return false;
        }
        return true;
    }

    public static boolean intValidate(int... vals) {

        for(int i:vals){
            if (!intValidate(i)) {
                return false;
            }
        }
      return true;
    }

    public static boolean stringsValidate(String... vals) {

        for(String s:vals){
            if (!stringValidate(s)) {
                return false;
            }
        }
        return true;
    }

    public static boolean descriptionValidate(String... vals) {

        for(String s:vals){
            if (!descriptionValidate(s)) {
                return false;
            }
        }
        return true;
    }

	public static boolean listValidate(List<UpdatePrePollingActivityRequest> list){
		if (list == null) {
			return false;
		}
		for(UpdatePrePollingActivityRequest activityRequest : list){
			if(activityRequest == null)
				return false;
			else if (!stringNullAndEmptyValidate(activityRequest.token)) {
				return false;
			}
			if (!intValidate(activityRequest.pollingstation_id, activityRequest.activity_id)) {
				return false;
			}
		}
		return true;
	}

    private static boolean stringValidate(String val) {
        if ( val == null || val.isEmpty()){
            return false;
        }
        /*First character is in a-z or A-Z, Alphanumeric and _*/
        final Pattern pattern = Pattern.compile("^[0-9A-Za-z_]++$");
        if (!pattern.matcher(val).matches()) {
            return false;
        }
        return true;
    }
    
    private static boolean wordsValidate(String val) {
        if ( val == null || val.isEmpty()){
            return false;
        }
        /*First character is in a-z or A-Z, Alphanumeric and _ space character */
        final Pattern pattern = Pattern.compile("^[a-zA-Z0-9][0-9A-Za-z_ ]++$");
        if (!pattern.matcher(val).matches()) {
            return false;
        }
        return true;
    }
    
    private static boolean addressValidate(String val) {
        if ( val == null || val.isEmpty()){
            return false;
        }
        /*First character is in a-z or A-Z, Alphanumeric and _ space character */
        final Pattern pattern = Pattern.compile("^[a-zA-Z0-9][0-9A-Za-z-, ]++$");
        if (!pattern.matcher(val).matches()) {
            return false;
        }
        return true;
    }
    
    private static boolean emailValidate(String val) {
        if ( val == null || val.isEmpty()){
            return false;
        }
        final Pattern pattern = Pattern.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
        if (!pattern.matcher(val).matches()) {
            return false;
        }
        return true;
    }

    private static boolean descriptionValidate(String val) {
        if ( val == null || val.isEmpty()){
            return false;
        }
        final Pattern pattern = Pattern.compile("^[0-9A-Za-z,!$&_+|@:)(;.\\s ]++$");
        if (!pattern.matcher(val).matches()) {
            return false;
        }
        return true;
    }

    private static boolean stringDateValidate(String val) {
        if ( val == null || val.isEmpty()){
            return false;
        }
        return true;
    }

    private static boolean passwordValidate(String val) {
        if (val == null || val.isEmpty() ){
            return false;
        }
        return true;
    }

    private static boolean intValidate(int val) {
        if (val <= 0) {
            return false;
        }
        return true;
    }

    private static boolean stringNullAndEmptyValidate(String val) {
        if ( val == null || val.isEmpty()){
            return false;
        }
        return true;
    }


	public static boolean inputValidation(AssignIssueRequest request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.getToken())) {
			return false;
		}
		if (!intValidate(request.getIssueId(), request.getUserId())) {
			return false;
		}
		return true;
	}

	public static boolean inputValidation(IssueNotificationRequest request) {
		if (request == null) {
			return false;
		}
		else if (!stringNullAndEmptyValidate(request.getToken())) {
			return false;
		}
		if (!intValidate(request.getIssuenotificationid())) {
			return false;
		}

		return true;
	}

}
