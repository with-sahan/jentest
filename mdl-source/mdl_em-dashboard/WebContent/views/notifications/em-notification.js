/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Modified by: Vindya Hettige
 * Module: EM notification controller
 */

'use strict';

var controllerName = 'mdl.em.controller.emnotification'
	angular.module('newApp').controller(controllerName,
			['$rootScope', '$scope', 'mdl.em.service.notificationServices', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.json','settings', 'mdl.em.service.geoHierarchyService',
			 function ($rootScope, $scope, notificationService, dashboardService, jsonService,settings,geoHierarchyService) {
				
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
			var resp = response.result.entry;
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
			var resp = response.result.entry;
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
			vm.geoHierarchy = response.response;
			//console.log(" vm.geoHierarchy " + vm.geoHierarchy.response);

        })
	}
	
	vm.getGeoHierarchy();
	
	vm.filterData=function(){
		var selhierarchy=vm.selectedHrc;
		notificationService.getlNotificationsByHierarchy(selhierarchy,function (response) {
			if(typeof response.result == 'undefined'){
				vm.notification={};
				//vm.notification.senton = vm.notification.senton.split('+')[0];
				//vm.notification.senton = moment(vm.notification.senton).format('yyyy-MM-dd' + 'at' + 'h:mma');
			}else{
				var resp = response.result.entry;
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