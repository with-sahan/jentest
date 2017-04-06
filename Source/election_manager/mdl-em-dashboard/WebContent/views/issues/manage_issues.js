/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM manage issue controller
 */

'use strict';

var controllerName = 'mdl.em.controller.emmanageissue'
	angular.module('newApp').controller(controllerName,
			['$http', '$rootScope', '$scope','mdl.em.service.emissueServices', 'mdl.mobileweb.service.json',
			 'mdl.mobileweb.service.dashboard', '$routeParams', 'toaster', 'mdl.mobileweb.service.login',
			 'Upload', '$timeout', 'settings','$location','mdl.mobileweb.service.jwt',
			 function ($http, $rootScope, $scope, issueService, jsonService, dashboardService, $routeParams,
					 toaster, loginService, Upload, $timeout, settings,$location, jwtService) {

	var vm = this;

	vm.resolvedIssue = {}
	vm.resolvedIssue.userid = "";
	vm.resolvedIssue.issuestatus = "";
	vm.resolvedIssue.priority = "";
	vm.resolvedIssue.comment = "";

	vm.buttonHide = false;
	vm.disableField = false;
	vm.buttonAddChatHide = false;

	vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	vm.appendUrl = settings.dowloadUrl;

	vm.oneIssueDetails = [];

	vm.chatmessage = "";

	vm.issueStausFilter = "";
	vm.issuePollingStationID = "";

	vm.getIssueByID = function (id) {
		issueService.getIssueByID(function (response) {
			vm.resolvedIssue = response;
			vm.issueStausFilter = vm.resolvedIssue.issuestatus;
			vm.issuePollingStationID = vm.resolvedIssue.stationid;

			if(vm.resolvedIssue.issuestatus=="1") {
        		vm.buttonHide = true;
        		vm.disableField = true;
        		vm.addChatResolveShow = false;
				vm.addChatCloseShow = false;
        	} else {
				if(vm.resolvedIssue.issuestatus == "2") {
					vm.closeDisabled = true;
					vm.addChatCloseShow = false;
					vm.addChatResolveShow = true;
				} else {
					vm.addChatCloseShow = true;
					vm.addChatResolveShow = true;
				}
			}
		},id)
	};

	vm.issueID = $routeParams.id;
	vm.getIssueByID(vm.issueID);

	vm.getIssueList = function () {
        issueService.getIssues(function (response) {
        	vm.issueList = response;

        })
    }

    vm.getIssueList();

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
  			//vm.buttonHide = true;
  		} else if (statusID == "2") {
  			vm.passedStatusTitle = "Closed";
  		} else if (statusID == "3") {
  			vm.passedStatusTitle = "In Progress";
  		} else  {
  			vm.passedStatusTitle = "Escalate";
  		}
  		return vm.passedStatusTitle;
  	};

  	vm.getStationList = function (){
  		dashboardService.getPollingStations(function (response){
  			var resp = response;
  			if(jsonService.whatIsIt(resp)=="Object"){
  				vm.pollingStationList[0] = resp;
  			}
  			else if(jsonService.whatIsIt(resp)=="Array"){
  				vm.pollingStationList = resp;
  			}
  	    })
  	}
  	vm.getStationList();

  	vm.user = {};
	vm.user.response = "";
	vm.user.id = "";
	vm.user.username = "";
	vm.user.email = "";
	vm.user.lastname = "";
	vm.user.firstname = "";
	vm.user.fullname = "";

	vm.userDetails = [];

	vm.getAssignableUsers = function (){
		issueService.getAssignableUsers(vm.issueID,function (response){
			vm.user = response;
	    })
	}

	vm.getAssignableUsers();


	vm.updateIssue = function (issueId) {
		if(vm.validateSave()){
	    	issueService.updateIssue(issueId, vm.resolvedIssue, function (response) {
	    		if(response.response ==="success"){
	    			if (vm.resolvedIssue.userid == 0) {
	    				toaster.pop("success","Issue Updated Successfully!","");
	    			} else {
	    				issueService.assignIssue(issueId, vm.resolvedIssue, function (response) {
	        				if(response.response=="success"){
	        					toaster.pop("success","Issue Updated Successfully!!!!","");

	    	                	if(vm.resolvedIssue.issuestatus=="1") {
	    	                		vm.buttonHide = true;
	    	                	}
	        				} else {
	        					toaster.pop("error","Error Submitting the issue!","Please try again");
	        				}
	        			});
	    			}
	            }
	            else{
	            	toaster.pop("error","Error Submitting the issue!","Please try again");
	            }
	        });
		}
    };

    $scope.uploadPic = function(file, issueid, pollingstationid, chatmessage) {
		if(vm.validate(chatmessage)){
			if(file==null) file = 'null';
			vm.buttonAddChatHide = true;
			try {
				//blockUI.start();

				$rootScope.cui_blocker(true);//UI blocker started
//				var stid=stationId;
//				if (stationId==null || stationId=="") stid="-1";
				vm.issueidupload = issueid;
				vm.pollingstationidupload = pollingstationid;
				vm.chatmessageupload = chatmessage;
				file.upload = Upload.upload({
					url: vm.mdljaxrsApiBaseUrl + 'chat/createchat?issueid='+ vm.issueidupload + '&pollingstationid='+ vm.pollingstationidupload + '&chatmessage=' + vm.chatmessageupload,
					data: {file: file},
				});
				file.upload.then(function (response) {
					//blockUI.stop();
					toaster.pop("Success","File Uploaded Successfully","Chat sent successfully");
					$rootScope.cui_blocker();
					$timeout(function () {
						file.result = response.data;
					});
					//$location.path('/all_issues');
//					location.reload();
					vm.getChat(issueid);
					vm.buttonAddChatHide = false;
					vm.chatmessage = "";
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
				if (file == 'null'){
					if (vm.chatmessageupload == "") {
						toaster.pop("error","Please Type a message","");
					} else {
						$rootScope.cui_blocker();
						toaster.pop("Success","Chat Sent Successfully!","");
						vm.getChat(issueid);
						vm.buttonAddChatHide = false;
						vm.chatmessage = "";
						//$location.path('/all_issues');
//						location.reload();
					}

				}
				else {
					if (vm.chatmessageupload == "") {
						toaster.pop("error","Please Type a message","");
					} else {
						toaster.pop("info","File Uploading","Please Wait..");
					}

				}

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


	vm.passedStatusID = "";
	vm.statusID = function(statusTitle) {
  		if (statusTitle == "Open") {
  			vm.passedStatusID = "0";
  		} else if (statusTitle == "Resolved") {
  			vm.passedStatusID = "1";
  		} else if (statusTitle == "Closed") {
  			vm.passedStatusID = "2";
  		} else if (statusTitle == "In Progress") {
  			vm.passedStatusID = "3";
  		} else {
  			vm.passedStatusID = "4";
  		}
  		return vm.passedStatusID;
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
	vm.addChatResolveShow = false;

	vm.getChat = function(issueid) {
		vm.issueid = issueid;

		issueService.getChat(issueid, function (response) {
			var res2 = response;

			if (jsonService.whatIsIt(res2)=="Object") {
				vm.chatShow = true;
				vm.getChatResult = res2;
				vm.relevantStatus = response.issuestatus;


				if(vm.relevantStatus == "1") {
					vm.addChatResolveShow = false;
					vm.addChatCloseShow = false;
				} else {
					if(vm.relevantStatus == "2") {
						vm.addChatCloseShow = false;
						vm.addChatResolveShow = true;
					} else {
						vm.addChatCloseShow = true;
						vm.addChatResolveShow = true;
					}
					//vm.addChatResolveShow = true;
					//vm.addChatCloseShow = true;
				}
			} else if(jsonService.whatIsIt(res2)=="Array"){
				vm.chatShow = true;
				vm.getChatResult = res2;
				vm.relevantStatus = response[0].issuestatus;


				if(vm.relevantStatus == "1") {
					vm.addChatResolveShow = false;
					vm.addChatCloseShow = false;
				} else {
					if(vm.relevantStatus == "2") {
						vm.addChatCloseShow = false;
						vm.addChatResolveShow = true;
					} else {
						vm.addChatCloseShow = true;
						vm.addChatResolveShow = true;
					}
					//vm.addChatResolveShow = true;
					//vm.addChatCloseShow = true;
				}
			} else{
				vm.chatShow = false;
				vm.getIssueByID(issueid);
			}
	    });
	};

	vm.getChat(vm.issueID);

	vm.cancelChatMessage = function(){
		vm.chatmessage = "";
	};

	vm.closeDisabled = false;
	vm.closeIssue = function (issueid){


		if(vm.chatmessage == "") {
			toaster.pop("error","Please Type a message","");
		} else {
			issueService.closeIssue(issueid, vm.chatmessage, function (response) {
	    		var res = response;

	    		if(res.response=="success"){
	    			//location.reload();
	            	toaster.pop("success","Issue Closed!","");
	            	vm.closeDisabled = true;
	            }
	            else{
	            	toaster.pop("error","Error Submitting the issue!","Please try again");
	            }
	        });
		}

	}

	vm.closeIssue_v2 = function (issueid){
		if(vm.validateSave()){
			issueService.closeIssue_v2(issueid, vm.resolvedIssue, function (response) {
	    		if(response.response=="success"){
	    			if (vm.resolvedIssue.userid == 0) {
	    				toaster.pop("success","Issue Closed Successfully!","");
						vm.closeDisabled = true;
	    			} else {
	    				issueService.assignIssue(issueid, vm.resolvedIssue, function (response) {
	        				if(response.response=="success"){
	        					toaster.pop("success","Issue Closed Successfully!","");
	        					vm.closeDisabled = true;

	    	                	if(vm.resolvedIssue.issuestatus=="1") {
	    	                		vm.buttonHide = true;
	    	                	}
	        				} else {
	        					toaster.pop("error","Error Submitting the issue!","Please try again");
	        				}
	        			});
	    			}
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
			issueService.resolveIssue(issueid, vm.chatmessage, function (response) {
	    		var res = response;

	    		if(res.response=="success"){
	    			//location.reload();
	            	toaster.pop("success","Issue Resolved!","");
	            	vm.resolveDisabled = true;
	            	vm.closeDisabled = true;
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
					headers: {
							'Authorization': "Bearer " + jwtService.getToken()
					}
			};
			$http({
					method: 'GET',
					url: vm.appendUrl + attachtment_url,
					params: config,
					responseType: 'arraybuffer'
			}).success(function(data, status, headers) {
					headers = headers();
					var contentDispositionHeader = headers['content-disposition'];
					var filename = contentDispositionHeader.split(';')[1].trim().split('=')[1];
					var ext = filename.substr(filename.lastIndexOf('.') + 1);
					var linkElement = document.createElement('a');
					try {
							if (ext == "jpg" || ext == "png" || ext == "jpeg" || ext == "gif" || ext == "bmp" || ext == "tiff") {
									var blob = new Blob([data], {
											type: 'image/png'
									});
									window.open(window.URL.createObjectURL(blob), '_blank', 'width=600,height=400');
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
			}).error(function(data) {
					console.log(data);
			});
	}


	vm.validateSave = function(){
		if ((vm.resolvedIssue.userid==undefined) || (vm.resolvedIssue.userid=='')) {
			toaster.pop("error","Please assign a user","");
			return false; }
		if ((vm.resolvedIssue.resolutiondescription==undefined) || (vm.resolvedIssue.resolutiondescription=='')) {
			toaster.pop("error","Fill the comment correctly","");
			return false; }
		return true;
	}
}]);
