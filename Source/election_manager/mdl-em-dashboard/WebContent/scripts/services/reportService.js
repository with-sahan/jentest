/***
 * Project: MDL Dashboard
 * Author: Rushan Arunod
 * Module: EM Hourly Analysis
 */

'use strict';

var serviceName = 'mdl.em.service.reportService'
	angular.module('newApp').service(serviceName, ['$http', 'settings', 'mdl.mobileweb.service.login', '$window',
	                                               function($http, settings, loginService, $window) {
		var vm = this;
		vm.jaxRSApiBaseUrl = settings.mdljaxrsApiBaseUrl;

		vm.getHourlyAnalysisData = function(hierarchyId,callback){
			vm.body = {
					"token":"",
					"hierarchyId":hierarchyId
			}
			var authEndPoint = vm.jaxRSApiBaseUrl + 'reports/hourlyanalysis';

			$http.post(authEndPoint,vm.body,{headers: {
				'Content-Type': 'application/json',
				'Accept': 'application/json'
			}})
			.success(function(response){
				callback(response);
			})
			.error(function (errResponse) {
				console.log(" Error returning from " + authEndPoint);
				callback(errResponse);
			});
		}
		

		vm.getTenderedBallotsData = function(hierarchyId, callback){
			vm.body = {
					"token":"",
					"hierarchyId":hierarchyId	
			}
			console.log(vm.body);
			var authEndPoint = vm.jaxRSApiBaseUrl + 'reports/gettenderedvotelist';
	
			$http.post(authEndPoint,vm.body,{headers: {
				'Content-Type': 'application/json',
				'Accept': 'application/json'
			}})
			.success(function(response){
				callback(response);
			})
			.error(function (errResponse) {
				console.log(" Error returning from " + authEndPoint);
				callback(errResponse);
			});
		}
	}
	]);
