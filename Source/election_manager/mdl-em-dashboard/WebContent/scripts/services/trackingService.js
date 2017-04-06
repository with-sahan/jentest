/***
 * Project: MDL
 * Author: Vindya Hettige
 * Modified: Akarshani Amarasinghe (31.01.2015)
 * Module: Ballot services
 */

'use strict';

var serviceName = 'mdl.em.service.trackingService'
angular.module('newApp').service(serviceName,
		['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
        function($http, $cookieStore, $location,settings,loginService) {
		
	var vm = this;
	
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.mdlApiBaseUrl = settings.mdljaxrsApiBaseUrl;

	vm.getMapCenter = function(callback){
		var body ={

					"token":"",
		};
		var authEndpoint = vm.mdlApiBaseUrl+ 'gpstrack/getmapcenter';

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
	
	
	
    //this is to get the geo hierarchy to the dropdown list
	vm.getGeoHierarchy = function () {
	    geoHierarchyService.getGeoHierarchy(function (response) {
	        vm.geoHierarchy = response;
	        //console.log(" vm.geoHierarchy " + vm.geoHierarchy.response);

	    })
	}

	vm.getGeoFilteredTrackingProgress = function (hierarchyid, callback) {
	    var token = loginService.getAccessToken();
	    var body = {
	        "token": token,
	        "hierarchyId": hierarchyid
	    };
	    var authEndpoint = settings.mdljaxrsApiBaseUrl + 'gpstrack/filterbyhierarchy';
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
            console.log(errResponse);
            console.log(" Error returning from " + authEndpoint);
        });
	}
	
} ]);
	