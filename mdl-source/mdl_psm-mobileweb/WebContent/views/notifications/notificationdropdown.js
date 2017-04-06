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
                                                     function($rootScope, $scope,notificationService,loginService, jsonService) {
	
	
	var vm = this;
	vm.number_of_Notifications = "";
	vm.number = "0";
	
	vm.notificationDetails=[];
	
	vm.notification = [];
	
    $scope.$on('timer-tick', function (event, args) {
    	var token = loginService.getAccessToken();
    	if(token!=null)
    	vm.getNewNotifications();
    	vm.loadTopNotifications();
    });
	vm.getNewNotifications=function(){
		notificationService.getNewNotificationCount(function (response){
			if(response.result.entry.response=="ok"){
				vm.number=response.result.entry.has_new_notification;
			}
		})
	}
	
	//get top 5 notifications
	vm.loadTopNotifications=function(){
		var token = loginService.getAccessToken();
    	if(token!=null){
			notificationService.getTopNotifications(function (response){
				/*if(typeof response != 'undefined' && typeof response.result.entry[0].response != 'undefined' && response.result.entry[0].response=="ok"){
					vm.notification=response.result.entry;
				}*/
				var res = response.result.entry;
				if(jsonService.whatIsIt(res)=="Object"){
					vm.notification[0] = res;
				}
				else if(jsonService.whatIsIt(res)=="Array"){
					vm.notification = res;
				}
			})
		}
	}
	
	vm.loadTopNotifications();
	vm.getNewNotifications();
	
} ]);

	