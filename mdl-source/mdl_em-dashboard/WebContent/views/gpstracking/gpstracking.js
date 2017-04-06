/***
 * Copyrights
 * Project: MDL
 * Author: Thilina Herath
 * Module: photo controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.gpstracking'
angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope','$geolocation','toaster', 'settings',
                                                     function($rootScope, $scope, $geolocation,toaster,settings) {
	$rootScope.loginactive = false;
	
	var vm = this;
    $scope.timerType = '';
    vm.buttonLabel = 'Start Tracking';
    vm.gpsTimeOut = settings.gpsTimeOut;
    
      // Start the timer
      vm.startTracking = function (){
    	  toaster.pop('info', "GPS Tracking Manager", "Started Tracking the device ");
    	  toaster.pop('success', "GPS Tracking Running","");
    	    
    	  vm.buttonLabel = 'Started Tracking...!';
          $scope.$broadcast('timer-start');
          $scope.timerRunning = true;
          document.getElementById("stopButton").disabled = false;
          document.getElementById("startButton").disabled = true;
      };

      // Stop the timer
      vm.stopTracking = function (){
          $scope.$broadcast('timer-stop');
          $scope.timerRunning = false;
          document.getElementById("startButton").disabled = false;
          document.getElementById("stopButton").disabled = true;
          toaster.pop('info', "GPS Tracking Stopped!","");
          vm.buttonLabel = 'Track Again';
      };

      // Timer tick event
      $scope.$on('timer-tick', function (event, args) {

          $geolocation.getCurrentPosition({
              timeout: 10000
          }).then(function (position) {

              //$scope.myPosition = position;
              var storeLocation = {};
              storeLocation.latitude = position.coords.latitude;
              storeLocation.longitude = position.coords.longitude;

              console.log(storeLocation);
              
              // Http request to upload the locations
          }, (function (error) {


          }));
      
      });
	
	
} ]);