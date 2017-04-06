/***
 * Copyrights
 * Project: MDL
 * Author: Thilina Herath
 * Module: photo controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.gpstracking'
angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope','$geolocation','toaster', 
                                                     'settings', 'mdl.mobileweb.service.gpstrack', '$modal', 'modalService','$location','$routeParams', '$interval',
                                                     function($rootScope, $scope, $geolocation,toaster,
                                                    		 settings, gpsService, $modal, modalService, $location, $routeParams, $interval) {
	$rootScope.loginactive = false;
	
	var vm = this;
	vm.isAutoTrackingEnabled = $routeParams.autotracking;
	
    $scope.timerType = '';
    vm.trackButton = false;
    vm.stopButton = true;
    vm.buttonLabel = 'Start Tracking';
    vm.gpsTimeOut = settings.gpsTimeOut;
    
    vm.latitudeArray = new Array(); //Adding latitude values to an array
    vm.longitudeArray = new Array(); //Adding longitude values to an array
    vm.distanceArray = new Array(); //Adding related distances to an array
    
    vm.timerTrack;
    
    if ($rootScope.trackingTimerStarted){
    	vm.buttonLabel = 'Tracking started already...!';
		vm.trackButton = false;
		vm.stopButton = false;
    }
    
    vm.stopTimer =  function(){
    	$interval.cancel(vm.timerTrack);
    };
    
    // Start the timer
    vm.startTracking = function (){
    	$rootScope.cui_blocker(true);
    	$geolocation.getCurrentPosition({}).then(function (position) {
    		var storeLocation = {};
            storeLocation.latitude = position.coords.latitude;
            storeLocation.longitude = position.coords.longitude;
    		vm.trackButton = true;
    		vm.stopButton = false;
    		
    		gpsService.startGpsTracking(storeLocation,function(response){
    			var res = response.response;
    			if ((res=="success") || (res=="tracking already started")){

    				toaster.pop('info', "GPS Tracking Manager","Started Tracking Your Location");
    				toaster.pop('success', "GPS Tracking is in progress","");
    				vm.buttonLabel = 'Started Tracking...!';
    				$rootScope.trackingTimerStarted = true;
    				vm.timerTrack = $interval(vm.trackingTimerCall, 180000);//This timer is available for whole application
    				$rootScope.cui_blocker();
    			}
    			else {
    				$rootScope.cui_blocker();
    				vm.trackButton = true;
    				toaster.pop('error', "Unauthorized Service","");
    			}    		  
    		})

    	}, (function (error) {
    		toaster.pop('error', "Error","Cannot find a network connection");       	  
    	}));
    };
    
    if(typeof vm.isAutoTrackingEnabled != "undefined" && vm.isAutoTrackingEnabled=="enableTracking")//If the page is visited with "enableTracking" param, tracking starts automatically i.e. Redirection from Record Progress
    	vm.startTracking();
    
    
      // Stop the timer
      vm.stopTracking = function (){
    	  vm.trackButton = false;
          //$scope.$broadcast('timer-stop');
          //$scope.timerRunning = false;
    	  vm.stopTimer();
    	  $rootScope.trackingTimerStarted = false;
          vm.stopButton = true;
          vm.buttonLabel = 'Track Again';
          
          gpsService.stopGpsTracking(function(response){
    		  var res = response.response;
    		  if (res=="success"){
    	          toaster.pop('info', "GPS Tracking Stopped Successfully","");
				}
			else {
				toaster.pop('error', "GPS Tracking did not exit!","");
				}    		  
    	  })
      };

      // Timer tick event
      vm.trackingTimerCall = function () {
    	  $rootScope.cui_blocker();
          $geolocation.getCurrentPosition({
              timeout: 10000
          }).then(function (position) {

              var storeLocation = {};
              storeLocation.latitude = position.coords.latitude;
              storeLocation.longitude = position.coords.longitude;

              var total = 0; //show the current location is in the given radius
              var median = 0;
              var variance = 0;
              
              var distanceBetweenTwoPoints = vm.calculateDistance(storeLocation.latitude, storeLocation.longitude, vm.countingCenterLatitude, vm.countingCenterLongitude);
      		  
      		  if (distanceBetweenTwoPoints > 0.5) {
      			  gpsService.updateGpsTracking(storeLocation,function(response){
      				  var res = response.response;
      				  if (res=="success"){
      					  if($location.path() == "/gpstracking" || $location.path() == "/gpstracking/enableTracking")//Timer is available globally, so only show this message when user visit this page
      						  toaster.pop('info', "","Location Updated");
      				  } else {
      					  toaster.pop('error', "GPS Tracking Upload Failed!","");
      				  }    		  
      			  })
      		  } else { 
	      			vm.latitudeArray.push(storeLocation.latitude);
	                vm.longitudeArray.push(storeLocation.longitude);
	                
	                if (vm.latitudeArray.length == 30 && vm.longitudeArray.length == 30) {
	              	  
	                	for (var i=0, j=0; i<vm.latitudeArray.length, j<vm.longitudeArray.length; i++, j++) {
	                		vm.distanceArray.push(vm.calculateDistance(vm.latitudeArray[i], vm.longitudeArray[j], vm.countingCenterLatitude, vm.countingCenterLongitude));
	                	}
	                	
	                	for (var i=0; i<vm.distanceArray.length; i++) {
	                		total = total+vm.distanceArray[i];
	                	}
	                	
	                	median = total/vm.distanceArray.length;
	                	
	                	for (var i=0; i<vm.distanceArray.length; i++) {
	                		var difference_with_median = Math.pow((vm.distanceArray[i]-median), 2);
	                		variance = variance + difference_with_median;
	                	}
	                	
	                	var standard_deviation = Math.sqrt(variance/vm.distanceArray.length);
	                	
	                	
	                	if(standard_deviation>0.02) {
	                		gpsService.updateGpsTracking(storeLocation,function(response){
	                			var res = response.response;
	                			if (res=="success"){
	                				toaster.pop('info', "","Location Updated");
	                			} else {
	                				toaster.pop('error', "GPS Tracking Upload Failed!","");
	                			}    		  
	                		})
	                		
	                		vm.latitudeArray = [];
	            			vm.longitudeArray = [];
	            			vm.distanceArray = [];
	            			
	                	} else {
	                		 vm.trackButton = false;
	                         //$scope.$broadcast('timer-stop');
	                         //$scope.timerRunning = false;
	                   	  	vm.stopTimer();
	                   	  	
	            			vm.buttonLabel = 'Track Again';
	            			vm.stopButton = true;
	            			vm.trackButton = false;
	                      
	            			gpsService.stopGpsTracking(function(response){
	            				var res = response.response;
            				  	if (res=="success"){
            				  		toaster.pop('info', "You have arrived to the Counting Center","GPS Tracking Stopped Successfully");
            				  	} else {
            				  		toaster.pop('error', "GPS Tracking did not exit!","");
            				  	}    		  
	            			})
	            			
	            			vm.latitudeArray = [];
	            			vm.longitudeArray = [];
	            			vm.distanceArray = [];
	                	}
	                }
      			  
      		  }
      		  
          }, (function (error) {
        	  toaster.pop('info', "","Retrying.... ");
        	  toaster.pop('error', "Error","Cannot find a network connection");       	  
          }));
      
      };
      
      //get Counting Center Latitude and Longitude
      vm.setCenter = function(){
    	  gpsService.getMapCenter(function(response){
    		  var resp = response;
    		  vm.center = [resp.latitude, resp.longitude];
    		  vm.countingCenterLatitude = resp.latitude;
    		  vm.countingCenterLongitude = resp.longitude;
    	  })
      };
      vm.setCenter();
      
      //calculate the distance between current location and the counting center in kilo meters
      vm.calculateDistance = function(currentLatitude, currentLongitude, countingCenterLatitude, countingCenterLongitude) {
    	  var radCurrent = Math.PI * currentLatitude/180;
    	  var radCountingCenter = Math.PI * countingCenterLatitude/180;
    	  var theta = currentLongitude-countingCenterLongitude;
    	  var radtheta = Math.PI * theta/180;
    	  var dist = Math.sin(radCurrent) * Math.sin(radCountingCenter) + Math.cos(radCurrent) * Math.cos(radCountingCenter) * Math.cos(radtheta);
    	  dist = Math.acos(dist);
    	  dist = dist * 180/Math.PI;
    	  dist = dist * 60 * 1.1515; //convert the distance to kilo meters
    	  dist = dist * 1.609344;
    	  
    	  return dist;
    }
	
} ]);


