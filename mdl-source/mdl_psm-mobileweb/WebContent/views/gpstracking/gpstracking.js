/***
 * Copyrights
 * Project: MDL
 * Author: Thilina Herath
 * Module: photo controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.gpstracking'
angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope','$geolocation','toaster', 
                                                     'settings', 'mdl.mobileweb.service.gpstrack', '$modal', 'modalService','$location',
                                                     function($rootScope, $scope, $geolocation,toaster,
                                                    		 settings, gpsService, $modal, modalService, $location) {
	$rootScope.loginactive = false;
	
	var vm = this;
    $scope.timerType = '';
    vm.trackButton = false;
    vm.stopButton = true;
    vm.buttonLabel = 'Start Tracking';
    vm.gpsTimeOut = settings.gpsTimeOut;
    
    // Start the timer
    vm.startTracking = function (){
    	$geolocation.getCurrentPosition({}).then(function (position) {
    		$rootScope.cui_blocker(true);
    		var storeLocation = {};
            storeLocation.latitude = position.coords.latitude;
            storeLocation.longitude = position.coords.longitude;
    		vm.trackButton = true;
    		vm.stopButton = false;
    		gpsService.startGpsTracking(storeLocation,function(response){
    			var res = response.result.entry.response;
    			if ((res=="success") || (res=="tracking already started")){

    				toaster.pop('info', "GPS Tracking Manager","Started Tracking Your Location!");
    				toaster.pop('success', "GPS Tracking Running","");
    				vm.buttonLabel = 'Started Tracking...!';
    				$scope.$broadcast('timer-start');
    				$scope.timerRunning = true;
    				$rootScope.cui_blocker();
    			}
    			else {
    				$rootScope.cui_blocker();
    				vm.trackButton = true;
    				toaster.pop('error', "Unauthorized Service","");
    			}    		  
    		})

    	}, (function (error) {
    		toaster.pop('error', "Error!","Cannot find a network connection!");       	  
    	}));
    };

      // Stop the timer
      vm.stopTracking = function (){
    	  vm.trackButton = false;
          $scope.$broadcast('timer-stop');
          $scope.timerRunning = false;
          vm.stopButton = true;
          vm.buttonLabel = 'Track Again';
          
          gpsService.stopGpsTracking(function(response){
    		  var res = response.result.entry.response;
    		  if (res=="success"){
    	          toaster.pop('info', "GPS Tracking Stopped Successfully!","");
				}
			else {
				toaster.pop('error', "GPS Tracking did not exit!","");
				}    		  
    	  })
      };

      // Timer tick event
      $scope.$on('timer-tick', function (event, args) {
    	  $rootScope.cui_blocker();
          $geolocation.getCurrentPosition({
              timeout: 10000
          }).then(function (position) {

              var storeLocation = {};
              storeLocation.latitude = position.coords.latitude;
              storeLocation.longitude = position.coords.longitude;

              console.log(storeLocation);
              
              gpsService.updateGpsTracking(storeLocation,function(response){
        		  var res = response.result.entry.response;
        		  if (res=="success"){
        	          toaster.pop('info', "","Location Updated!");
    				}
    			else {
    				toaster.pop('error', "GPS Tracking Upload Failed!","");
    				}    		  
        	  })
              
          }, (function (error) {
        	  toaster.pop('info', "","Retrying.... ");
        	  toaster.pop('error', "Error!","Cannot find a network connection!");       	  
          }));
      
      });
      
                                                         //modalcolouredfooter
      vm.template = "views/templatemodal/modalcolouredfooter.html";
      $scope.templateModal = {
          id: "gps_tracking",
          header: "Confirmation",
          body: "You have unsaved data before navigating to another page. " +
    		  		"Are you sure you want to leave this page?",
          closeCaption: "No",
          saveCaption: "Yes",
          save: function () {
              vm.onRouteChangeOff();
              $location.path($location.url(vm.newUrl).hash()); //Go to page 
              modalService.close('gps_tracking');
          },
          close: function () {
              modalService.close('gps_tracking');
          }
      };

      vm.onRouteChangeOff =  $scope.$on('$locationChangeStart', function (event, newUrl, oldUrl) {
          if (vm.trackButton) {
              vm.newUrl = newUrl;
              event.preventDefault();

              modalService.load('gps_tracking');
    	  }
      });
	
} ]);


