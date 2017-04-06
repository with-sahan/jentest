/***
 * Project: MDL
 * Author: Rushan Arunod
 * Module: csv File Upload
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.csvfileupload'
	angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
	                                              function($http, $cookieStore, $location,settings,loginService) {

		var vm = this;
		vm.webApiBaseUrl = settings.webApiBaseUrl;
		vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

		vm.uploadPollingStations = function(path,eid, callback){
			var token = loginService.getAccessToken();
			var body ={
					"token":token,
					"path":path,
					"electionId":eid
			};
			console.log(body);
			
			var authEndpoint = vm.jaxrsApiBaseUrl+'csvfileservice/uploadedcsv';

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
		};

		vm.filedetails = function(eid, callback){
			var token = loginService.getAccessToken();
			var body ={
					"getfilereport":{
						"token":token,
						"electionId":eid
					}
			};
			var authEndpoint = vm.webApiBaseUrl+'services/getfilereport/getfilereport';

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
		};
	}]);
