/***
 * Copyrights
 * Project: MDL
 * Author: Ashan Perera
 * Module: Issue Notification
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.issuedropdown'
angular.module('newApp').controller(controllerName,['$scope','mdl.em.service.emissueServices','mdl.mobileweb.service.json','$location',
                                                     function($scope,issueService, jsonService, $location) {
	var vm = this;
	
	vm.newIssues = [];
	
    $scope.$on('timer-tick', function (event, args) { // Update the Issue notification on all EM pages but login
    	if($location.$$path != "/login")
    		vm.getUnwatchedIssues();
    });
    
    vm.getUnwatchedIssues = function() { //Fetch all unwatched issues
    	vm.newIssues = [];
    	issueService.getUnwatchedIssues(function (response) {	
        	if(response.result.entry != "undefined"){
        		var res = response.result.entry;
    			if(jsonService.whatIsIt(res)=="Object"){
    				vm.newIssues[0] = res;
    			}
    			else if(jsonService.whatIsIt(res)=="Array"){
    				vm.newIssues = res;
    			}
        	}

        });
    }
    
    vm.setIssueAsWatched =  function(notificationid, issueid){ //If any issue is clicked (on issue notification dropdown), mark it as watched
    	issueService.setIssueAsWatched(notificationid, function (response) {
    		vm.getUnwatchedIssues();
    		$location.path('/all_issues/manage/'+issueid); // take to Issue detail page
        }); 
    }    
    
    vm.getUnwatchedIssues(); // On template load, fetch newly reported issues
	
} ]);

	