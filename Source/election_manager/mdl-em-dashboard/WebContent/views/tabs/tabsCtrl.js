/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM accordion controller
 */

'use strict';

var controllerName = 'mdl.em.controller.emtab'
angular.module('newApp').controller(controllerName,
		[ '$rootScope', '$scope','mdl.mobileweb.service.login', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.json', 'toaster', 'mdl.em.service.emtabServices',
        function($rootScope, $scope, loginService, dashboardService, jsonService, toaster, ballotService) {

	var vm = this;

	vm.pollingStationList = [];
	vm.electionlist = [];
	vm.electionId = 0;

    vm.getStationList = function (){
		dashboardService.getPollingStations(function (response){
			var resp = response;
			if(jsonService.whatIsIt(resp)=="Object"){
				vm.pollingStationList[0] = resp;
				vm.getEList(vm.pollingStationList[0].id)
			}
			else if(jsonService.whatIsIt(resp)=="Array"){
				vm.pollingStationList = resp;
				vm.getEList(vm.pollingStationList[0].id)
			}
        })
    }
    vm.getStationList();

    $rootScope.dashboard = true;
    $rootScope.openstation = true;
    $rootScope.reportissue = true;
    $rootScope.recordprogress = true;
    $rootScope.trackprogress = true;
    $rootScope.account = true;
    $rootScope.photo = true;
    $rootScope.activeTab = true;
    var vm = this;

    $rootScope.stationcheck = function (stationid) {//Control Main menu items as per the station
        switch (stationid) {
            case 1:
                $rootScope.dashboard = true;
                $rootScope.openstation = true;
                $rootScope.reportissue = true;
                $rootScope.recordprogress = true;
                $rootScope.trackprogress = true;
                $rootScope.account = true;
                $rootScope.photo = true;
                break;
            case 2:
                $rootScope.dashboard = false;
                $rootScope.openstation = false;
                $rootScope.reportissue = false;
                $rootScope.recordprogress = true;
                $rootScope.trackprogress = false;
                $rootScope.account = true;
                $rootScope.photo = true;
                break;
            case 3:
                $rootScope.dashboard = true;
                $rootScope.openstation = false;
                $rootScope.reportissue = false;
                $rootScope.recordprogress = true;
                $rootScope.trackprogress = true;
                $rootScope.account = false;
                $rootScope.photo = true;
                break;
            case 4:
                $rootScope.dashboard = true;
                $rootScope.openstation = false;
                $rootScope.reportissue = false;
                $rootScope.recordprogress = true;
                $rootScope.trackprogress = true;
                $rootScope.account = true;
                $rootScope.photo = false;
                break;
            case 5:
                $rootScope.dashboard = false;
                $rootScope.openstation = true;
                $rootScope.reportissue = false;
                $rootScope.recordprogress = true;
                $rootScope.trackprogress = false;
                $rootScope.account = false;
                $rootScope.photo = true;
        }

        vm.getActivityList(stationid);
        vm.openStationButton(stationid);
        vm.getEList(stationid);

    }

    vm.electionlist = [];

    vm.getEList = function (stationid){
    	dashboardService.getEllectionList(stationid,function (response){
			var res = response;
			if(jsonService.whatIsIt(res)=="Object"){
				vm.electionlist[0] = res;
			}
			else if(jsonService.whatIsIt(res)=="Array"){
				vm.electionlist = res;
			}

        })
    };

    vm.prePollActivities = {};
    vm.prePollActivities.id = "";
    vm.prePollActivities.organization_id = "";
    vm.prePollActivities.election_name = "";
    vm.prePollActivities.election_date_start = "";
    vm.prePollActivities.election_date_end = "";
    vm.prePollActivities.status = "";
    vm.prePollActivities.ballotboxno = "";

	vm.getPrePollActivities = function(){
		ballotService.getPrePollActivities(function(response){
			vm.prePollActivities = response;
		})
	}

	vm.getPrePollActivities();

} ]);
