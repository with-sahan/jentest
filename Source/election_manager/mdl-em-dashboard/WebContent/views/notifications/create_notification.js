/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM create notification controller
 */

'use strict';

var controllerName = 'mdl.em.controller.emcreatenotification'
	angular.module('newApp').controller(controllerName,
			['$rootScope', '$scope','mdl.em.service.notificationServices', 
			 'mdl.mobileweb.service.dashboard','mdl.mobileweb.service.json', 'mdl.mobileweb.service.login','mdl.em.service.geoHierarchyService', 
			 'Upload', '$timeout','toaster','$location','settings',
			 function ($rootScope, $scope, notificationService, dashboardService, 
					 jsonService, loginService,geoHierarchyService, Upload, $timeout, toaster, $location, settings) {
				
	$rootScope.loginactive = false;

	var vm = this;
	vm.buttonHide = false;	
	vm.description = "";
	vm.geoHierarchy=[];
	vm.selectedHrc="";
	vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	
	vm.getStationList = function (){
		dashboardService.getPollingStationsByHierarchy(vm.selectedHrc,function (response){
			var resp = response;
			if(jsonService.whatIsIt(resp)=="Object"){
				vm.pollingStationList[0] = resp;
			}
			else if(jsonService.whatIsIt(resp)=="Array"){
				vm.pollingStationList = resp;
			}
	    })
	}
	
	
	$scope.uploadPic = function(file, stationId, description) {
		
		var fileInput = $('.upload-file');
	    var maxSize = fileInput.data('max-size');
	    
//		alert(maxSize);	
		if(fileInput.get(0).files.length){
            var fileSize = fileInput.get(0).files[0].size; // in bytes
            if(fileSize>maxSize){
            	toaster.pop("Success","file size is more than " + maxSize/(1024*1024) + " MB","");   
                return false;
            }else{
            }
        }else{
        }
		
		if(vm.validate(description,stationId)){

			
			
			if(file==null) file = 'null';
			vm.buttonHide = true;	
		    try {
		        //blockUI.start();
		    	$rootScope.cui_blocker(true);//UI blocker started
				var token = loginService.getAccessToken();	
				var stid=stationId;
				if (stationId==null || stationId=="") stid="-1";
				
				if (file != 'null') {
					file.upload = Upload.upload({
						url: vm.mdljaxrsApiBaseUrl + 'notification/makenotification',
						data: {file: file, hierarchyId:vm.selectedHrc, stationId:stid, description:description},
					});

					file.upload.then(function (response) {
					    //blockUI.stop();
						toaster.pop("Success","File Successfully Uploaded","Notification Sent Successfully.");
						$rootScope.cui_blocker();
						$timeout(function () {
							file.result = response.data;
						});
						$location.path('/notifications');
					},
					function (response) {
					    //blockUI.stop();
						$rootScope.cui_blocker();
						if (response.status > 0)
							$scope.errorMsg = response.status + ': ' + response.data;
					});
				} else {
					Upload.upload({
						url: vm.mdljaxrsApiBaseUrl + 'notification/makenotification',
                        data: {file: file, hierarchyId:vm.selectedHrc, stationId:stid, description:description},
					});
				}
			}finally{
				if (file == 'null'){
					$rootScope.cui_blocker();
					toaster.pop("Success","Notification Sent Successfully","");
					$location.path('/notifications');
				}
				else
				toaster.pop("info","File Uploading","Please Wait..");
			}		
		}
	}
	
	
	//this is to get the geo hierarchy to the dropdown list
	vm.getGeoHierarchy=function(){
		geoHierarchyService.getGeoHierarchy(function (response) {
			vm.geoHierarchy = response;
			//console.log(" vm.geoHierarchy " + vm.geoHierarchy.response);

        })
	}
	
	vm.getGeoHierarchy();
	
	vm.loadStstions=function(){
		vm.getStationList();
	}
	
	vm.validate = function(description,stationId){
		
		if (vm.selectedHrc==null || vm.selectedHrc==""){
			toaster.pop("error","Location must be selected!","");
			return false;
		}
		if (description==""){
			toaster.pop("error","Fill the description!","");
			return false;
		}
		return true;
	}
	
	vm.cancelNotification = function(){
		$location.path('/notifications');
	}	

}]);