/***
 * Project: MDL
 * Author: Sudaraka Jayashanka
 * Module: Organisation Setup controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.orgsetup'
angular.module('newApp').controller(controllerName,
    ['$rootScope', '$scope', '$location','mdl.mobileweb.service.reportIssue', 'mdl.mobileweb.service.dashboard', 'toaster',
     'mdl.mobileweb.service.json',
function ($rootScope, $scope, $location,reportIssueService, dashboardService, toaster,jsonService) {
    $rootScope.loginactive = false;

    var vm = this;
    vm.orgSetup={};
    
    vm.update=function(orgSetup){
    	
    }
    
    vm.getOrganizationInfo=function(){
    	//load the information
    	
    }

    


}]);