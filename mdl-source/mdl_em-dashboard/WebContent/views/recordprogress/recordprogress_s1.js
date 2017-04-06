'use strict';


angular.module('newApp').controller('mdl.mobileweb.controller.recordprogress_s1',
		['$rootScope', '$scope', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.recordprogress','mdl.mobileweb.service.login', 'toaster', 'mdl.mobileweb.service.json',
		  function ($rootScope, $scope, dashboardService, recordprogressService, loginService, toaster, jsonService) {

			var vm = this;

			vm.pollingStationList = [];
			vm.electionlist = [];
			vm.electionId = 0;
		
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
	        
	        vm.periodProgress ={};
	        vm.periodProgress.ballotPappersIssued = "";
	        vm.periodProgress.postalPackRecieved = "";
	        vm.periodProgress.postalPacksCollected = "";
	        
	        vm.progressSummery = [];
	        vm.progressSummery.ballotpapers = "0";
	        vm.progressSummery.postalpacks = "0";
	        vm.progressSummery.postalpackscollected = "0";
	        
	        
	        vm.submitPostalPacksCollected = function(stationId) {
	        	if(vm.electionId == '') {
	        		toaster.pop("error","Select Election!","");
	        	} else {
	        		var totalPostalPackRecievedDataNumber = parseInt(vm.progressSummery.postalpacks, 10);
			        var totalPostalPackCollectedDataNumber = parseInt(vm.progressSummery.postalpackscollected, 10);
			        
			        vm.progressSummery.postalPacksCollectedFinal = totalPostalPackRecievedDataNumber - totalPostalPackCollectedDataNumber;
			        /*if (isNaN(vm.periodProgress.ballotPappersIssued)) {
		                toaster.pop("error","You have entered negative value for Number of Ballot Papers Issued!","");
		            } else if (isNaN(vm.periodProgress.postalPackRecieved)) {
		                toaster.pop("error","You have entered negative value for Number of Postal Packs Received!","");
		            } else*/ if(vm.progressSummery.postalPacksCollectedFinal > 0){
		        		
		        		recordprogressService.submitPostalPacksCollected(vm.electionId, stationId, vm.progressSummery, function(response) {
		        			vm.postResult = response.result.entry;
		        			if(response.result.entry.response=="success"){
		        				vm.progressSummery = response.result.entry;
		                    	toaster.pop("success","You have successfully collected your postal packs","");
		                    	//$location.path('/');
		                    }
		                    else{
		                    	toaster.pop("error","Error Submitting the issue!","Please try again");
		                    }
		        		});
		        		
		        	} else {
		        		toaster.pop("error","Invalid Data","");
		        	}
	        	}
		     };
	        
	        vm.save = function(stationId) {
	        	//vm.electionId = electionid;
	        	if(vm.electionId == '') {
	        		toaster.pop("error","Select Election!","");
	        	} else {
	        		if (vm.periodProgress.ballotPappersIssued == '') {
		                toaster.pop("error","Fill Number of Ballot Papers Issued since last updated","");
		            } else if (vm.periodProgress.postalPackRecieved == '') {
		                toaster.pop("error","Fill Number of Postal Packs Received since last updated","");
		            } else if (isNaN(vm.periodProgress.ballotPappersIssued)) {
		                toaster.pop("error","You have entered negative value for Number of Ballot Papers Issued!","");
		            } else if (isNaN(vm.periodProgress.postalPackRecieved)) {
		                toaster.pop("error","You have entered negative value for Number of Postal Packs Received!","");
		            } else {
		            	recordprogressService.save(vm.electionId,stationId,vm.periodProgress, function(response) {
		            		vm.progressSummery = response.result.entry;
		            		toaster.pop("success","Saved","");
		            	}) ;         	
		            }
	        	}
	        };
	        
	        vm.getProgress = function (electionid, stationId) {
	        	vm.electionId = electionid;
	        	console.log(stationId);
	        	console.log(electionid);
	        	recordprogressService.getProgress(electionid, stationId, function(response) {
	        		//console.log("1111111111111111");
	        		console.log(response);
	        		if(response.result.entry.response=="success"){
	    				vm.progressSummery = response.result.entry;
	    			}
	    			else{
	    				toaster.pop("error","Data loading error found!","");
	    			}
	        		
	        	});
	        };
	        
	        vm.getEList = function (stationid){
	        	dashboardService.getEllectionList(stationid,function (response){
	    			var res = response.result.entry;
	    			if(jsonService.whatIsIt(res)=="Object"){
	    				//toaster.pop("info","Object","");
	    				vm.electionlist[0] = res;
	    			}
	    			else if(jsonService.whatIsIt(res)=="Array"){
	    				vm.electionlist = res;
	    				//toaster.pop("info","Array","");
	    			}
	    			
	            })
	        };

	        vm.stationcheck = function(id)
	        {
		        vm.periodProgress ={};
		        vm.periodProgress.ballotPappersIssued = "";
		        vm.periodProgress.postalPackRecieved = "";
		        vm.periodProgress.postalPacksCollected = "";
		        
		        vm.progressSummery = [];
		        vm.progressSummery.ballotpapers = "0";
		        vm.progressSummery.postalpacks = "0";
		        vm.progressSummery.postalpackscollected = "0";
	        }
	        
			
		} ]);
