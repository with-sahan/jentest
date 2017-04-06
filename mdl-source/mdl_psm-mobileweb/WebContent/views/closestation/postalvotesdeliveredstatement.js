
'use strict';

angular.module('newApp').controller('mdl.mobileweb.controller.postalvotesdeliveredstatement',
		['$rootScope', '$scope', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.recordprogress','mdl.mobileweb.service.login', 'toaster', 'mdl.mobileweb.service.json', '$http','modalService','$location','mdl.mobileweb.service.postalvotes',
		 function ($rootScope, $scope, dashboardService, recordprogressService, loginService, toaster, jsonService, $http,modalService,$location, postalvotesService) {

			var vm = this;

			vm.pollingStationList = [];
			vm.electionlist = [];
			vm.electionId;
			vm.getProgressSummary=[];
			vm.progressSummeryDetails = [];
			
			vm.stationstatuscheck = function(stationId){
				dashboardService.getpollingstationclosedstatus(stationId, function(response) {
					var res = response.result.entry;
					if(res.response=="success"){
						if ((res.open_status==1)&&(res.closed_status==0)){
//							toaster.pop("info","can do record progress");
							vm.stationstatus = true;
						}
						else if(res.open_status==0) {
							vm.stationstatus = false;
							toaster.pop("info","Station Not Opened!","");
						}
						else if(res.closed_status==1) {
							vm.stationstatus = false;
							toaster.pop("error","Station Closed!","");
						}
						else{
							vm.stationstatus = false;
							toaster.pop("error","Error!","Please try again later.");
						}
					}
					else{
						toaster.pop("error","Error!","Try again later");
					}
				});
			}
			
			vm.getStationList = function (){
				dashboardService.getPollingStations(function (response){
					var resp = response.result.entry;
					if(jsonService.whatIsIt(resp)=="Object"){
						vm.pollingStationList[0] = resp;
						vm.getEList(vm.pollingStationList[0].id)
					}
					else if(jsonService.whatIsIt(resp)=="Array"){
						vm.pollingStationList = resp;
						vm.getEList(vm.pollingStationList[0].id)
					}
					vm.stationstatuscheck(vm.pollingStationList[0].id);
				})
			};
			vm.getStationList();

			vm.getEList = function (stationid){
				dashboardService.getEllectionList(stationid,function (response){
					var res = response.result.entry;
					if(jsonService.whatIsIt(res)=="Object"){
						vm.electionlist[0] = res;
					}
					else if(jsonService.whatIsIt(res)=="Array"){
						vm.electionlist = res;
					}
					
					vm.getProgress(vm.electionlist[0].electionid,stationid);
					vm.checkElection(vm.electionlist[0].electionid,stationid);
				})
			};
			
			vm.checkElectionClosed = 0;
			vm.checkElection = function(eid,stationid){
				$rootScope.cui_blocker(true);//UI blocker started
				dashboardService.getElectionStatus(eid,stationid,function(response){
					vm.checkElectionClosed = response.result.entry.electionstatus;
					vm.electionstatus = response.result.entry;
					 $rootScope.cui_blocker(false);//UI blocker close
				});				
			}	
			
			vm.stationcheck = function(stationid,eid) {
				vm.electionlist = [];
				vm.getEList(stationid);

				vm.stationstatuscheck(stationid);

			}
			
			vm.getProgress = function(electionid, stationId) {
				vm.electionId=electionid;
				//console.log(stationId);
				//console.log(electionid);
				vm.checkElection(electionid,stationId);
				recordprogressService.getProgress_V2(electionid, stationId, function(response) {
					console.debug("***");
			        //console.debug(response.result.entry);
			        
			        var res = response.result.entry;
					if(jsonService.whatIsIt(res)=="Object"){
						vm.progressSummery = res;
						console.debug(vm.progressSummery.response);
					}
					else if(jsonService.whatIsIt(res)=="Array"){
						vm.progressSummery = res;
						console.debug(vm.progressSummery.length);
					}
				});
				
			}
			
			vm.cancel = function () {
				$location.path('/closestation');
			}
			
		} ]);
