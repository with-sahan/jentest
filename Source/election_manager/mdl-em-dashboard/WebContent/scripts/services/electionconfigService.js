/***
 * Project: MDL
 * Author: Rushan Arunod
 * Modified By: Akarshani Amarasinghe
 * Module: election configuration - psa
 */

'use strict';

var serviceName = 'mdl.dashboard.service.electionconfig'
angular.module('newApp').service(serviceName,['$http','settings', 'mdl.mobileweb.service.login',
                                              function($http,settings,loginService) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.javaApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	vm.getElection = function(callback) {

		var body = {
		        "token":""
		};
		
		var authEndpoint = vm.javaApiBaseUrl + 'election/findByUser';
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
	
	vm.createElection = function(election, counting_center_latitude, counting_center_longitude, BPA_identifier, callback){
		console.log("Selected value in service"+ BPA_identifier);
		var body = {
            	"ename":election.ename,
                "election_date":election.edate,
                "start_time":election.starttime,
                "end_time":election.endtime,
                "counting_center_name":election.counting_center_name,
                "counting_center_address":election.counting_center_address,
                "counting_center_latitude":counting_center_latitude,
                "counting_center_longitude":counting_center_longitude,
                "BPA_identifier":election.BPA_identifier,
                "ballot_type_count":election.ballot_type_count
            };
        
        
        
        var authEndpoint = vm.javaApiBaseUrl + 'election/create';
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
	
	vm.getElectionByID = function(election_Id,callback ) {
		var body = {
		       "electionid":election_Id
		};
		
		var authEndpoint = vm.javaApiBaseUrl + 'election/getelectionbyid';
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
	
	vm.updateElection = function(election, counting_center_latitude, counting_center_longitude,selectCheckBox, callback){

        var body = {
    	        "election_id": election.electionid,
    	        "ename": election.election_name,
    	        "election_date":election.election_date,
    	        "start_time":election.election_start_time,
    	        "end_time":election.election_end_time,
    	        "counting_center_name":election.counting_center_name,
                "counting_center_address":election.counting_center_address,
                "counting_center_latitude":counting_center_latitude,
                "counting_center_longitude":counting_center_longitude,
                "BPA_identifier":selectCheckBox,
                "ballot_type_count":election.ballot_type_count
    	};
       
        var authEndpoint = vm.javaApiBaseUrl  + 'election/update';
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
	
	vm.deleteElection = function(electionID,callback){
		 var body = {
    	        "election_Id":electionID
    	};
        
        
        var authEndpoint = vm.javaApiBaseUrl + 'election/delete';
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
	
	vm.getElectionFileUploadDetails = function(callback, election_Id) {

		var body = {
		        "eid":election_Id
		};
		
		
		var authEndpoint = vm.javaApiBaseUrl + 'election/file-upload-data';
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
	
	vm.getPollingstationsByElectionId = function(electionID,callback){
		var body = {
    	        "electionid":electionID
    	};
        
        
        var authEndpoint = vm.javaApiBaseUrl + 'election/stations-by-eid';
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
	
	vm.getPollingstationsByStationId = function(stationid,callback){
		var body = {
    	        "stationid":stationid

    	};
        var authEndpoint = vm.javaApiBaseUrl + 'polling-station/findbyid';
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
	
	vm.updateStation = function(electionid,currentStation,callback){
		 var body = {
    	        "electionid":electionid,
    	        "stationid":currentStation.stationid,
    	        "boxnumber":currentStation.boxnumber,
    	        "stationname":currentStation.stationname
    	};
        var authEndpoint = vm.javaApiBaseUrl + 'polling-station/update';
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

	vm.resettenantdata = function(callback){
		var body = {
				"token":""
		}
		
		var authEndpoint = vm.javaApiBaseUrl + 'election/resettenantdata'; 
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

	
} ]);

