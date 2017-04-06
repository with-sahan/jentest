//---------------------------------------------------------------------
// NAMESPACE DECLARATIONS
//---------------------------------------------------------------------
var $RESPONSE = $RESPONSE || {}; // Responses namespace

(function($RESPONSE, undefined) {

	$RESPONSE.default = {
		"error": {"success": false, "alert": {"type": "error", "message": "There was an error. Please try again or contact system administrator."}},
		"invalid": {"success": false, "alert": {"type": "error", "message": "There is a problem with your data."}}
	}

	$RESPONSE.data = {
				
		"/pub/login": {
			"POST": {
				"error": $RESPONSE.default.invalid
			},			
		},	
		
		"/api/formdesign": {
			"POST": {
				"success": {"success": true, "alert": {"type": "success", "message": "Form saved successfuly."}},
				"error": $RESPONSE.default.invalid
			},			
		},	
		
		"/api/forminstance": {
			"GET": {
				"error": {"success": false, "alert": {"type": "error", "message": "Form instance not found."}},
			},			
		},	
		
		"/api/user": {
			"POST": {
				"success": {"success": true, "alert": {"type": "success", "message": "User created successfuly."}},
				"error": $RESPONSE.default.invalid
			},			
		},	
		
		
		
		
	}

})($RESPONSE);
