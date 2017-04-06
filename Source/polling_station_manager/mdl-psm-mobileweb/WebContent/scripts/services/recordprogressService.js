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
    vm.updateProgressEndPoint = vm.jaxrsUrl + 'progress/updateprogress';
    vm.getProgressEndPoint = vm.jaxrsUrl + 'progress/getprogress';
    vm.showCloseButtonEndPoint = vm.jaxrsUrl + 'stationelection/getrecordclosebuttonstate';
    vm.closeStationEndPoint = vm.jaxrsUrl + 'election/closeelection';
    //vm.postalPackCollectedEndPoint = vm.jaxrsUrl + + 'services/collectpostalpacks/collectpostalpacks';
    vm.postalPackCollectedEndPoint2 = vm.jaxrsUrl + 'stationelection/collectpostalpacks';
    vm.getElectionByIdEndpoint = vm.jaxrsUrl + 'election/getelectionbyid';
    vm.getpollingstationelectiondetailsEndpoint = vm.jaxrsUrl + 'stationelection/getpollingstationelectiondetails';
    vm.getunclosedelectiondbystationEndpoint = vm.jaxrsUrl + 'stationelection/getunclosedelectionsbystationid';
    vm.completeprogresssequenceEndpoint = vm.jaxrsUrl + 'polling-station/completeprogresssequence';
    vm.getPostalPackProgressEndPoint = vm.jaxrsUrl + 'stationelection/getpostalpackprogress';


    vm.getProgress = function (electionid,pollingstationid, callback) {

        var body = {
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
       
    vm.updateProgress = function (electionid, pollingstationid, data, callback) {
        console.log(data);
        var body = {};
        body.electionId = electionid;
        body.pollingStationId = pollingstationid;
        body.recordProgressDtoList = data;
        
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

    vm.showCloseButton = function (electionid, stationid, callback) {

        var electionid = electionid;
        var stationid = stationid;
        
        var body =  {
        	        "electionid": electionid,
        	        "pollingstationid": stationid
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

        var electionid = electionid;
        var stationid = stationid;
        
        var body = {
        	        "electionid": electionid,
        	        "pollingstationid": stationid,
        	        "electionstatus": 1
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
    
    
    vm.getElectionByID = function(callback, election_Id) {

		var body = { 
		        "electionid": election_Id
		    };
		
        $http.post(vm.getElectionByIdEndpoint, body, {
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

		var body = { 
		        "electionid":electionid,
		        "pollingstationid":pollingstationid
		    };
		
        $http.post(vm.getpollingstationelectiondetailsEndpoint, body, {
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

        var body = {
        	        "pollingstationid": stationid,
        	        "electionid":electionid,
        	        "person_name":assigned_person_name
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
    
    vm.getUnclosedElectionsbystationid = function(election_Id, stationid, callback) {
    	/*
    	 * post: Returns all incomplete elections (with nolasthourrecord) for given Station
    	 */

		var body = { 
		         "electionid": election_Id,
		        "pollingstationid": stationid
		    };

        $http.post(vm.getunclosedelectiondbystationEndpoint, body, {
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
    
    vm.completeProgressSequence = function(stationid, callback) {
    	/*
    	 * post: Complete given election, BP is generated and it's station is closed 
    	 * Note: longtitude and latitude are hardcoded
    	 */    	

		var body = {
		        "pollingstationid": stationid
		    };
		
        $http.post(vm.completeprogresssequenceEndpoint, body, {
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

    vm.getPostalPackProgress = function (electionid, pollingstationid, callback) {

            var token = loginService.getAccessToken();

            var body = { 
                "token":token,
                "electionid":electionid,
                "pollingstationid": pollingstationid
                };

        $http.post(vm.getPostalPackProgressEndPoint, body, {
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