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
            var body = {
                "token":""
            };
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'chat/counter-alert-v1';

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
        
        /* The following section was used for issue Bell notification, commented on 24-04-16  */

        vm.getChatCountTrigger = function () {
           vm.getChatCount(function (response) {
                vm.pending_chats = response.chatcount;
                vm.issue_id = response.issueid;
                //$rootScope.pending_chats = vm.pending_chats;
            });
        };
        

        vm.getChatCount(function (response) {
        	vm.pending_chats = response.chatcount;
        	vm.issue_id = response.issueid;

            $rootScope.$watch(function () { 
            	return vm.pending_chats; 
            	return vm.issue_id;
            }, function (newValue, oldValue) {
                if (oldValue === undefined) {
                }
                else {
                    if ((newValue - oldValue) > 0) {
                    	dashboardService.triggerIssueCount(vm.pending_chats, vm.issue_id);
                    }
                }
            }, true);

        }); 

        vm.timerPromise = $interval(vm.getChatCountTrigger, 90000);

        $rootScope.$on('$destroy', function () {
            $interval.cancel(vm.timerPromise);
        });

    }]);