'use strict';


angular.module('newApp').controller('mdl.mobileweb.controller.openstation',
		[ '$rootScope', '$scope', 'mdl.mobileweb.service.dashboard','mdl.mobileweb.service.login','$cookieStore',
		  'mdl.mobileweb.service.json','toaster',
		  function($rootScope, $scope, dashboardService,loginService,$cookieStore,jsonService,toaster) {

			var vm = this;
			$rootScope.stationcheck = function(stationid) {//Control Main menu items as per the station
				vm.selectedAll = "0";
				vm.getActivityList(stationid);
				vm.openStationButton(stationid);
				vm.buttonLable = "Open Station";
			}

			var token = loginService.getAccessToken();
			loginService.org_info(token , function(response) {
				$rootScope.logourl=response.logourl;
				$rootScope.organization=response.organization;
			});

			vm.activityList = [];
			vm.pollingStationList = [];
			vm.buttonHidedisable;
			vm.buttonLable = "Open Station";

			vm.openStationButton = function(stationid){
				dashboardService.getOpenStationButtonStatus(stationid,function (response){
					if (response.result.entry.status==1){
						vm.buttonHidedisable = true;
						vm.buttonLable = "Station Opened";
					}
					else vm.buttonHidedisable = false;

	                console.log(vm.buttonHidedisable);
	            })
			};

			vm.saveStation = function(stationid){
				angular.forEach(vm.activityList, function (item) {
		        	dashboardService.updatePreActivity(item.id,item.status,stationid);
		        });
	        	toaster.pop("success","Your checklist has been updated","");
			};

			vm.openStation = function(stationid){
				vm.saveStation(stationid);
		        dashboardService.openCurrentStation(stationid,function (response){
		        	vm.openStationButton(stationid);
		        	toaster.pop("success","Station successfully opened!","");
		        });
			};

			vm.getActivityList = function (stationid){
				dashboardService.getPreActivities(stationid,function (response){
	                vm.activityList = response;
	            })
	        }

	        vm.getStationList = function (){
				dashboardService.getPollingStations(function (response){
					var res = response;
					if(jsonService.whatIsIt(res)=="Object"){
						vm.pollingStationList[0] = res;
						vm.getActivityList(vm.pollingStationList[0].id);
		                vm.openStationButton(vm.pollingStationList[0].id);
					}
					else if(jsonService.whatIsIt(res)=="Array"){
						vm.pollingStationList = res;
						vm.getActivityList(vm.pollingStationList[0].id);
		                vm.openStationButton(vm.pollingStationList[0].id);
					}
	            })
	        }
	        vm.getStationList();

		    vm.selectedAll = "0";
		    $scope.checkAll = function (selectedAll) {
		    	if(vm.selectedAll=="1")
		    		vm.selectedAll = "0";
		    	else
		    		vm.selectedAll = "1";
		        angular.forEach(vm.activityList, function (item) {
		        	item.status = vm.selectedAll;
		        });
		    };

		} ])
		.directive('applyicheck', function($timeout, $parse) {
		    return {
		        require: 'ngModel',
		        link: function($scope, element, $attrs, ngModel) {
		            return $timeout(function() {
		                var value;
		                value = $attrs['value'];

		                $scope.$watch($attrs['ngModel'], function(newValue){
		                    $(element).iCheck('update');
		                })

		                return $(element).iCheck({
		                    checkboxClass: 'iradio_square-green',
		                    radioClass: 'iradio_flat-aero'

		                }).on('ifChanged', function(event) {
		                    if ($(element).attr('type') === 'checkbox' && $attrs['ngModel']) {
		                        $scope.$apply(function() {
		                        	if($(element).attr('id')=="selectall")
		                        		$scope.checkAll(1);
		                            return ngModel.$setViewValue(event.target.checked);
		                        });
		                    }
		                    if ($(element).attr('type') === 'radio' && $attrs['ngModel']) {
		                        return $scope.$apply(function() {
		                            return ngModel.$setViewValue(value);
		                        });
		                    }
		                });
		            });
		        }
		    };
		});
