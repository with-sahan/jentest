/***
 * Project: MDL
 * Author: Sudaraka Jayashanka
 * Module: login services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.notification'
angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login', 
                                              function($http, $cookieStore, $location,settings,loginService) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	
    vm.getNotificationByID = function(callback){
		var token = loginService.getAccessToken();
		var body = {
					"notificationid":notificationid,
					"token": token
		    };
		
		var authEndpoint = vm.mdljaxrsApiBaseUrl+'notification/id';

		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
            // success
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}	
	
	vm.getNewNotificationCount = function(callback){
		var token = loginService.getAccessToken();
		var body ={
				"token":token };
		console.log(body);
		var authEndpoint = vm.mdljaxrsApiBaseUrl+'notification/pulse';
			
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
	
	vm.getTopNotifications = function(callback){
	    var token = loginService.getAccessToken();
		var body ={
				"token": token};
		var authEndpoint = vm.mdljaxrsApiBaseUrl+'notification/top';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
            // success
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
	
	vm.getAllNotifications = function(callback){
		/*
		 * Post: Get all Notification (on notification -> see all page )
		 */
		var token = loginService.getAccessToken();
		var body = {"token":token};
		var authEndpoint = vm.mdljaxrsApiBaseUrl+'notification/all';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
            // success
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
	
    
	vm.confirmNotifications	= function(notification_id, callback){
		/*
		 * Post: Acknowledge a given notification
		 */
		var token = loginService.getAccessToken();
		var body = { "notification_id": notification_id,
		   "token": token};

		console.log(body);
		var authEndpoint = vm.mdljaxrsApiBaseUrl+'notification/read';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
            // success
        	callback(response);
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    callback(errResponse);
       });				
	}
	
	
} ]);