/***
 * Project: MDL
 * Author: Thilina Herath
 * Module: Report issue controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.reportissue'
angular.module('newApp').controller(controllerName,
    ['$rootScope', '$scope', '$location','mdl.mobileweb.service.reportIssue', 'mdl.mobileweb.service.dashboard', 'toaster',
     'mdl.mobileweb.service.json',
function ($rootScope, $scope, $location,reportIssueService, dashboardService, toaster,jsonService) {
    $rootScope.loginactive = false;

    var vm = this;

    vm.issue = {};
    vm.issue.selectedReasonId = "";
    vm.issue.selectedPriorityId = "";
    vm.issue.messageDescription = "";
    vm.buttonDis = false;

    vm.givenDescription = [];
    vm.pollingStationList = [];

    vm.stationcheck = function(stationid) {
    	 	vm.issue.selectedReasonId = "";
    	    vm.issue.selectedPriorityId = "";
    	    vm.issue.messageDescription = "";
    	    vm.buttonDis = false;
    }

    vm.getStationList = function () {
        dashboardService.getPollingStations(function (response) {
            var res = response;
			if(jsonService.whatIsIt(res)=="Object"){
				vm.pollingStationList[0] = res;
			}
			else if(jsonService.whatIsIt(res)=="Array"){
				vm.pollingStationList = res;
			}

        })
    }
    vm.getStationList();

    vm.getIssueList = function () {
        reportIssueService.getIssues(function (response) {
            vm.selectedReason = response.result.entry;

        })
    }
    vm.getIssueList();

    vm.priority = [
    { ID: '1', PriorityTitle: 'Low' },
    { ID: '2', PriorityTitle: 'Medium' },
    { ID: '3', PriorityTitle: 'High' },
    ];


    vm.submitDescription = function (stationId) {
        if (vm.issue.selectedReasonId == '') {
            toaster.pop("error","Select a Reason!","");
        }
        else if(vm.issue.selectedPriorityId == ''){
        	toaster.pop("error","Select Priority!","");
        }
        else if(vm.issue.messageDescription == ''){
        	toaster.pop("error","Fill the description!","");
        }
        else {
        	vm.buttonDis = true;
            reportIssueService.submitDescription(-1, stationId, vm.issue, function (response) {
                vm.postResult = response;
                console.log(response);
                if(response.response=="success"){
                	toaster.pop("success","Issue Reported to the Election Manager!","");
                	$location.path('/');
                }
                else{
                	toaster.pop("error","Error Submitting the issue!","Please try again");
                }
            });


        }
    };


}]);
