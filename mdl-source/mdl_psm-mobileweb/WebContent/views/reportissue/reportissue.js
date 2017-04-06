/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: Report issue controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.reportissue'
angular.module('newApp').controller(controllerName,
    ['$rootScope', '$scope', '$location', 'mdl.mobileweb.service.reportIssue', 'mdl.mobileweb.service.dashboard', 'toaster',
     'mdl.mobileweb.service.json', 'modalService',
function ($rootScope, $scope, $location, reportIssueService, dashboardService, toaster, jsonService, modalService) {
    $rootScope.loginactive = false;

    var vm = this;

    vm.issue = [];
    //  vm.edited = false;
    vm.issue.selectedReasonId = "";
    vm.issue.selectedPriorityId = "";
    vm.issue.messageDescription = "";
    vm.buttonDis = false;
    vm.org_state = [];
    angular.copy(vm.issue, vm.org_state);

    vm.pollingstation_id_list = [];
    vm.pollingstation_id_list_single = [];

    vm.givenDescription = [];
    vm.pollingStationList = [];
    vm.stationcheck = function (stationid) {
        vm.issue.selectedReasonId = "";
        vm.issue.selectedPriorityId = "";
        vm.issue.messageDescription = "";
        vm.buttonDis = false;
        vm.buttonDisAll = false;
    }

    vm.getStationList = function () {
        dashboardService.getPollingStations(function (response) {
            var res = response.result.entry;
            if (jsonService.whatIsIt(res) == "Object") {
                vm.pollingStationList[0] = res;
                vm.buttonDisAll = true;
            }
            else if (jsonService.whatIsIt(res) == "Array") {
                vm.pollingStationList = res;

                for (var i = 0; i < (vm.pollingStationList).length; i++) {
                    vm.pollingstation_id_list[i] = (response.result.entry[i].id).slice();
                }
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
            toaster.pop("error", "Select a Reason!", "");
        }
        else if (vm.issue.selectedPriorityId == '') {
            toaster.pop("error", "Select Priority!", "");
        }
        else if (vm.issue.messageDescription == '') {
            toaster.pop("error", "Fill the description!", "");
        }
        else {
            vm.buttonDis = true;
            vm.pollingstation_id_list_single[0] = stationId;
            reportIssueService.reportIssue(vm.pollingstation_id_list_single, vm.issue, function (response) {
                vm.postResult = response;
                if (vm.postResult.response == "Success") {
                    //angular.copy(vm.issue, vm.org_state);
                    toaster.pop("success", "Issue Reported to the Election Manager!", "");
                    vm.buttonDis = false;
                    vm.issue = [];
                	vm.pollingstation_id_list_single = [];
                	vm.issue.selectedReasonId = "";
                	vm.issue.selectedPriorityId = "";
                	vm.issue.messageDescription = "";
                }
                else {
                	vm.issue = [];
                	vm.pollingstation_id_list_single = [];
                    toaster.pop("error", "Error Submitting the issue!", "Please try again");
                    vm.buttonDis = false;
                }
                vm.issue = [];
                angular.copy(vm.issue, vm.org_state);
                vm.pollingstation_id_list_single = [];
            	vm.issue.selectedReasonId = "";
            	vm.issue.selectedPriorityId = "";
            	vm.issue.messageDescription = "";

            });


        }
    };

    vm.reportIssueAllStations = function () {
        if (vm.issue.selectedReasonId == '') {
            toaster.pop("error", "Select a Reason!", "");
        }
        else if (vm.issue.selectedPriorityId == '') {
            toaster.pop("error", "Select Priority!", "");
        }
        else if (vm.issue.messageDescription == '') {
            toaster.pop("error", "Fill the description!", "");
        }
        else {
            vm.buttonDisAll = true;
            reportIssueService.reportIssue(vm.pollingstation_id_list, vm.issue, function (response) {
                vm.postResultAll = response;
                if (vm.postResultAll.response == "Success") {
                    //angular.copy(vm.issue, vm.org_state);

                    //angular.copy(vm.issue, vm.org_state);
                    toaster.pop("success", "Issue has been reported for all of your polling stations", "");
                    vm.buttonDisAll = false;
                    vm.issue.selectedReasonId = "";
                	vm.issue.selectedPriorityId = "";
                	vm.issue.messageDescription = "";
                }
                else {
                	vm.issue = [];
                	vm.pollingstation_id_list = [];
                    toaster.pop("error", "Error Submitting the issue to the all stations!", "Please try again");
                    vm.buttonDisAll = false;
                }
                vm.issue = [];
                angular.copy(vm.issue, vm.org_state);
            	vm.issue.selectedReasonId = "";
            	vm.issue.selectedPriorityId = "";
            	vm.issue.messageDescription = "";
            });


        }
    };

    //modalcolouredfooter
    vm.template = "views/templatemodal/modalcolouredfooter.html";
    $scope.templateModal = {
        id: "report_issue",
        header: "Confirmation",
        body: "You have unsaved data before navigating to another page. " +
  		  		"Are you sure you want to leave this page?",
        closeCaption: "No",
        saveCaption: "Yes",
        save: function () {
            vm.onRouteChangeOff();
            $location.path($location.url(vm.newUrl).hash()); //Go to page 
            modalService.close('report_issue');
        },
        close: function () {
            modalService.close('report_issue');
        }
    };

    vm.onRouteChangeOff = $scope.$on('$locationChangeStart', function (event, newUrl, oldUrl) {
        //if (!angular.equals(vm.org_state, vm.issue)) {
        // if(vm.issue.length != 0){
        if (vm.issue.selectedReasonId.length > 0 || vm.issue.selectedPriorityId.length > 0 || vm.issue.messageDescription.length > 0) {
            vm.newUrl = newUrl;
            event.preventDefault();

            modalService.load('report_issue');
        }
    });


}]);