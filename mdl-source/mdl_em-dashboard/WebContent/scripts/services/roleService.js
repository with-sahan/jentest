/***
 * Project: MDL
 * Author: Sudaraka Jayashanka
 * Module: Role services
 */

'use strict';

var serviceName = 'mdl.dashboard.service.role'
angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
                                              function($http, $cookieStore, $location,settings,loginService) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	
	vm.getAllRoles = function(callback){
		var token = loginService.getAccessToken();
		var body ={"getallroles":{ 
				"token":token}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/getallroles/getallroles';
			
//		return (vm.preactresponse);	//To Remove
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
	
	vm.addNewRole=function(roleName,description,callback){
		var token = loginService.getAccessToken();
		var body ={"addrole":{ 
				"token":token,
				"rolename":roleName,
				"description":description
		}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/addrole/addrole';
			
//		return (vm.preactresponse);	//To Remove
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
	
	vm.updateRole=function(roleid,roleName,description,callback){
		var token = loginService.getAccessToken();
		var body ={"updaterole":{ 
				"token":token,
				"roleid":roleid,
				"rolename":roleName,
				"description":description
		}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/updaterole/updaterole';
			
//		return (vm.preactresponse);	//To Remove
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
	
	vm.getRoleById=function(roleid,callback){
		var token = loginService.getAccessToken();
		var body ={"getrolebyid":{ 
				"token":token,
				"roleid":roleid
		}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/getrolebyid/getrolebyid';
			
//		return (vm.preactresponse);	//To Remove
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
	
	vm.deleteRole=function(oldroleid,newroleid,callback){
		var token = loginService.getAccessToken();
		var body ={"deleterole":{ 
				"token":token,
				"oldroleid":oldroleid,
				"newroleid":newroleid
		}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/deleterole/deleterole';
			
//		return (vm.preactresponse);	//To Remove
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
	
} ]);
	