/***
 * Project: MDL Dashboard
 * Author: Niranjan Thilakarathna
 * Module: BOF Tendered votes
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.tenderedvotes';

angular.module('newApp').controller(controllerName, ['$scope', 'mdl.mobileweb.service.formService', 'mdl.mobileweb.service.dashboard',
    'toaster', '$routeParams', '$location', 'modalService',
    function($scope, formService, dashboardService, toaster, $routeParams, $location, modalService) {

        var vm = this;
        vm.tvid = $routeParams.id;
        vm.electionList = [];
        vm.pollingStationList = [];
        vm.stationid = 0;
        vm.curPage = 1;
        vm.pageSize = 10;

        //Get polling station list for particular PSM
        vm.getStationList = function() {
            dashboardService.getPollingStations(function(response) {
                vm.pollingStationList = response;
                if (vm.pollingStationList[0]) {
                    vm.stationname = vm.pollingStationList[0].name;
                    vm.stationcheck(vm.pollingStationList[0].id);
                    vm.getEList(vm.pollingStationList[0].id);
                }
            });
        };

        vm.getStationList();

        //Get all election in particular polling station
        vm.getEList = function(stationid) {
            dashboardService.getEllectionList(stationid, function(response) {
                vm.electionList = response;
                vm.currentElection = vm.electionList[0].electionid;
            })
        };

        vm.stationcheck = function(stationid) {
            vm.stationid = stationid;
            vm.selectedStation = stationid;
        };

        // set active station and station name
        vm.setStation = function(stationid, stationname) {
            vm.stationid = stationid;
            vm.selectedStation = stationid;
            vm.stationname = stationname;
            vm.electionlist = [];
            vm.getEList(stationid);
        };

        //set active election
        vm.setElection = function(electionid) {
            vm.currentElection = electionid;
        };

        /* List of Tendered Votes Apis */

        vm.tenderedvoteslist = [];

        //View All Tendered votes/
        vm.getAllTenderedVotes = function() {
            formService.getAllTenderedVotes(function(response) {
                vm.tenderedvoteslist = response;
            });
        };

        //Get tendered votes by given ID
        vm.getTenderedVotesById = function() {
            formService.getTenderedVotesById(vm.tvid, function(response) {
                if (response[0].response === "success") {
                    vm.tenderedvoteslist = [];
                    vm.tenderedvoteslist = response[0];
                    vm.tenderedvoteslist.votername = vm.tenderedvoteslist.votername;
                }
            });
        }

        //Add new tendered votes
        vm.submitTenderedVotes = function(tenderedvoteslist) {
            if (vm.isValidInput(tenderedvoteslist)) {
                formService.submitTenderedVotes(vm.stationid, vm.currentElection, vm.tenderedvoteslist, function(response) {
                    if (response.response == "success") {
                        toaster.pop("success", "Record Successfully Submitted", "");
                        $location.path('/forms/tenderedvotes');
                    } else if (response.response == "duplicate") {
                        toaster.pop("error", "Duplicate Entry", "Please double check the input");
                    } else {
                        toaster.pop("error", "Error Submitting the Record!", "Please try again");
                    }
                });
            }
        };

        //Edit tendered votes details
        vm.updateTenderedVotes = function(tenderedvoteslist) {
            if (vm.isValidInput(tenderedvoteslist)) {
                formService.updateTenderedVotes(tenderedvoteslist, function(response) {
                    if (response.response === "success") {
                        toaster.pop("success", "Record Successfully Updated", "");
                        $location.path('/forms/tenderedvotes');
                      } else if (response.response == "duplicate") {
                          toaster.pop("error", "Duplicate Entry", "Please double check the input");
                      } else {
                          toaster.pop("error", "Error Submitting the Record!", "Please try again");
                      }
                });
            }
        };

        //Delete tendered votes
        vm.deleteTenderedVotes = function(tenderedvoteslist) {
            formService.deleteTenderedVotes(tenderedvoteslist, function(response) {
                if (response.response === "success") {
                    toaster.pop("success", "Record Successfully Deleted", "");
                    $location.path('/forms/tenderedvotes');
                } else {
                    toaster.pop("error", "Error Deleting the Record!", "Please try again");
                }
            });
        }

        //Path Logics
        if ($location.path() === "/forms/tenderedvotes")
            vm.getAllTenderedVotes();
        if (typeof vm.tvid !== 'undefined') {
            vm.getTenderedVotesById();
        }

        //modalinfo
        vm.info = "views/forms/tenderedvotes/InfoForms.html";
        vm.infoModal = {
            id: "infoid"
        };

        vm.getInfo = function() {
            vm.infoModal = {
                id: "infoid",
                body: "this is the information",
                closeCaption: "Cancel",
                saveCaption: "OK",
            };
            vm.infoModal.close = function() {
                modalService.close('infoid');
            };
            modalService.load('infoid');
        };

        vm.isValidInput = function(tenderedvoteslist) {
            if ((tenderedvoteslist.votername === undefined) || (vm.tenderedvoteslist
                    .votername === '')) {
                toaster.pop("error", "Please Enter a Valid Voter Name", "");
                return false;
            } else if (tenderedvoteslist.votername.length > 100) {
                toaster.pop("error", "Voter Name is too long", "");
                return false;
            } else if ((tenderedvoteslist.electornumber === undefined) || (tenderedvoteslist.electornumber === null)) {
                toaster.pop("error", "Please Enter a Valid Elector Number", "");
                return false;
            } else if (vm.tenderedvoteslist.ismarked === undefined) {
                toaster.pop("error", "Please Enter a Reason", "");
                return false;
            } else {
                return true;
            }
        };

    }
]);