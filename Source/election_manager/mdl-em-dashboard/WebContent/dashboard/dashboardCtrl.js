'use strict';

/**
 * @ngdoc function
 * @name newappApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the newappApp
 */
angular.module('newApp')    
.controller('dashboardCtrl', ['$rootScope','$scope' , '$location', 'dashboardService', 'pluginsService', 'mdl.mobileweb.service.dashboard',
                              'chartService','mdl.em.service.emissueServices',
                              'mdl.em.service.geoHierarchyService', '$interval', 'toaster', '$filter', '$timeout',
                              'mdl.em.service.emissueFetchServices','settings', 'mdl.mobileweb.service.chatFetchService',
                              'mdl.mobileweb.service.json','mdl.mobileweb.service.recordprogress', '$http','mdl.em.service.ballotService','$anchorScroll', 'mdl.em.service.issueAssignFetchService',
                              'mdl.mobileweb.service.login','mdl.mobileweb.service.jwt',
                              function ($rootScope, $scope,$location, dashboardService, pluginsService,
                            		  dashboardDBService, chartService, issueService, geoHierarchyService,
                            		  $interval, toaster, $filter, $timeout, issueFetchServices,settings, chatFetchService,jsonService,recordprogressService,  $http,ballotService, $anchorScroll, issueAssignFetchService, loginService, jwtService) {
	var vm = this;
	$scope.issueResolveData = {};
	vm.timerPromise;
	$scope.appendUrl = settings.dowloadUrl;
	//$scope.openClose=["Not Open Station","Open Station"]

//	$scope.$on('timer-tick', function (event, args) {
////	vm.getNewNotifications();
//	});
	$rootScope.classFromController = "";

	vm.getOrgInfo_V2 =  function() {

	    if (jwtService.hasValidToken()) {
			loginService.org_info("" , function(response) {
				$scope.roleId = response.roletype;
				//alert($scope.roleId);

			});
		}
		else
			$location.path('/login');

    };
    vm.getOrgInfo_V2();

	if($location.path() == "/dashboard-summary")// This controller is shared between analytics and summary pages
		vm.isSummaryPage = true;
	else
		vm.isSummaryPage = false;

	$scope.allStations=[];
	$scope.notOpenAndClose = false;
	$scope.notOpenAndCloseControl = function(action) {
		if(action){
      if (typeof $scope.selectedHrc !== 'undefined') {
        $rootScope.cui_blocker(true);
  			dashboardDBService.getNotOpenAndOpenStations($scope.selectedHrc,function(response){
  				$rootScope.cui_blocker();
  				if(typeof response != 'undefined')
  					$scope.allStations=response;
  					$scope.allStationsOpened = $filter('filter')($scope.allStations, { openStatus: "1" });
  					$scope.allStationsClosed = $filter('filter')($scope.allStations, { openStatus: "0" });
  			});
  			$scope.notOpenAndClose = true;
      }			
		}
		else{
			$scope.notOpenAndClose = false;
		}

	}


	vm.loadCloseStation=function(){
		//$scope.test=" scope test";
		//alert("  ");
		var stationId=$location.search().id;
		var electionID=$location.search().electionId;
		//console.log("electionId "+electionID);
		if(typeof stationId === 'undefined'){
			// this is not the edit screen
		}else{
			//load the User
			//$rootScope.cui_blocker(true);
			$scope.pollingStationList = [];
			$scope.electionlist = [];
			$scope.electionId = '';
			$scope.postPollActivities = [];
			$scope.org_state = [];
			$scope.isViewed==0;

			$scope.isStationClosed = 0;
			$scope.showBallotStats = false;
			dashboardDBService.getpollingstationclosedstatus(stationId,function(response){
				$scope.isStationClosed=response.closed_status;
				});
			//vm.getpollingstationclosedstatus(stationId);
			if(typeof electionID != 'undefined'){
				//$rootScope.cui_blocker(true);//UI blocker started
				dashboardDBService.getElectionStatus(electionID,stationId,function(response){
					$scope.checkElectionClosed = response.electionstatus;
					dashboardDBService.getBPGeneratedStaus(stationId,electionID,function(response){
						if(typeof response.result.entry != 'undefined' && response.result.entry.response=="success")
							$scope.isBPAgenerated = response.result.entry.status;
						else
							$scope.isBPAgenerated = 0;
					});
					if($scope.checkElectionClosed==0)
						console.log("Error","Record progress is not completed");
						//toaster.pop("Error","Record progress is not completed");
					//vm.checkElectionClosed = 1;
					 //$rootScope.cui_blocker(false);//UI blocker started
				});
				dashboardDBService.getPostPollActivities(stationId,electionID,function(response){
					$scope.postPollActivities = response;
					angular.copy($scope.postPollActivities, $scope.org_state);
				});
				$scope.closeStationEnabled = false;
				dashboardDBService.check_allelectionclosed(stationId,function(response){
					if(typeof response != 'undefined' && response.response=="success")
						$scope.closeStationEnabled = response.status;
				});
				dashboardDBService.getBPGeneratedStaus(stationId,electionID,function(response){
					if(typeof response != 'undefined' && response.response=="success")
						$scope.isBPAgenerated = response.status;
					else
						$scope.isBPAgenerated = 0;
				});
				dashboardDBService.getpollingstationclosedstatus(stationId,function(response){
					$scope.isStationClosed=response.closed_status;
				});
			}
			$scope.showBallotStats = false;
			$scope.checkElectionClosed = 0;
			/*$scope.saveStationChecklist = function (stationId) {
		    	  //$rootScope.cui_blocker(true);//UI blocker started
		    	  angular.copy($scope.postPollActivities, $scope.org_state);
		          angular.forEach($scope.postPollActivities, function (postPollActivity) {
		        	  dashboardDBService.updatePreActivity(postPollActivity.id, postPollActivity.iscompleted, stationId);
		          });
		         // $rootScope.cui_blocker();
		          toaster.pop("success", "Your checklist has been updated", "");
		      };
		      */
		      /*vm.checkElection = function(electionID,stationId){
					vm.showBallotStats = false;
					$rootScope.cui_blocker(true);//UI blocker started
					dashboardDBService.getElectionStatus(electionID,stationId,function(response){
						vm.checkElectionClosed = response.result.entry.electionstatus;
						vm.getBPGeneratedStaus(stationId,electionID);
						if(vm.checkElectionClosed==0)
							toaster.pop("Error","Record progress is not completed");
						//vm.checkElectionClosed = 1;
						 $rootScope.cui_blocker(false);//UI blocker started
					});
				}*/
		      $scope.generateBPA= function (stationId,electionID){
		    	  dashboardDBService.generateBPA(stationId,electionID,function(response){
						if(typeof response != 'undefined' && response.response=="success"){
							//toaster.pop("success","Ballot Papers generated Successfully","");
							$scope.check_allelectionclosed(stationId);
						}

					});
		    	  $scope.isBPAgenerated=1;
				}


				/*vm.closeStationEnabled = false;
				vm.check_allelectionclosed = function(stationId){
					dashboardDBService.check_allelectionclosed(stationId,function(response){
						if(typeof response.result.entry != 'undefined' && response.result.entry.response=="success")
							vm.closeStationEnabled = response.result.entry.status;
					});
				}

				vm.getBPGeneratedStaus = function(stationId,electionID){
					dashboardDBService.getBPGeneratedStaus(stationId,electionID,function(response){
						if(typeof response.result.entry != 'undefined' && response.result.entry.response=="success")
							vm.isBPAgenerated = response.result.entry.status;
						else
							vm.isBPAgenerated = 0;
					});
				}*/
		   /*   $scope.closePollingStation = function(stationId){
					dashboardDBService.closeCurrentStation(stationId,function (response){
						$scope.buttonLable = "Station Closed";
						if(response=="success"){
							toaster.pop("success","Station Successfully Closed!","");
							$scope.isStationClosed=1;
						}
						else if(response=="Station not opened"){
							toaster.pop("Error","Couldn't close the station!","Station is still not opened!");
						}
						else{
							toaster.pop("info","Couldn't close the station!","Unauthorized");
						}
					});
				};*/

				//creating data to export as csv
				/*$scope.setArrayCsv = function (array,electionID){
					$scope.elecid = "eid_"+ electionID;
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

				$scope.loadPaperCount = function(electionID,stationId){
					$scope.isViewed=1;
					$rootScope.cui_blocker(true);//UI blocker started
					ballotService.getBallotAccounts(electionID,stationId,function(response){
						if(response.result.entry.response=="ok"){
							$scope.closedstation = response.result.entry;
							$scope.setArrayCsv($scope.closedstation,electionID);
						}
						$scope.showBallotStats = true;
						$rootScope.cui_blocker(false);
				        $timeout(function() {
				        	anchorSmoothScroll.scrollTo('ballotAcc');
				        }, 2000);

					});
				}

				$scope.checkAllClose = function () {
		          angular.forEach($scope.postPollActivities, function (item) {
		              item.iscompleted = $scope.selectedAll;
		          });
		      };*/




			}
		}
	vm.loadCloseStation();
	vm.loadOpenStation=function(){
		$scope.prePollActivities = [];
		$scope.prePollActivityGroups = [];
		$scope.org_state = [];
		//alert("  ");
		var stationId=$location.search().id;
		//console.log("Station ID"+stationId);

		if(typeof stationId === 'undefined'){
			// this is not the edit screen
		}else{
			//load the User
			//$rootScope.cui_blocker(true);

			//vm.selectedAll = "0";
			$scope.buttonLable = "Open Station";

			dashboardDBService.getPreActivities(stationId, function (response) {
					var res = response;

					if (res[0].response == "success") {
						if (jsonService.whatIsIt(res) == "Object") {
							$scope.prePollActivities[0] = res;
						}
						else if (jsonService.whatIsIt(res) == "Array") {
							$scope.prePollActivities = res;
						}
					} else {
						toaster.pop("error", "Data loading error found!", "");
					}
					angular.copy($scope.prePollActivities, $scope.org_state);
					$scope.prePollActivityGroups = angular.copy($filter('unique')($scope.prePollActivities, 'category'));

					$scope.setCheckAllGroups();
				});



			$scope.pollingStationList = [];
			$scope.buttonHidedisable;
			$scope.buttonLable = "Open Station";
			$scope.selectedAll = "0";


			/*$scope.saveStation = function (stationId) {
				angular.copy($scope.prePollActivities, $scope.org_state);
//				$rootScope.cui_blocker(true);//UI blocker started
				angular.forEach($scope.prePollActivities, function (prePollActivity) {
					dashboardDBService.updatePreActivity(prePollActivity.id, prePollActivity.iscompleted, stationId);
				});
//				$rootScope.cui_blocker();
				toaster.pop("success", "Your checklist has been updated", "");
			};

			$scope.openStation = function (stationId) {
				$rootScope.cui_blocker(true);//UI blocker started
				vm.saveStation(stationId);
				dashboardDBService.openCurrentStation(stationId, function (response) {
					toaster.pop("success", "Station successfully opened!", "");
					$rootScope.cui_blocker(false);//UI blocker close
				});
			};*/
			/*$scope.checkAll = function () {

				angular.forEach($scope.prePollActivities, function (item) {
					item.iscompleted = $scope.selectedAll;
				});

				$scope.setCheckAllGroups();
			};

			$scope.checkGroup = function (selected, group) {
				angular.forEach($filter('filter')($scope.prePollActivities, { category: group.category }), function (item) {
					item.iscompleted = selected;
				});

				$scope.setCheckAll();
			}*/







			$scope.setGroupChecked = function (group) {
				var notSelected = $filter('filter')($scope.prePollActivities, { category: group.category, iscompleted: "0" })
				if (notSelected) {
					if (notSelected.length <= 0)
						group.status = "1";
					else
						group.status = "0";
				}
				else {
					group.status = "0";
				}

				$scope.setCheckAll();
			}

			$scope.setCheckAllGroups = function () {
				angular.forEach($scope.prePollActivityGroups, function (group) {
					$scope.setGroupChecked(group);
				});
			}

			$scope.setCheckAll = function () {
				var notSelected = $filter('filter')($scope.prePollActivities, { iscompleted: "0" })
				if (notSelected) {
					if (notSelected.length <= 0) {
						$scope.selectedAll = "1";
					}
					else {
						$scope.selectedAll = "0";
					}
				}
				else {
					$scope.selectedAll = "0"
				}
			}

			$scope.removeUnwantedStrings = function (category) {
				var removeUnwantedCategoryStrings = "";

				var unwantedString = /prepoll_activity_/;
				if (unwantedString.test(category)) {
					removeUnwantedCategoryStrings = category.replace("prepoll_activity_", "");

					removeUnwantedCategoryStrings = (removeUnwantedCategoryStrings).replace(/_/g, " ");

				}
				return removeUnwantedCategoryStrings;
			};



			// vm.getStationList();


		};


	}

	vm.loadOpenStation();
	$scope.todashboard = function(){
		$location.path('/');
	}

	$scope.$on('$viewContentLoaded', function () {

		vm.ballotIssue = '';
		vm.postalCollected = '';

		vm.GetGraphFigures = function(){
			dashboardDBService.getBallotIssueGraph($scope.selectedHrc, function (response){
				if(typeof response != "undefined"){
					vm.ballotIssue=response;
					dashboardService.charts('visitors-chart1', vm.ballotIssue, 'getBallotIssueGraph', 'visitors-chart1-legend');
					$scope.ballotIssue_legend = dashboardService.legendArr;
//					console.log("Number of items"+$scope.ballotIssue_legend.length);
				}
				else
					$scope.ballotIssue_legend = [];
			});
			dashboardDBService.getPostalCollectedGraph($scope.selectedHrc, function (response){
				if(typeof response != "undefined"){
					vm.postalCollected=response;
					dashboardService.charts('visitors-chart2', vm.postalCollected, 'getPostalCollectedGraph', 'visitors-chart2-legend');
					$scope.postalCollected_legend = dashboardService.legendArr;
//					console.log("Number of items"+$scope.postalCollected_legend.length);
				}
				else
					$scope.postalCollected_legend = [];
			});
			issueService.getIssueAvgSolveTime(function (response){
				if(typeof response != "undefined"){
						var res_data = response;
            $scope.hidetable=false;
            if (res_data.length == 0) {
              $scope.hidetable=true;
            }else if (res_data.length == 1) {
              $scope.issueResolveData = res_data[0];
              $scope.issueResolveData.issuehourafter = parseInt($scope.issueResolveData.issuehour)+1;
            } else if (res_data.length > 1){
              $scope.hidetable=true;
              dashboardService.timeToSolveIssueGraph('visitors-chart3', res_data);
            }
				}
			});

		};

		//vm.getOpenIssues = function () {
		//	dashboardDBService.getOpenIssues(function (response){
		//		$scope.pending_issues=response.result.entry.openissues;
		//	});
		//};

		//watching the issue count and notify if new issue comes
		//$scope.$watch('pending_issues', function(newValue, oldValue){
		//  if (oldValue === undefined) {
		//  }
		//  else{
		//  	if((newValue-oldValue) > 0 ){
		//  		toaster.pop("info","New Issue Reported!","");
		//  	}
		//  }
		//}, true);

		$scope.$watch(function () { return issueFetchServices.pending_issues; }, function (newValue, oldValue) {
			$scope.pending_issues = newValue;
		}, true);

		vm.getNotificationCount = function () {
			/*dashboardDBService.getNotificationCount(function (response){
				$scope.notification_count=response.result.entry.notificationcount;
	        });		*/
			$scope.notification_count =0;
		};
		$scope.cat_summary = [];
		vm.getIssueList = function() {
			issueService.getIssueCategory(function (response){
				chartService.dashboardPieCharts(response);
				$scope.cat_summary = chartService.cat_summary;
			});
		};
		$scope.allElections = [];
		$scope.filterData = function() {
			if(!vm.isSummaryPage){
				dashboardDBService.getIssueCountGraphStats($scope.selectedHrc,function (response){
					$scope.pending_issues_v2=response.result.entry.openissues;
					$scope.opencount_v2=response.result.entry.opencount;
					$scope.closecount_v2=response.result.entry.closecount;
				});
				vm.GetGraphFigures();
			}
			dashboardDBService.getElectionsByHierarchy($scope.selectedHrc,function(response){

				$scope.allElections = response;
				angular.forEach($scope.allElections, function(value, key) {
					dashboardDBService.getStatsByElection($scope.selectedHrc,value.id,function(response){
						$scope.allElections[key].stats=response;

						setTimeout(function(){
							pluginsService.loadImg();
							//alert(10);
						}, 100);
					});
					dashboardDBService.getSumStats($scope.selectedHrc,value.id,function(response){
						$scope.allElections[key].sumstats=response[0];
					});
				});
			});
		};


//		$scope.filterData();
		$scope.geoHierarchy = [];
		$scope.geoArray = [];
		//this is to get the geo hierarchy to the dropdown list
		vm.getGeoHierarchy=function(){
			$scope.geoArray = [];
			geoHierarchyService.getGeoHierarchy(function (response) {
				$scope.geoHierarchy = response;
				if (typeof $scope.geoHierarchy[0] != 'undefined'){
					$scope.selectedHrc = $scope.geoHierarchy[0].split('|')[1];//Default Geo place; used for loading election on page load
					$scope.filterData();// Load Elec
				}
				angular.forEach($scope.geoHierarchy, function (ele) {
					$scope.geoArray.push({id: ele.split('|')[1], name: ele.split('|')[0]});
				});
			})
		}


		vm.getGeoHierarchy();
		//chartService.dashboardPieCharts();
		if(!vm.isSummaryPage){
			//vm.GetGraphFigures();
			//vm.getOpenIssues();
			vm.getNotificationCount();
			vm.getIssueList();
		}
		dashboardService.init();
		pluginsService.init();
		dashboardService.setHeights()
		if ($('.widget-weather').length) {
			widgetWeather();
		}
		//handleTodoList();

	});

	//$scope.getImage = function (appendUrl, e_photo, $event) {
	//    console.log(e_photo);
	////$event.preventDefault();
    //var elem = angular.element($event.currentTarget);
	// $(elem).attr({
    //        "href": ""
    //     })
	//$event.stopPropagation();
	//var config = {
	//		headers:  {
	//			'Authorization': "Bearer " + jwtService.getToken()
	//		}

	//	};
	//$http.get(appendUrl+e_photo, config).then(function(response){
	//        $(elem).attr({
    //            "href": "data:image/jpeg;base64,"+response.data
    //         }).trigger("click");

	//    })
	//}

	//$scope.p_issues = 1000;
	$scope.e_proxy = 2500;
	$scope.activeTab = true;

	vm.timermethods = function () {
		if(!vm.isSummaryPage){
			//vm.GetGraphFigures();
			//vm.getOpenIssues();
			vm.getNotificationCount();
			vm.getIssueList();
		}
		$scope.filterData();
	}
	vm.timerPromise = $interval(vm.timermethods, 90000);

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



}])
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
.filter('unique', function () {
		    return function (collection, keyname) {
		        var output = [],
                    keys = [];

		        angular.forEach(collection, function (item) {
		            var key = item[keyname];
		            if (keys.indexOf(key) === -1) {
		                keys.push(key);
		                output.push(item);
		            }
		        });

		        return output;
		    };
		})
.directive('wbSelect2', function ($timeout) {
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
