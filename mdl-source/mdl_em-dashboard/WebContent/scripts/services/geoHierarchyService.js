/***
 * Project: MDL
 * Author: Sudaraka
 */

'use strict';

var serviceName = 'mdl.em.service.geoHierarchyService'
angular.module('newApp').service(serviceName,
		['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
        function($http, $cookieStore, $location,settings,loginService) {
		
	var vm = this;
	
	vm.webApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	
	vm.getGeoHierarchy = function(callback){
		var token = loginService.getAccessToken();
		var body ={"token":token};
		var authEndpoint = vm.webApiBaseUrl+'geohierarchy/getgeohierarchy';

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
	