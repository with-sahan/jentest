/***
 * Project: MDL
 * Author: Thilina Herath
 * Modified by: Akarshani Amarasinghe
 * Module: login services
 */
'use strict';

angular.module('newApp')
    .controller('mdl.mobileweb.controller.openstation',
		['$rootScope', '$scope', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.login', '$cookieStore',
		  'mdl.mobileweb.service.json', 'toaster', '$filter', 'modalService', '$location',
		  function ($rootScope, $scope, dashboardService, loginService, $cookieStore, jsonService, toaster, $filter, modalService, $location) {

		      var vm = this;

		      vm.prePollActivities = [];
		      vm.prePollActivityGroups = [];
		      vm.org_state = [];
		      vm.stationId = 0;

		      vm.stationcheck = function (stationid) {
		          vm.stationId = stationid;
		          vm.prePollActivities = [];
		          //vm.selectedAll = "0";
		          vm.openStationButton(stationid);
		          vm.buttonLable = "Open Station";
		          vm.getPrePollActivities(stationid);
		      }

		      var token = loginService.getAccessToken();
		      loginService.org_info(token, function (response) {
		          $rootScope.logourl = response.logourl;
		          $rootScope.organization = response.organization;
		      });

		      vm.pollingStationList = [];
		      vm.buttonHidedisable;
		      vm.buttonLable = "Open Station";
		      vm.selectedAll = "0";

		      vm.openStationButton = function (stationid) {
		          dashboardService.getOpenStationButtonStatus(stationid, function (response) {
		              if (response.result.entry.status == 1) {
		                  vm.buttonHidedisable = true;
		                  vm.buttonLable = "Station Opened";
		              }
		              else vm.buttonHidedisable = false;

		              console.log(vm.buttonHidedisable);
		          })
		      };

		      vm.saveStation = function (stationid) {
		          angular.copy(vm.prePollActivities, vm.org_state);
		          $rootScope.cui_blocker(true);//UI blocker started
		          var token = loginService.getAccessToken();
		          var reqlist = [];
		          angular.forEach(vm.prePollActivities, function (prePollActivity) {
		              var tempobj = {};
		              tempobj.token = token;
		              tempobj.pollingstation_id = stationid;
		              tempobj.activity_id = prePollActivity.id;
		              tempobj.status = prePollActivity.iscompleted;
		              reqlist.push(tempobj);
		          });
		          dashboardService.updateprepollactivities_v2(reqlist, function (response) {
		              toaster.pop("success", "Your checklist has been updated!", "");
		              $rootScope.cui_blocker();
		          });
		      };

		      vm.openStation = function (stationid) {
		          vm.saveStation(stationid);
		          $rootScope.cui_blocker(true);//UI blocker started
		          dashboardService.openCurrentStation(stationid, function (response) {
		              vm.openStationButton(stationid);
		              toaster.pop("success", "Station successfully opened!", "");
		              $rootScope.cui_blocker(false);//UI blocker close
		          });
		      };

		      vm.getStationList = function () {
		          dashboardService.getPollingStations(function (response) {
		              var res = response.result.entry;
		              if (jsonService.whatIsIt(res) == "Object") {
		                  vm.pollingStationList[0] = res;
		                  vm.openStationButton(vm.pollingStationList[0].id);
		              }
		              else if (jsonService.whatIsIt(res) == "Array") {
		                  vm.pollingStationList = res;
		                  vm.openStationButton(vm.pollingStationList[0].id);
		              }
		              if (vm.pollingStationList[0]) {
		                  vm.stationcheck(vm.pollingStationList[0].id);
		              }
		          });
		      }

		      vm.checkAll = function () {

		          angular.forEach(vm.prePollActivities, function (item) {
		              item.iscompleted = vm.selectedAll;
		          });

		          vm.setCheckAllGroups();
		      };

		      vm.checkGroup = function (selected, group) {
		          angular.forEach($filter('filter')(vm.prePollActivities, { category: group.category }), function (item) {
		              item.iscompleted = selected;
		          });

		          vm.setCheckAll();
		      }

		      vm.electionlist = [];

		      vm.getEList = function (stationid) {
		          dashboardService.getEllectionList(stationid, function (response) {
		              var res = response.result.entry;
		              if (jsonService.whatIsIt(res) == "Object") {
		                  vm.electionlist[0] = res;
		              }
		              else if (jsonService.whatIsIt(res) == "Array") {
		                  vm.electionlist = res;
		              }

		          })
		      };



		      vm.getPrePollActivities = function (stationid) {
		          dashboardService.getPrePollActivities(stationid, function (response) {
		              var res = response.result.entry;

		              if (res[0].response == "success") {
		                  if (jsonService.whatIsIt(res) == "Object") {
		                      vm.prePollActivities[0] = res;
		                  }
		                  else if (jsonService.whatIsIt(res) == "Array") {
		                      vm.prePollActivities = res;
		                  }
		              } else {
		                  toaster.pop("error", "Data loading error found!", "");
		              }
		              angular.copy(vm.prePollActivities, vm.org_state);
		              vm.prePollActivityGroups = angular.copy($filter('unique')(vm.prePollActivities, 'category'));

		              vm.setCheckAllGroups();
		          })
		      }

		      vm.setGroupChecked = function (group) {
		          var notSelected = $filter('filter')(vm.prePollActivities, { category: group.category, iscompleted: "0" })
		          if (notSelected) {
		              if (notSelected.length <= 0)
		                  group.status = "1";
		              else
		                  group.status = "0";
		          }
		          else {
		              group.status = "0";
		          }

		          vm.setCheckAll();
		      }

		      vm.setCheckAllGroups = function () {
		          angular.forEach(vm.prePollActivityGroups, function (group) {
		              vm.setGroupChecked(group);
		          });
		      }

		      vm.setCheckAll = function () {
		          var notSelected = $filter('filter')(vm.prePollActivities, { iscompleted: "0" })
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

		          var unwantedString = /prepoll_activity_/;
		          if (unwantedString.test(category)) {
		              removeUnwantedCategoryStrings = category.replace("prepoll_activity_", "");

		              removeUnwantedCategoryStrings = (removeUnwantedCategoryStrings).replace(/_/g, " ");

		          }
		          return removeUnwantedCategoryStrings;
		      };

		      //modalcolouredfooter
		      vm.template = "views/templatemodal/modalcolouredfooter.html";
		      $scope.templateModal = {
		          id: "open_station",
		          header: "Confirmation",
		          body: "You have unsaved data before navigating to another page. " +
		    		  		"Are you sure you want to leave this page?",
		          closeCaption: "No",
		          saveCaption: "Yes",
		          save: function () {
		              vm.onRouteChangeOff();
		              $location.path($location.url(vm.newUrl).hash()); //Go to page 
		              modalService.close('open_station');
		          },
		          close: function () {
		              modalService.close('open_station');
		          }
		      };

		      vm.onRouteChangeOff = $scope.$on('$locationChangeStart', function (event, newUrl, oldUrl) {
		          if (!angular.equals(vm.org_state, vm.prePollActivities)) {
		              vm.newUrl = newUrl;
		              event.preventDefault();

		              modalService.load('open_station');
		          }
		      });

		      vm.getStationList();

		  }]);
