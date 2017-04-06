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
	vm.mdlApiBaseUrl = settings.mdljaxrsApiBaseUrl;

	
	vm.getPrePollActivities = function(callback){
		var body ={
			"polling_station_id":polling_station_id,
		};
		var authEndpoint = vm.mdlApiBaseUrl + 'polling-station/pre-poll-activities';

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
	