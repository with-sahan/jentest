/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Modified by: Vindya Hettige
 * Module: EM notification controller
 */

'use strict';

var controllerName = 'mdl.em.controller.emnotification'
	angular.module('newApp').controller(controllerName,
			['$http', '$rootScope', '$scope', 'mdl.em.service.notificationServices', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.json','settings', 'mdl.em.service.geoHierarchyService','mdl.mobileweb.service.jwt',
			 function ($http, $rootScope, $scope, notificationService, dashboardService, jsonService,settings,geoHierarchyService, jwtService) {

	$rootScope.loginactive = false;

	var vm = this;

	vm.notification = {};
	vm.notification.id = "";
	vm.notification.pollingstation = "";
	vm.notification.message = "";
	vm.notification.attachtment = "";
	vm.notification.senton = "";
	vm.notification.status = "";
	vm.notification.response = "";
	vm.appendUrl = settings.dowloadUrl;
	vm.geoHierarchy=[];
    vm.selectedHrc = "";
	vm.notification = [];
	vm.curPage = 1;
	vm.pageSize = 10;

	vm.getAllNotifications = function () {
		notificationService.getAllNotifications(function (response) {
			var resp = response;
			if(jsonService.whatIsIt(resp)=="Object"){
				vm.notification[0] = resp;
			}
			else if(jsonService.whatIsIt(resp)=="Array"){
				vm.notification = resp;
			}
	    })
	}


	vm.getAllNotifications();

	vm.getStationList = function (){
		dashboardService.getPollingStations(function (response){
			var resp = response;
			if(jsonService.whatIsIt(resp)=="Object"){
				vm.pollingStationList[0] = resp;
			}
			else if(jsonService.whatIsIt(resp)=="Array"){
				vm.pollingStationList = resp;
			}
	    })
	}
	vm.getStationList();

	//this is to get the geo hierarchy to the dropdown list
	vm.getGeoHierarchy=function(){
		geoHierarchyService.getGeoHierarchy(function (response) {
			vm.geoHierarchy = response;
			//console.log(" vm.geoHierarchy " + vm.geoHierarchy.response);

        })
	}
    $scope.downloadCSV = function(param) {
        var config = {
             headers:  {
                  'Authorization': "Bearer " + jwtService.getToken()
              }
         };
				 $http({
 						method: 'GET',
 						url: param,
 						params: config,
 						responseType: 'arraybuffer'
 				}).success(function(data, status, headers) {
 						headers = headers();
 						var contentDispositionHeader = headers['content-disposition'];
 						var filename = contentDispositionHeader.split(';')[1].trim().split('=')[1];
 						var ext = filename.substr(filename.lastIndexOf('.') + 1);
 						var linkElement = document.createElement('a');
 						try {
 										var blob = new Blob([data]);
 										var url = window.URL.createObjectURL(blob);
 										linkElement.setAttribute('href', url);
 										linkElement.setAttribute("download", filename);
 	
 										var clickEvent = new MouseEvent("click", {
 												"view": window,
 												"bubbles": true,
 												"cancelable": false
 										});
 										linkElement.dispatchEvent(clickEvent);
 						} catch (ex) {
 								console.log(ex);
 						}
 				}).error(function(data) {
 						console.log(data);
 				});

     }
	vm.getGeoHierarchy();

	vm.filterData=function(){
		var selhierarchy=vm.selectedHrc;
		notificationService.getlNotificationsByHierarchy(selhierarchy,function (response) {
			if(typeof response == 'undefined'){
				vm.notification={};
				//vm.notification.senton = vm.notification.senton.split('+')[0];
				//vm.notification.senton = moment(vm.notification.senton).format('yyyy-MM-dd' + 'at' + 'h:mma');
			}else{
				var resp = response;
				if(jsonService.whatIsIt(resp)=="Object"){
					vm.notification[0] = resp;
					//vm.notification[0].senton = vm.notification[0].senton.split('+')[0];
					//resp[0].senton = moment(resp[0].senton).format('yyyy-MM-dd' + 'at' + 'h:mma');
				}
				else if(jsonService.whatIsIt(resp)=="Array"){
					vm.notification = resp;
					//vm.notification.senton = vm.notification.senton.split('+')[0];
					//resp.senton = moment(resp.senton).format('yyyy-MM-dd' + 'at' + 'h:mma');
				}
			}


        })
	}

}])
.filter('pagination', function() {
	return function(input, start) {
		if (!input || !input.length) { return; }
        start = +start; //parse to int
        return input.slice(start);
	};
});
