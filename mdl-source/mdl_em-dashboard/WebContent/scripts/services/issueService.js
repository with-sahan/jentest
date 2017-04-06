/***
 * Project: MDL Dashboard
 * Author: Akarshani Amarasinghe
 * Module: EM issue service
 * Modified by: Ashan Perera [30/01/16]
 */

'use strict';

var serviceName = 'mdl.em.service.emissueServices'
angular.module('newApp').service(serviceName, 
	['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login',
    function ($http, $cookieStore, $location, settings, loginService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;
        vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.getIssues = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getissuelist": {
                    "token": token
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getissuelist/getissuelist';
            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
            .success(function (response) {
                callback(response);
            })
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
            });
        }
        
        vm.getIssueListData = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getallissues": {
                    "token": token
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getallissues/getallissues';
            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
            .success(function (response) {
                callback(response);
            })
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
            });
        }
        
        vm.getIssueListDataFiltered = function (hierarchyid,callback) {
            var token = loginService.getAccessToken();
            var body = {
            				"token": token,
            				"hierarchyId":hierarchyid
            			};
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issue/filterbyhierarchy';
            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
            .success(function (response) {
                callback(response);
            })
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
            });
        }
        vm.getIssueAvgSolveTime = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getissueresolvegraphstats": {
                    "token": token
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getissueresolvegraphstats/getissueresolvegraphstats';
            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
            .success(function (response) {
                callback(response);
            })
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
            });
        }      
        vm.getIssueCategory = function (callback) {
        	/*
        	 * post: returns categories with stats
	        	     {
				        "response": "success",
				        "reason": "Accessibility",
				        "issuecount": "4"
				     },
        	 */
        	
            var token = loginService.getAccessToken();
            var body = {
                "getissueresolvegraphstats": {
                    "token": token
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getissuecategorygraphstats/getissuecategorygraphstats';
            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
            .success(function (response) {
                callback(response);
            })
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
            });
        }
        
        vm.getIssueByID = function(callback, issueid){
    		
    		var token = loginService.getAccessToken();
    		var body = {
    				"getissuebyid ":{ 
    					"token":token,
    					"issueid":issueid
    				} 
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/getissuebyid/getissuebyid';
    			
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.getAllUsers = function(callback){
    		
    		var token = loginService.getAccessToken();
    		var body = {
    				"getallusers ":{ 
    					"token":token,
    				} 
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/getallusers/getallusers';
    			
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.getAllUsersByIssueId = function(issueid,callback){
    		
    		var token = loginService.getAccessToken();
    		var body = {
    				"getallusersbyissueid ":{ 
    					"token":token,
    					"issueid": issueid
    				} 
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/getallusersbyissueid/getallusersbyissueid';
    			
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        

        vm.updateIssue = function(issueId, resolvedIssue, callback){
    		//alert(issueId);
        	//console.log("resolveIssue");
        	//console.log(resolveIssue);
    		var token = loginService.getAccessToken();
    		var body = {
    				"updateissue":{
    			        "token":token,
    			        "issueid":issueId,
    			        "userid":resolvedIssue.userid,
    			        "status":resolvedIssue.issuestatus,
    			        "priority":resolvedIssue.priority,
    			        "comment":resolvedIssue.resolutiondescription
    			    	}
    		};
    		console.log(body);
    		var authEndpoint = vm.webApiBaseUrl+'services/updateissue/updateissue';
    			
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.assignIssue = function(issueId, resolvedIssue, callback){
    		//alert(issueId);
        	//console.log("resolveIssue");
        	//console.log(resolveIssue);
    		var token = loginService.getAccessToken();
    		var body = {
    		    "token":token,
    		    "issueId":issueId,
    		    "userId":resolvedIssue.userid
    		};
    		console.log(body);
    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'reportissueservices/assignissue';
    			
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.resolveIssue = function(issueId, resolvedIssueComment, callback){
    		var token = loginService.getAccessToken();
    		var body = {
	    			"resolveissue":{
		    		    "token":token,
		    		    "issueid":issueId,
		    		    "description":resolvedIssueComment
	    		    }
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/resolveissue/resolveissue';
    			
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.creatingEmail = function(emailDetails, callback){
    		//alert(issueId);
        	//console.log("resolveIssue");
        	//console.log(resolveIssue);
    		var token = loginService.getAccessToken();
    		var body = {
    				    "token":token,
    				    "emailTo":emailDetails.emailTo,
    				    "emailSubject":emailDetails.emailSubject,
    				    "emailBody":emailDetails.emailBody
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issue/sendemail';
    			
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.getChat = function (issueid, callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getchat": {
                    "token":token,
                    "issueid":issueid
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getchat/getchat';
            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
            .success(function (response) {
                callback(response);
            })
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
            });
        }
        
        vm.closeIssue = function(issueId, resolvedIssueComment, callback){
    		var token = loginService.getAccessToken();
    		var body = {
	    			"chatresolveissue":{
		    		    "token":token,
		    		    "issueid":issueId,
		    		    "issuestatus": 2,
		    		    "description":resolvedIssueComment
	    		    }
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/chatresolveissue/chatresolveissue';
    		console.log(body);
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	console.log(response);
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.resolveIssue = function(issueId, resolvedIssueComment, callback){
    		var token = loginService.getAccessToken();
    		var body = {
	    			"chatresolveissue":{
		    		    "token":token,
		    		    "issueid":issueId,
		    		    "issuestatus": 1,
		    		    "description":resolvedIssueComment
	    		    }
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/chatresolveissue/chatresolveissue';
    		console.log(body);
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	console.log(response);
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.getPollingStations_V2 = function(callback){
    		var token = loginService.getAccessToken();
    		var body = {
	    			"getpollingstations_v2":{
		    		    "token":token
	    		    }
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/getpollingstations_v2/getpollingstations_v2';
    		//console.log(body);
    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
                // success
            	//console.log(response);
            	callback(response);
            })
            
            .error(function (errResponse) {
                //console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.getAssignableUsers = function (issueid,callback) {
            var token = loginService.getAccessToken();
            
            var body = {
            	    "token":token,
            	    "issueId":issueid
            };
            
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issue/getisseresolvers';
            
            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
            
            .success(function (response) {
                callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
            });
        }
        
        vm.getUnwatchedIssues = function (callback) {
        	/*
        	 * pre: token being available
        	 * post: return the result - unwatched issue list as call back
        	 */
        	var token = loginService.getAccessToken();
    		var body = {
	    			"getUnTrackedIssueNotifications":{
		    		    "token":token
	    		    }
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/getUnTrackedIssueNotifications/getUnTrackedIssueNotifications';

    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {

            	callback(response);
            })
            
            .error(function (errResponse) {

           	    callback(errResponse);
           });        	
        }
        
        vm.setIssueAsWatched = function(issueNotificationId, callback){
        	
        	/*
        	 * pre: token being available, issueNotificationId => to mark the issue as watched
        	 * post: mark a given issue as watched
        	 */        	
        	
        	var token = loginService.getAccessToken();
    		var body = {
	    			"markIssueNotificationsAsWatched":{
		    		    "token":token,
		    		    "issuenotificationid":issueNotificationId
	    		    }
    		};
    		
    		var authEndpoint = vm.webApiBaseUrl+'services/markIssueNotificationsAsWatched/markIssueNotificationsAsWatched';

    		$http.post(authEndpoint,body,{headers: {
    				   'Content-Type': 'application/json',
    				   'Accept': 'application/json'
    				 }})
            .success(function (response) {
            	callback(response);
            })
            
            .error(function (errResponse) {
           	    callback(errResponse);
           });        	
        	
        }
                
    }]);