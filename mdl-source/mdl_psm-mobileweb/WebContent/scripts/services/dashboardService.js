/***
 * Project: MDL
 * Author: Thilina Herath
 * Modified by: Akarshani Amarasinghe
 * Module: login services
 */
'use strict';

var serviceName = 'mdl.mobileweb.service.dashboard'
angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login','cacheService',
                                              function ($http, $cookieStore, $location, settings, loginService, cacheService) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	
	vm.getPreActivities = function (stationid, callback) {
		var token = loginService.getAccessToken();
		var body ={"getprepollactivities":{ 
				"token":token, 
				"electionid":1, 
				"pollingstationid" : stationid }};
		var authEndpoint = vm.webApiBaseUrl+'services/getprepollactivities';
			
//		return (vm.preactresponse);	//To Remove
	    $http.post(authEndpoint, body, {
	        headers: {
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
	
	
	vm.getElectionStatus = function (electionid,stationid,callback) {
		var token = loginService.getAccessToken();
		var body ={"getelectionstatus":{ 
				"token":token, 
				"stationid":stationid,
				"electionid":electionid 
				}};
		var authEndpoint = vm.webApiBaseUrl+'services/getelectionstatus/getelectionstatus';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	//console.log(response.result.entry.response);
        	callback(response);
        })
        
        .error(function (errResponse) {
           // console.log(" Error returning from " + authEndpoint);
        	callback(errResponse);
       });		
	}
	
	
	vm.updatePreActivity = function(actid, status, stationid){
		var token = loginService.getAccessToken();
		var body ={"updateprepollingactivity":{ 
				"token":token, 
				"electionid":1, 
				"pollingstationid" : stationid,
				"activityid":actid, 
				"status" : status
				}};
		var authEndpoint = vm.webApiBaseUrl+'services/updateprepollingactivity';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	//console.log(response.result.entry.response);
        	return(response.result.entry.response);
        })
        
        .error(function (errResponse) {
           // console.log(" Error returning from " + authEndpoint);
            return(errResponse);
       });
	}
	
	vm.openCurrentStation = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={"openstation":{ 
				"token":token, 
				"pollingstation_id" : stationid
				}};
		//console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/openstation/openstation';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	//console.log(response.result.entry.response);
        	callback(response.result.entry.response);
        })
        
        .error(function (errResponse) {
           // console.log(" Error returning from " + authEndpoint);
            callback(errResponse);
       });
	}
	
	vm.closeCurrentStation = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={"closepollingstation":{ 
				"token":token, 
				"pollingstationid" : stationid
				}};
		var authEndpoint = vm.webApiBaseUrl+'services/closepollingstation/closepollingstation';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	//console.log(response.result.entry.response);
        	callback(response.result.entry.response);
        })
        
        .error(function (errResponse) {
            //console.log(" Error returning from " + authEndpoint);
            callback(errResponse);
       });
	}
	
	vm.updateCloseStats = function(statoinid,closestation,eid,callback){
		var token = loginService.getAccessToken();
		var body ={"updateclosestats":{ 
				"token":token, 
			    "electionid":eid,
			    "pollingstationid":statoinid,
			    "tot_ballots":closestation.tot_ballots,
			    "tot_spoiled_replaced":closestation.tot_spoiled_replaced,
			    "tot_unused":closestation.tot_unused,
			    "tot_tend_ballots":closestation.tot_tend_ballots,
			    "tot_tend_spoiled":closestation.tot_tend_spoiled,
			    "tot_tend_unused":closestation.tot_tend_unused
				}};
		var authEndpoint = vm.webApiBaseUrl+'services/updateclosestats/updateclosestats';
		
		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	//console.log(response.result.entry.response);
        	callback(response.result.entry.response);
        })
        
        .error(function (errResponse) {
            //console.log(" Error returning from " + authEndpoint);
            callback(errResponse);
       });
	}
	
	
	vm.getPollingStations = function (callback) {
	    var offline = {};
	    offline.allowOffline = true;
	    offline.setCache = function (data) { cacheService.put('pollingStations', data); }
	    offline.getCache = function () { return cacheService.get('pollingStations'); }

		var token = loginService.getAccessToken();
		var body ={"getpollingstations":{ 
				"token":token
				}};
		var authEndpoint = vm.webApiBaseUrl+'services/getpollingstations/getpollingstations';
		
	    $http.post(authEndpoint, body, {
	        offline:offline,
	        headers: {
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
	
	vm.getEllectionList = function (stationid, callback) {
	    var offline = {};
	    offline.allowOffline = true;
	    offline.setCache = function (data) { cacheService.put('electionList', data); }
	    offline.getCache = function () { return cacheService.get('electionList'); }

		var token = loginService.getAccessToken();
		var body ={"getelectionsbystationid":{ 
				"token":token,
				"stationid":stationid
				}};
		var authEndpoint = vm.webApiBaseUrl+'services/getelectionsbystationid/getelectionsbystationid';
		
	    $http.post(authEndpoint, body, {
	        offline:offline,
	        headers: {
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
	
	
	vm.getOpenStationButtonStatus = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={"getpollingstationstatus":{ 
				"token":token,  
				"stationid" : stationid }};
		var authEndpoint = vm.webApiBaseUrl+'services/getpollingstationstatus';
			
//		return (vm.preactresponse);	//To Remove
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
            //console.log(" error Returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
	
	vm.getCloseStationButtonStatus = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={"getelectionsbystationid":{ 
				"token":token,  
				"stationid" : stationid }};
		var authEndpoint = vm.webApiBaseUrl+'services/getelectionsbystationid/getelectionsbystationid';
			
//		return (vm.preactresponse);	//To Remove
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
           // console.log(" error Returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
	
	vm.getPrePollActivities = function (polling_station_id, callback) {
	    var offline = {};
	    offline.allowOffline = true;
	    offline.setCache = function (data) { cacheService.put('prePollActivities', data); }
	    offline.getCache = function () { return cacheService.get('prePollActivities'); }

		var token = loginService.getAccessToken();
		var body ={
				"getprepollactivities_v2":{ 
					"token":token,
					"polling_station_id":polling_station_id,
				 }
		};
		var authEndpoint = vm.webApiBaseUrl+'services/getprepollactivities_v2/getprepollactivities_v2';

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
            //console.log(" Error returning from " + authEndpoint);
        });
	}
	
	vm.getElectionStats = function(electionId, callback) {
		
		var token = loginService.getAccessToken();
		var body ={
			    "token":token,
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
            //console.log(" Error returning from " + authEndpoint);
        });			
	}
	
	vm.getAllElections = function(callback){
		var token = loginService.getAccessToken();
		var body ={
			    "token":token
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
            //console.log(" Error returning from " + authEndpoint);
        });			
		
	};
	
    vm.getpollingstationclosedstatus = function (stationid, callback) {

    	var token = loginService.getAccessToken();
    	var body = {
    			"getpollingstationclosedstatus":{
    				"token":token,
    				"stationid":stationid
    			}
    	};
    	var authEndpoint = vm.webApiBaseUrl+'services/getpollingstationclosedstatus/getpollingstationclosedstatus';
    	$http.post(authEndpoint, body, {
    		headers: {
    			'Content-Type': 'application/json',
    			'Accept': 'application/json'
    		}
    	})
    	.success(function (response) {
    		console.log(response);
    		callback(response);
    	})
    	.error(function (errResponse) {
    		console.log(" Error returning from " + authEndpoint);
    		callback(errResponse);
    	});
    }
    
	vm.getPostPollActivities = function(polling_station_id,election_id,callback){
		var token = loginService.getAccessToken();
		var body ={
		    "getpostpollactivities":{ 
			     "token":token,
			     "polling_station_id":polling_station_id,
			     "electionid":election_id
			 }	
		};
		
		var authEndpoint = vm.webApiBaseUrl+'services/getpostpollactivities/getpostpollactivities';

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
            //console.log(" Error returning from " + authEndpoint);
        });
	}    	
	vm.generateBPA = function(stationid,electionid,callback){
		var token = loginService.getAccessToken();
		var body ={
		    "getpostpollactivities":{ 
			     "token":token,
			     "stationid":stationid,
			     "electionid":electionid
			 }	
		};
		
		var authEndpoint = vm.webApiBaseUrl+'services/generatebpa/generatebpa';

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
            //console.log(" Error returning from " + authEndpoint);
        });		
	}
	vm.check_allelectionclosed = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={
		    "getbpastatusbystation":{ 
			     "token":token,
			     "stationid":stationid
			 }	
		};
		
		var authEndpoint = vm.webApiBaseUrl+'services/getbpastatusbystation/getbpastatusbystation';

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
            //console.log(" Error returning from " + authEndpoint);
        });			
	}
	
	vm.getBPGeneratedStaus = function(stationid,electionid,callback){
		var token = loginService.getAccessToken();
		var body ={
		    "getbpastatus":{ 
			     "token":token,
			     "stationid":stationid,
			     "electionid": electionid
			 }	
		};
		
		var authEndpoint = vm.webApiBaseUrl+'services/getbpastatus/getbpastatus';

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
            //console.log(" Error returning from " + authEndpoint);
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

        	  console.log(response);
        })
        .error(function (errResponse) {
            //console.log(" Error returning from " + authEndpoint);
        });			
		
	};
	
	vm.getBPNames = function(electionid,callback){
		var token = loginService.getAccessToken();
		var body ={
		    "getballotpapernames":{ 
			     "token":token,
			     "electionid": electionid
			 }	
		};
		
		var authEndpoint = vm.webApiBaseUrl+'services/getballotpapernames/getballotpapernames';

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
            //console.log(" Error returning from " + authEndpoint);
        });			
	}	
	
	vm.getBallotType = function(electionid,callback){
		var token = loginService.getAccessToken();
		var body ={
		    "getballottypecount":{ 
			     "token":token,
			     "electionid": electionid
			 }	
		};
		
		var authEndpoint = vm.webApiBaseUrl+'services/getballottypecount/getballottypecount';

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
            //console.log(" Error returning from " + authEndpoint);
        });			
	}		
	
	
} ]);