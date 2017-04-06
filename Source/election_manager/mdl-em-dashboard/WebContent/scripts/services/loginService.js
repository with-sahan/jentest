/***
 * Project: MDL
 * Author: Thilina Herath
 * Module: login services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.login'
angular.module('newApp').service(serviceName, ['$http', '$cookieStore', '$location', 'settings', '$rootScope', 'mdl.mobileweb.service.jwt','toaster',
                                              function ($http, $cookieStore, $location, settings, $rootScope, jwtService, toaster) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

	$rootScope.roleId = false;
	$rootScope.userfullname = false;
	
	
	vm.getAccessToken = function(){
	    if (!jwtService.hasValidToken()) {
	        $location.path('/login');
	    }

	    return "";
	}
	
	vm.getUserRoleId = function () {
	    var claims = jwtService.decodeToken();

	    if (claims) {
	        if(claims.roleId)
	        {
	            return claims.roleId;
	        }
	    }

	    return false;
	}
	
	
	vm.validateToken = function(token){
	    if (!jwtService.hasValidToken()) {
	        $location.path('/login');
	    }
	}
	
	
	vm.org_info = function(token, callback){		
		/*
		 *  post: Returns Info. of the organization
		 */
		var body = {"token":token};
		var orgInfoEndpoint = vm.jaxrsApiBaseUrl + 'organization/getorginfo';
			
	    $http.post(orgInfoEndpoint, body, {
	        headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
            // success
        	callback(response);
        	
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + orgInfoEndpoint);
       	    //callback(errResponse);
       });
	}	
	
	vm.login = function(user, callback){

		var authEndpoint = vm.jaxrsApiBaseUrl + 'login';
				
	    $http.post(authEndpoint, user, {
	        headers: {
			   'Content-Type': 'application/json',
			   'Accept': 'application/json'
			 }})
        .success(function (response) {
            if (response.jwt) {

                var userToken = response.token;

                var claims = jwtService.decodeToken(response.jwt);

                if (claims && claims.roleId) {

                    if (claims.roleId == 1) {
                        toaster.pop("error", "Access Denied", "PO has no access previledges for EM");
                        $location.path('/login');
                    }
                    else {

                        jwtService.setToken(response.jwt);

                        $rootScope.roleId = vm.getUserRoleId();

                        $rootScope.loginactive = false;

                        vm.org_info(userToken, function (response) {
                            $rootScope.logourl = response.logourl;
                            $rootScope.organization = response.organization;
                            $rootScope.userfullname = response.userfullname;
                        });

                        $location.path('/');

                        callback(userToken);
                    }
                }
            }
        })
        .error(function (errResponse) {
            var response = "";

            if (errResponse.status == 400 || errResponse.status == 401) {
                response = "unauthorized";
            }
            console.log("error from" + authEndpoint);
            console.log(errResponse);
            callback(response);
       });
	}
	
	
    vm.logout = function(){
        var logoutEndpoint = vm.jaxrsApiBaseUrl + 'logout';
        var body = {};
        $http.get(logoutEndpoint, null, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            jwtService.setToken(null);
            $location.path('/login');
        })
	}
	

    /* Define Access Rules  */
    $rootScope.accessObj = [];
    $rootScope.accessObj['2'] = ["login", "dashboard-summary", "openstation","closestation", "trackprogress", "all_issues", "notifications", "ballotaccount", "analytics", "psichecklist","formreports"];
    $rootScope.accessObj['3'] = ["login", "dashboard-summary", "openstation", "closestation", "all_issues", "notifications", "analytics", "psichecklist"];
    $rootScope.accessObj['4'] = ["login", "all_issues"];
    $rootScope.accessObj['5'] = ["login", "dashboard-summary", "openstation", "closestation", "ballotaccount", "analytics"];
    $rootScope.accessObj['7'] = ["login", "dashboard-summary", "openstation", "closestation", "trackprogress", "all_issues", "notifications", "ballotaccount", "analytics", "admin", "managepollingstationdetails",
        "electionconfiguration", "orgsetup", "manageroles", "manageusers", "adduser", "edituser", "deleteuser","formreports","changepass"];

    $rootScope.checkAccess = function (cur_url) {
        $rootScope.roleId = vm.getUserRoleId();
        if ($rootScope.roleId) {
            var accessList = $rootScope.accessObj[$rootScope.roleId];
            if (cur_url.length == 0)
                cur_url = "analytics";
            if (accessList.indexOf(cur_url) != -1) {
                return true;
            }
        }
        return false;
    }
	
    vm.checkAccess = function (url) {
        return $rootScope.checkAccess(url);
    }
	
} ]);