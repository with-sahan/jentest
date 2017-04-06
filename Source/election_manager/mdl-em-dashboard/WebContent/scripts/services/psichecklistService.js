/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM PSI Checklist service
 */

'use strict';

var serviceName = 'mdl.em.service.psichecklistService'
angular.module('newApp').service(serviceName,
	['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login',
    function ($http, $cookieStore, $location, settings, loginService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;
        vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.getPlacesList = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
        			"token":token
        		}
						var authEndpoint = vm.mdljaxrsApiBaseUrl+'psichecklist/list-places';

            $http.post(authEndpoint, body, {
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
        	};




        vm.getPSIChecklist = function (place_id, callback) {
            var token = loginService.getAccessToken();
            var body = {
        			"token":token,
        			"place_id":place_id
        	};
            var authEndpoint = vm.mdljaxrsApiBaseUrl+'psichecklist/checklist';
            $http.post(authEndpoint, body, {
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

        vm.getPsiChecklistGroups= function(place_id, callback){
        	var token = loginService.getAccessToken();
        	var body = {
            			"token":token,
            			"place_id":place_id
            	};
        	var authEndpoint = vm.mdljaxrsApiBaseUrl+'psichecklist/checklist-category';
        	$http.post(authEndpoint, body, {
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

        vm.updatePSIChecklist = function(reqlist,callback){
					
        	var token = loginService.getAccessToken();
        	var body = {
					   "token": token,
					   "checkListUpdateData":reqlist// [{"placeId":1127,"activityId":3133,"isCompleted":1}]
					};

    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'psichecklist/psichecklistupdate';

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

    	};

    }]);
