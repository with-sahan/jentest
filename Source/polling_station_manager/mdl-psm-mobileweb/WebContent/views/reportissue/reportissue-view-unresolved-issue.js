/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: View unresolved issues controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.viewunresolvedissue'
	angular.module('newApp').controller(controllerName,
			['$http', 'mdl.mobileweb.service.jwt', '$rootScope', '$scope', '$location','mdl.mobileweb.service.reportIssue', 'mdl.mobileweb.service.dashboard', 'toaster', 'settings',
			 'mdl.mobileweb.service.json','modalService', 'mdl.mobileweb.service.login', 'Upload', '$timeout',
			 function ($http, jwtService, $rootScope, $scope, $location,reportIssueService, dashboardService, toaster, settings, jsonService, modalService, loginService, Upload, $timeout) {
				$rootScope.loginactive = false;

				var vm = this;
				//alert(sessionStorage.issue_id);
				vm.buttonDis = false;
				vm.org_state={};
				//angular.copy(vm.issue, vm.org_state);

				vm.appendUrl = settings.dowloadUrl;
				vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
				vm.givenDescription = [];
				vm.pollingStationList = [];
				vm.getChatResult = [];

				vm.passedPriorityTitle = "";
				vm.passedStatusTitle = "";

				vm.issue = [];

				vm.curPage = 1;
				vm.pageSize = 10;

				vm.chatmessage = "";

				vm.viewChatc = 9102;
				//alert("ommmhkk");

				vm.passingIndex = 0;
				//vm.viewChat = "0";
				vm.checkChatCondition = "0";
				vm.radioButtonChecked = false;

				vm.divHide = false;
				vm.viewChat = [];

				vm.showChat = function(id, stationId, status) {
					vm.getChat(id, stationId, status);
					vm.addChat(true);
					angular.forEach(vm.issue, function (value, key) {
						if(value.id==id){
							vm.viewChat[id]="1";
						}
						else{
							vm.viewChat[id]="0";
						}

					});
				}


				vm.addChatResolveShow = false;
				vm.stationcheck = function(stationid) {

					vm.stationid=stationid;
					vm.viewChat[sessionStorage.issue_id] = false;
					vm.viewChat[sessionStorage.issue_id_assignment] = false;
					if (vm.checkChatCondition == true) {
						vm.viewChat[sessionStorage.issue_id]=true;

						vm.chat_alert_issuestatus = sessionStorage.issue_status;
						vm.getIssueListData(stationid);


						vm.addChatShow = false;
						vm.addChat = function(action) {
							if(action){
								vm.addChatShow = true;
							}
							else{
								vm.addChatShow = false;
							}

						};

						reportIssueService.getChat(sessionStorage.issue_id, function (response) {
							var res = response;
							vm.radioButtonChecked = true;
							if(jsonService.whatIsIt(res)=="Object"){
								vm.chatShow = true;
								vm.getChatResult[0] = res;

								vm.addChat(true);

								if(vm.chat_alert_issuestatus == 1) {
									vm.addChatCloseShow = false;
									vm.addChatResolveShow = false;
								} else if(vm.chat_alert_issuestatus == 2) {
									vm.addChatCloseShow = false;
									vm.addChatResolveShow = true;
								} else {
									vm.addChatCloseShow = true;
									vm.addChatResolveShow = true;
								}
							} else if(jsonService.whatIsIt(res)=="Array"){
								vm.chatShow = true;
								vm.getChatResult = res;

								vm.addChat(true);

								if(vm.chat_alert_issuestatus == 1) {
									vm.addChatCloseShow = false;
									vm.addChatResolveShow = false;
								} else if(vm.chat_alert_issuestatus == 2) {
									vm.addChatCloseShow = false;
									vm.addChatResolveShow = true;
								} else {
									vm.addChatCloseShow = true;
									vm.addChatResolveShow = true;
								}
							} else{
								vm.chatShow = false;

								vm.addChat(false);

								if(vm.chat_alert_issuestatus == 1) {
									vm.addChatCloseShow = false;
									vm.addChatResolveShow = false;
								} else if(vm.chat_alert_issuestatus == 2) {
									vm.addChatCloseShow = false;
									vm.addChatResolveShow = true;
								} else {
									vm.addChatCloseShow = true;
									vm.addChatResolveShow = true;
								}
							}
						});

						vm.issue = []
						vm.getChatResult=[];
						vm.addChat(false);
						vm.addChatCloseShow = false;
						vm.addChatResolveShow = false;
						//vm.viewChat = "0";
						vm.checkChatCondition = "0";
						vm.checkChatCondition_assign = false;
					} else if (vm.checkChatCondition_assign == true) {
						vm.viewChat[sessionStorage.issue_id_assignment] = true;
						vm.issue = [];
						vm.getIssueListData(stationid);
						vm.getChatResult=[];
						vm.addChat(false);
						vm.addChatCloseShow = false;
						vm.addChatResolveShow = false;
						vm.checkChatCondition = false;
						vm.checkChatCondition_assign = false;
					} else {
						//alert("else");
						vm.issue = [];
						vm.getIssueListData(stationid);
						vm.getChatResult=[];
						vm.addChat(false);
						vm.addChatCloseShow = false;
						vm.addChatResolveShow = false;
					}

					sessionStorage.issue_id="";
					sessionStorage.pollingstation_id="";
					sessionStorage.issue_status="";

					sessionStorage.issue_id_assignment = "";
		    		sessionStorage.pollingstation_id_assignment = "";
		    		//vm.passingIndex = 0;

				}

				$scope.uploadPic = function(file, issueid, pollingstationid, chatmessage) {
//					var fileInput = $('.upload-file');
//					var maxSize = fileInput.data('max-size');

//					if(fileInput.get(0).files.length){
//					var fileSize = fileInput.get(0).files[0].size; // in bytes
//					if(fileSize>maxSize){
//					toaster.pop("Success","file size is more than " + maxSize/(1024*1024) + " MB","");
//					return false;
//					}else{
//					}
//					}else{
//					}

					if(vm.validate(chatmessage)){
						if(file==null)
							file = 'null';
						vm.buttonHide = true;
						try {
							//blockUI.start();

							$rootScope.cui_blocker(true);//UI blocker started

//							var stid=stationId;
//							if (stationId==null || stationId=="") stid="-1";
							vm.issueidupload = issueid;
							vm.pollingstationidupload = pollingstationid;
							vm.chatmessageupload = chatmessage;

							if (file != 'null') {
								file.upload = Upload.upload({
									url: vm.mdljaxrsApiBaseUrl + 'chat/createchat?issueid='+ vm.issueidupload + '&pollingstationid='+ vm.pollingstationidupload + '&chatmessage=' + vm.chatmessageupload,
								  data: {file: file},
								});

								file.upload.then(function (response) {
									vm.picFile = '';
									vm.picFile = null;

									//blockUI.stop();
									toaster.pop("Success","File Uploaded Successfully","Chat Sent Successfully");
									$rootScope.cui_blocker();
									$timeout(function () {
										file.result = response.data;
									});
									//$location.path('/reportissue');
	//								location.reload();
									vm.getChat(issueid, pollingstationid, vm.status);
									vm.buttonHide = false;
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
						}
						else {
							Upload.upload({
								url: vm.mdljaxrsApiBaseUrl + 'chat/createchat?issueid='+ vm.issueidupload + '&pollingstationid='+ vm.pollingstationidupload + '&chatmessage=' + vm.chatmessageupload,
								data: {file: file},
							});
						}

						}finally{
							if (file == 'null'){
								if (vm.chatmessageupload == "") {
									toaster.pop("error","Please Type a message","");
								} else {
									$rootScope.cui_blocker();
									toaster.pop("Success","Chat Sent Successfully","");
									//$location.path('/reportissue');
									vm.getChat(issueid, pollingstationid, vm.status);
									vm.buttonHide = false;
//									location.reload();
								}

							}
							else {
								if (vm.chatmessageupload == "") {
									toaster.pop("error","Please Type a message","");
								} else {
									toaster.pop("info","File Uploading","Please Wait..");
								}

							}
							vm.getChatRefresh(issueid);
						}
					}

				}
				vm.validate = function(chatmessage){
					if ((chatmessage == "") || (chatmessage == undefined)) {
						toaster.pop("error","Please Type a message","");
						return false;
					}
					//alert(chatmessage);
					return true;
				}

				vm.getStationList = function () {
					dashboardService.getPollingStations(function (response) {
						var res = response;
						if(jsonService.whatIsIt(res)=="Object"){
							if(sessionStorage.issue_id>0 && sessionStorage.pollingstation_id>0 && sessionStorage.issue_status>=0) {
								vm.pollingStationList[0] = res;
								vm.passingIndex = 0;
								vm.viewChat[sessionStorage.issue_id] = true;
								vm.checkChatCondition = vm.viewChat[sessionStorage.issue_id];
								vm.stationcheck(sessionStorage.pollingstation_id);
							} else if(sessionStorage.issue_id_assignment>0 && sessionStorage.pollingstation_id_assignment>0) {
								vm.pollingStationList[0] = res;
								vm.passingIndex = 0;
								vm.viewChat[sessionStorage.issue_id_assignment] = true;
								vm.checkChatCondition_assign = vm.viewChat[sessionStorage.issue_id_assignment];
								vm.stationcheck(sessionStorage.pollingstation_id_assignment);
							} else {
								vm.pollingStationList[0] = res;
								vm.getIssueListData(vm.pollingStationList[0].id);
							}

						}
						else if(jsonService.whatIsIt(res)=="Array"){
							if(sessionStorage.issue_id>0 && sessionStorage.pollingstation_id>0 && sessionStorage.issue_status>=0) {
								//alert(sessionStorage.pollingstation_id);
								vm.pollingStationList = res;

								for (var i=0;i<vm.pollingStationList.length; i++) {
									if (vm.pollingStationList[i].id == sessionStorage.pollingstation_id) {
										vm.passingIndex = i;
									}
								}
								//alert(vm.passingIndex);
								vm.viewChat[sessionStorage.issue_id] = true;
								vm.checkChatCondition = vm.viewChat[sessionStorage.issue_id];
								vm.stationcheck(sessionStorage.pollingstation_id);
							} else if(sessionStorage.issue_id_assignment>0 && sessionStorage.pollingstation_id_assignment>0) {
								vm.pollingStationList = res;
								//alert(sessionStorage.issue_id_assignment);
								for (var i=0;i<vm.pollingStationList.length; i++) {
									if (vm.pollingStationList[i].id == sessionStorage.pollingstation_id_assignment) {
										vm.passingIndex = i;
									}
								}
								vm.viewChat[sessionStorage.issue_id_assignment] = true;
								vm.checkChatCondition_assign = vm.viewChat[sessionStorage.issue_id_assignment];
								vm.stationcheck(sessionStorage.pollingstation_id_assignment);
							} else {
								vm.pollingStationList = res;
								vm.getIssueListData(vm.pollingStationList[0].id);
							}

						}

						if (vm.pollingStationList[0]) {
		                	vm.stationcheck(vm.pollingStationList[0].id);
		            	}
		            	vm.selectedStation=vm.stationid;

					})
				}
				vm.getStationList();

				vm.getIssueListData = function (stationid) {
					reportIssueService.getIssueListData_V2(stationid, function (response) {
						//vm.issue = response.result.entry;
						vm.issue = [];
						var res = response;
						if(jsonService.whatIsIt(res)=="Object"){
							vm.issue[0] = res;
						}
						else if(jsonService.whatIsIt(res)=="Array"){
							vm.issue = res;
						}

					})

					vm.numberOfPages = function() {
						return Math.ceil(vm.issue.length / vm.pageSize);
					};
				};

				//vm.getIssueListData();

				vm.priority = [
				               { ID: '1', PriorityTitle: 'Low' },
				               { ID: '2', PriorityTitle: 'Medium' },
				               { ID: '3', PriorityTitle: 'High' },
				               ];

				vm.priorityTitle = function(priorityID) {
					if (priorityID == "1") {
						vm.passedPriorityTitle = "Low";
					} else if (priorityID == "2") {
						vm.passedPriorityTitle = "Medium";
					} else {
						vm.passedPriorityTitle = "High";
					}
					return vm.passedPriorityTitle;
				};

				vm.status = [
				             { id: '0', statusName: 'Open' },
				             { id: '1', statusName: 'Resolved' },
				             { id: '2', statusName: 'Closed' },
				             { id: '3', statusName: 'In Progress' },
				             { id: '4', statusName: 'Escalate' },
				             ];

				vm.statusTitle = function(statusID) {
					if (statusID == "0") {
						vm.passedStatusTitle = "Open";
					} else if (statusID == "1") {
						vm.passedStatusTitle = "Resolved";
					} else if (statusID == "2") {
						vm.passedStatusTitle = "Closed";
					} else if (statusID == "3") {
						vm.passedStatusTitle = "In Progress";
					} else {
						vm.passedStatusTitle = "Escalate";
					}
					return vm.passedStatusTitle;
				};

				vm.stationID = function(stationid, pollingStationID) {
					if (statusID == pollingStationID) {
						vm.passedStatusTitle = "Open";
					}
				};

				vm.addChatShow = false;
				vm.addChat = function(action) {
					if(action){
						vm.addChatShow = true;
					}
					else{
						vm.addChatShow = false;
					}

				};

				vm.chatShow = false;
				vm.addChatCloseShow = false;

				vm.getChat = function(issueid, pollingStationID, issuestatus) {
					vm.getChatResult = [];
					/*if (pollingStationID == vm.pollingStationList.id) {

		}*/
					vm.issueid = issueid;
					vm.status = issuestatus;
					//alert(issuestatus);
					vm.station = pollingStationID;

					vm.chatmessage = "";

					//var chatIconID = document.getElementById('chat-button');


					reportIssueService.getChat(issueid, function (response) {
						var res = response;
						vm.closeDisabled = false;
						if(jsonService.whatIsIt(res)=="Object"){
							vm.chatShow = true;
							vm.getChatResult[0] = res;

							//chatIconID.className -= ' ' + 'btn-white';
							//chatIconID.className += ' ' + 'btn-default';
							if(issuestatus == "1") {
								vm.addChatCloseShow = false;
								vm.addChatResolveShow = false;
							} else if(issuestatus == "2") {
								vm.addChatCloseShow = false;
								vm.addChatResolveShow = true;
							} else {
								vm.addChatCloseShow = true;
								vm.addChatResolveShow = true;
							}
						} else if(jsonService.whatIsIt(res)=="Array"){
							vm.chatShow = true;
							vm.getChatResult = res;

							if(issuestatus == "1") {
								vm.addChatCloseShow = false;
								vm.addChatResolveShow = false;
							} else if(issuestatus == "2") {
								vm.addChatCloseShow = false;
								vm.addChatResolveShow = true;
							} else {
								vm.addChatCloseShow = true;
								vm.addChatResolveShow = true;
							}
						} else{
							vm.chatShow = false;
							//chatIconID.className -= ' ' + 'btn-white';
							//chatIconID.className += ' ' + 'btn-default';
							if(issuestatus == "1") {
								vm.addChatCloseShow = false;
								vm.addChatResolveShow = false;
							} else if(issuestatus == "2") {
								vm.addChatCloseShow = false;
								vm.addChatResolveShow = true;
							} else {
								vm.addChatCloseShow = true;
								vm.addChatResolveShow = true;
							}
						}
					});
				};


				vm.getChatRefresh = function(issueid){
					vm.chatShow = true;
					reportIssueService.getChat(issueid, function (response) {
						var res = response;
						vm.getChatResult = res;
					});
				}

				vm.addChatScreen = false;
				/*vm.addChatMessage = function(action) {
		if(action){
			vm.addChatScreen = true;
		}
		else{
			vm.addChatScreen = false;
		}

	};*/

				vm.cancelChatMessage = function(){
					vm.chatmessage = "";
				};

				vm.closeDisabled = false;
				vm.closeIssue = function (issueid){

					if(vm.chatmessage == "") {
						toaster.pop("error","Please Type a message","");
					} else {
						reportIssueService.closeIssue(issueid, vm.chatmessage, function (response) {
							var res = response;

							if(res.response=="success"){
								//location.reload();
								toaster.pop("success","Issue Closed","");
								vm.closeDisabled = true;
								vm.chatmessage = "";
							}
							else{
								toaster.pop("error","Error Submitting the issue!","Please try again");
							}
						});
					}

				}

				vm.resolveDisabled  = false;
				vm.resolveIssue = function (issueid){
					if(vm.chatmessage == "") {
						toaster.pop("error","Please Type a message","");
					} else {
						reportIssueService.resolveIssue(issueid, vm.chatmessage, function (response) {
							var res = response;

							if(res.response=="success"){
								//location.reload();
								toaster.pop("success","Issue Resolved!","");
								vm.resolveDisabled = true;
								vm.closeDisabled = true;
								vm.chatmessage = "";
							}
							else{
								toaster.pop("error","Error Submitting the issue!","Please try again");
							}
						});
					}

				}

				vm.returnAttachementURL = "";
				vm.attachementWindowOpen = function(attachtment_url) {
					var config = {
          	headers:  {
            	'Authorization': "Bearer " + jwtService.getToken()
            }
          };
					$http({
						method: 'GET',
						url: vm.appendUrl + attachtment_url,
						params: config,
						responseType: 'arraybuffer'
					}).success(function (data, status, headers) {
						headers = headers();								 				
						var contentDispositionHeader = headers['content-disposition'];
						var filename = contentDispositionHeader.split(';')[1].trim().split('=')[1];
						var ext = filename.substr(filename.lastIndexOf('.') + 1);
						var linkElement = document.createElement('a');
						try {
							if (ext == "jpg" || ext == "png" || ext == "jpeg" || ext == "gif" || ext == "bmp" || ext == "tiff") {								  
								var blob = new Blob([data],{type:'image/png'});
								window.open(window.URL.createObjectURL(blob),'_blank','width=600,height=400');
							} else {
								var blob = new Blob([data]);
								var url = window.URL.createObjectURL(blob);
								linkElement.setAttribute('href', url);
								linkElement.setAttribute("download", filename);
									 
								var clickEvent = new MouseEvent("click", {
									"view": window,
									"bubbles": true,
									"cancelable": false
								});
								linkElement.dispatchEvent(clickEvent);
							}									            
						} catch (ex) {
							console.log(ex);
						}
						}).error(function (data) {
							console.log(data);
    				});
          };
			}])
			.filter('pagination', function() {
				return function(input, start)
				{
					start = +start;
					return input.slice(start);
				};
			})
		.directive('capplyicheck', function ($timeout, $parse) {
		    return {
		        require: 'ngModel',
		        link: function ($scope, element, $attrs, ngModel) {
		            return $timeout(function () {
		                var value;
		                value = $attrs['value'];

		                $scope.$watch($attrs['ngModel'], function (newValue) {
		                    $(element).iCheck('update');
		                })

		                return $(element).iCheck({
		                    checkboxClass: 'iradio_square-green',
		                    radioClass: 'iradio_flat-aero'

		                }).on('ifChanged', function (event) {
		                    if ($(element).attr('type') === 'checkbox' && $attrs['ngModel']) {
		                        $scope.$apply(function () {
		                            return ngModel.$setViewValue(event.target.checked);
		                        });
		                    }
		                    if ($(element).attr('type') === 'radio' && $attrs['ngModel']) {
		                        return $scope.$apply(function () {
		                            return ngModel.$setViewValue(value);
		                        });
		                    }
		                });
		            });
		        }
		    };
		});
