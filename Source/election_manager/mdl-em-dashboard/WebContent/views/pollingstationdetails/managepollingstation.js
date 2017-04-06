/***
Project: MDL Dashboard Admin
Author: Vindya Hettige
Module: EM polling station details Controller
 */
'use strict';

angular.module('newApp').controller('mdl.dashboard.controller.managepollingstationdetails',
		['$http','$scope','toaster', 'mdl.mobileweb.service.json','mdl.dashboard.service.electionconfig','$rootScope', '$location', '$routeParams'
		 ,'Upload','settings','$timeout','mdl.mobileweb.service.csvfileupload', '$interval','modalService', 'mdl.mobileweb.service.jwt',
		 function ($http, $scope, toaster, jsonService, elecconfigService, $rootScope, $location,
				 $routeParams, Upload, settings,$timeout,csvService, $interval,modalService, jwtService) {

			var vm = this;
			vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
			vm.appendUrl = settings.dowloadUrl;
			var url = window.location.href;
			var eid = url.substring(url.lastIndexOf('/') + 1);
			$scope.elecid = eid;

			vm.saveDisabled = false;
			vm.uploadDisabled = false;
			vm.uploadDivHide = false;

			vm.electionconfig = {};

			vm.listOfStations = [];
			
			vm.curPage = 1;
			vm.pageSize = 10;

			vm.latitude = null;
			vm.longitude = null;

			vm.geocoder = new google.maps.Geocoder();
			vm.selectCheckBox="0";

			vm.checkCheckBox = function () {
				console.log("Clicked!!!!");
				//var notSelected = $filter('filter')( { iscompleted: "0" })

				if (vm.selectCheckBox==1) {
					vm.selectCheckBox="1";
				}
				else {
					//vm.selectCheckBox = "0";
				}
			}

			$scope.add = function(a,b){
				return parseInt(a)+parseInt(b);
			}

			vm.getStations = function () {
				if (eid>0){
					elecconfigService.getPollingstationsByElectionId(eid,function (response) {
						//vm.listOfStations = response.result.entry;

						var resp = response;

						if(jsonService.whatIsIt(resp)=="Object"){
							vm.listOfStations[0] = resp;
						}
						else if(jsonService.whatIsIt(resp)=="Array"){
							vm.listOfStations = resp;
						}
					})
				}
			}

			vm.getStations();

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
							/*vm.latitude = null;
							vm.longitude = null;
							alert("vm.latitude:"+vm.latitude+", vm.longitude:" + vm.longitude);
							console.debug("1111111");
							console.debug(electionconfig.counting_center_address);
							console.debug(vm.latitude);
							console.debug(vm.longitude);*/
							$rootScope.cui_blocker();
							toaster.pop("error","Geocode was not successful, Enter a Valid Address for counting center","");
						}
					});

				}else $rootScope.cui_blocker();
			}

			vm.validate = function(electionconf){
				console.log(electionconf);
				if ((electionconf.ename==undefined) || (electionconf.ename=='')) { 
					toaster.pop("error","Fill the Election Name!","");
					return false; }
				if ((electionconf.edate==undefined) || (electionconf.edate==''))  { 
					toaster.pop("error","Fill the Election Date!","");
					return false; }
				if ((electionconf.starttime==undefined) || (electionconf.starttime=='')) { 
					toaster.pop("error","Fill the Election Start Time!","");
					return false; }
				if ((electionconf.endtime==undefined) || (electionconf.endtime=='')) { 
					toaster.pop("error","Fill the Election End Time!","");
					return false; }
				if (electionconf.endtime<=electionconf.starttime) { 
					toaster.pop("error","Election End Time should larger than Election Start Time!","");
					return false; }
				if ((electionconf.counting_center_name==undefined) || (electionconf.counting_center_name=='')) { 
					toaster.pop("error","Fill the Counting Center Name!","");
					return false; }
				if ((electionconf.counting_center_address==undefined) || (electionconf.counting_center_address=='')) { 
					toaster.pop("error","Fill the Counting Center Address!","");
					return false; }
				return true;
			};

			vm.cancel = function () { 
				$location.search('id', null); 
				var url = window.location.href;
				var lasturl = url.split('/editstation')[0].split('#')[1];
				$location.path(lasturl);
			}
			vm.backtoelist = function () {
				$location.path('/electionconfiguration');
			}

			vm.fileupload = function(file){
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
							toaster.pop("Success","File Successfully Uploaded!","file is being processed");
							$rootScope.cui_blocker();
							
							//putting -1 to identify the 2 file
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
			
			vm.updateStation = function(currentStation){
				var url = window.location.href;
				var electionid = url.split('/editstation')[0].split('stationlist/')[1];
				$rootScope.cui_blocker(true);
				elecconfigService.updateStation(electionid,currentStation,function (response) {
					$rootScope.cui_blocker();
					vm.cancel();
				});
			};
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
			vm.loadStation=function(){
				var stationId=$location.search().id;
				if(typeof stationId === 'undefined'){
					// this is not the edit screen
				}else{
					$rootScope.cui_blocker(true);
					elecconfigService.getPollingstationsByStationId(stationId,function (response) {
						$rootScope.cui_blocker();
						if(response.response=="success"){
							vm.currentStation = response;

						}else if(response.response=="unauthorized"){
							toaster.pop("error","Station unauthorized","");
						}else{
							toaster.pop("error",response.response,"");
						}

					})
				};
			}
			vm.loadStation();


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
							id: "popup_pollingstation",
							header: vm.filestatus,
							closeCaption: "Close",
							saveCaption: "Yes",
							validation:vm.valid,
							fileinfo: fileinfo,
							savehide: true,
							colorchange: vm.color,
							close: function() { modalService.close('popup_pollingstation');  }			
					};					
					modalService.load('popup_pollingstation');		
				});

			}

			vm.timermethods = function(){
				vm.getElection();
			}
			//$interval(vm.timermethods, 30000);

		}]);
