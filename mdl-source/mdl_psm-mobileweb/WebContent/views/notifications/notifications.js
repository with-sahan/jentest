/***
 * Copyrights
 * Project: MDL
 * Author: Ashan Perera
 * Module: Notification module
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.notifications'
angular.module('newApp').controller(controllerName,['$scope','mdl.mobileweb.service.notification',
                                                    'toaster','settings','$routeParams','$anchorScroll',
                                                    'mdl.mobileweb.service.anchorSmoothScroll','$timeout','mdl.mobileweb.service.json',
                                                     function( $scope,notificationService,toaster,settings,
                                                    		 $routeParams,$anchorScroll,anchorSmoothScroll,$timeout,jsonService) {
	
	
	var vm = this;
	vm.number_of_Notifications = "";
	vm.number = "0";
	vm.notifications = [];
	vm.appendUrl = settings.dowloadUrl;

	vm.notificationId = $routeParams.id;
	//get top 5 notifications
	vm.getAllNotifications=function(){
		notificationService.getAllNotifications(function (response){
			if(response.result!=""){
				var res = response.result.entry;
				if(jsonService.whatIsIt(res)=="Object"){
					vm.notifications[0] = res;
				}
				else if(jsonService.whatIsIt(res)=="Array"){
					vm.notifications = res;
				}
			}			
		})
	}
	
	vm.confirmMsg = function(notification_id){ //Acknowledge a msg
		notificationService.confirmNotifications(notification_id, function (response){
			if(response.result!="" && response.result.entry.response=='success'){
				toaster.pop("success","Your message has been acknowledged","");
			}			
		})				
	}
	
    angular.element(document).ready(function () {// Notification id is passed in the url, scroll to that message (tracked by msg id)
        $timeout(function() {
	    	if(typeof vm.notificationId != "undefined"){
				anchorSmoothScroll.scrollTo('notification'+vm.notificationId);
			}	
        }, 30000);			

    });		
	vm.getAllNotifications();
	
} ]);

	