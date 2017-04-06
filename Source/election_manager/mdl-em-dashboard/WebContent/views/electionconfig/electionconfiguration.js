/***
Project: MDL Dashboard Admin
Author: Rushan Arunod
Modified By: Akarshani Amarasinghe
Module: EM election configuration Controller
 */
'use strict';

angular.module('newApp').controller('mdl.dashboard.controller.electionconfiguration',
		['$http','$scope','toaster', 'mdl.mobileweb.service.json','mdl.dashboard.service.electionconfig','$rootScope', '$location', '$routeParams'
		 ,'Upload','settings','$timeout','mdl.mobileweb.service.csvfileupload', '$interval','modalService','mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.jwt',
		 function ($http,$scope, toaster, jsonService, elecconfigService, $rootScope, $location,
				 $routeParams, Upload, settings,$timeout,csvService, $interval, modalService,dashboardDBService, jwtService) {

			var vm = this;
			vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
			vm.appendUrl = settings.dowloadUrl;

			vm.picFile= [];

			vm.saveDisabled = false;
			vm.uploadDisabled = false;
			vm.uploadDivHide = false;

			vm.electionconfig = {};
			/* Setting To false value */
			vm.electionconfig.ballot_type_count=1;
			vm.electionconfig.BPA_identifier=0;

			vm.listOfElections = [];

			vm.latitude = null;
			vm.longitude = null;

			vm.geocoder = new google.maps.Geocoder();
			vm.selectCheckBox="0";

			vm.checkCheckBox = function () {
				console.log("Clicked!!!!");
		          //var notSelected = $filter('filter')( { iscompleted: "0" })

		              if (vm.selectCheckBox==1) {
		            	  vm.selectCheckBox="1";
		                  console.log("selected@@@");
		              }
		              else {
		                  //vm.selectCheckBox = "0";
		                  console.log("Not selected@@@");
		              }
		      }



			vm.getElection = function () {
				elecconfigService.getElection(function (response) {
					//vm.listOfElections = response.result.entry;

					var resp = response;
					//var resp = response.result.entry;


					if(jsonService.whatIsIt(resp)=="Object"){
						vm.listOfElections[0] = resp;
					}
					else if(jsonService.whatIsIt(resp)=="Array"){
						vm.listOfElections = resp;
					}
					angular.forEach(vm.listOfElections,function(value,key){
						elecconfigService.getElectionFileUploadDetails(function (response) {
				            var res = response.response;
				            vm.listOfElections[key].filestatus=res;

				            /*if (res == "success") {
				            	vm.uploadDivHide = true;
				            } else if (res == "nodata") {
				            	vm.uploadDivHide = false;
				            }*/
				        }, value.electionid)

					});

				})
			}

			vm.getElection();

			vm.save = function(electionconfig){
				$rootScope.cui_blocker(true);//UI blocker started

				if(vm.validate(electionconfig)){
					vm.geocoder.geocode({'address': electionconfig.counting_center_address}, function(results, status) {
						if (status === google.maps.GeocoderStatus.OK) {
							vm.latitude = results[0].geometry.location.lat();
							vm.longitude = results[0].geometry.location.lng();


							elecconfigService.createElection(electionconfig,vm.latitude, vm.longitude,vm.selectCheckBox, function(response){
								var resp = response.response;
								if(resp=="success"){
									vm.saveDisabled = true;
									toaster.pop("success","Successfully Created The Election","");
									//location.reload();
									$location.path('/electionconfiguration');
									$rootScope.cui_blocker();
								}
								else if(resp=="dataduplicate"){
									toaster.pop("info","This Election is already created!","");
									$rootScope.cui_blocker();
								}
								else if(resp=="notcurrentdate"){
									toaster.pop("info","You can only create an Election from today onwards!","");
									$rootScope.cui_blocker();
								}
								else if(resp=="notcurrenttime"){
									toaster.pop("info","You can only create an Election from the current time today onwards!","");
									$rootScope.cui_blocker();
								}
								else{
									toaster.pop("error","Error Creating The Election","Please try again later!");
									$rootScope.cui_blocker();
								}
							});

						} else {

							$rootScope.cui_blocker();
							toaster.pop("error","Geocode was not successful, Enter a Valid Address for counting center","");
						}
					});

				}else $rootScope.cui_blocker();
			}

			vm.validate = function(electionconf){
//				console.log(electionconf);
				if ((electionconf.ename==undefined) || (electionconf.ename=='')) {
					toaster.pop("error","Fill the election name correctly","");
					return false; }
				if ((electionconf.edate==undefined) || (electionconf.edate==''))  {
					toaster.pop("error","Fill the election date","");
					return false; }
				if ((electionconf.starttime==undefined) || (electionconf.starttime=='')) {
					toaster.pop("error","Fill the election start time","");
					return false; }
				if ((electionconf.endtime==undefined) || (electionconf.endtime=='')) {
					toaster.pop("error","Fill the election end time","");
					return false; }
				if (electionconf.endtime<=electionconf.starttime) {
					toaster.pop("error","Election end time should larger than election start time","");
					return false; }
				if ((electionconf.counting_center_name==undefined) || (electionconf.counting_center_name=='')) {
					toaster.pop("error","Fill the counting center name correctly","");
					return false; }
				if ((electionconf.counting_center_address==undefined) || (electionconf.counting_center_address=='')) {
					toaster.pop("error","Fill the counting center address correctly","");
					return false; }
				return true;
			};

			vm.cancel = function () {
				$location.path('/electionconfiguration');
			}

			vm.fileupload = function(file,eid){
				if(file==null) {toaster.pop("error","No File!","Please Choose a File.");}
				else{
					try {
						//blockUI.start();
						$rootScope.cui_blocker(true);//UI blocker started

						file.upload = Upload.upload({
							url: vm.mdljaxrsApiBaseUrl + 'media/uploadcsv',
							data: {file: file},
						});

						file.upload.then(function (response) {
							//blockUI.stop();
							var path = response.data.path;
							console.log(path);
							toaster.pop("Success","File Successfully Uploaded!","file is being processed");
							$rootScope.cui_blocker();

							csvService.uploadPollingStations(path,eid,function(response){
								$rootScope.cui_blocker();
								if(response.response=="Success") {
									toaster.pop("success","Report generated!","");
//									location.reload();
								}else if(response.response=="notsupported"){
									toaster.pop("error","Structure Not Supported!","");
								}else if(response.response=="ERROR"){
									toaster.pop("error","Please Try Again Later","");
								}else
									toaster.pop("error","Unauthorized!");
							});

							$timeout(function () {
//								file.result = response.data;
							});
						},
						function (response) {
							//blockUI.stop();
							$rootScope.cui_blocker();
							if (response.status > 0)
								$scope.errorMsg = response.status + ': ' + response.data;
						},
						function (evt) {
							file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
						});
					}finally{
					}
				}
			}

			vm.timermethods = function(){
				vm.getElection();
			}

			//modalcolouredfooter
			$scope.template = "views/templatemodal/modalcolouredfooter.html";
			var fileinfo = {};

			vm.loadStatus = function(eid){
				vm.filestatus="";
				csvService.filedetails(eid,function(response){
					vm.details=response;
					vm.valid="";

					if(vm.details.response==""){
						vm.filestatus="Error";
					}else if(vm.details.response=="success"){
						vm.filestatus="CSV Report";
						fileinfo.name = vm.details.reportpath.split('/data/media/')[1];
						fileinfo.url = vm.appendUrl+vm.details.reportpath;

						if(vm.details.filestatus==2){
							vm.valid="Validated With Errors";
							vm.color="red";
						}
						else if(vm.details.filestatus==3){
							vm.valid="Validation Success";
							vm.color="green";
							}
						else {
							vm.valid="Not Validated";
							vm.color="red";
							};
					}else
						vm.filestatus="Unauthorized!";


					$scope.templateModal =  {
							id: "popup_elecConfig",
							header: vm.filestatus,
							closeCaption: "Close",
							saveCaption: "Yes",
							validation:vm.valid,
							fileinfo: fileinfo,
							savehide: true,
							colorchange: vm.color,
							close: function() { modalService.close('popup_elecConfig');  }
					};
					modalService.load('popup_elecConfig');
				});


			}

			vm.resettenant = function(){
				$rootScope.cui_blocker();
				elecconfigService.resettenantdata(function (response) {
					$rootScope.cui_blocker(false);
					if (response.result.response == 'success'){
						toaster.pop("info","Reset Tenant Success","");
					}
				});
			}
			vm.updateelectionstatus = function(newstatus){
				$rootScope.cui_blocker();
				dashboardDBService.updateelectioneventstatus(newstatus,function(response){
					$rootScope.cui_blocker(false);
					if (response.result.response == 'success'){
						toaster.pop("info","Election Status Updated","");
					}
				});
			}
            $scope.downloadCSV = function(param) {
                  var config = {
                       headers:  {
                       		'Authorization': "Bearer " + jwtService.getToken()
                       	    }
                        };
                  $http.get(param, config).success(function(data, status, headers, config){
                       var contentDispositionHeader = headers('Content-Disposition');
                       var result = contentDispositionHeader.split(';')[1].trim().split('=')[1];
                       var anchor = angular.element('<a/>');
                       	    anchor.attr({
                       			href: 'data:attachment/c2sv;charset=utf-8,' + encodeURI(data),
                       			target: '_blank',
                       			download: result
                       			})[0].click();
                       })

            }
			vm.loadelectionstatus = function(){
				dashboardDBService.getelectioneventstatus(function(response){
					if (response.response == 'success'){
						console.log(response);
						switch(response.status){
						case 0:
							$scope.electionstatus="pre";
							break;
						case 1:
							$scope.electionstatus="current";
							break;
						case 2:
							$scope.electionstatus="post";
							break;
						default:
							$scope.electionstatus="";
							break;
						}
					}
				});
			}
			vm.loadelectionstatus();

			$scope.$watch('electionstatus', function(newValue, oldValue){
			  if (oldValue === undefined) {
			  }
			  else{
				  vm.updateelectionstatus(newValue);
			  }
			}, true);
		}]);
