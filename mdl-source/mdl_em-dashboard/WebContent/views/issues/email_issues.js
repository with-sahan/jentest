/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM email issue controller
 */

'use strict';

var controllerName = 'mdl.em.controller.ememailissue'
	angular.module('newApp').controller(controllerName,
			['$rootScope', '$scope','mdl.em.service.emissueServices', 'mdl.mobileweb.service.json','mdl.mobileweb.service.dashboard', '$routeParams', 'toaster',  
			 function ($rootScope, $scope, issueService, jsonService, dashboardService, $routeParams, toaster) {
		
	var vm = this;
	
	vm.buttonHide = false;

  	vm.user = {};
	vm.user.response = "";
	vm.user.id = "";
	vm.user.username = "";
	vm.user.email = "";
	vm.user.lastname = "";
	vm.user.firstname = "";
	vm.user.fullname = "";
	
	vm.userDetails = [];
	vm.emailDetails = {};
	vm.emailDetails.emailTo = "";
	
	vm.getAllUsers = function (){
		issueService.getAllUsers(function (response){
			vm.user = response.result.entry;
	    })
	}
	
	vm.getAllUsers();
	
	vm.creatingEmail = function (emaildetails) {
		console.log(emaildetails);
		if(vm.emailDetails.emailTo.length <= 0) {
			toaster.pop("error","Select a Person to send the email!","");
		} else if(vm.emailDetails.emailBody == undefined) {
			toaster.pop("error","Insert the content of your email!","");
		} else {
			
			vm.emailDetails.emailSubject = vm.resolvedIssue.issuedescription;
			issueService.creatingEmail(emaildetails, function (response){
				var res = response;
	    		console.log(response);
	    		if(response.response=="success"){
	            	toaster.pop("success","Emailed!","");
	            }
	            else{
	            	toaster.pop("error","Error Submitting the Email!","Please try again");
	            }
		    })
		}
	}
	
	/*vm.resolvedIssue = [];
	vm.resolvedIssue*/
	
	vm.getIssueByID = function (id) {
		
			issueService.getIssueByID(function (response) {
				vm.resolvedIssue = response.result.entry;
				
			},id)
		
		
	};
	
	vm.issueID = $routeParams.id;
	vm.getIssueByID(vm.issueID);
				
}]);