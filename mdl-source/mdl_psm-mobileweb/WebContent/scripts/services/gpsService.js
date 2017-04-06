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
	
	vm.startGpsTracking = function(storeLocation,callback){
		var token = loginService.getAccessToken();
		var body ={"trackingstart":{ 
				"token":token,
				"longtitude":storeLocation.longitude, 
				"latitude":storeLocation.latitude }};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/trackingstart/trackingstart';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	console.log(response);
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}

	vm.updateGpsTracking = function(storeLocation,callback){
		var token = loginService.getAccessToken();
		var body ={"trackingupdate":{ 
				"token":token, 
				"longtitude":storeLocation.longitude, 
				"latitude":storeLocation.latitude }};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/trackingupdate/trackingupdate';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	console.log(response);
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
	
	
	vm.stopGpsTracking = function(callback){
		var token = loginService.getAccessToken();
		var body ={"trackingclose":{ 
				"token":token }};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/trackingclose/trackingclose';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	console.log(response);
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
} ]);