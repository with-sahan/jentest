/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM manage notification controller
 */

'use strict';

var controllerName = 'mdl.em.controller.emmanagenotification'
	angular.module('newApp').controller(controllerName,
			['$rootScope', '$scope','mdl.em.service.notificationServices', 'mdl.mobileweb.service.json',
			 'mdl.mobileweb.service.dashboard', '$routeParams', 
			 function ($rootScope, $scope, notificationService, jsonService, dashboardService, $routeParams) {
		
	var vm = this;
	
	vm.oneNotification = {};
	vm.oneNotification.id = "";
	vm.oneNotification.message = "";
	vm.oneNotification.attachtment = "";
	vm.oneNotification.senton = "";
	vm.oneNotification.status = "";
	vm.oneNotification.response = "";
	
	vm.oneNotificationDetails = [];
	
	vm.getNotificationByID = function (id) {
		notificationService.getNotificationByID(function (response) {
			vm.oneNotification = response;
		},id)
	};
	vm.getNotificationByID($routeParams.id);
				
}]);