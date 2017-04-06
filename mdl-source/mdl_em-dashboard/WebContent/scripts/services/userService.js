/***
 * Project: MDL
 * Author: Rushan Arunod
 * Modified By: Akarshani Amarasinghe
 * Module: User services
 */

'use strict';

var serviceName = 'mdl.dashboard.service.user'
	angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
	                                              function($http, $cookieStore, $location,settings,loginService) {

		var vm = this;
		vm.webApiBaseUrl = settings.webApiBaseUrl;
		
		vm.getAllRoles = function(callback){
			var token = loginService.getAccessToken();
			var body = {
					"getallroles ":{ 
						"token":token,
					} 
			};
			var authEndpoint = vm.webApiBaseUrl+'services/getallroles/getallroles';

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
		
		vm.getAllUsers = function(callback){
			var token = loginService.getAccessToken();
			var body = {
					"getallusers ":{ 
						"token":token,
					} 
			};
			//console.debug("Content", body)
			var authEndpoint = vm.webApiBaseUrl+'services/getallusers/getallusers';

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
		
		
		vm.updateUser= function(userDetails,roleid,callback){
			var token = loginService.getAccessToken();
			var body = {
					"updateuser ":{ 
						"token":token,
						"userid":userDetails.userid,	
						"firstname":userDetails.firstname,	
						"lastname":userDetails.lastname,	
						"email":userDetails.email,	
						"username":userDetails.username,
						"roleid":roleid
						} 
			};
			var authEndpoint = vm.webApiBaseUrl+'services/updateuser/updateuser';

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
		
		vm.createUser= function(userDetails,callback){
			var token = loginService.getAccessToken();
			var body = {
					"adduser ":{ 
						"token":token,	
						"firstname":userDetails.firstname,	
						"lastname":userDetails.lastname,	
						"email":userDetails.email,	
						"username":userDetails.username,
						"userpassword":userDetails.password,	
						"language_id":userDetails.language_id						
						} 
			};
			var authEndpoint = vm.webApiBaseUrl+'services/adduser/adduser';

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
		
		
		vm.getUserById= function(userid,callback){
			var token = loginService.getAccessToken();
			var body = {
					"getuserbyid ":{ 
						"token":token,
						"userid":userid	} 
			};
			var authEndpoint = vm.webApiBaseUrl+'services/getuserbyid/getuserbyid';

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
		
		vm.deleteUser= function(userid,callback){
			var token = loginService.getAccessToken();
			var body = {
					"deleteuser":{ 
						"token":token,
						"usrid":userid	} 
			};
			var authEndpoint = vm.webApiBaseUrl+'services/deleteuser/deleteuser';

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
		
		
		vm.updatePassword= function(userDetails,callback){
			var token = loginService.getAccessToken();
			var body = {
					"updatepassword ":{ 
						"token":token,
						"userid":userDetails.userid,	
						"newpass":userDetails.newpass,	
						"adminpass":userDetails.adminpass
						} 
			};
			var authEndpoint = vm.webApiBaseUrl+'services/updatepassword/updatepassword';

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
		
	}]);