/***
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
		vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
		
		vm.getAllRoles = function(callback){
			var token = loginService.getAccessToken();
			var body = {

						"token":token,

			};
			var authEndpoint = vm.jaxrsApiBaseUrl+'role/getallroles';

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
					 	"token":token,
						};
			//console.debug("Content", body)
			var authEndpoint = vm.jaxrsApiBaseUrl+'user/getallusers';

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
						"token":token,
						"userid":userDetails.userid,	
						"firstname":userDetails.firstname,	
						"lastname":userDetails.lastname,	
						"email":userDetails.email,	
						"username":userDetails.username,
						"roleid":roleid

			};
			var authEndpoint = vm.jaxrsApiBaseUrl+'user/updateuser';

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
		
		vm.createUser= function(userDetails,callback){
			var token = loginService.getAccessToken();
			var body = {

						"token":token,	
						"firstname":userDetails.firstname,	
						"lastname":userDetails.lastname,	
						"email":userDetails.email,	
						"username":userDetails.username,
						"userpassword":userDetails.password,	
						"language_id":userDetails.language_id						

			};
			var authEndpoint = vm.jaxrsApiBaseUrl+'user/adduser';

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
		
		
		vm.getUserById= function(userid,callback){
			var token = loginService.getAccessToken();
			var body = {
						"token":token,
						"userid":userid
			};
			var authEndpoint = vm.jaxrsApiBaseUrl+'user/getuserbyid';

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
		
		vm.deleteUser= function(userid,callback){
			var token = loginService.getAccessToken();
			var body = {
						"token":token,
						"userid":userid
			};
			var authEndpoint = vm.jaxrsApiBaseUrl+'user/deleteuser';

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
		
		
		vm.updatePassword= function(userDetails,callback){
			var token = loginService.getAccessToken();
			var body = {
						"token":token,
						"userid":userDetails.userid,	
						"newpass":userDetails.newpass,	
						"adminpass":userDetails.adminpass

			};
			var authEndpoint = vm.jaxrsApiBaseUrl+'user/updatepassword';

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