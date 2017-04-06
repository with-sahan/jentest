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
	
	vm.getElection = function(callback) {
		var token = loginService.getAccessToken();
		
		var body = {
		    "getelection":{ 
		        "token":token
		    }
		};
		
		var authEndpoint = vm.webApiBaseUrl + 'services/getelection/getelection';
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
		var token = loginService.getAccessToken();
        var body = {
            "createelection": {
            	"token":token,
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
                
            }
        };
        
        
        
        var authEndpoint = vm.webApiBaseUrl + 'services/createelection/createelection';
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
	
	vm.getElectionByID = function(callback, election_Id) {
		var token = loginService.getAccessToken();
		
		var body = {
		    "getelectionbyid":{ 
		        "token":token,
		        "election_Id":election_Id
		    }
		};
		
		
		var authEndpoint = vm.webApiBaseUrl + 'services/getelectionbyid/getelectionbyid';
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
		var token = loginService.getAccessToken();
		console.log("BPAidentifier"+selectCheckBox);
        var body = {
    	    "updateelection":{ 
    	        "token":token,
    	        "election_id": election.electionid,
    	        "ename": election.election_name,
    	        "election_date":election.election_date,
    	        "start_time":election.election_start_time,
    	        "end_time":election.election_end_time,
    	        "counting_center_name":election.counting_center_name,
                "counting_center_address":election.counting_center_address,
                "counting_center_latitude":counting_center_latitude,
                "counting_center_longitude":counting_center_longitude,
                "BPAidentifier":selectCheckBox,
                "ballot_type_count":election.ballot_type_count
    	    }
    	};
       
        var authEndpoint = vm.webApiBaseUrl + 'services/updateelection/updateelection';
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
		var token = loginService.getAccessToken();
        var body = {
    	    "deleteelection":{ 
    	        "token":token,
    	        "election_Id":electionID
    	    }
    	};
        
        
        var authEndpoint = vm.webApiBaseUrl + 'services/deleteelection/deleteelection';
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
		var token = loginService.getAccessToken();
		
		var body = {
		    "getelectionfileuploaddetails":{ 
		        "token":token,
		        "eid":election_Id
		    }
		};
		
		
		var authEndpoint = vm.webApiBaseUrl + 'services/getelectionfileuploaddetails/getelectionfileuploaddetails';
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
		var token = loginService.getAccessToken();
        var body = {
    	    "getpollingstationsDetailsbyelectionid":{ 
    	        "token":token,
    	        "electionid":electionID
    	    }
    	};
        
        
        var authEndpoint = vm.webApiBaseUrl + 'services/getpollingstationsDetailsbyelectionid/getpollingstationsDetailsbyelectionid';
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
		var token = loginService.getAccessToken();
        var body = {
    	    "getpollingstationsDetailsbyStationid":{ 
    	        "token":token,
    	        "stationid":stationid
    	    }
    	};
        var authEndpoint = vm.webApiBaseUrl + 'services/getpollingstationsDetailsbyStationid/getpollingstationsDetailsbyStationid';
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
		var token = loginService.getAccessToken();
        var body = {
    	    "updatestation":{ 
    	        "token":token,
    	        "electionid":electionid,
    	        "stationid":currentStation.stationid,
    	        "boxnumber":currentStation.boxnumber,
    	        "stationname":currentStation.stationname
    	    }
    	};
        console.log(body);
        var authEndpoint = vm.webApiBaseUrl + 'services/updatestation/updatestation';
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