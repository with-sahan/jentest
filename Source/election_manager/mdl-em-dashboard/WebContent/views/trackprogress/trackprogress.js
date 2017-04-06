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
			 'mdl.em.service.geoHierarchyService','mdl.mobileweb.service.json','distance',

			 function ($rootScope, $scope, $location, roleService, toaster, trackingService, $interval, $filter,
					 distanceMatrixService, geoHierarchyService,jsonService,distance) {
				$rootScope.loginactive = false;

				var vm = this;
				vm.timerPromise;
				vm.markers = [];
//				vm.center = [0, 0];
				vm.geoHierarchy = [];
				vm.selectedHrc = "";

				vm.processResponse = function (response) {
					vm.markers = response;
					var resp = response;
					if(jsonService.whatIsIt(resp)=="Object"){
						vm.markers[0] = resp;
					}
					else if(jsonService.whatIsIt(resp)=="Array"){
						vm.markers = resp;
					}

					console.log(vm.markers);
					angular.forEach(vm.markers, function (marker, key) {

//						if (marker.latitude != 0) {
//							vm.center = [marker.latitude, marker.longtitude];
//						}
						if (marker.destination_latitude != 0) {
							vm.center = [marker.destination_latitude, marker.destination_longtitude];
						}

						marker.eta = "";
//						distanceMatrixService.getDistance(marker,
//								function (response) {
//							marker.eta = response.eta; $scope.$apply();
//						});

						vm.beginpoint = {"lat":parseFloat(marker.begin_latitude), "lon":parseFloat(marker.begin_longtitude)};
						vm.currentpoint = {"lat":parseFloat(marker.latitude), "lon":parseFloat(marker.longtitude)};
						vm.endpoint = {"lat":parseFloat(marker.destination_latitude), "lon":parseFloat(marker.destination_longtitude)};

						var distanceremaining = distance.getDistancefromHaversine(vm.currentpoint,vm.endpoint);
						if(marker.average_speed==="0.0"){
							marker.eta="not moving";
						}else{
							var eta =(distanceremaining/parseFloat(marker.average_speed));
							marker.eta = vm.getTimeString(eta);
						}

						if((vm.currentpoint.lat===vm.beginpoint.lat) && (vm.currentpoint.lon===vm.beginpoint.lon)){
							marker.eta="not moving";
						}
						console.log(marker.eta);
					})
				}

				vm.getTimeString = function(timeSeconds){
					var timeString = "";
					timeSeconds = parseInt(timeSeconds);

					if (timeSeconds<60){
						timeString = timeSeconds + "s";
					}else if(timeSeconds<3600){
						timeString = parseInt(timeSeconds/60)+ "m " + (timeSeconds%60) +"s";
					}else if(timeSeconds>3600){
						timeString = parseInt(timeSeconds/3600)+ "h " + parseInt((timeSeconds%3600)/60)+ "m " + ((timeSeconds%3600)%60) +"s";
					}
					return timeString;
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
						vm.geoHierarchy = response;
						vm.selectedHrc = vm.geoHierarchy[0].split('|')[1];
						vm.filterData();
						//console.log(" vm.geoHierarchy " + vm.geoHierarchy.response);

					})
				}

				vm.setCenter = function(){
					trackingService.getMapCenter(function(response){
						var resp = response;
						vm.center = [resp.latitude, resp.longitude];
					})
				}
				vm.setCenter();
				vm.getGeoHierarchy();

				vm.showMakerName = function () {
					var id = document.getElementById(this.id);

					vm.showBallotBoxNumber(this.id);
				};

				vm.showBallotBoxNumber = function  (ballot_box_number) {
					toaster.pop("info", "Box "+ballot_box_number, "");
				};

				vm.showCountingCenter = function () {
					toaster.pop("info", "Counting Center", "");
				};

				vm.timerPromise=$interval(vm.getTrackingProgressTimed, 60000);

				$scope.$on('$destroy', function () {
				    if (vm.timerPromise) {
				        $interval.cancel(vm.timerPromise);
				        vm.timerPromise = undefined;
				    }
				});
			}]);