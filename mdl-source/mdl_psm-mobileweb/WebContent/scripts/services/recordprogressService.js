var serviceName = 'mdl.mobileweb.service.recordprogress'

angular.module('newApp').service(serviceName, ['settings','mdl.mobileweb.service.login','$http', 
                                               function (settings,loginService,$http) {
    var vm = this;

    vm.webApiBaseUrl = settings.webApiBaseUrl;
    //vm.getProgressEndPoint = vm.webApiBaseUrl + 'services/getprogress';
    //vm.updateProgressEndPoint = vm.webApiBaseUrl + 'services/updateprogress_v2/updateprogress_v2';

   // vm.getProgressEndPoint = vm.webApiBaseUrl + 'progress/getprogress';
    //vm.updateProgressEndPoint = vm.webApiBaseUrl + 'services/updateprogress';

    vm.jaxrsUrl = settings.mdljaxrsApiBaseUrl;
    vm.updateProgressEndPoint = vm.webApiBaseUrl + 'services/updateprogress_v2/updateprogress_v2';
    vm.getProgressEndPoint = vm.jaxrsUrl + 'progress/getprogress';
    vm.showCloseButtonEndPoint = vm.webApiBaseUrl + 'services/getrecordclosebuttonshow/getrecordclosebuttonshow';
    vm.closeStationEndPoint = vm.webApiBaseUrl + 'services/closeelection/closeelection';
    vm.postalPackCollectedEndPoint = vm.webApiBaseUrl + 'services/collectpostalpacks/collectpostalpacks';
    vm.postalPackCollectedEndPoint2 = vm.webApiBaseUrl + 'services/collectpostalpacks_v2/collectpostalpacks_v2';
    vm.getProgressEndPoint_V2 = vm.webApiBaseUrl + 'services/getupliftingperson/getupliftingperson';

    vm.getProgress = function (electionid,pollingstationid, callback) {

        var token = loginService.getAccessToken();

        var body = {
                    "token": token,
                    "electionId": electionid,
                    "stationid": pollingstationid,
        		};

        $http.post(vm.getProgressEndPoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            callback(response);
        })
         .error(function (errResponse) {
             callback(errResponse);
         });

    }
    
    vm.getProgress_V2 = function (electionid,pollingstationid, callback) {

        var token = loginService.getAccessToken();

        var body = {
		    "getupliftingperson": { 
		        "token":token,
		        "electionid":electionid,
		        "stationid":pollingstationid
		      }
		};
        
        $http.post(vm.getProgressEndPoint_V2, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            callback(response);
        })
         .error(function (errResponse) {
             callback(errResponse);
         });

    }
    
    vm.submitPostalPacksCollected = function (electionid,pollingstationid,data, callback) {

        var token = loginService.getAccessToken();

        var body = {
            "updateprogress":
                {
                "token": token,
                "electionid": electionid,
                "pollingstationid": pollingstationid,
                "ballotpapers": 0,
                "postalpacks": 0,
                "postalpackscollected": data.postalPacksCollectedFinal
                }
        };

        $http.post(vm.updateProgressEndPoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            callback(response);
        })
         .error(function (errResponse) {
             callback(errResponse);
         });

    }

        
    vm.updateProgress = function (electionid, pollingstationid, data, callback) {
        console.log(data);
        var token = loginService.getAccessToken();
        var body = {};
        body.electionId = electionid;
        body.pollingStationId = pollingstationid;
        body.token = token;
        body.recordProgressDtoList = data;
        
        var endpoint = vm.jaxrsUrl + 'progress/updateprogress';
        $http.post(endpoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            callback(response);
        })
         .error(function (errResponse) {
             callback(errResponse);
         });


    }

    vm.showCloseButton = function (electionid, stationid, callback) {

        var token = loginService.getAccessToken();
        var electionid = electionid;
        var stationid = stationid;
        
        var body = {
        	    "getrecordclosebuttonshow": {
        	        "token":token,
        	        "electionid": electionid,
        	        "stationid": stationid
        	        }
        };
        
        $http.post(vm.showCloseButtonEndPoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            callback(response);
        })
         .error(function (errResponse) {
             callback(errResponse);
         });


    }
    
    vm.closeStation = function (electionid, stationid, callback) {

        var token = loginService.getAccessToken();
        var electionid = electionid;
        var stationid = stationid;
        
        var body = {
        	    "closeelection": {
        	        "token": token,
        	        "electionid": electionid,
        	        "stationid": stationid,
        	        "electionstatus": 1
        	        }
        };
        

        $http.post(vm.closeStationEndPoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            callback(response);
        })
         .error(function (errResponse) {
             callback(errResponse);
         });


    }
    
    vm.postalPackCollected = function (electionid, stationid, callback) {

        var token = loginService.getAccessToken();
        var electionid = electionid;
        var stationid = stationid;
        
        var body = {
        	    "collectpostalpacks":{
        	        "token":token,
        	        "stationdid":stationid,
        	        "electionid":electionid
        	        }
        };
        
        $http.post(vm.postalPackCollectedEndPoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            callback(response);
        })
         .error(function (errResponse) {
             callback(errResponse);
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
        });
	}
    
    vm.getPollingStationElectionDetails = function(callback, electionid, pollingstationid) {
		var token = loginService.getAccessToken();
		
		var body = {
		    "getpollingstationelectiondetails":{ 
		        "token":token,
		        "electionid":electionid,
		        "pollingstationid":pollingstationid
		    }
		};
		
		var authEndpoint = vm.webApiBaseUrl + 'services/getpollingstationelectiondetails/getpollingstationelectiondetails';
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
        });
	}
    
    vm.postalPackCollected_V2 = function (electionid, stationid, assigned_person_name, callback) {

        var token = loginService.getAccessToken();
        
        var body = {
        	    "collectpostalpacks_v2":{
        	        "token":token,
        	        "stationdid":stationid,
        	        "electionid":electionid,
        	        "person_name":assigned_person_name
        	    }
       };
        
        $http.post(vm.postalPackCollectedEndPoint2, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            callback(response);
        })
         .error(function (errResponse) {
             callback(errResponse);
         });

    }
    
}]);