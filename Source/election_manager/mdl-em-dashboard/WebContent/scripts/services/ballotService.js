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
					"token":token,
					"eid":electionid
		};
		var authEndpoint = vm.mdljaxrsApiBaseUrl+'ballot/close-statall';

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
		
		console.debug("***");
		console.debug(body);
		console.debug(authEndpoint);

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
					"token":token,
					"eid":electionid
		};
		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'ballot/close-statsummary';

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
	    		    "token":token
		};

		var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/polling-stations';
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

        var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/filterbyhierarchy';

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

	vm.csvBallotAccountExport = function(electionid, callback){
		var token = loginService.getAccessToken();
		var body = {
		    "token": token, 
		    "electionid": electionid
		};

		var authEndpoint = vm.mdljaxrsApiBaseUrl+'ballot/ballot-export';
		
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
	
	vm.getCsvBallotAccountUnexport = function(electionid, hierarchyId, callback){

		var token = loginService.getAccessToken();
		var body = {
				"token":token,
				"electionId":electionid,
				"hierarchyId":hierarchyId
		};
		
		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'getstats/csvballotaccountunexport';

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
