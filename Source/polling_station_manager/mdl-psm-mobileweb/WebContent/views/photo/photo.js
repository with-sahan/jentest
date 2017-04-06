/***
 * Copyrights
 * Project: MDL
 * Author: Thilina Herath
 * Module: photo controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.photo'
	angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope', 'Upload','$timeout',
	                                                     'mdl.mobileweb.service.login','$base64','settings','toaster',
	                                                     'mdl.mobileweb.service.dashboard','mdl.mobileweb.service.json','$filter',
	                                                     function($rootScope, $scope, Upload, $timeout,loginService,$base64
	                                                    		 ,settings,toaster,dashboardService,jsonService,$filter) {
		$rootScope.loginactive = false;

		var vm = this;
		vm.weburl = settings.mdljaxrsApiBaseUrl;
		vm.photoUploadUrl = vm.weburl + 'media/upload-image';
		$scope.picture = false;
		vm.pollingStationList = [];

		vm.file = null;

		$scope.onFilesSelected = function(files) {
     console.log("files - " + files);
	 	};

		vm.stationcheck = function(stationid){
			vm.stationid=stationid;
			$scope.picture = false;
		}

		vm.getStationList = function () {
			dashboardService.getPollingStations(function (response) {
				var res = response;
				if (jsonService.whatIsIt(res) == "Object") {
					vm.pollingStationList[0] = res;
				}
				else if (jsonService.whatIsIt(res) == "Array") {
					vm.pollingStationList = res;
				}
				else{
					toaster.pop("error","Station list loading error!");
				}

				if (vm.pollingStationList[0]) {
		                vm.stationcheck(vm.pollingStationList[0].id);
		            }

		            vm.selectedStation=vm.stationid;
			});
		}

		vm.getStationList();

		// HTML5 camera plugins inject trough the JS
			$scope.setFile = function(element) {
					$scope.$apply(function($scope) {
							$scope.theFile = element.files[0];
											vm.file    = document.querySelector('input[type=file]').files[0];
											var inputExtension = $filter('lowercase')(vm.file.type);
											if (inputExtension === 'image/gif' || inputExtension === 'image/bmp' || inputExtension === 'image/tiff' || inputExtension === 'image/png' ||
													inputExtension === 'image/jpg' || inputExtension === 'image/jpeg') {
													var reader  = new FileReader();
													reader.addEventListener("load", function () {
													$scope.picture = reader.result;

													}, false);

														// if (file) {
														// 	reader.readAsDataURL(file);
														// }
														if (vm.file) {
															reader.readAsDataURL(vm.file);
														}

											} else {
													toaster.pop("error", "Unsupported file format", "Please select an image file to upload.");
													vm.picFile = '';
											}


					});
			};




		$scope.uploadPic = function(file1,stationid) {
			$rootScope.cui_blocker(true);//UI blocker started
			var encodedI = $base64.encode(file1);
			var stationId = stationid;

			file.upload = Upload.upload({
				url: vm.photoUploadUrl +'?stationId=' + stationId ,
				method : 'POST',
				headers: { 'Content-Type': 'multipart/form-data'},
				file: encodedI
			});

			file.upload.then(function (response) {
				$timeout(function () {
					file.result = response.data;
					if(file.result.response=="success"){
						$rootScope.cui_blocker();
						toaster.pop("success","File Upload Success","");
						$scope.picture = false;
						vm.picFile = null;
					}
					else if(file.result.response=="Error"){
						$rootScope.cui_blocker();
						toaster.pop("error","File Upload Error!","");
					}
				});
			}, function (response) {
				if (response.status > 0)
					$scope.errorMsg = response.status + ': ' + response.data;
			});
		}
	} ]);
