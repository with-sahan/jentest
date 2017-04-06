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
                    "token": token
            };
            var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/list';
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
                    "token": token
            };
            var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/all';
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
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/filterbyhierarchy';
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
			var body = {"token": token};
			// var authEndpoint = vm.webApiBaseUrl + 'services/getissueresolvegraphstats/getissueresolvegraphstats';
			var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/resolve-graphstats';
                       
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
                    "token": token
            };
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/category-graphstats';
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
    					"token":token,
    					"issueid":issueid
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/getissue-byid';
    			
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
    					"token":token,
    		};
    		
    		var authEndpoint =  vm.mdljaxrsApiBaseUrl + 'issues/allusers';
    			
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
    					"token":token,
    					"issueid": issueid
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/allusers-byid';
    			
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
    			        "token":token,
    			        "issueid":issueId,
    			        "userid":resolvedIssue.userid,
    			        "status":resolvedIssue.issuestatus,
    			        "priority":resolvedIssue.priority,
    			        "comment":resolvedIssue.resolutiondescription
    		};
    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/update';
    			
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
		    		    "token":token,
		    		    "issueid":issueId,
		    		    "description":resolvedIssueComment
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/resolve';
    			
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
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/sendemail';
    			
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
                    "token":token,
                    "issueid":issueid
            };
            var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/chat';
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
		    		    "token":token,
		    		    "issueid":issueId,
		    		    "issuestatus": 2,
		    		    "description":resolvedIssueComment
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/chat-resolve';
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
		    		    "token":token,
		    		    "issueid":issueId,
		    		    "issuestatus": 1,
		    		    "description":resolvedIssueComment
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/chat-resolve';
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
		    		    "token":token
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/polling-stations';
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
            
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/getisseresolvers';
            
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
		    		    "token":token
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/untracked-notifications';

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
		    		    "token":token,
		    		    "issuenotificationid":issueNotificationId
    		};
    		
    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/mark-notification';

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
        
        vm.closeIssue_v2 = function(issueId, resolvedIssue, callback){
    		//alert(issueId);
        	//console.log("resolveIssue");
        	//console.log(resolveIssue);
    		var token = loginService.getAccessToken();
    		var body = {
    			        "token":token,
    			        "issueid":issueId,
    			        "userid":resolvedIssue.userid,
    			        "status":2,
    			        "priority":resolvedIssue.priority,
    			        "comment":resolvedIssue.resolutiondescription
    		};
    		var authEndpoint = vm.mdljaxrsApiBaseUrl+'issues/update';
    			
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
                
    }]);