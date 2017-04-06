/***
 * Copyrights
 * Project: MDL
 * Author: Thilina Herath
 * Module: login controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.notificationdropdown'
angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope','mdl.mobileweb.service.notification', 
                                                     'mdl.mobileweb.service.login', 'mdl.mobileweb.service.json',
                                                     'mdl.mobileweb.service.jwt',
                                                     function ($rootScope, $scope, notificationService, loginService, jsonService, jwtService) {
	
	
	var vm = this;
	vm.number_of_Notifications = "";
	vm.number = "0";
	
	vm.notificationDetails=[];
	
	vm.notification = [];
	
    $scope.$on('timer-tick', function (event, args) {
        if (jwtService.hasValidToken()) {
            vm.getNewNotifications();
            vm.loadTopNotifications();
        }
    });

	vm.getNewNotifications=function(){
		notificationService.getNewNotificationCount(function (response){
			if(response.response=="ok"){
				vm.number=response.has_new_notification;
			}
		})
	}
	
	//get top 5 notifications
	vm.loadTopNotifications=function(){

		notificationService.getTopNotifications(function (response){
			/*if(typeof response != 'undefined' && typeof response.result.entry[0].response != 'undefined' && response.result.entry[0].response=="ok"){
				vm.notification=response.result.entry;
			}*/
			var res = response;
			if(jsonService.whatIsIt(res)=="Object"){
				vm.notification[0] = res;
			}
			else if(jsonService.whatIsIt(res)=="Array"){
				vm.notification = res;
			}
		})
		
	}
	if (jwtService.hasValidToken()) {
	    vm.loadTopNotifications();
	    vm.getNewNotifications();
	}
	
} ]);

	