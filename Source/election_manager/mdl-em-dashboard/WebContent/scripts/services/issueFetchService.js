'use strict';

var serviceName = 'mdl.em.service.emissueFetchServices'
angular.module('newApp').service(serviceName,
	['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login', '$rootScope', 'toaster', '$interval','dashboardService',
    function ($http, $cookieStore, $location, settings, loginService, $rootScope, toaster, $interval, dashboardService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;
        vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.timerPromise;

        vm.pending_issues = [];

        vm.getOpenIssues = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
                    "token": token
            };
            var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/count-graphstats';

            //	return (vm.preactresponse);	//To Remove
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
        
       /* vm.getOpenIssuesTrigger = function () {
            vm.getOpenIssues(function (response) {
                vm.pending_issues = response.result.entry.openissues;
            });
        };
        

        vm.getOpenIssues(function (response) {
            vm.pending_issues = response.result.entry.openissues;

            $rootScope.$watch(function () { return vm.pending_issues; }, function (newValue, oldValue) {
                if (oldValue === undefined) {
                }
                else {
                    if ((newValue - oldValue) > 0) {
                    	dashboardService.triggerNotification(vm.pending_issues);
                        //toaster.pop("info", "A New Issue Has Been Reported.", "Please take appropriate action");
                    }
                }
            }, true);

        });

        vm.timerPromise = $interval(vm.getOpenIssuesTrigger, 90000);

        $rootScope.$on('$destroy', function () {
            $interval.cancel(timerPromise);
        });*/

    }]);