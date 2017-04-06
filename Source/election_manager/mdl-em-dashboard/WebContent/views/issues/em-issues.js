/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM issue controller
 * Modified by: Ashan Perera [30/01/16]
 * Modified by: Vindya Hettige [04/02/16]
 */

'use strict';

var controllerName = 'mdl.em.controller.emissue'
angular.module('newApp').controller(controllerName,
    ['$rootScope', '$scope', 'mdl.em.service.emissueServices', 'mdl.mobileweb.service.json', 
     'mdl.mobileweb.service.dashboard','mdl.em.service.geoHierarchyService','$interval','settings', 'toaster', 'mdl.mobileweb.service.login', '$location', 'Upload','$timeout',
     function ($rootScope, $scope, issueService, jsonService, dashboardService,geoHierarchyService,$interval, settings, toaster, loginService, $location, Upload,$timeout) {
    	
    $rootScope.loginactive = false;

    $rootScope.classFromController = "gen_noPadding";
    
    var vm = this;

    vm.issue = [];
    vm.timerPromise;
    vm.issueDetails = [];
    vm.passedPriorityTitle = "";
    vm.passedStatusTitle = "";
    vm.curPage = 1;
    vm.geoHierarchy=[];
    $scope.selectedHrc = "";
    vm.userId = "";
    //vm.filtered=0;
    //vm.totalItems = $scope.items.length;
    vm.pageSize = 10;
    
    vm.appendUrl = settings.dowloadUrl;
    
    vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
    
    vm.chatmessage = "";

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
    
    vm.stationIdValue = "";
    
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
  	   { id: '', statusName: 'All' },
  	   { id: '0', statusName: 'Open' },
  	   { id: '2', statusName: 'Closed' },	  
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
  	
  	vm.userId = function(asigneeName) {
  		var fullName = firstName+space+lastName;
  		return fullName;
  	};
	
	vm.getStationList = function (){
		issueService.getPollingStations_V2(function (response){
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
	
	vm.getAllUsers = function (){
		issueService.getAllUsers(function (response){
			vm.user = response;
			vm.setFullname();
	    })
	}
	vm.setFullname = function(){
		angular.forEach(vm.user,function(user,key){
			user.fullname = user.firstname + ' ' + user.lastname;
		});
	}
	vm.getAllUsers();
	
	//this is to get the geo hierarchy to the dropdown list
	vm.getGeoHierarchy=function(){
		geoHierarchyService.getGeoHierarchy(function (response) {
			vm.geoHierarchy = response;
			if (typeof vm.geoHierarchy[0] != 'undefined'){
				$scope.selectedHrc = vm.geoHierarchy[0].split('|')[1];//Default Geo place; used for loading election on page load
				vm.filterData();
			}			
			//console.log(" vm.geoHierarchy " + vm.geoHierarchy.response);

        })
	}
	
	vm.getGeoHierarchy();
	
	vm.filterData=function(){
		issueService.getIssueListDataFiltered($scope.selectedHrc,function (response) {
			if(typeof response === 'undefined'){
				vm.issue={};
			}else{
				vm.issue = response;
			};
        })
        vm.numberOfPages = function() {
    		return Math.ceil(vm.issue.length / vm.pageSize);
    	};
	}
	
	vm.timermethods = function(){
		vm.filterData();
//		vm.getIssueList();
//		vm.getIssueListData();
		vm.getGeoHierarchy();
		vm.getAllUsers();
		vm.getStationList();
	}
	vm.timerPromise = $interval(vm.timermethods, 90000);
	
	$scope.$on('$destroy', function () {
	    if (vm.timerPromise) {
	        $interval.cancel(vm.timerPromise);
	        vm.timerPromise = undefined;
	    }
	});
	
	$scope.uploadPic = function(file, issueid, pollingstationid, chatmessage) {

//		var fileInput = $('.upload-file');
//		var maxSize = fileInput.data('max-size');

//		if(fileInput.get(0).files.length){
//		var fileSize = fileInput.get(0).files[0].size; // in bytes
//		if(fileSize>maxSize){
//		toaster.pop("Success","file size is more than " + maxSize/(1024*1024) + " MB","");   
//		return false;
//		}else{
//		}
//		}else{
//		}

		if(vm.validate(chatmessage)){
			if(file==null) file = 'null';
			vm.buttonHide = true;	
			try {
				//blockUI.start();

				$rootScope.cui_blocker(true);//UI blocker started
				var token = loginService.getAccessToken();	
//				var stid=stationId;
//				if (stationId==null || stationId=="") stid="-1";
				vm.issueidupload = issueid;
				vm.pollingstationidupload = pollingstationid;
				vm.chatmessageupload = chatmessage;
				//console.log(vm.mdljaxrsApiBaseUrl + 'chatservices/createchat?issueid='+ vm.issueidupload + '&pollingstationid='+ vm.pollingstationidupload + '&token=' + token + '&chatmessage=' + vm.chatmessageupload);
				file.upload = Upload.upload({
					url: vm.mdljaxrsApiBaseUrl + 'chat/createchat?issueid='+ vm.issueidupload + '&pollingstationid='+ vm.pollingstationidupload + '&chatmessage=' + vm.chatmessageupload,
					data: {file: file},
				});
				file.upload.then(function (response) {
					//blockUI.stop();
					toaster.pop("Success","File Successfully Uploaded!","Chat Sent Successfully.");
					$rootScope.cui_blocker();
					$timeout(function () {
						file.result = response.data;
					});
					//$location.path('/');
					location.reload();
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
						//$location.path('/');
						location.reload();
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
	vm.getChat = function(issueid, pollingstationid) {
		vm.issueid = issueid;
		vm.gettingpollingstationid = pollingstationid;
		
		
		issueService.getChat(issueid, function (response) {
			
			
			var res2 = response.result;
			
			if (jsonService.whatIsIt(res2.entry)=="Object") {
				vm.chatShow = true;
				vm.getChatResult = res2;
				vm.relevantStatus = response.issuestatus;
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
	
	/*vm.notStationIdValue = "";
	vm.notStationId = function() {
		
	}*/
	vm.cancelChatMessage = function(){
		vm.chatmessage = "";
	};
	
	vm.closeDisabled = false;
	vm.closeIssue = function (issueid){
		
		
		if(vm.chatmessage == "") {
			toaster.pop("error","Type a message!","");
		} else {
			issueService.closeIssue(issueid, vm.chatmessage, function (response) {
	    		var res = response;
	    		
	    		if(res.response=="success"){
	    			location.reload();
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
	    		var res = response;
	    		
	    		if(res.response=="success"){
	    			location.reload();
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
	
	vm.getIssueByID = function (id) {
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
	};
}])

.filter('pagination', function() {
	return function(input, start)
	 {
	  start = +start;
	  return input.slice(start);
	 };
}).filter('split', function() {
    return function(input, splitChar, splitIndex) {
        // do some bounds checking here to ensure it has that index
        return input.split(splitChar)[splitIndex];
    }
});



