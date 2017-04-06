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
            var body = {
                    "electionid": electionid,
                    "pollingstationid": pollingstationid,
                    "issueid": data.selectedReasonId,
                    "description": data.messageDescription,
                    "priority": data.selectedPriorityId //1=low,2=medium,3=high
            };

            var authEndpoint = vm.mdljaxrsApiBaseUrl+ + 'issues/report';

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
            var body = {     "token": ""
                        };
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'issues/list';
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
             var body = {
                    "token": ""
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
        
        vm.getChat = function (issueid, callback) {
            var body = {
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
    		var body = {
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
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.resolveIssue = function(issueId, resolvedIssueComment, callback){
    		var body = {
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
            	callback(response);
            })
            
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
           	    callback(errResponse);
           });
    	}
        
        vm.reportIssueAllStations = function (electionid, pollingstation_id_list, data, callback) {
            var body = {
            	    "pollingstation_id_list":pollingstation_id_list,
            	    "electionid":electionid,
            	    "issue_list_id":data.selectedReasonId,
            	    "description":data.messageDescription,
            	    "priority":data.selectedPriorityId
            };

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
            var body = {
                    "stationid": stationid
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
        
        vm.reportIssue = function (pollingstation_id_list, data, callback) {
            var body = {
            	    "pollingstation_id_list":pollingstation_id_list,
            	    "issue_list_id":data.selectedReasonId,
            	    "description":data.messageDescription,
            	    "priority":data.selectedPriorityId
            };

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