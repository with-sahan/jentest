/***
 * Copyrights
 * Project: MDL
 * Author: Rushan Arunod
 * Module: election configuration - psa
 */

'use strict';

angular.module('newApp').controller('mdl.mobileweb.controller.electionconfig',
		['$scope','toaster', 'mdl.mobileweb.service.json','mdl.dashboard.service.electionconfig','$rootScope',
		 function ($scope, toaster, jsonService, elecconfigService,$rootScope) {

			var vm = this;
			vm.electionconfig = {};
			vm.save = function(electionconfig){
				$rootScope.cui_blocker(true);//UI blocker started
				if(vm.validate(electionconfig)){
					elecconfigService.createElection(electionconfig,function(response){
						var resp = response.response;
						if(resp=="success"){
							toaster.pop("success","Successfully Created The Election","");
							$rootScope.cui_blocker();
						}
						else if(resp=="dataduplicate"){
							toaster.pop("info","This Election is already created!","");
							$rootScope.cui_blocker();
						}
						else{
							toaster.pop("error","Error Creating The Election","Please try again later!");
							$rootScope.cui_blocker();
						}
					});
				}else $rootScope.cui_blocker();
			}

			vm.validate = function(electionconf){
				console.log(electionconf);
				if ((electionconf.ename==undefined) || (electionconf.ename=='')) { 
					toaster.pop("error","Fill the Election Name!","");
					return false; }
				if ((electionconf.edate==undefined) || (electionconf.edate==''))  { 
					toaster.pop("error","Fill the Election Date!","");
					return false; }
				if ((electionconf.starttime==undefined) || (electionconf.starttime=='')) { 
					toaster.pop("error","Fill the Election Start Time!","");
					return false; }
				if ((electionconf.endtime==undefined) || (electionconf.endtime=='')) { 
					toaster.pop("error","Fill the Election End Time!","");
					return false; }
				if (electionconf.endtime<=electionconf.starttime) { 
					toaster.pop("error","Election End Time should larger than Election Start Time!","");
					return false; }
				return true;
			};
	  }]);
