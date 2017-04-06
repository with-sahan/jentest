/***
 * Project: MDL
 * Author: Thilina Herath
 * Module: login services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.login'
angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','$rootScope', 
                                              function($http, $cookieStore, $location,settings,$rootScope) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	$rootScope.roleId = false;
	$rootScope.userfullname = false;
	
	vm.getUser = function(){
		if($cookieStore.get('user') == null){
			$location.path('/login');
		}
		else{
			var token = $cookieStore.get('user');
			return token;
		}
	}
	
	vm.getAccessToken = function(){
		if($cookieStore.get('accessTokenEm') == null){
			$location.path('/login');
		}
		else{
			var token = $cookieStore.get('accessTokenEm');	
			vm.validateToken(token);
			return token;
		}
	}
	
	vm.getUserRoleId =  function(){
		if($cookieStore.get('userRoleID') == null){
			return false;
		}
		else{
			var roleId = $cookieStore.get('userRoleID');	
			return roleId;
		}
	}
	
	vm.setUserRoleId =  function(userRoleID){
		$cookieStore.put('userRoleID', userRoleID);
		$rootScope.roleId=userRoleID;
	}	
	
	vm.validateToken = function(token){
		var body = {"validate_token" : {"token":token}};
		var authEndpoint = vm.webApiBaseUrl+'services/validate_token/validate_token';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	if(response.result.entry=="0"){
        		$location.path('/login');
        	}
        })
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       });
	}
	
	
	vm.org_info = function(token, callback){		
		/*
		 *  post: Returns Info. of the organization
		 */
		var body = {"getorginfo" : {"token":token}};
		var authEndpoint = vm.webApiBaseUrl+'services/getorginfo';
			
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
            // success
        	callback(response.result.entry);
        	
        })
        
        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
       	    //callback(errResponse);
       });
	}	
	
	vm.login = function(user, callback){
		var login ={"login": user};
		var authEndpoint = vm.webApiBaseUrl+'services/login/login';
				
		$http.post(authEndpoint,login,{headers: {
			   'Content-Type': 'application/json',
			   'Accept': 'application/json'
			 }})
        .success(function (response) {
        	var userToken = response.result.entry.response;
        	if (!(userToken == "unauthorized")){
        		$cookieStore.put('accessTokenEm', userToken);
        		$cookieStore.put('user', user.username);
        		$rootScope.loginactive = false;
        		$location.path('/');
        	}
        	callback(userToken);
        })
        .error(function (errResponse) {
            console.log("error from" + authEndpoint);
            console.log(errResponse);
       	    callback(errResponse);
       });
	}
	
	
    vm.logout = function(){
    	$cookieStore.remove('user');
    	$cookieStore.remove('accessTokenEm');
    	$cookieStore.remove('userRoleID');
    	$location.path('/login');
	}
	
	
	
} ]);