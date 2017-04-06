/***
 * Project: MDL
 * Author: Thilina Herath
 * Modified by: Akarshani Amarasinghe
 * Module: login services
 */
'use strict';

var serviceName = 'mdl.mobileweb.service.dashboard'
angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
                                              function ($http, $cookieStore, $location, settings, loginService) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	
	vm.getElectionStatus = function (electionid,stationid,callback) {
		var body ={
				"stationid":stationid,
				"electionid":electionid 
				};
		var authEndpoint = vm.jaxrsApiBaseUrl+'polling-station/election-status';
		
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
	
	
	vm.updatePreActivity = function(actid, status, stationid){
		var body ={
				"electionid":1,
				"pollingstationid" : stationid,
				"activityid":actid, 
				"status" : status
				};
		var authEndpoint = vm.jaxrsApiBaseUrl+'polling-station/pre-poll-activity';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	return(response.response);
        })
        
        .error(function (errResponse) {
            return(errResponse);
       });
	}
	
	vm.openCurrentStation = function(stationid,callback){
		var body ={
				    "pollingstationid": stationid
				};

		var authEndpoint = vm.jaxrsApiBaseUrl + 'polling-station/open-station';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	callback(response.response);
        })
        
        .error(function (errResponse) {
            callback(errResponse);
       });
	}
	
	vm.closeCurrentStation = function(stationid,callback){
		var body ={
				"pollingstationid" : stationid
				};
		var authEndpoint = vm.jaxrsApiBaseUrl+'polling-station/close-station';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	callback(response.response);
        })

        .error(function (errResponse) {
            callback(errResponse);
       });
	}
	
	vm.updateCloseStats = function(statoinid,closestation,eid,callback){
		var body ={
				"electionid":eid,
			    "pollingstationid":statoinid,
			    "tot_ballots":closestation.tot_ballots,
			    "tot_spoiled_replaced":closestation.tot_spoiled_replaced,
			    "tot_unused":closestation.tot_unused,
			    "tot_tend_ballots":closestation.tot_tend_ballots,
			    "tot_tend_spoiled":closestation.tot_tend_spoiled,
			    "tot_tend_unused":closestation.tot_tend_unused
				};
		var authEndpoint = vm.jaxrsApiBaseUrl+'polling-station/close-stat';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	callback(response.response);
        })
        
        .error(function (errResponse) {
            callback(errResponse);
       });
	}
	
	
	vm.getPollingStations = function (callback) {
	    var offline = {};
	    //offline.allowOffline = true;
	    //offline.setCache = function (data) { cacheService.put('pollingStations', data); }
	    //offline.getCache = function () { return cacheService.get('pollingStations'); }

		var body ={
				"token":""
				};
		var authEndpoint = vm.jaxrsApiBaseUrl+'polling-station/stations';
        $http.post(authEndpoint, body, {
	        offline:offline,
	        headers: {
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
	
	vm.getEllectionList = function (stationid, callback) {
	    var offline = {};
	    //offline.allowOffline = true;
	    //offline.setCache = function (data) { cacheService.put('electionList', data); }
	    //offline.getCache = function () { return cacheService.get('electionList'); }

		var body ={
				"stationid":stationid
				};
		var authEndpoint = vm.jaxrsApiBaseUrl+'polling-station/elections-station';
		
	    $http.post(authEndpoint, body, {
	        offline:offline,
	        headers: {
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
	
	
	vm.getOpenStationButtonStatus = function(stationid,callback){
		var body ={
				"stationid" : stationid};
		var authEndpoint = vm.jaxrsApiBaseUrl+'openstation/getpollingstationstatus';
			
//		return (vm.preactresponse);	//To Remove
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
	
	vm.getCloseStationButtonStatus = function(stationid,callback){
		var body ={
				"stationid" : stationid };
		var authEndpoint = vm.jaxrsApiBaseUrl+'polling-station/elections-station';
			
//		return (vm.preactresponse);	//To Remove
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
	
	vm.getPrePollActivities = function (polling_station_id, callback) {
	    var offline = {};
	    //offline.allowOffline = true;
	    //offline.setCache = function (data) { cacheService.put('prePollActivities', data); }
	    //offline.getCache = function () { return cacheService.get('prePollActivities'); }

		var body = {
		    "pollingstationid": polling_station_id
		}

		var authEndpoint = vm.jaxrsApiBaseUrl + 'polling-station/pre-poll-activities';

	    $http.post(authEndpoint, body, {
	        offline:offline,
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
	
	vm.getElectionStats = function(electionId, callback) {
		
		var body ={
			    "electionId":electionId
		};
		var authEndpoint = vm.jaxrsApiBaseUrl+'psmdashboard/getstats';

		$http.post(authEndpoint,body,{
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
	
	vm.getAllElections = function(callback){
		var body ={
			    "token":""
		};
		var authEndpoint = vm.jaxrsApiBaseUrl+'psmdashboard/getelectionsbyuser';

		$http.post(authEndpoint,body,{
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
		
	};
	
    vm.getpollingstationclosedstatus = function (stationid, callback) {

    	var body = {
    				"stationid":stationid
    	};
    	var authEndpoint = vm.jaxrsApiBaseUrl+ 'polling-station/closed-status';
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
    		callback(errResponse);
    	});
    }
    
	vm.getPostPollActivities = function(polling_station_id,election_id,callback){
		var body ={
			    "polling_station_id":polling_station_id,
			     "electionid":election_id
		};
		
		var authEndpoint = vm.jaxrsApiBaseUrl+ 'polling-station/post-poll-activity';

		$http.post(authEndpoint,body,{
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
	vm.generateBPA = function(stationid,electionid,callback){
		var body ={
			     "stationid":stationid,
			     "electionid":electionid
		};
		
		var authEndpoint = vm.jaxrsApiBaseUrl+ 'polling-station/bpa-generate';

		$http.post(authEndpoint,body,{
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
	vm.check_allelectionclosed = function(stationid,callback){
		var body ={
			     "stationid":stationid
		};
		
		var authEndpoint = vm.jaxrsApiBaseUrl+ 'polling-station/bpa-station-by-station';

		$http.post(authEndpoint,body,{
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
	
	vm.getBPGeneratedStaus = function(stationid,electionid,callback){
		var body ={
			     "stationid":stationid,
			     "electionid": electionid
		};
		
		var authEndpoint = vm.jaxrsApiBaseUrl+ 'polling-station/bpa-status';

		$http.post(authEndpoint,body,{
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
	
	vm.updateprepollactivities_v2 = function(body,callback){
		
		var authEndpoint = vm.jaxrsApiBaseUrl+'psmdashboard/updateprepollingactivity';

		$http.post(authEndpoint,body,{
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
		
	};
	
	vm.getBPNames = function(electionid,callback){
		var body ={
			    "electionid": electionid
		};
		
		var authEndpoint = vm.jaxrsApiBaseUrl+ 'ballot/ballot-papers';

		$http.post(authEndpoint,body,{
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
	
	vm.getBallotType = function(electionid,callback){
		var body ={
			     "electionid": electionid
		};
		
		var authEndpoint = vm.jaxrsApiBaseUrl+ 'ballot/ballot-type-count';

		$http.post(authEndpoint,body,{
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
	
	
} ]);