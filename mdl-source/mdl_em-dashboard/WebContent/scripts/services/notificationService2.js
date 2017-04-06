/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM notification service
 */

'use strict';

var serviceName = 'mdl.em.service.notificationServices'
angular.module('newApp').service(serviceName, 
		['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login',
		 function ($http, $cookieStore, $location, settings, loginService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;
        vm.mdlApiBaseUrl = settings.mdljaxrsApiBaseUrl;
        vm.getAllNotifications = function(callback){
    		
    		var token = loginService.getAccessToken();
    		var body = {
    				"getglobalnotifications ":{ 
    					"token":token 
    				} 
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/getglobalnotifications/getglobalnotifications';
    			
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
        
        vm.getlNotificationsByHierarchy = function(hierarchyid,callback){
    		
    		var token = loginService.getAccessToken();
    		var body = {"token":token,"hierarchyId":hierarchyid};
    		
    		
    		var authEndpoint = vm.mdlApiBaseUrl+'services/notificationsbyhierarchy';
    			
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
        
        vm.getNotificationByID = function(callback, notificationid){
    		
    		var token = loginService.getAccessToken();
    		var body = {
    				"getnotificationbyid ":{ 
    					"token":token,
    					"notificationid":notificationid
    				} 
    		};
    		console.debug("Content", body)
    		var authEndpoint = vm.webApiBaseUrl+'services/getnotificationbyid/getnotificationbyid';
    			
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
        
        vm.uploadPic = function(file) {
    		file.upload = Upload.upload({
    			url: 'https://angular-file-upload-cors-srv.appspot.com/upload',
    			data: {file: file},
    		});
    	
    		file.upload.then(function (response) {
    			$timeout(function () {
    				file.result = response.data;
    				alert("uploaded");
    			});
    		}, function (response) {
    			if (response.status > 0)
    				$scope.errorMsg = response.status + ': ' + response.data;
    		}, function (evt) {
    			// Math.min is to fix IE which reports 200% sometimes
    			file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
    		});
    	}
    }]);