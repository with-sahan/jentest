/***
 * Copyrights
 * Project: MDL
 * Author: Rushan Arunod
 * Module: data configuration - psa
 */

'use strict';

angular.module('newApp').controller('mdl.mobileweb.controller.datauploads',
		['$scope','toaster', 'mdl.mobileweb.service.json','$rootScope','mdl.mobileweb.service.csvfileupload','$parse','Upload','settings','$timeout',
		 function ($scope, toaster, jsonService, $rootScope, csvService, $parse, Upload, settings,$timeout) {

			var vm = this;
			vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
			$scope.csv = {
					accept: ".csv",
					content: null,
					header: true,
					headerVisible: true,
					separator: ',',
					separatorVisible: true,
					result: null,
					encoding: 'ISO-8859-1',
					encodingVisible: true,
			};

			vm.save = function(eid){
				toaster.pop("info","Please Wait!");
				$rootScope.cui_blocker(true);
				var objtlist = null;
				if($scope.csv.result!=null){
					var bodyarray = []
					angular.forEach($scope.csv.result, function(row) {
						if(row["Polling Place Name "]!=""){
							var stationdetails={};
							stationdetails.electionid = eid;
							stationdetails.address = row.Address;
							stationdetails.ballotboxnumber = row["Ballot Box Number"];
							stationdetails.constituency = row["Constituency Name "];
							stationdetails.contact = row["Contact Number"];
							stationdetails.keyholder = row["Keyholder Name "];
							stationdetails.passwords = row.Password;
							stationdetails.district = row["Poll District"];
							stationdetails.place = row["Polling Place Name "];
							stationdetails.stationname = row["Polling Station Names"];
							stationdetails.presidingofficer = row["Presiding Officer Names"];
							stationdetails.username = row["Username "];
							stationdetails.ward = row["Ward Names"];
							bodyarray.push(stationdetails);
						}
					});
					csvService.uploadPollingStations(bodyarray,function(response){
						$rootScope.cui_blocker();
						if(response.response=="success") {
							toaster.pop("success","Successfully Uploaded the file!",response.inserted +" rows inserted. "+
									response.duplicated+" rows skipped.");
						}
						else
							toaster.pop("error","Unauthorized!");
					});
				}
				else{
					toaster.pop("error","Please Choose a File First!","");
				}
			}

			vm.fileupload = function(file,eid){
				if(file==null) {toaster.pop("error","No File!","Please Choose a File.");}
				else{
					try {
						//blockUI.start();
						$rootScope.cui_blocker(true);//UI blocker started

						file.upload = Upload.upload({
							url: vm.mdljaxrsApiBaseUrl + 'csvfileservice/uploadcsv',
							data: {file: file},
						});

						file.upload.then(function (response) {
							//blockUI.stop();
							console.log(response.data.path);
							var path = response.data.path;
							toaster.pop("Success","File Successfully Uploaded!","file is being processed");
							$rootScope.cui_blocker();
							
							csvService.uploadPollingStations(path,eid,function(response){
								$rootScope.cui_blocker();
								if(response.response=="success") {
									toaster.pop("success","",response.inserted +" rows inserted. "+
											response.duplicated+" rows skipped.");
								}
								else
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
		}]);
