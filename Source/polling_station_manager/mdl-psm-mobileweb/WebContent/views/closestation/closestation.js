
'use strict';

angular.module('newApp')
.controller('mdl.mobileweb.controller.closestation',
		['$rootScope', '$scope', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.recordprogress','mdl.mobileweb.service.login', 'toaster', 'mdl.mobileweb.service.json', '$http','mdl.mobileweb.service.ballot','$anchorScroll','mdl.mobileweb.service.anchorSmoothScroll','$timeout','modalService','$location','$filter',
		 function ($rootScope, $scope, dashboardService, recordprogressService, loginService, toaster, jsonService, $http, ballotService, $anchorScroll, anchorSmoothScroll, $timeout, modalService, $location, $filter) {

			var vm = this;
			
			vm.pollingStationList = [];
			vm.electionlist = [];
			vm.electionId = '';
			vm.postPollActivities = [];
			vm.org_state = [];
			vm.isViewed==0;
			vm.closeStationEnabled_button = 0;
			
			vm.bpNames = {}
			vm.typeResult = {};

			vm.isStationClosed = 0;
			vm.showBallotStats = false;
			vm.getpollingstationclosedstatus = function(station_id){
				dashboardService.getpollingstationclosedstatus(station_id,function(response){
					vm.isStationClosed=response.closed_status;
				});	
			}				
			
			vm.getStationList = function (){
				dashboardService.getPollingStations(function (response){
					var resp = response;
					if(jsonService.whatIsIt(resp)=="Object"){
						vm.pollingStationList[0] = resp;
						vm.getEList(vm.pollingStationList[0].id);
						//vm.getpollingstationclosedstatus(vm.pollingStationList[0].id);
						vm.getpollingstationclosedstatus(vm.pollingStationList[0].id);
						//vm.check_allelectionclosed(vm.pollingStationList[0].id);
					}
					else if(jsonService.whatIsIt(resp)=="Array"){
						vm.pollingStationList = resp;
						vm.getEList(vm.pollingStationList[0].id);
						//vm.getpollingstationclosedstatus(vm.pollingStationList[0].id);
						vm.getpollingstationclosedstatus(vm.pollingStationList[0].id);
						//vm.check_allelectionclosed(vm.pollingStationList[0].id);
					}
					if (vm.pollingStationList[0]) {
		                vm.stationcheck(vm.pollingStationList[0].id);
		            }

		            vm.selectedStation=vm.station_id;
				})
			};
			vm.getStationList();
			vm.getEList = function (stationid){
				$rootScope.cui_blocker(true);
				dashboardService.getEllectionList(stationid,function (response){
					var res = response;
					if(jsonService.whatIsIt(res)=="Object"){
						vm.electionlist[0] = res;
					}
					else if(jsonService.whatIsIt(res)=="Array"){
						vm.electionlist = res;
					}
					if(typeof vm.pollingStationList[0] != 'undefined' && typeof vm.electionlist[0] != 'undefined'){
						vm.checkElection(vm.electionlist[0].electionid, stationid);
						vm.getPostPollActivities(stationid,vm.electionlist[0].electionid);
						//vm.check_allelectionclosed(stationid);
						vm.getBPGeneratedStaus(stationid,vm.electionlist[0].electionid);
						vm.getpollingstationclosedstatus(stationid);
						vm.getBPNames(vm.electionlist[0].electionid);
						//vm.check_allelectionclosed(vm.pollingStationList[0].id);
					}
					$rootScope.cui_blocker(false);
				});
				vm.showBallotStats = false;
			};
			
			vm.checkElectionClosed = 0;
			vm.stationcheck = function(stationid)
			{
				vm.station_id=stationid;
				vm.electionlist = [];
				vm.getEList(stationid);
				vm.getpollingstationclosedstatus(stationid);
				vm.showBallotStats = false;
				//vm.check_allelectionclosed(stationid);
			}
			
		      vm.saveStationChecklist = function (stationid) {
		    	  $rootScope.cui_blocker(true);//UI blocker started
		    	  angular.copy(vm.postPollActivities, vm.org_state);
		          angular.forEach(vm.postPollActivities, function (postPollActivity) {
		              dashboardService.updatePreActivity(postPollActivity.id, postPollActivity.iscompleted, stationid);
		          });
		          $rootScope.cui_blocker();
		          toaster.pop("success", "Your checklist has been updated", "");
		      };			
			
			vm.checkElection = function(eid,stationid){
				vm.election_id=eid;
				vm.showBallotStats = false;
				$rootScope.cui_blocker(true);//UI blocker started
				dashboardService.getElectionStatus(eid,stationid,function(response){
					vm.checkElectionClosed = response.electionstatus;
					vm.getBPGeneratedStaus(stationid,eid);
					if(vm.checkElectionClosed==0)
						toaster.pop("Error","Record progress is not completed, please complete Record Progress");
					//vm.checkElectionClosed = 1;
					 $rootScope.cui_blocker(false);//UI blocker started
				});	
				dashboardService.getBallotType(eid, function(response){
					vm.typeResult = response;
				});				
			}
			
			vm.generateBPA= function (stationid,electionid){
				dashboardService.generateBPA(stationid,electionid,function(response){
					if(typeof response != 'undefined' && response.response=="success"){
						toaster.pop("success","Ballot Papers generated Successfully","");
						//vm.check_allelectionclosed(stationid);
					}
						
				});					
				vm.isBPAgenerated=1;
			}
			vm.getPostPollActivities = function(station_id, eid){
				dashboardService.getPostPollActivities(station_id,eid,function(response){
					vm.postPollActivities = response;
					angular.copy(vm.postPollActivities, vm.org_state);
					vm.setCheckAll();
				});				
			}
			vm.closeStationEnabled = false;
			vm.check_allelectionclosed = function(station_id){
				dashboardService.check_allelectionclosed(station_id,function(response){
					if(typeof response != 'undefined' && response.response=="success") {
						vm.closeStationEnabled_button = response.status;
						
						if(vm.closeStationEnabled_button == 1 && vm.isStationClosed == 1) {
							vm.closeStationEnabled = 0;
						} else if (vm.closeStationEnabled_button == 0) {
							vm.closeStationEnabled = 1;
						} else if (vm.closeStationEnabled_button == 1) {
							vm.closeStationEnabled = 0;
						}
						//alert(vm.isStationClosed);
					} 
					
				});
				/*if (vm.closeStationEnabled_button == 1 && vm.isStationClosed == 1) {
					alert("button disabled");
				} else {
					alert("button enabled");
				}*/
				
			}	
			
			vm.getBPGeneratedStaus = function(stationid,electionid){
				dashboardService.getBPGeneratedStaus(stationid,electionid,function(response){
					if(typeof response != 'undefined' && response.response=="success")
						vm.isBPAgenerated = response.status;
					else
						vm.isBPAgenerated = 0;
				});				
			}
			vm.closePollingStation = function(stationid){
				dashboardService.closeCurrentStation(stationid,function (response){
					vm.buttonLable = "Station Closed";
					if(response=="success"){
						toaster.pop("success","Station Successfully Closed!","");
						vm.isStationClosed=1;
					}
					else if(response=="Station not opened"){
						toaster.pop("Error","Couldn't close the station!","Station is still not opened!");
					}
					else{
						toaster.pop("info","Couldn't close the station!","Unauthorized");
					}
				});
			};		
			
			//creating data to export as csv
			vm.setArrayCsv = function (array,eid){
				$scope.elecid = "eid_"+ eid;
				$scope.getArray = [{key: "        Ordinary Ballot Papers", value:""}, 
				                   {key: "", value:""}, 
				                   {key:"Total ballot papers issued", value:array.tot_ballots}, 
				                   {key:"How many spoilt ballot papers did you issue replacements for?", value:array.tot_spolied_issued},
				                   {key:"Total ballot papers issued and not spoilt", value:(array.tot_ballots-array.tot_spolied_issued)},
				                   {key:"Total unused ballot papers", value:array.tot_unused},
				                   {key:"", value:""},
				                   {key:"         Tendered Ballot Papers", value:""},
				                   {key:"", value:""},
				                   {key:"Total ballot papers issued", value:array.tot_tend_ballots},
				                   {key:"Total spoilt tendered ballot papers", value:array.tot_tend_spoiled},
				                   {key:"Total unused tendered ballot papers", value:array.tot_tend_unused}
				                   ];
			}
			
			vm.loadPaperCount = function(electionid,station_id){
				vm.isViewed=1;
				$rootScope.cui_blocker(true);//UI blocker started
				ballotService.getBallotAccounts(electionid,station_id,function(response){
					if(response.response=="ok"){
						vm.closedstation = response;
						vm.setArrayCsv(vm.closedstation,electionid); 
					}
					console.debug("***");
					console.debug(vm.closedstation);
					vm.showBallotStats = true;
					$rootScope.cui_blocker(false);
			        $timeout(function() {
			        	anchorSmoothScroll.scrollTo('ballotAcc');
			        }, 2000);		
					
				});	
			}	
			
	      vm.checkAll = function () {
	          angular.forEach(vm.postPollActivities, function (item) {
	              item.iscompleted = vm.selectedAll;
	          });
	      };
		
	      vm.gotoPostalVotes = function () {
	    	  $location.path('/closestation/postal_votes_delivered_statement');
	      };

	      vm.onRouteChangeOff =  $scope.$on('$locationChangeStart', function (event, newUrl, oldUrl) {
	          if (!angular.equals(vm.org_state, vm.postPollActivities)) {
	              vm.newUrl = newUrl;
	              event.preventDefault();

	              modalService.load('close_station');
	    	  }
	      });	      
	      
	      
	      vm.template = "views/templatemodal/modalcolouredfooter.html";
	      $scope.templateModal = {
	          id: "close_station",
	          header: "Confirmation",
	          body: "You have unsaved data before navigating to another page. " +
	    		  		"Are you sure you want to leave this page?",
	          closeCaption: "No",
	          saveCaption: "Yes",
	          save: function () {
	              vm.onRouteChangeOff();
	              $location.path($location.url(vm.newUrl).hash()); //Go to page 
	              modalService.close('close_station');
	          },
	          close: function () {
	              modalService.close('close_station');
	          }
	      };	
	      
		vm.getBPNames = function(eid){
			$rootScope.cui_blocker(true);//UI blocker started
			dashboardService.getBPNames(eid,function(response){
				vm.bpNames = response;
				 $rootScope.cui_blocker(false);//UI blocker close
			});				
		}

		vm.setCheckAll = function () {
		    var notSelected = $filter('filter')(vm.postPollActivities, { iscompleted: "0" })
		    if (notSelected) {
		        if (notSelected.length <= 0) {
		            vm.selectedAll = "1";
		        }
		        else {
		            vm.selectedAll = "0";
		        }
		    }
		    else {
		        vm.selectedAll = "0"
		    }
		}
	      
} ]);
