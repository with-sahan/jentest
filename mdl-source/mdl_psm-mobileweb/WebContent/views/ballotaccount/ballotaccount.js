/***
 * Project: MDL
 * Author: Rushan Arunod
 * Module: Ballot account controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.ballotaccount'
angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope','mdl.mobileweb.service.login',
                                                     'mdl.mobileweb.service.dashboard','mdl.mobileweb.service.json','toaster',
                                                     'mdl.mobileweb.service.ballot',
                                                     function($rootScope, $scope,loginService,dashboardservice,jsonService,
                                                    		 toaster,ballotService) {
	
	var vm = this;
	vm.stationcheck = function(stationid) {//Control Main menu items as per the station
		
		vm.getEList(stationid);
		vm.closedstation.tot_ballots= 0;
    	vm.closedstation.tot_spoiled_replaced = 0;
    	vm.closedstation.tot_unused = 0;
    	vm.closedstation.tot_tend_ballots = 0;
    	vm.closedstation.tot_tend_spoiled = 0;
    	vm.closedstation.tot_tend_unused = 0;
	}
	
	vm.closedstation = [];
	vm.pollstationlist = [];
	vm.electionlist = [];
	
	vm.loadPaperCount = function(electionid,station_id){
		ballotService.getBallotAccounts(electionid,station_id,function(response){
			if(response.result.entry.response=="ok"){
				vm.closedstation = response.result.entry;
			}
			else{
				toaster.pop("info","There are no stations closed now","Ballot Paper Accounts are generated when the polling station is closed. Please try later");
			}
		})
	}
//	vm.loadPaperCount("2","2");
		
	vm.getStationList = function (){
		dashboardservice.getPollingStations(function (response){			
			var resp = response.result.entry;
			if(jsonService.whatIsIt(resp)=="Object"){
				vm.pollstationlist[0] = resp;
				vm.getEList(vm.pollstationlist[0].id);
			}
			else if(jsonService.whatIsIt(resp)=="Array"){
				vm.pollstationlist = resp;
				vm.getEList(vm.pollstationlist[0].id);
			}
        })
    };
	
	vm.getEList = function (stationid){
		dashboardservice.getEllectionList(stationid,function (response){
			var res = response.result.entry;
			if(jsonService.whatIsIt(res)=="Object"){
//				alert("object");
				vm.electionlist[0] = res;
			}
			else if(jsonService.whatIsIt(res)=="Array"){
//				alert("Array");
				vm.electionlist = res;
			}
			
        })
    };
    vm.getStationList();
    vm.calculate = function(){
    	if(vm.closedstation.tot_ballots<vm.closedstation.tot_spoiled_replaced)
    		return true; 
    };

	
} ]);