/***
 * Project: MDL
 * Author: Sudaraka Jayashanka
 * Module: Track Progress controller
 */

'use strict';

var controllerName = 'mdl.dashboard.controller.trackprogress'
	angular.module('newApp').controller(controllerName,
			['$rootScope', '$scope', '$location', 'mdl.dashboard.service.role', 
			 'toaster', 'mdl.em.service.trackingService', '$interval', '$filter', 'mdl.em.service.distanceMatrixService',
			 'mdl.em.service.geoHierarchyService','mdl.mobileweb.service.json',

			 function ($rootScope, $scope, $location, roleService, toaster, trackingService, $interval, $filter, 
					 distanceMatrixService, geoHierarchyService,jsonService) {
				$rootScope.loginactive = false;

				var vm = this;
				vm.timerPromise;
				vm.markers = [];
//				vm.center = [0, 0];
				vm.geoHierarchy = [];
				vm.selectedHrc = "";

				vm.processResponse = function (response) {
					vm.markers = response.result.entry;
					var resp = response.result.entry;
					if(jsonService.whatIsIt(resp)=="Object"){
						vm.markers[0] = resp;
					}
					else if(jsonService.whatIsIt(resp)=="Array"){
						vm.markers = resp;
					}


					angular.forEach(vm.markers, function (marker, key) {

//						if (marker.latitude != 0) {
//							vm.center = [marker.latitude, marker.longtitude];
//						}
						if (marker.destination_latitude != 0) {
							vm.center = [marker.destination_latitude, marker.destination_longtitude];
						}

						marker.eta = "";
						distanceMatrixService.getDistance(marker,
								function (response) {
							marker.eta = response.eta; $scope.$apply();
						});
					})
				}

				vm.getTrackingProgressTimed = function()
				{
						vm.filterData();
				}


				vm.filterData = function () {
					trackingService.getGeoFilteredTrackingProgress(vm.selectedHrc,
							function (response) {
						vm.processResponse(response);

					});
				}

				//this is to get the geo hierarchy to the dropdown list
				vm.getGeoHierarchy = function () {
					geoHierarchyService.getGeoHierarchy(function (response) {
						vm.geoHierarchy = response.response;
						vm.selectedHrc = vm.geoHierarchy[0].split('|')[1];
						vm.filterData();
						//console.log(" vm.geoHierarchy " + vm.geoHierarchy.response);

					})
				}
				
				vm.setCenter = function(){
					trackingService.getMapCenter(function(response){
						var resp = response.result.entry;
						vm.center = [resp.latitude, resp.longitude];
					})
				}
				vm.setCenter();
				vm.getGeoHierarchy();

				vm.timerPromise=$interval(vm.getTrackingProgressTimed, 15000);
				
				$scope.$on('$destroy', function () {
				    if (vm.timerPromise) {
				        $interval.cancel(vm.timerPromise);
				        vm.timerPromise = undefined;
				    }
				});
			}]);