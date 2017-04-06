/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: issue assign services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.issueAssignFetchService'
angular.module('newApp').service(serviceName,
	['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login', '$rootScope', 'toaster', '$interval','dashboardService',
    function ($http, $cookieStore, $location, settings, loginService, $rootScope, toaster, $interval, dashboardService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;
        vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.timerPromise;

        vm.pending_issues = [];

        vm.getAssignmentCountAlert = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getassignmentcountalert": {
                    "token":token
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getassignmentcountalert/getassignmentcountalert';

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

        vm.getAssignmentCountTrigger = function () {
            vm.getAssignmentCountAlert(function (response) {
                vm.issueassigncount = response.result.entry.issueassigncount;
                vm.issue_id = response.result.entry.issue_id;
                vm.pollingstationid = response.result.entry.pollingstationid;
            });
        };
        

        vm.getAssignmentCountAlert(function (response) {
        	vm.issueassigncount = response.result.entry.issueassigncount;
            vm.issue_id = response.result.entry.issue_id;
            vm.pollingstationid = response.result.entry.pollingstationid;

            $rootScope.$watch(function () { 
            	return vm.issueassigncount; 
            	return vm.issue_id;
            	return vm.pollingstationid;
            }, function (newValue, oldValue) {
                if (oldValue === undefined) {
                }
                else {
                    if ((newValue - oldValue) > 0) {
                    	dashboardService.triggerAssignCount(vm.issueassigncount, vm.issue_id, vm.pollingstationid);
                    }
                }
            }, true);

        });

        vm.timerPromise = $interval(vm.getAssignmentCountTrigger, 90000);

        $rootScope.$on('$destroy', function () {
            $interval.cancel(vm.timerPromise);
        });

    }]);