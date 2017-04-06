/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: issue services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.reportIssue'
angular.module('newApp').service(serviceName, ['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login',
    function ($http, $cookieStore, $location, settings, loginService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;
        
        vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.submitDescription = function (electionid, pollingstationid, data, callback) {
            console.log(data);
            var token = loginService.getAccessToken();

            var body = {
                "reportissue": {
                    "token": token,
                    "electionid": electionid,
                    "pollingstationid": pollingstationid,
                    "issueid": data.selectedReasonId,
                    "description": data.messageDescription,
                    "priority": data.selectedPriorityId //1=low,2=medium,3=high
                }
            };
            console.log(body);

            var authEndpoint = vm.webApiBaseUrl + 'services/reportissue/reportissue';

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
    		//console.debug("Content", body)
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
    		//console.debug("Content", body)
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
        
        vm.reportIssueAllStations = function (electionid, pollingstation_id_list, data, callback) {
            console.log(pollingstation_id_list);
            var token = loginService.getAccessToken();

            var body = {
            	    "token":token,
            	    "pollingstation_id_list":pollingstation_id_list,
            	    "electionid":electionid,
            	    "issue_list_id":data.selectedReasonId,
            	    "description":data.messageDescription,
            	    "priority":data.selectedPriorityId
            };
            
            console.log(body);

            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'reportissueallstationsservices/reportissueallstations';

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
        
        vm.getIssueListData_V2 = function (stationid, callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getallissues_v2": {
                    "token": token,
                    "stationid": stationid
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getallissues_v2/getallissues_v2';
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
        
        vm.reportIssue = function (pollingstation_id_list, data, callback) {
            console.log(pollingstation_id_list);
            var token = loginService.getAccessToken();

            var body = {
            	    "token":token,
            	    "pollingstation_id_list":pollingstation_id_list,
            	    "issue_list_id":data.selectedReasonId,
            	    "description":data.messageDescription,
            	    "priority":data.selectedPriorityId
            };
            
            console.log(body);

            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'reportissueservices/reportissue';

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
    }]);