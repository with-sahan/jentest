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
	                                                     'mdl.mobileweb.service.dashboard','mdl.mobileweb.service.json',
	                                                     function($rootScope, $scope, Upload, $timeout,loginService,$base64
	                                                    		 ,settings,toaster,dashboardService,jsonService) {
		$rootScope.loginactive = false;

		var vm = this;
		vm.weburl = settings.mdljaxrsApiBaseUrl;
		vm.photoUploadUrl = vm.weburl + 'photo/uploadImage';
		$scope.picture = false;
		vm.pollingStationList = [];

		vm.stationcheck = function(stationid){
			$scope.picture = false;
		}

		vm.getStationList = function () {
			dashboardService.getPollingStations(function (response) {
				var res = response.result.entry;
				if (jsonService.whatIsIt(res) == "Object") {
					vm.pollingStationList[0] = res;
				}
				else if (jsonService.whatIsIt(res) == "Array") {
					vm.pollingStationList = res;
				}
				else{
					toaster.pop("error","Station list loading error!");
				}
			});
		}

		vm.getStationList();

		// HTML5 camera plugins inject trough the JS
	    $scope.setFile = function(element) {
	        $scope.$apply(function($scope) {
	            $scope.theFile = element.files[0];
				
				//var preview = document.querySelector('img');
	            var file    = document.querySelector('input[type=file]').files[0];
	            var reader  = new FileReader();

	            reader.addEventListener("load", function () {
	                //preview.src = reader.result;
	            	$scope.picture = reader.result;
		
	            }, false);

	            	if (file) {
	            		reader.readAsDataURL(file);
	            	}
	  
				//console.log($scope.picture);
	        });
	    };
		
		$scope.uploadPic = function(file1,stationid) {
			$rootScope.cui_blocker(true);//UI blocker started
			var encodedI = $base64.encode(file1);
			var token = loginService.getAccessToken();	
			var stationId = stationid;

			file.upload = Upload.upload({
				url: vm.photoUploadUrl +'?stationId=' + stationId + '&token=' + token,
				method : 'POST',
				headers: { 'Content-Type': 'multipart/form-data'},
				file: encodedI
			});

			file.upload.then(function (response) {
				$timeout(function () {
					file.result = response.data;
					//console.log(file.result);
					if(file.result.response=="success"){
						$rootScope.cui_blocker();
						toaster.pop("success","File Upload Success!","");
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