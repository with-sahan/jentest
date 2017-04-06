/***
 * Project: MDL
 * Author: Rushan Arunod
 * Module: close station controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.closestationold'
	angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope','mdl.mobileweb.service.login',
	                                                     'mdl.mobileweb.service.dashboard','mdl.mobileweb.service.json','toaster',
	                                                     function($rootScope, $scope,loginService,dashboardservice,jsonService,toaster) {

		var vm = this;
		vm.stationcheck = function(stationid,eid) {
			vm.buttonHidedisable = false;		
			vm.getEList(stationid,eid);
			vm.closestation.tot_ballots= '';
			vm.closestation.tot_spoiled_replaced = '';
			vm.closestation.tot_unused = '';
			vm.closestation.tot_tend_ballots = '';
			vm.closestation.tot_tend_spoiled = '';
			vm.closestation.tot_tend_unused = '';	
			vm.buttonLable = "Save and Close";
			vm.closeStationButton(stationid,eid);
		}

		vm.closestation = [];
		vm.pollstationlist = [];
		vm.electionlist = [];
		vm.maxDb = 999999999;
		vm.buttonLable = "Save and Close";
		vm.buttonHidedisable ;
		vm.onlyNumbers = /^\d+$/;

		vm.getStationList = function (){
			dashboardservice.getPollingStations(function (response){
				var res1 = response.result.entry;
				if(jsonService.whatIsIt(res1)=="Object"){
					vm.pollstationlist[0] = res1;
				}
				else if(jsonService.whatIsIt(res1)=="Array"){
					vm.pollstationlist = res1;
				}
				vm.getEList(vm.pollstationlist[0].id,"");
			})
		};



		vm.closeStationButton = function(stationid,eid){
			dashboardservice.getCloseStationButtonStatus(stationid,function (response){
				var resultArry = response;
				if(jsonService.whatIsIt(resultArry)=="Object"){
					if((eid==resultArry.electionid) && (resultArry.isopened=="0")){
						vm.buttonHidedisable = true;
						vm.buttonLable = "Station Not Opened";
					}
					else if((eid==resultArry.electionid) && (resultArry.isclosed=="1")){
						vm.buttonHidedisable = true;
						vm.buttonLable = "Station Closed";
						toaster.pop("info","","This station is already closed!");
					}
					else{
						vm.buttonHidedisable = false;
						vm.buttonLable = "Save and Close";
					}				
				}
				else if(jsonService.whatIsIt(resultArry)=="Array"){
					var i;
					for (i = 0; i < resultArry.length; i++) {
						if((eid==resultArry[i].electionid) && (resultArry[i].isopened=="0")){
							vm.buttonHidedisable = true;
							vm.buttonLable = "Station Not Opened";
							toaster.pop("info","","This station is not opened!");
							break;
						}
						else if((eid==resultArry[i].electionid) && (resultArry[i].isclosed=="1")){
							vm.buttonHidedisable = true;
							vm.buttonLable = "Station Closed";
							toaster.pop("info","","This station is already closed!");
							break;
						}
						else{
							vm.buttonHidedisable = false;
							vm.buttonLable = "Save and Close";
						}
					}
				}

			})
		};

		vm.getEList = function (stationid,eid){
			dashboardservice.getEllectionList(stationid,function (response){
				var res = response.result.entry;
				vm.electionlist = [];
				if(jsonService.whatIsIt(res)=="Object"){
					vm.electionlist[0] = res;
				}
				else if(jsonService.whatIsIt(res)=="Array"){
					vm.electionlist = res;
				}
				console.log("info",$scope.selected,"");

				if(eid==""){
					$scope.selected = vm.electionlist[0];
					vm.closeStationButton(stationid,vm.electionlist[0].electionid);
				}
			})
		};

		vm.getStationList();
		vm.calculate = function(){

			if(vm.closestation.tot_ballots<vm.closestation.tot_spoiled_replaced)
				return true; 
		};

		vm.closePollingStation = function(stationid,closestation,eid){
			console.log(stationid,closestation,eid);
			if(vm.calculate()){
				toaster.pop("error","","Total ballot papers should be larger than spoilt ballot papers!");
				toaster.pop("info","Couldn't close the station!","");
			}
			else if(vm.closeValidate(eid)){
				dashboardservice.updateCloseStats(stationid,closestation,eid,function (response){
					console.log(response);
					if(response!="success")
						toaster.pop("info","Error Updating The Station","");
				})
				console.log(closestation);
				dashboardservice.closeCurrentStation(stationid,eid,function (response){
					console.log(response);
					vm.buttonHidedisable = true;
					vm.buttonLable = "Station Closed";
					if(response=="success"){
						toaster.pop("success","Station Successfully Closed!","");
					}
					else if(response=="Station not opened"){
						toaster.pop("Error","Couldn't close the station!","Station is still not opened!");
					}
					else{
						toaster.pop("info","Couldn't close the station!","Unauthorized");
					}
				})
			}
		};

		vm.closeValidate = function(eid){
			vm.closestation.tot_ballots = parseInt(vm.closestation.tot_ballots);
			vm.closestation.tot_spoiled_replaced = parseInt(vm.closestation.tot_spoiled_replaced);
			vm.closestation.tot_unused = parseInt(vm.closestation.tot_unused);
			vm.closestation.tot_tend_ballots = parseInt(vm.closestation.tot_tend_ballots);
			vm.closestation.tot_tend_spoiled = parseInt(vm.closestation.tot_tend_spoiled);
			vm.closestation.tot_tend_unused = parseInt(vm.closestation.tot_tend_unused);
			if (isNaN(eid)) { 
				toaster.pop("error","Select an election first!","");
				return false; }
			if ((isNaN(vm.closestation.tot_ballots)) || ((vm.closestation.tot_ballots)<0) || 
					(vm.closestation.tot_ballots)>vm.maxDb){
				vm.closestation.tot_ballots=0; 
				toaster.pop("error","Enter the total ballots correctly!","");
				return false; }
			if ((isNaN(vm.closestation.tot_spoiled_replaced)) || ((vm.closestation.tot_spoiled_replaced)<0) || 
					(vm.closestation.tot_spoiled_replaced)>vm.maxDb){
				vm.closestation.tot_spoiled_replaced=0; 
				toaster.pop("error","Enter the total spoiled ballots correctly!","");
				return false; }
			if ((isNaN(vm.closestation.tot_unused)) || ((vm.closestation.tot_unused)<0) || 
					(vm.closestation.tot_unused)>vm.maxDb){
				vm.closestation.tot_unused=0; 
				toaster.pop("error","Enter the total unused ballots correctly!","");
				return false; }
			if ((isNaN(vm.closestation.tot_tend_ballots)) || ((vm.closestation.tot_tend_ballots)<0) || 
					(vm.closestation.tot_tend_ballots)>vm.maxDb){
				vm.closestation.tot_tend_ballots=0; 
				toaster.pop("error","Enter the total ballots correctly!","");
				return false; }
			if ((isNaN(vm.closestation.tot_tend_spoiled)) || ((vm.closestation.tot_tend_spoiled)<0) || 
					(vm.closestation.tot_tend_spoiled)>vm.maxDb){
				vm.closestation.tot_tend_spoiled=0; 
				toaster.pop("error","Enter the total spoilt tenderd ballots correctly!","");
				return false; }
			if ((isNaN(vm.closestation.tot_tend_unused)) || ((vm.closestation.tot_tend_unused)<0) || 
					(vm.closestation.tot_tend_unused)>vm.maxDb){
				vm.closestation.tot_tend_unused=0; 
				toaster.pop("error","Enter the total  unused tenderd ballots correctly!","");
				return false; }
			return true;
		}

	} ]);