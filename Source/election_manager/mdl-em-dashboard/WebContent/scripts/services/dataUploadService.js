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
		vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

		vm.uploadPollingStations = function(path,eid, callback){

			var body ={
					"path":path,
					"electionId":eid
			};
			console.log(body);
			
			var authEndpoint = vm.jaxrsApiBaseUrl+'media/uploadedcsv';

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
						"token":token,
						"electionId":eid
			};
			var authEndpoint = vm.jaxrsApiBaseUrl+'allfiles/getfilereport';

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
