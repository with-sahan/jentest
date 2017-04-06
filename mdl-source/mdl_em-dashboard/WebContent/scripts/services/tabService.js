/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM accordion service
 */

'use strict';

var serviceName = 'mdl.em.service.emtabServices'
angular.module('newApp').service(serviceName,
		['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
        function($http, $cookieStore, $location,settings,loginService) {
		
	var vm = this;
	
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	
	vm.getPrePollActivities = function(callback){
		var token = loginService.getAccessToken();
		var body ={
				"getprepollactivities_v2":{ 
					"token":token,
					"polling_station_id":polling_station_id,
				 }
		};
		var authEndpoint = vm.webApiBaseUrl+'services/getprepollactivities_v2/getprepollactivities_v2';

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
	
	/*vm.getBallotAccounts = function(callback){
		var token = loginService.getAccessToken();
		var body ={
				"getallclosestats":{ 
					"token":token, 
				 }
		};
		var authEndpoint = vm.webApiBaseUrl+'services/getallclosestats/getallclosestats';

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
	
	vm.getBallotAccountSummary = function(callback){
		var token = loginService.getAccessToken();
		var body ={
				"getallclosestatssummary":{ 
					"token":token, 
				 }
		};

		var authEndpoint = vm.webApiBaseUrl+'services/getallclosestatssummary/getallclosestatssummary';

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
	}*/

	
} ]);
	