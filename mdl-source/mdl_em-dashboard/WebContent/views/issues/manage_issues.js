/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM manage issue controller
 */

'use strict';

var controllerName = 'mdl.em.controller.emmanageissue'
	angular.module('newApp').controller(controllerName,
			['$rootScope', '$scope','mdl.em.service.emissueServices', 'mdl.mobileweb.service.json',
			 'mdl.mobileweb.service.dashboard', '$routeParams', 'toaster', 'mdl.mobileweb.service.login', 
			 'Upload', '$timeout', 'settings','$location',
			 function ($rootScope, $scope, issueService, jsonService, dashboardService, $routeParams, 
					 toaster, loginService, Upload, $timeout, settings,$location) {
		
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
	//$rootScope.userfullname=response.userfullname;
	//vm.reportedBy = $rootScope.userfullname;
	
	/*$rootScope.getOrgInfo =  function() {
		var token = loginService.getAccessToken();	
		if((typeof token !== 'undefined' && token !== null && token.length>0)){
			loginService.org_info(token , function(response) {				
				$rootScope.userfullname=response.userfullname;
				//$rootScope.organization=response.organization;
			});	
		}            	
    };*/

	vm.oneIssueDetails = [];
	
	vm.chatmessage = "";
	
	vm.issueStausFilter = "";
	vm.issuePollingStationID = "";
	
	vm.getIssueByID = function (id) {
		issueService.getIssueByID(function (response) {
			vm.resolvedIssue = response.result.entry;
			//console.log(vm.resolvedIssue);
			vm.issueStausFilter = vm.resolvedIssue.issuestatus;
			vm.issuePollingStationID = vm.resolvedIssue.stationid;
			
			if(vm.resolvedIssue.issuestatus=="1") {
        		vm.buttonHide = true;
        		vm.disableField = true;
        		vm.addChatResolveShow = false;
				vm.addChatCloseShow = false;
        	} else {
				if(vm.resolvedIssue.issuestatus == "2") {
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
        	vm.issueList = response.result.entry;

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
  			var resp = response.result.entry;
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
	
	/*vm.getAllUsers = function (){
		issueService.getAllUsers(function (response){
			vm.user = response.result.entry;
	    })
	}*/
	
	//vm.getAllUsers();
	
	/*vm.getAllUsersByIssueId = function (issueid){
		issueService.getAllUsersByIssueId(issueid,function (response){
			vm.user = response.result.entry;
	    })
	}
	
	vm.getAllUsersByIssueId(vm.issueID);*/
	
	vm.getAssignableUsers = function (){
		issueService.getAssignableUsers(vm.issueID,function (response){
			vm.user = response;
	    })
	}
	
	vm.getAssignableUsers();
	
	
	vm.updateIssue = function (issueId) {
		//if (vm.resolvedIssue.issuestatus != "0") {
			if (vm.resolvedIssue.userid == 0) {
	            toaster.pop("error","Please Assign a User to the Issue!","");
	        } 
			else if(vm.resolvedIssue.resolutiondescription == ""){
	        	toaster.pop("error","Fill the comment!","");
	        }
	        else {
	        	
	        	issueService.updateIssue(issueId, vm.resolvedIssue, function (response) {
	        		var res = response.result.entry;
	        		
	        		if(response.result.entry.response=="success"){
	        			
	        			issueService.assignIssue(issueId, vm.resolvedIssue, function (response) {
	        				if(response.response=="Success"){
	        					toaster.pop("success","Issue Updated Successfully!","");
	    	                	
	    	                	if(vm.resolvedIssue.issuestatus=="1") {
	    	                		vm.buttonHide = true;
	    	                	}
	        				} else {
	        					toaster.pop("error","Error Submitting the issue!","Please try again");
	        				}
	        			});
	        			
	                }
	                else{
	                	toaster.pop("error","Error Submitting the issue!","Please try again");
	                }
	            });


	        }
		/*} 
		else {
			//vm.resolvedIssue.userid == '0';
			
			if(vm.resolvedIssue.resolutiondescription == ""){
	        	toaster.pop("error","Fill the comment!","");
	        }
	        else {
	        	console.debug("***");
	        	console.debug(vm.resolvedIssue.userid);
		       	console.debug(vm.resolvedIssue.issuestatus);
		       	console.debug(vm.resolvedIssue.priority);
		       	console.debug(vm.resolvedIssue.resolutiondescription);
	        	issueService.updateIssue(issueId, vm.resolvedIssue, function (response) {
	        		//vm.postResult = response.result.entry;
	        		var res = response.result.entry;
	        		
	        		if(response.result.entry.response=="success"){
	                	toaster.pop("success","Issue Updated Successfully!","");
	                	
	                	if(vm.resolvedIssue.issuestatus=="1") {
	                		vm.buttonHide = true;
	                	}
	                	//vm.buttonHide = true;
	                	//$location.path('/');
	                }
	                else{
	                	toaster.pop("error","Error Submitting the issue!","Please try again");
	                }
	            });


	        }
		}*/
        
    };
    
    /*vm.resolveIssue = function (issueId) {
    	//toaster.pop("success","Are you sure do you want to resolve issue?","");
		if(vm.resolvedIssue.comment == ''){
        	toaster.pop("error","Fill the comment!","");
        }
        else {
        	//console.debug("***");
        	//console.debug(vm.resolvedIssue.userid);
        	//console.debug(vm.resolvedIssue.status);
        	//console.debug(vm.resolvedIssue.priority);
        	//console.debug(vm.resolvedIssue.comment);
        	vm.buttonDis = true;
        	issueService.resolveIssue(issueId, vm.resolvedIssue.comment, function (response) {
        		//vm.postResult = response.result.entry;
        		var res = response.result.entry;
        		
        		if(response.result.entry.response=="success"){
                	toaster.pop("success","Resolved Issue!","");
                	//$location.path('/');
                }
                else{
                	toaster.pop("error","Error Submitting the issue!","Please try again");
                }
            });


        }
    };*/
    
    $scope.uploadPic = function(file, issueid, pollingstationid, chatmessage) {
		if(vm.validate(chatmessage)){
			if(file==null) file = 'null';
			vm.buttonAddChatHide = true;	
			try {
				//blockUI.start();

				$rootScope.cui_blocker(true);//UI blocker started
				var token = loginService.getAccessToken();	
//				var stid=stationId;
//				if (stationId==null || stationId=="") stid="-1";
				vm.issueidupload = issueid;
				vm.pollingstationidupload = pollingstationid;
				vm.chatmessageupload = chatmessage;
				console.log("vm.mdljaxrsApiBaseUrl");
				console.log(vm.mdljaxrsApiBaseUrl + 'chatservices/createchat?issueid='+ vm.issueidupload + '&pollingstationid='+ vm.pollingstationidupload + '&token=' + token + '&chatmessage=' + vm.chatmessageupload);
				file.upload = Upload.upload({
					url: vm.mdljaxrsApiBaseUrl + 'chatservices/createchat?issueid='+ vm.issueidupload + '&pollingstationid='+ vm.pollingstationidupload + '&token=' + token + '&chatmessage=' + vm.chatmessageupload,
					data: {file: file},
				});
				file.upload.then(function (response) {
					//blockUI.stop();
					toaster.pop("Success","File Successfully Uploaded!","Chat Sent Successfully.");
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
						toaster.pop("error","Type a message!","");
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
						toaster.pop("error","Type a message!","");
					} else {
						toaster.pop("info","File Uploading!","Please Wait..");
					}

				}

			}		
		}

	}
	vm.validate = function(chatmessage){
		if ((chatmessage == "") || (chatmessage == undefined)) {
			toaster.pop("error","Type a message!!!","");
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
			
			
			var res2 = response.result;
			
			if (jsonService.whatIsIt(res2.entry)=="Object") {
				vm.chatShow = true;
				vm.getChatResult = res2;
				vm.relevantStatus = response.result.entry.issuestatus;
				
				
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
			} else if(jsonService.whatIsIt(res2.entry)=="Array"){
				vm.chatShow = true;
				vm.getChatResult = res2.entry;
				vm.relevantStatus = response.result.entry[0].issuestatus;

				
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
			}
			
			/*var res = response.result.entry;
			if(jsonService.whatIsIt(res)=="Object"){
				vm.chatShow = true;
				vm.getChatResult[0] = res;
				vm.relevantStatus = response.result.entry[0].issuestatus;
				console.debug("###");
				console.debug(vm.relevantStatus);
				
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
			} else if(jsonService.whatIsIt(res)=="Array"){
				vm.chatShow = true;
				vm.getChatResult = res;
				vm.relevantStatus = response.result.entry[0].issuestatus;
				console.debug("###");
				console.debug(vm.relevantStatus);
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
			}*/ else{
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
			toaster.pop("error","Type a message!","");
		} else {
			issueService.closeIssue(issueid, vm.chatmessage, function (response) {
	    		var res = response.result.entry;
	    		
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
	
	vm.resolveDisabled  = false;
	vm.resolveIssue = function (issueid){
		
		
		if(vm.chatmessage == "") {
			toaster.pop("error","Type a message!","");
		} else {
			issueService.resolveIssue(issueid, vm.chatmessage, function (response) {
	    		var res = response.result.entry;
	    		
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
	
	/*vm.getIssueByID = function (id) {
		issueService.getIssueByID(function (response) {
			vm.resolvedIssue = response.result.entry;
			
			if(vm.resolvedIssue.issuestatus == "1") {
				vm.addChatResolveShow = false;
				vm.addChatCloseShow = false;
			} else {
				if(vm.resolvedIssue.issuestatus == "2") {
					vm.addChatCloseShow = false;
					vm.addChatResolveShow = true;
				} else {
					vm.addChatCloseShow = true;
					vm.addChatResolveShow = true;
				}
			}
		},id)
	};*/
	
	vm.returnAttachementURL = "";
	vm.attachementWindowOpen = function(attachtment_url) {
		vm.returnAttachementURL = vm.appendUrl + "/" + attachtment_url;
		console.debug("1111111");
		console.debug(vm.returnAttachementURL);
		window.open(vm.returnAttachementURL,'jbnWindow','width=600,height=400');
	}
				
}]);