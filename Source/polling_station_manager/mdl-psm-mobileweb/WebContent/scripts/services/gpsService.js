/***
 * Project: MDL
 * Author: Rushan Arunod	
 * Module: GPS Services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.gpstrack'
angular.module('newApp').service(serviceName,['$http','$location','settings','mdl.mobileweb.service.login',
                                              function($http,$location,settings,loginService) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	
	vm.startGpsTracking = function(storeLocation,callback){
		var body ={
				"longtitude":storeLocation.longitude,
				"latitude":storeLocation.latitude };
		var authEndpoint = vm.jaxrsApiBaseUrl+'gpstrack/starttrack';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}

	vm.updateGpsTracking = function(storeLocation,callback){
		var body ={
				"longtitude":storeLocation.longitude,
				"latitude":storeLocation.latitude };
		var authEndpoint = vm.jaxrsApiBaseUrl+'gpstrack/updatetrack';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
	
	
	vm.stopGpsTracking = function(callback){
	    var body ={
				"token":"" };
		var authEndpoint = vm.jaxrsApiBaseUrl+'gpstrack/closetrack';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
	
	vm.getMapCenter = function(callback){
		var body ={
					"token":""
		};
		var authEndpoint = vm.jaxrsApiBaseUrl + 'gpstrack/getmapcenter';

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