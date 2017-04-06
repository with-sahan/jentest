/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: Postal Votes Services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.postalvotes'
angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
                                              function($http, $cookieStore, $location,settings,loginService) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	
	vm.getBallotAccounts = function(electionid,stationid,callback){
		var body ={
				"electionid":electionid, 
				"pollingstationid" : stationid };
		console.log(body);
		var authEndpoint = vm.mdljaxrsApiBaseUrl+'ballot/close-stat';
			
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
	