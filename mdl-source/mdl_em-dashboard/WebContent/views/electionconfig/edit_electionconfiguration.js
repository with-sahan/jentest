/***
Project: MDL Dashboard Admin
Author: Akarshani Amarasinghe
Module: EM election configuration Controller
 */

'use strict';

angular.module('newApp').controller('mdl.dashboard.controller.editelectionconfiguration',
		['$scope','toaster', 'mdl.mobileweb.service.json','mdl.dashboard.service.electionconfig','$rootScope', '$location', '$routeParams',
		 function ($scope, toaster, jsonService, elecconfigService, $rootScope, $location, $routeParams) {

			var vm = this;
			
			vm.saveDisabled = false;
			vm.saveDisabledDelete = false;
			
			vm.oneOfElections = [];
			
			vm.electionID = $routeParams.id;
			
			vm.geocoder = new google.maps.Geocoder();
			
			vm.latitude = null;
			vm.longitude = null;
			vm.selectCheckBox="0";
			
			vm.disableTextBox = false;
			
			vm.checkCheckBox = function () {
				console.log("Clicked!!!!");
		          //var notSelected = $filter('filter')( { iscompleted: "0" })
		          
		              if (vm.selectCheckBox==1) {
		                  
		                  console.log("selected@@@");
		              }
		              else {
		                  //vm.selectCheckBox = "0";
		                  console.log("Not selected@@@");
		              }
		      }
			
			vm.getElectionByID = function (election_Id) {
				elecconfigService.getElectionByID(function (response) {
		            vm.oneOfElections = response.result.entry;
		            vm.oneOfElections.election_date = vm.oneOfElections.election_date.replace('+00:00', '');
		            vm.oneOfElections.election_start_time = vm.oneOfElections.election_start_time.replace(':00.000+00:00', '');
		            vm.oneOfElections.election_end_time = vm.oneOfElections.election_end_time.replace(':00.000+00:00', '');
		            vm.oneOfElections.today_date = vm.oneOfElections.today_date.replace('+00:00', '');
		            vm.oneOfElections.today_time = vm.oneOfElections.today_time.replace('.000+00:00', '');
		            vm.selectCheckBox = vm.oneOfElections.BPA_identifier;
		            
		            

		            if (((vm.oneOfElections.election_date == vm.oneOfElections.today_date)&&(vm.oneOfElections.election_start_time<=((vm.oneOfElections.today_time).slice(0,5)))) || vm.oneOfElections.election_date < vm.oneOfElections.today_date) {
		            	vm.disableTextBox = true;
		            }

		        }, election_Id)
		    };
		    
		    vm.getElectionByID(vm.electionID);
		    
		    vm.updateElection = function(electionconfig){
				
				if ((electionconfig.election_name==undefined) || (electionconfig.election_name=='')) { 
					toaster.pop("error","Fill the Election Name!","");
				} else if ((electionconfig.election_date==undefined) || (electionconfig.election_date==''))  { 
					toaster.pop("error","Fill the Election Date!","");
				} else if ((electionconfig.election_start_time==undefined) || (electionconfig.election_start_time=='')) { 
					toaster.pop("error","Fill the Election Start Time!","");
				} else if ((electionconfig.election_end_time==undefined) || (electionconfig.election_end_time=='')) { 
					toaster.pop("error","Fill the Election End Time!","");
				} /*else if (!vm.dateValidation(electionconfig.election_date)) {
					toaster.pop("error","Election Date format is incorrect!","");
				} else if (!vm.timeValidation(electionconfig.election_start_time)) {
					toaster.pop("error","Election Star Time format is incorrect!","");
				} else if (!vm.timeValidation(electionconfig.election_end_time)) {
					toaster.pop("error","Election End Time format is incorrect!","");
				}*/ else if (electionconfig.election_end_time<=electionconfig.election_start_time) { 
					toaster.pop("error","Election End Time should larger than Election Start Time!","");
				} else if ((electionconfig.counting_center_name==undefined) || (electionconfig.counting_center_name=='')) { 
					toaster.pop("error","Fill the Counting Center Name!","");
				} else if ((electionconfig.counting_center_address==undefined) || (electionconfig.counting_center_address=='')) { 
					toaster.pop("error","Fill the Counting Center Address!","");
				} else {
					vm.geocoder.geocode({'address': electionconfig.counting_center_address}, function(results, status) {
						if (status === google.maps.GeocoderStatus.OK) {
							vm.latitude = results[0].geometry.location.lat();
							vm.longitude = results[0].geometry.location.lng();
							
							$rootScope.cui_blocker(true);//UI blocker started
							elecconfigService.updateElection(electionconfig, vm.latitude, vm.longitude,vm.selectCheckBox, function(response){
								var resp = response.result.entry;
								if(response.result.entry.response=="success"){
									vm.saveDisabled = true;
									toaster.pop("success","Successfully Updated The Election","");
									//location.reload();
									$location.path('/electionconfiguration');
									$rootScope.cui_blocker();
								}
								else if(response.result.entry.response=="dataduplicate"){
									toaster.pop("info","This Election is already created!","");
									$rootScope.cui_blocker();
								}
								else if(response.result.entry.response=="notcurrentdate"){
									toaster.pop("info","You can only update an Election from today onwards!","");
									$rootScope.cui_blocker();
								}
								else if(response.result.entry.response=="notcurrenttime"){
									toaster.pop("info","You can only update an Election from the current time today onwards!","");
									$rootScope.cui_blocker();
								}
								else{
									toaster.pop("error","Error Updating The Election","Please try again later!");
									$rootScope.cui_blocker();
								}
							});
						} else {
							$rootScope.cui_blocker();
							toaster.pop("error","Geocode was not successful, Enter a Valid Address for counting center","");
						}
					});
				}
				
			}
		    
		    vm.deleteElection = function(electionID){
				$rootScope.cui_blocker(true);//UI blocker started
				
				
				
				elecconfigService.deleteElection(electionID,function(response){
					var resp = response.result.entry;
					if(response.result.entry.response=="success"){
						vm.saveDisabledDelete = true;
						toaster.pop("success","Successfully Deleted The Election","");
						$location.path('/electionconfiguration');
						$rootScope.cui_blocker();
					}
					else{
						toaster.pop("error","Error Deleting The Election","Please try again later!");
						$rootScope.cui_blocker();
					}
				});
				
			}
		    
		    vm.cancel = function () {
				$location.path('/electionconfiguration');
			}
		    
		    vm.dateValidation = function (str) {
		    	// STRING FORMAT yyyy-mm-dd
		    	if(str=="" || str==null){return false;}								
		    	
		    	// m[1] is year 'YYYY' * m[2] is month 'MM' * m[3] is day 'DD'					
		    	var m = str.match(/(\d{4})-(\d{2})-(\d{2})/);
		    	
		    	// STR IS NOT FIT m IS NOT OBJECT
		    	if( m === null || typeof m !== 'object'){return false;}				
		    	
		    	// CHECK m TYPE
		    	if (typeof m !== 'object' && m !== null && m.size!==3){return false;}
		    				
		    	var ret = true; //RETURN VALUE
		    	
		    	// YEAR CHECK
		    	if( (m[1].length < 4) ) {ret = false;}
		    	// MONTH CHECK			
		    	if( (m[2].length < 2) || m[2] < 1 || m[2] > 12){ret = false;}
		    	// DAY CHECK
		    	if( (m[3].length < 2) || m[3] < 1 || m[3] > 31){ret = false;}
		    	
		    	return ret;	
		    }
		    
		    vm.timeValidation = function (str) {
		    	// regular expression to match required time format
		        var re = /^\d{1,2}:\d{2}([ap]m)?$/;

		        if(!str.match(re)) {
		    		return false;
		        } else {
		    		return true;
		    	}

		    }
		    
	  }]);
