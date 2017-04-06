
'use strict';

angular.module('newApp')
.controller('mdl.mobileweb.controller.closestation',
		['$rootScope', '$scope', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.recordprogress','mdl.mobileweb.service.login', 'toaster', 'mdl.mobileweb.service.json', '$http','mdl.em.service.ballotService','$anchorScroll','mdl.mobileweb.service.anchorSmoothScroll','$timeout','modalService','$location',
		 function ($rootScope, $scope, dashboardService, recordprogressService, loginService, toaster, jsonService, $http,ballotService,$anchorScroll,anchorSmoothScroll,$timeout,modalService,$location) {

			var vm = this;
			
			vm.pollingStationList = [];
			vm.electionlist = [];
			vm.electionId = '';
			vm.postPollActivities = [];
			vm.org_state = [];
			vm.isViewed==0;

			vm.isStationClosed = 0;
			vm.showBallotStats = false;
			vm.getpollingstationclosedstatus = function(station_id){
				dashboardService.getpollingstationclosedstatus(station_id,function(response){
					vm.isStationClosed=response.result.entry.closed_status;
				});	
			}				
			
			vm.getStationList = function (){
				dashboardService.getPollingStations(function (response){
					var resp = response.result.entry;
					if(jsonService.whatIsIt(resp)=="Object"){
						vm.pollingStationList[0] = resp;
						vm.getEList(vm.pollingStationList[0].id);
						//vm.getpollingstationclosedstatus(vm.pollingStationList[0].id);
						vm.getpollingstationclosedstatus(vm.pollingStationList[0].id);
					}
					else if(jsonService.whatIsIt(resp)=="Array"){
						vm.pollingStationList = resp;
						vm.getEList(vm.pollingStationList[0].id);
						//vm.getpollingstationclosedstatus(vm.pollingStationList[0].id);
						vm.getpollingstationclosedstatus(vm.pollingStationList[0].id);
					}
				})
			};
			vm.getStationList();
			vm.getEList = function (stationid){
				$rootScope.cui_blocker(true);
				dashboardService.getEllectionList(stationid,function (response){
					var res = response.result.entry;
					if(jsonService.whatIsIt(res)=="Object"){
						vm.electionlist[0] = res;
					}
					else if(jsonService.whatIsIt(res)=="Array"){
						vm.electionlist = res;
					}
					if(typeof vm.pollingStationList[0] != 'undefined' && typeof vm.electionlist[0] != 'undefined'){
						vm.checkElection(vm.electionlist[0].electionid, stationid);
						vm.getPostPollActivities(stationid,vm.electionlist[0].electionid);
						vm.check_allelectionclosed(stationid);
						vm.getBPGeneratedStaus(stationid,vm.electionlist[0].electionid);
						vm.getpollingstationclosedstatus(stationid);
					}
					$rootScope.cui_blocker(false);
				});
				vm.showBallotStats = false;
			};
			
			vm.checkElectionClosed = 0;
			vm.stationcheck = function(stationid)
			{
				vm.electionlist = [];
				vm.getEList(stationid);
				vm.getpollingstationclosedstatus(stationid);
				vm.showBallotStats = false;
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
				vm.showBallotStats = false;
				$rootScope.cui_blocker(true);//UI blocker started
				dashboardService.getElectionStatus(eid,stationid,function(response){
					vm.checkElectionClosed = response.result.entry.electionstatus;
					vm.getBPGeneratedStaus(stationid,eid);
					if(vm.checkElectionClosed==0)
						toaster.pop("Error","Record progress is not completed");
					//vm.checkElectionClosed = 1;
					 $rootScope.cui_blocker(false);//UI blocker started
				});				
			}
			
			vm.generateBPA= function (stationid,electionid){
				dashboardService.generateBPA(stationid,electionid,function(response){
					if(typeof response.result.entry != 'undefined' && response.result.entry.response=="success"){
						toaster.pop("success","Ballot Papers generated Successfully","");
						vm.check_allelectionclosed(stationid);
					}
						
				});					
				vm.isBPAgenerated=1;
			}
			vm.getPostPollActivities = function(station_id, eid){
				dashboardService.getPostPollActivities(station_id,eid,function(response){
					vm.postPollActivities = response.result.entry;
					angular.copy(vm.postPollActivities, vm.org_state);
				});				
			}
			vm.closeStationEnabled = false;
			vm.check_allelectionclosed = function(station_id){
				dashboardService.check_allelectionclosed(station_id,function(response){
					if(typeof response.result.entry != 'undefined' && response.result.entry.response=="success")
						vm.closeStationEnabled = response.result.entry.status;
				});
			}	
			
			vm.getBPGeneratedStaus = function(stationid,electionid){
				dashboardService.getBPGeneratedStaus(stationid,electionid,function(response){
					if(typeof response.result.entry != 'undefined' && response.result.entry.response=="success")
						vm.isBPAgenerated = response.result.entry.status;
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
				                   {key:"How many spoilt ballot papers did you issue replacements for?", value:array.tot_spoiled_replaced},
				                   {key:"Total ballot papers issued and not spoilt", value:(array.tot_ballots-array.tot_spoiled_replaced)},
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
					if(response.result.entry.response=="ok"){
						vm.closedstation = response.result.entry;
						vm.setArrayCsv(vm.closedstation,electionid); 
					}
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
	      
} ])
.directive('applyicheck', function ($timeout, $parse) {
    return {
        require: 'ngModel',
        link: function ($scope, element, $attrs, ngModel) {
            return $timeout(function () {
                var value;
                value = $attrs['value'];

                $scope.$watch($attrs['ngModel'], function (newValue) {
                    $(element).iCheck('update');
                })

                return $(element).iCheck({
                    checkboxClass: 'iradio_square-green',
                    radioClass: 'iradio_flat-aero'

                }).on('ifChanged', function (event) {
                    if ($(element).attr('type') === 'checkbox' && $attrs['ngModel']) {
                        $scope.$apply(function () {
                            return ngModel.$setViewValue(event.target.checked);
                        });
                    }
                    if ($(element).attr('type') === 'radio' && $attrs['ngModel']) {
                        return $scope.$apply(function () {
                            return ngModel.$setViewValue(value);
                        });
                    }
                });
            });
        }
    };
})
;
