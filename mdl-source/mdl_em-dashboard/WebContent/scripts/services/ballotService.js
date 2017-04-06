/***
 * Project: MDL
 * Author: Vindya Hettige
 * Modified: Akarshani Amarasinghe (31.01.2015)
 * Module: Ballot services
 */

'use strict';

var serviceName = 'mdl.em.service.ballotService'
angular.module('newApp').service(serviceName,
		['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
        function($http, $cookieStore, $location,settings,loginService) {

	var vm = this;

	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

	vm.getBallotAccounts = function(electionid, callback){

		/* TO DO - this is the old API for Ballot account summary - no longer used, check & delete  */

		var token = loginService.getAccessToken();
		var body ={
				"getallclosestats":{
					"token":token,
					"eid":electionid
				 }
		};
		var authEndpoint = vm.webApiBaseUrl+'services/getallclosestats_v2/getallclosestats_v2';

		$http.post(authEndpoint,body,{
			headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
			}
		})
        .success(function (response) {
        	callback(response);
        })
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
        });
	}

	vm.getBallotAccounts_v2 = function(electionid, hierarchyId, callback){

		/*
		 * pre: electionid, hierarchyId => Geo Hierachi ID, callback => returns result
		 * post: fetch summary for all elections and return result with callback
		 */

		var token = loginService.getAccessToken();
		var body = {
					"token":token,
					"electionId":electionid,
					"hierarchyId":hierarchyId
				 };
		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'getstats/getallclosestats_v3';

		$http.post(authEndpoint,body,{
			headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
			}
		})
        .success(function (response) {
        	callback(response);
        })
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
        });
	}

	vm.getBallotAccountSummary = function(electionid, callback){
		var token = loginService.getAccessToken();
		var body ={
				"getallclosestatssummary_v2":{
					"token":token,
					"eid":electionid
				 }
		};
		var authEndpoint = vm.webApiBaseUrl+'services/getallclosestatssummary_v2/getallclosestatssummary_v2';

		$http.post(authEndpoint,body,{
			headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
			}
		})
        .success(function (response) {
        	callback(response);
        })
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
        });
	}

	vm.getPollingStations_V2 = function(callback){
		var token = loginService.getAccessToken();
		var body = {
    			"getpollingstations_v2":{
	    		    "token":token
    		    }
		};

		var authEndpoint = vm.webApiBaseUrl+'services/getpollingstations_v2/getpollingstations_v2';
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
            // success
        	console.log(response);
        	callback(response);
        })

        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}

	vm.getIssueListDataFiltered = function (hierarchyid,callback) {

        var token = loginService.getAccessToken();

        var body = {
			"token": token,
			"hierarchyId":hierarchyid
		};

        var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issue/filterbyhierarchy';

        $http.post(authEndpoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            callback(response);
        })
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
        });
    }

	vm.getBallotAccountSummary_v2 = function(electionid, hierarchyId, callback){

		/*
		 * pre: electionid, hierarchyId => Geo Hierachi ID, callback => returns result
		 * post: fetch summary for all elections and return result with callback
		 */

		var token = loginService.getAccessToken();
		var body = {
					"token":token,
					"electionId":electionid,
					"hierarchyId":hierarchyId
				 };
		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'getstats/getallclosestatssummary_v3';

		//console.debug("^^^");
		//console.debug(body);
		$http.post(authEndpoint,body,{
			headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
			}
		})
        .success(function (response) {
        	callback(response);
        })
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
        });
	}


} ]);
