/***
 * Copyrights
 * Project: MDL
 * Author: Thilina Herath
 * Module: photo controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.photo'
angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope', 
                                                     function($rootScope, $scope) {
	$rootScope.loginactive = false;
	
	var vm = this;
		
	$scope.picture = false;
	
	
} ]);