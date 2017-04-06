/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: issue services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.chatFetchService'
angular.module('newApp').service(serviceName,
	['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login', '$rootScope', 'toaster', '$interval','dashboardService',
    function ($http, $cookieStore, $location, settings, loginService, $rootScope, toaster, $interval, dashboardService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;
        vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.timerPromise;

        vm.pending_issues = [];

        vm.getChatCount = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getchatcountalert_v2": {
                    "token":token
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getchatcountalert_v2/getchatcountalert_v2';

            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
		    .success(function (response) {
		        // success
		        //console.log(response);
		        callback(response);
		    })

		    .error(function (errResponse) {
		        console.log(" Error returning from " + authEndpoint);
		        callback(errResponse);
		    });

        };

        vm.getChatCountTrigger = function () {
            vm.getChatCount(function (response) {
                vm.pending_chats = response.result.entry.chatcount;
                vm.issue_id = response.result.entry.issueid;
                vm.pollingstation_id = response.result.entry.pollingstationid;
                vm.status = response.result.entry.issue_status;
            });
        };
        

        vm.getChatCount(function (response) {
        	vm.pending_chats = response.result.entry.chatcount;
        	vm.issue_id = response.result.entry.issueid;
        	vm.pollingstation_id = response.result.entry.pollingstationid;
        	vm.status = response.result.entry.issue_status;

            $rootScope.$watch(function () { 
            	return vm.pending_chats; 
            	return vm.issue_id;
            }, function (newValue, oldValue) {
                if (oldValue === undefined) {
                }
                else {
                    if ((newValue - oldValue) > 0) {
                    	dashboardService.triggerIssueCount(vm.pending_chats, vm.issue_id, vm.pollingstation_id, vm.status);
                    }
                }
            }, true);

        });

        vm.timerPromise = $interval(vm.getChatCountTrigger, 90000);

        $rootScope.$on('$destroy', function () {
            $interval.cancel(vm.timerPromise);
        });

    }]);