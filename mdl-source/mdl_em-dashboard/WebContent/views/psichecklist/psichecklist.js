/***
Project: MDL EM
Author: Akarshani Amarasinghe
Module: EM PSI Checklist Controller
 */
'use strict';

angular.module('newApp').controller('mdl.em.controller.psichecklist',
		['$rootScope', '$scope', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.login', '$cookieStore',
		  'mdl.mobileweb.service.json', 'toaster', '$filter', 'modalService', '$location', 'mdl.em.service.psichecklistService',
		  function ($rootScope, $scope, dashboardService, loginService, $cookieStore, jsonService, toaster, $filter, modalService, $location, psichecklistService) {

		      var vm = this;

		      vm.placesList = [];
		      vm.checkList = [];
		      vm.psiChecklistGroups = [];
		      vm.selectedAll = "0";
		      
		      $scope.filterData = function() {
		          vm.selectedAll = "0";
		    	  vm.getPSIChecklist($scope.selectedHvalueId);
		      }

		      vm.getPlacesList = function () {
		    	  psichecklistService.getPlacesList(function (response) {
		    		  var res = response.result.entry;		    		  
			    		if(jsonService.whatIsIt(res)=="Object"){
			          		vm.placesList[0] = res;
						} else if(jsonService.whatIsIt(res)=="Array"){
							vm.placesList = res;
						}
			    		vm.getPSIChecklist(vm.placesList[0].hierarchy_value_id);
			    		$scope.selectedHvalueId=vm.placesList[0].hierarchy_value_id;
		          })
		      };
		      
		      vm.getPlacesList();
		      
		      vm.getPSIChecklist = function (place_id) {
		    	  $rootScope.cui_blocker(true);
		    	  psichecklistService.getPSIChecklist(place_id, function (response) {
		    		  vm.checkList = response.result.entry;
		    		  $rootScope.cui_blocker(false);
		          });
		    	  psichecklistService.getPsiChecklistGroups(place_id, function(response){	//get Category  Lists for Accordian	    		  
		    		  vm.psiChecklistGroups = response.result.entry;		    		  
		    	  });
		      }

		      vm.updatePSIChecklist = function (place_id) {
		          var token = loginService.getAccessToken();
		          var reqlist = [];
		          angular.forEach(vm.checkList, function (checkListSet) {
		              var tempobj = {};
		              tempobj.placeId = checkListSet.place_id;
		              tempobj.activityId = checkListSet.id;
		              tempobj.isCompleted = checkListSet.iscompleted;
		              reqlist.push(tempobj);
		          });
		          vm.saveTimeSlot(reqlist);
		      };
		      
		      vm.saveTimeSlot = function(reqlist) {
				$rootScope.cui_blocker(true);//UI blocker started
				psichecklistService.updatePSIChecklist(reqlist, function (response) {
				    if (response.response == 'success') {
						toaster.pop("success","Data saved Successfully","");
				    } 
					$rootScope.cui_blocker();
				}) ;  				
		      }

		      vm.checkAll = function () {

		          angular.forEach(vm.checkList, function (item) {
		        	  item.iscompleted = vm.selectedAll;
		          });

		          vm.setCheckAllGroups();
		      };

		      vm.checkGroup = function (selected, group) {
		    	  //console.debug("clicked");
		          angular.forEach($filter('filter')(vm.checkList, { category: group.categoryname }), function (item) {
		              item.iscompleted = selected;
		          });

		          //vm.setCheckAll();
		      }

		      vm.setGroupChecked = function (group) {
		          var notSelected = $filter('filter')(vm.checkList, { category: group.categoryname, iscompleted: "0" });
		          if (notSelected) {
		              if (notSelected.length <= 0)
		                  group.iscompleted = "1";
		              else
		                  group.iscompleted = "0";
		          }
		          else {
		              group.iscompleted = "0";
		          }

		          vm.setCheckAll();
		      }

		      vm.setCheckAllGroups = function () {
		          angular.forEach(vm.psiChecklistGroups, function (group) {
		              vm.setGroupChecked(group);
		          });
		      }

		      vm.setCheckAll = function () {
		          var notSelected = $filter('filter')(vm.checkList, { iscompleted: "0" })
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

		      vm.removeUnwantedStrings = function (category) {
		          var removeUnwantedCategoryStrings = "";

		          var unwantedString = /psi_checklist_/;
		          if (unwantedString.test(category)) {
		              removeUnwantedCategoryStrings = category.replace("psi_checklist_", "");

		              removeUnwantedCategoryStrings = (removeUnwantedCategoryStrings).replace(/_/g, " ");

		          }
		          return removeUnwantedCategoryStrings;
		      };

		  }])
		.directive('applyicheck2', function ($timeout, $parse) {
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
		;
