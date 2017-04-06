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
	vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	
	
	
	vm.getNewNotificationCount = function(callback){
		var body ={"token":"" };
		var authEndpoint = vm.jaxrsApiBaseUrl+'notification/pulse';
			
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
	
	vm.getTopNotifications = function(callback){
		var body ={"token":"" };
		var authEndpoint = vm.jaxrsApiBaseUrl+'notification/top';
			
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
		
		var body = {"token":""};
		var authEndpoint = vm.jaxrsApiBaseUrl+'notification/all';
			
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
		
		var body = {"notification_id": notification_id };
		var authEndpoint = vm.jaxrsApiBaseUrl+'notification/read';
			
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