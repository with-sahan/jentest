/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: Voter list controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.voterlist'
angular.module('newApp').controller(controllerName,
    ['$rootScope', '$scope', '$location','mdl.mobileweb.service.voterlist', 'mdl.mobileweb.service.dashboard', 'toaster',
     'mdl.mobileweb.service.json','modalService',
function ($rootScope, $scope, $location,voterListService, dashboardService, toaster,jsonService,modalService) {
    $rootScope.loginactive = false;

    var vm = this;

    vm.voterList = [];
    vm.pollingStationList = [];
    
    vm.createVoterData = [];
    vm.createVoterData.voter_name = "";
    vm.createVoterData.phone_number = "";
    vm.createVoterData.companion_name = "";
    vm.createVoterData.companion_address = "";
    
    vm.chatEnable = false;
    vm.buttonHide = false;
    
    /*vm.org_state=[];
    angular.copy(vm.createVoterData, vm.org_state);*/
    
    vm.stationcheck = function(stationid) {
    	vm.chatEnable = false;
    	vm.buttonHide = false; 	
    };
    
    vm.getStationList = function () {
        dashboardService.getPollingStations(function (response) {
            var res = response.result.entry;
			if(jsonService.whatIsIt(res)=="Object"){
				vm.pollingStationList[0] = res;
			}
			else if(jsonService.whatIsIt(res)=="Array"){
				vm.pollingStationList = res;
			}

        })
    };
    vm.getStationList();
    
    vm.getVoterList = function () {
    	voterListService.getVoters(function (response) {
            var res = response.result.entry;
			if(jsonService.whatIsIt(res)=="Object"){
				vm.voterList[0] = res;
			}
			else if(jsonService.whatIsIt(res)=="Array"){
				vm.voterList = res;
			}

        })
    };
    vm.getVoterList();

    vm.createVoterList = function (polling_station_id) {
    	if (vm.createVoterData.voter_name == "") {
    		toaster.pop("error","Enter the Voter Name!","");
    	} else if (vm.createVoterData.phone_number == "") {
    		toaster.pop("error","Enter the Phone Number!","");
    	} else if (vm.createVoterData.companion_name == "") {
    		toaster.pop("error","Enter the Companion Name!","");
    	} else if (vm.createVoterData.companion_address == "") {
    		toaster.pop("error","Enter the Companion Address!","");
    	} else if (/\d/.test(vm.createVoterData.voter_name)) {
    		toaster.pop("error","Enter only text for the Voter Name!","");
    	} else if (!(/\d/.test(vm.createVoterData.phone_number))) {
    		toaster.pop("error","Enter only numbers for the Phone Number!","");
    	} else if (/\d/.test(vm.createVoterData.companion_name)) {
    		toaster.pop("error","Enter only text for the Companion Name!","");
    	} else if ((vm.createVoterData.phone_number).length > 10) {
    		toaster.pop("error","Enter only ten numbers for the Phone Number!","");
    	} else {
    		$rootScope.cui_blocker(true);//UI blocker started
    		voterListService.createVoters(polling_station_id, vm.createVoterData, function (response) {
        		vm.createVoterDataResult = response.result.entry;
                if(response.result.entry.response=="success"){
                	console.debug("***");
                	console.debug(vm.createVoterDataResult);
                	angular.copy(vm.createVoterData, vm.org_state);
                	toaster.pop("success","Voter's Data has Added!","");
                	
                	location.reload();
                	$rootScope.cui_blocker(false);//UI blocker close
                }
                else{
                	toaster.pop("error","Error Submitting the data!","Please try again");
                	$rootScope.cui_blocker(false);//UI blocker close
                }

            })
    	}
    	
    };
    
    vm.chatRowEnable = function () {
    	vm.chatEnable = true;
    	vm.buttonHide = true;
    };

    vm.addingVoterDisable = function () {
    	vm.chatEnable = false;
    	vm.buttonHide = false;
    };
    
    vm.deleteVoterList = function (voter_list_id) {
    	voterListService.deleteVoters(voter_list_id, function (response) {
    		vm.deleteVoterDataResult = response.result.entry;
            if(response.result.entry.response=="success"){
            	console.debug("***");
            	console.debug(vm.deleteVoterDataResult);
            	toaster.pop("success","Voter's Data has Deleted!","");
            	location.reload();
            }
            else{
            	toaster.pop("error","Error Submitting the data!","Please try again");
            }

        })
    };
    
  //modalcolouredfooter
    /*vm.template = "views/templatemodal/modalcolouredfooter.html";
    $scope.templateModal = {
        id: "voterlist",
        header: "Confirmation",
        body: "You have unsaved data before navigating to another page. " +
  		  		"Are you sure you want to leave this page?",
        closeCaption: "No",
        saveCaption: "Yes",
        save: function () {
            vm.onRouteChangeOff();
            $location.path($location.url(vm.newUrl).hash()); //Go to page 
            modalService.close('voterlist');
        },
        close: function () {
            modalService.close('voterlist');
        }
    };

    vm.onRouteChangeOff =  $scope.$on('$locationChangeStart', function (event, newUrl, oldUrl) {
        if (!angular.equals(vm.org_state, vm.createVoterData)) {
            vm.newUrl = newUrl;
            event.preventDefault();

           modalService.load('voterlist');
  	  	}
    });*/
}]);