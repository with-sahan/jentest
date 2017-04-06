/***
 * Project: MDL
 * Author: Vindya Hettige
 * Modified: Akarshani Amarasinghe (31.01.2015)
 * Module: Ballot account controller
 */

'use strict';

var controllerName = 'mdl.em.controller.ballotaccount'
angular.module('newApp').controller(controllerName,
		[ '$rootScope', '$scope','mdl.mobileweb.service.login', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.json', 'toaster', 'mdl.em.service.ballotService',
		  'mdl.em.service.geoHierarchyService',
        function($rootScope, $scope, loginService, dashboardService, jsonService, toaster, ballotService, geoHierarchyService) {

	var vm = this;

	vm.pollingStationList = [];
	vm.electionlist = [];
	vm.electionId = 0;

	vm.ballotcounts= [];
	vm.ballotcounts.tot_tend_ballots = "";
	vm.ballotcounts.tot_ballots = "";
	vm.ballotcounts.tot_spoiled_replaced = "";
	vm.ballotcounts.tot_tend_unused = "";
	vm.ballotcounts.tot_tend_spoiled = "";
	vm.ballotcounts.electionid = "";
	vm.ballotcounts.tot_unused = "";
	vm.ballotcounts.pollingstation = "";
	vm.ballotcounts.electionname = "";

	vm.ballotaccountsummary = [];

	vm.csvGenerationArray = [];
	vm.validCSVGenerationArray = new Array (vm.ballotcounts.length);

	vm.csvArray = [];

	vm.csvExportDisable = false;

    vm.geoHierarchy=[];
    $scope.selectedHrc = "";
    vm.bpNames = {};
    vm.typeResult = {};

	//this is to get the geo hierarchy to the dropdown list
	vm.getGeoHierarchy=function(){
		geoHierarchyService.getGeoHierarchy(function (response) {
			vm.geoHierarchy = response.response;
	        $scope.selectedHrc = vm.geoHierarchy[0].split('|')[1];
	        vm.getStationList();
        })
	}

	vm.filterData=function(){
		vm.getStationList();
	}

	vm.getGeoHierarchy();

	vm.stationcheck = function(electionid) {
		$rootScope.cui_blocker(true);//UI blocker started
		vm.csvExportDisable = false;
		vm.ballotcounts = [];
		vm.csvArray = [];
		vm.ballotaccountsummary = [];
		vm.getBallotAccounts(electionid);
		vm.BallotACountSummary(electionid);

		$rootScope.cui_blocker(false);//UI blocker close
		//vm.getGeoHierarchy();
		dashboardService.getBallotType(electionid, function(response){
			vm.typeResult = response.result.entry;
			if(vm.typeResult.typecount==2){
				vm.getBallot2_label = "/ V2";
				vm.isBallot2Enabled = true;
			}
				
			else{
				vm.getBallot2_label = "";
				vm.isBallot2Enabled = false;
			}
				
		});
	}
	
    vm.getStationList = function (){
    	ballotService.getPollingStations_V2(function (response){
    		$rootScope.cui_blocker(true);//UI blocker started
			var resp = response.result.entry;
			if(jsonService.whatIsIt(resp)=="Object"){
				vm.pollingStationList[0] = resp;
				vm.getEList(vm.pollingStationList[0].polling_station_id);
			}
			else if(jsonService.whatIsIt(resp)=="Array"){
				vm.pollingStationList = resp;
				vm.getEList(vm.pollingStationList[0].polling_station_id);
			}
			$rootScope.cui_blocker(false);//UI blocker false
        })
    }
    vm.getStationList();

    vm.electionlist = [];

    vm.getEList = function (stationid){
    	dashboardService.getEllectionList(stationid,function (response){
			var res = response.result.entry;
			if(jsonService.whatIsIt(res)=="Object"){
				vm.electionlist[0] = res;
				vm.getBallotAccounts(vm.electionlist[0].electionid);
				vm.stationcheck(vm.electionlist[0].electionid);
			}
			else if(jsonService.whatIsIt(res)=="Array"){
				vm.electionlist = res;
				vm.getBallotAccounts(vm.electionlist[0].electionid);
				vm.stationcheck(vm.electionlist[0].electionid);
			}

			vm.getBPNames(vm.electionlist[0].electionid);

        })
    };

	vm.getBallotAccounts = function(electionid){
		$rootScope.cui_blocker(true);//UI blocker started
		ballotService.getBallotAccounts_v2(electionid,$scope.selectedHrc, function(response){
			var res = response;
			if(jsonService.whatIsIt(res)=="Object"){
				vm.ballotcounts[0] = res;
			}
			else if(jsonService.whatIsIt(res)=="Array"){
				vm.ballotcounts = res;
			}
			$rootScope.cui_blocker(false);//UI blocker started
		});
	}

	vm.BallotACountSummary = function(electionid){
		ballotService.getBallotAccountSummary_v2(electionid, $scope.selectedHrc, function(response){
			if(typeof response[0] !== "undefined"){
				vm.ballotaccountsummary = response[0];
			} else {
				vm.csvExportDisable = true;
				toaster.pop("info","There are no stations closed now","Ballot Paper Accounts are generated when the polling station is closed. Please try later");
			}
		})
	}

	vm.assigningToCSVGenerationArray = function (passingArray) {
		
		if (vm.isBallot2Enabled) {
			vm.csvArray = [];

			Array.prototype.push.apply(vm.csvArray, [{
				council: "Council",
				ward: "Ward",
				district: "District",
				place: "Place",
				pollingstation: "Station Name",
				tot_ballots:"Ordinary Ballot Papers Issued",
				tot_ballots2:"Ordinary Ballot Papers Issued V2",
				tot_spoiled_replaced:"Replacements for spoilt ballot papers",
				tot_spoiled_replaced2:"Replacements for spoilt ballot papers V2",
				ballot_issued_and_not_spoilt:"Ordinary Ballot papers issued and not spoilt",
				ballot_issued_and_not_spoilt2:"Ordinary Ballot papers issued and not spoilt V2",
				tot_unused:"Ordinary Ballot papers unused",
				tot_unused2:"Ordinary Ballot papers unused V2",
				tot_tend_ballots:"Tendered ballot papers issued",
				tot_tend_ballots2:"Tendered ballot papers issued V2",
				tot_tend_spoiled:"Tendered ballot papers spoilt",
				tot_tend_spoiled2:"Tendered ballot papers spoilt V2",
				tot_tend_unused:"Tendered ballot papers unused",
				tot_tend_unused2:"Tendered ballot papers unused V2",
				}]);

			if (typeof passingArray !== 'undefined' && passingArray.length > 0) {
				for (var i = 1; i < passingArray.length+1; i++) {
		    		Array.prototype.push.apply(vm.csvArray, [{
		    			council: passingArray[i-1].pollingstation_council,
		    			ward: passingArray[i-1].pollingstation_ward,
		    			district: passingArray[i-1].pollingstation_district,
		    			place: passingArray[i-1].pollingstation_place,
		    			pollingstation: passingArray[i-1].pollingstation,
		    			tot_ballots:passingArray[i-1].tot_ballots,
		    			tot_ballots2:passingArray[i-1].tot_ballots2,
	    				tot_spoiled_replaced:passingArray[i-1].tot_spoiled_replaced,
	    				tot_spoiled_replaced2:passingArray[i-1].tot_spoiled_replaced2,
	    				ballot_issued_and_not_spoilt:(passingArray[i-1].tot_ballots-passingArray[i-1].tot_spoiled_replaced),
	    				ballot_issued_and_not_spoilt2:(passingArray[i-1].tot_ballots2-passingArray[i-1].tot_spoiled_replaced2),
	    				tot_unused:passingArray[i-1].tot_unused,
	    				tot_unused2:passingArray[i-1].tot_unused2,
	    				tot_tend_ballots:passingArray[i-1].tot_tend_ballots,
	    				tot_tend_ballots2:passingArray[i-1].tot_tend_ballots2,
	    				tot_tend_spoiled:passingArray[i-1].tot_tend_spoiled,
	    				tot_tend_spoiled2:passingArray[i-1].tot_tend_spoiled2,
	    				tot_tend_unused:passingArray[i-1].tot_tend_unused,
	    				tot_tend_unused2:passingArray[i-1].tot_tend_unused2,
	    				}]);
		    	}
			} else {
				Array.prototype.push.apply(vm.csvArray, [{
					council: passingArray.pollingstation_council,
	    			ward: passingArray.pollingstation_ward,
	    			district: passingArray.pollingstation_district,
					place: passingArray.pollingstation_place,
					pollingstation: passingArray.pollingstation,
					tot_ballots:passingArray.tot_ballots,
					tot_ballots2:passingArray.tot_ballots2,
					tot_spoiled_replaced:passingArray.tot_spoiled_replaced,
					tot_spoiled_replaced2:passingArray.tot_spoiled_replaced2,
					ballot_issued_and_not_spoilt:(tot_ballots-tot_spoiled_replaced),
					ballot_issued_and_not_spoilt2:(tot_ballots2-tot_spoiled_replaced2),
					tot_ballots:passingArray.tot_ballots,
					tot_ballots2:passingArray.tot_ballots2,
					tot_unused:passingArray.tot_unused,
					tot_unused2:passingArray.tot_unused2,
					tot_tend_ballots:passingArray.tot_tend_ballots,
					tot_tend_ballots2:passingArray.tot_tend_ballots2,
					tot_tend_spoiled:passingArray.tot_tend_spoiled,
					tot_tend_spoiled2:passingArray.tot_tend_spoiled2,
					tot_tend_unused:passingArray.tot_tend_unused,
					tot_tend_unused2:passingArray.tot_tend_unused2,
				}]);

			}
		} else if (!vm.isBallot2Enabled) {
			vm.csvArray = [];

			Array.prototype.push.apply(vm.csvArray, [{
				council: "Council",
				ward: "Ward",
				district: "District",
				place: "Place",
				pollingstation: "Station Name",
				tot_ballots:"Ordinary Ballot Papers Issued",
				tot_spoiled_replaced:"Replacements for spoilt ballot papers",
				ballot_issued_and_not_spoilt:"Ordinary Ballot papers issued and not spoilt",
				tot_unused:"Ordinary Ballot papers unused",
				tot_tend_ballots:"Tendered ballot papers issued",
				tot_tend_spoiled:"Tendered ballot papers spoilt",
				tot_tend_unused:"Tendered ballot papers unused",
				}]);

			if (typeof passingArray !== 'undefined' && passingArray.length > 0) {
				for (var i = 1; i < passingArray.length+1; i++) {
		    		Array.prototype.push.apply(vm.csvArray, [{
		    			council: passingArray[i-1].pollingstation_council,
		    			ward: passingArray[i-1].pollingstation_ward,
		    			district: passingArray[i-1].pollingstation_district,
		    			place: passingArray[i-1].pollingstation_place,
		    			pollingstation: passingArray[i-1].pollingstation,
		    			tot_ballots:passingArray[i-1].tot_ballots,
	    				tot_spoiled_replaced:passingArray[i-1].tot_spoiled_replaced,
	    				ballot_issued_and_not_spoilt:(passingArray[i-1].tot_ballots-passingArray[i-1].tot_spoiled_replaced),
	    				tot_unused:passingArray[i-1].tot_unused,
	    				tot_tend_ballots:passingArray[i-1].tot_tend_ballots,
	    				tot_tend_spoiled:passingArray[i-1].tot_tend_spoiled,
	    				tot_tend_unused:passingArray[i-1].tot_tend_unused,
	    				}]);
		    	}
			} else {
				Array.prototype.push.apply(vm.csvArray, [{
					council: passingArray.pollingstation_council,
	    			ward: passingArray.pollingstation_ward,
	    			district: passingArray.pollingstation_district,
					place: passingArray.pollingstation_place,
					pollingstation: passingArray.pollingstation,
					tot_ballots:passingArray.tot_ballots,
					tot_spoiled_replaced:passingArray.tot_spoiled_replaced,
					ballot_issued_and_not_spoilt:(tot_ballots-tot_spoiled_replaced),
					tot_ballots:passingArray.tot_ballots,
					tot_unused:passingArray.tot_unused,
					tot_tend_ballots:passingArray.tot_tend_ballots,
					tot_tend_spoiled:passingArray.tot_tend_spoiled,
					tot_tend_unused:passingArray.tot_tend_unused,
				}]);

			}
		}

		return vm.csvArray;
    };

	vm.getBPNames = function(eid){
		$rootScope.cui_blocker(true);//UI blocker started
		dashboardService.getBPNames(eid,function(response){
			vm.bpNames = response.result.entry;
			 $rootScope.cui_blocker(false);//UI blocker close
		});
	}

} ])
.directive('wbSelectbpa', function ($timeout) {
	return {
		restrict: 'A',
		require: 'ngModel',
		link: function ($scope, element, attrs, ngModel) {
			$timeout(function(){
				$(element).select2().on('change', function (event) {//Set ngModal on dowpdown change
					$scope.$apply(function () {
						return ngModel.$setViewValue(event.val);
					});
					$scope.filterData();
				});
			}, 2000);
			$scope.$watch(function () {//If ngmodal changed, set dropdown value
				return ngModel.$modelValue;
			}, function(newValue) {
				$(element).select2().select('val', newValue);
			});
		}
	};
})
;