'use strict';


angular.module('newApp').controller('mdl.mobileweb.controller.dashboard',
		[ 'mdl.mobileweb.service.login','$rootScope', '$scope', 'mdl.mobileweb.service.dashboard','$location','$filter','$interval','toaster', 'mdl.mobileweb.service.chatFetchService', 'mdl.mobileweb.service.issueAssignFetchService',
		  function(loginService,$rootScope, $scope, dashboardService, $location,$filter,$interval,toaster, chatFetchService, issueAssignFetchService) {
			var vm = this;
			vm.timerPromise;
			vm.elections = [];
			vm.allElectionStats = [];
			vm.allStationsOpened = 1;
			$rootScope.cui_blocker(true);
			vm.electionCheck = function(electionId) {//Control Main menu items as per the station
				vm.getAllElectionStats(electionId);
			}
			
			vm.getAllElections =  function() {
				dashboardService.getAllElections(function(response){
					vm.elections = response;
					if(vm.elections.length>0){
						vm.getAllElectionStats(vm.elections[0].id);
					}
					$rootScope.cui_blocker();
//					if (response.length<1)toaster.pop("error","No Currently Running Elections Available.",""); 
//					else{
//					vm.getAllElectionStats(vm.elections[0].id);
//					$rootScope.cui_blocker();
//					}
				});	
				loginService.getElectionActivationStatus(loginService.getAccessToken() , function(response) {				
				    $rootScope.electiondaystatus = response.result.status;
				});	
			}			
			
			vm.getAllElectionStats = function(electionId) {
				dashboardService.getElectionStats(electionId, function(response){
					vm.allElectionStats = response;
					vm.allStationsOpened = $filter('filter')(vm.allElectionStats.dashboardData, { status: 0 }).length;
				});				
			}
			vm.viewNotification = function(id) {
				$location.path('/notification/see_all/'+id);
			}			

			vm.getAllElections();
			
			vm.timermethods = function(){
				vm.getAllElections();
			}
			vm.timerPromise=$interval(vm.timermethods, 90000);
			
			$scope.$on('$destroy', function () {
			    if (vm.timerPromise) {
			        $interval.cancel(vm.timerPromise);
			        vm.timerPromise = undefined;
			    }
			});
			
			$scope.$watch(function () { 
				return chatFetchService.pending_chats; 
			}, function (newValue, oldValue) {
			    $scope.pending_chats = newValue;
			}, true);
			
			$scope.$watch(function () { 
				return issueAssignFetchService.issueassigncount; 
			}, function (newValue, oldValue) {
			    $scope.issueassigncount = newValue;
			}, true);
			
		} ]);
