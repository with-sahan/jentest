/***
 * Project: MDL
 * Author: Thilina Herath
 * Module: login services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.dashboard'
angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings','mdl.mobileweb.service.login',
                                              function($http, $cookieStore, $location,settings,loginService) {

	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;
	vm.mdlApiBaseUrl = settings.mdljaxrsApiBaseUrl;


	vm.getBallotIssueGraph =  function (hierarchyId, callback) {
			var token = loginService.getAccessToken();
			/*var body ={"getballotissuegraphstats":{
				"token":token}};*/
			var body ={
			"token":token,
			"hierarchyId":hierarchyId
			};
			//var authEndpoint = vm.webApiBaseUrl+'services/getballotissuegraphstats';
			var authEndpoint = vm.jaxrsApiBaseUrl+'emdashboard/getballotissuegraphstats_v2';

		//	return (vm.preactresponse);	//To Remove
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

	};

	vm.getPostalCollectedGraph =  function (hierarchyId, callback) {
			var token = loginService.getAccessToken();
		/*var body ={"getpostalcollectgraphstats":{
			"token":token}};*/
			var body ={
				"token":token,
				"hierarchyId":hierarchyId
				};
			//var authEndpoint = vm.webApiBaseUrl+'services/getpostalcollectgraphstats';
			var authEndpoint = vm.jaxrsApiBaseUrl+'emdashboard/getpostalcollectgraphstats_v2';

		//	return (vm.preactresponse);	//To Remove
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

	};
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
	};
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
	} ;
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
    };
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
	};
	//vm.getOpenIssues =  function (callback) {
	//	var token = loginService.getAccessToken();
	//	var body ={"getissuecountgraphstats":{
	//		"token":token}};
	//		var authEndpoint = vm.webApiBaseUrl+'services/getissuecountgraphstats';

	//	//	return (vm.preactresponse);	//To Remove
	//		$http.post(authEndpoint,body,{headers: {
	//				   'Content-Type': 'application/json',
	//				   'Accept': 'application/json'
	//				 }})
	//	    .success(function (response) {
	//	        // success
	//	    	callback(response);
	//	    })

	//	    .error(function (errResponse) {
	//	        console.log(" Error returning from " + authEndpoint);
	//	   	    callback(errResponse);
	//	   });

	//};

	//To do - EM dashboard - Emergency proxy can not use this function
	vm.getNotificationCount =  function (callback) {
		var token = loginService.getAccessToken();
		var body ={"getnotificationcountgraphstats":{
			"token":token}};
			var authEndpoint = vm.webApiBaseUrl+'services/getnotificationcountgraphstats';

		//	return (vm.preactresponse);	//To Remove
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

	};

	vm.getIssueList =  function (callback) {
		var token = loginService.getAccessToken();
		var body ={"getallissues":{
			"token":token}};
			var authEndpoint = vm.webApiBaseUrl+'services/getallissues';

		//	return (vm.preactresponse);	//To Remove
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
	};
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
	};
	vm.getPreActivities = function(polling_station_id, callback){
			var token = loginService.getAccessToken();
			var body ={
					"getprepollactivities_v2":{
						"token":token,
						"polling_station_id":polling_station_id,
					 }
			};
			var authEndpoint = vm.webApiBaseUrl+'services/getprepollactivities_v2/getprepollactivities_v2';

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

	vm.updatePreActivity = function(actid, status, stationid){
		var token = loginService.getAccessToken();
		var body ={"updateprepollingactivity":{
				"token":token,
				"electionid":"1",
				"pollingstationid" : stationid,
				"activityid":actid,
				"status" : status
				}};
		console.log(body);
		console.log("********"+ actid+"--"+status +"********"+stationid);
		var authEndpoint = vm.webApiBaseUrl+'services/updateprepollingactivity';

		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	console.log(response.result.entry.response);
        	return(response.result.entry.response);
        })

        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
            return(errResponse);
       });
	}

	vm.openCurrentStation = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={"openstation":{
				"token":token,
				"pollingstation_id" : stationid
				}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/openstation/openstation';

		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	console.log(response.result.entry.response);
        	callback(response.result.entry.response);
        })

        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
            callback(errResponse);
       });
	}

	vm.closeCurrentStation = function(stationid,eid,callback){
		var token = loginService.getAccessToken();
		var body ={"closepollingstation":{
				"token":token,
				"electionid" : eid,
				"pollingstationid" : stationid
				}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/closepollingstation/closepollingstation';

		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	console.log(response.result.entry.response);
        	callback(response.result.entry.response);
        })

        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
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
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/updateclosestats/updateclosestats';

		$http.post(authEndpoint,body,{headers: {
				   'Content-Type': 'application/json',
				   'Accept': 'application/json'
				 }})
        .success(function (response) {
        	console.log(response.result.entry.response);
        	callback(response.result.entry.response);
        })

        .error(function (errResponse) {
            console.log(" Error returning from " + authEndpoint);
            callback(errResponse);
       });
	}


	vm.getPollingStations = function(callback){
		var token = loginService.getAccessToken();
		var body ={"getpollingstations":{
				"token":token
				}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/getpollingstations/getpollingstations';

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

	vm.getPollingStationsByHierarchy = function(hierarchyid,callback){
		var token = loginService.getAccessToken();
		var body ={"token":token,"hierarchyId":hierarchyid};
		console.log(body);
		var authEndpoint = vm.mdlApiBaseUrl+'services/getpollingstationsbyhierarchy';

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

	vm.getEllectionList = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={"getelectionsbystationid":{
				"token":token,
				"stationid":stationid
				}};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/getelectionsbystationid/getelectionsbystationid';

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


	vm.getOpenStationButtonStatus = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={"getpollingstationstatus":{
				"token":token,
				"stationid" : stationid }};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/getpollingstationstatus';

//		return (vm.preactresponse);	//To Remove
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
            console.log(" error Returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}

	vm.getCloseStationButtonStatus = function(stationid,callback){
		var token = loginService.getAccessToken();
		var body ={"getelectionsbystationid":{
				"token":token,
				"stationid" : stationid }};
		console.log(body);
		var authEndpoint = vm.webApiBaseUrl+'services/getelectionsbystationid/getelectionsbystationid';

//		return (vm.preactresponse);	//To Remove
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
            console.log(" error Returning from " + authEndpoint);
       	    callback(errResponse);
       });
	}
	vm.getElectionsByHierarchy = function(hierarchyId, callback){
		var token = loginService.getAccessToken();
		var body ={
			    "token":token,
			    "hierarchyId":hierarchyId
		};
		var authEndpoint = vm.jaxrsApiBaseUrl+'emdashboard/getelectionsbyhierarchy';

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
	vm.getIssueCountGraphStats = function(hierarchyId, callback){
		var token = loginService.getAccessToken();
		var body ={
			    "token":token,
			    "hierarchyId":hierarchyId
		};
		var authEndpoint = vm.jaxrsApiBaseUrl+'emdashboard/getissuecountgraphstats';

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
	vm.getStatsByElection = function(hid,electionId, callback){
		var token = loginService.getAccessToken();
		var body ={
			    "token":token,
			    "electionId":electionId,
			    "hierarchyId":hid
		};
		var authEndpoint = vm.jaxrsApiBaseUrl+'emdashboard/getstatsbyelection';
		console.log(body);
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

	vm.getSumStats = function(hierarchyId,electionId, callback){
		var token = loginService.getAccessToken();
		var body ={
			    "token":token,
			    "electionId":electionId,
			    "hierarchyId":hierarchyId
		};
		var authEndpoint = vm.jaxrsApiBaseUrl+'emdashboard/getsumstats';

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
            console.log(" Error returning from " + authEndpoint);
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
	
	vm.getNotOpenAndOpenStations = function(hierarchyId, callback){
		var token = loginService.getAccessToken();
		var body ={
			    "token":token,
			    "hierarchyId":hierarchyId
		};
		var authEndpoint = vm.jaxrsApiBaseUrl+'emdashboard/getpollingstationdetails';

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

} ]);