/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: Key contact details controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.keycontact'
angular.module('newApp').controller(controllerName,
    ['$rootScope', '$scope', '$location','mdl.mobileweb.service.keycontact', 'mdl.mobileweb.service.dashboard', 'toaster',
     'mdl.mobileweb.service.json','modalService',
function ($rootScope, $scope, $location,keycontactService, dashboardService, toaster,jsonService,modalService) {
    $rootScope.loginactive = false;

    var vm = this;

    vm.keyContact = [];
    
    vm.keyContact_new = [];
    /*vm.keyContact_new.pollingstation_id = "";
    vm.keyContact_new.pollingstation_name = "";
    vm.keyContact_new.primary_name = "";
    vm.keyContact_new.primary_phone = "";
    vm.keyContact_new.primary_mobile = "";
    vm.keyContact_new.not_primary_name = "";
    vm.keyContact_new.not_primary_phone = "";
    vm.keyContact_new.not_primary_mobile = "";
*/
    vm.getKeyContactDetails = function () {
    	keycontactService.getKeyContactDetails(function (response) {
            var res = response;
            
            //console.debug("***");
            //console.debug(res[0].pollingstation_id);
            
			if(jsonService.whatIsIt(res)=="Object"){
				vm.keyContact[0] = res;
			}
			else if(jsonService.whatIsIt(res)=="Array"){
				//vm.keyContact = vm.returnKeyContact(res);
				vm.keyContact = res;
			}

        })
    };
    vm.getKeyContactDetails();
    
    vm.returnKeyContact = function(keyContactArray) {
    	
    	for (var i=0; i <keyContactArray.length; i++) {
    		//vm.keyContact_new[0].pollingstation_name = keyContactArray[0].pollingstation_name;
        	//alert(keyContactArray[0].pollingstation_name);
    		vm.keyContact_new = keyContactArray;
    		if (i == 0) {
    			//vm.keyContact[i]==keyContactArray[i];
    			if (keyContactArray[0].primary_contact == 1) {
    				vm.keyContact_new[0].pollingstation_name = keyContactArray[0].pollingstation_name;
    				alert(vm.keyContact_new[0].pollingstation_name);
    				vm.keyContact_new[0].primary_name = keyContactArray[0].name;
    			    vm.keyContact_new[0].primary_phone = keyContactArray[0].phone;
    			    vm.keyContact_new[0].primary_mobile = keyContactArray[0].mobile;
    			    vm.keyContact_new[0].not_primary_name = "";
    			    vm.keyContact_new[0].not_primary_phone = "";
    			    vm.keyContact_new[0].not_primary_mobile = "";
    			} else {
    				vm.keyContact_new[0].pollingstation_name = keyContactArray[0].pollingstation_name;
    				vm.keyContact_new[0].primary_name = "";
    			    vm.keyContact_new[0].primary_phone = "";
    			    vm.keyContact_new[0].primary_mobile = "";
    			    vm.keyContact_new[0].not_primary_name = keyContactArray[0].name;
    			    vm.keyContact_new[0].not_primary_phone = keyContactArray[0].phone;
    			    vm.keyContact_new[0].not_primary_mobile = keyContactArray[0].mobile;
    			}
    		} else if (keyContactArray[i-1].pollingstation_id==keyContactArray[i].pollingstation_id) {
    			alert(keyContactArray[i-1].pollingstation_id);
    			if (keyContactArray[i].primary_contact == 1) {
    				vm.keyContact_new[i].primary_name = keyContactArray[i].name;
    			    vm.keyContact_new[i].primary_phone = keyContactArray[i].phone;
    			    vm.keyContact_new[i].primary_mobile = keyContactArray[i].mobile;
    			    vm.keyContact_new[0].not_primary_name = keyContactArray[i-1].name;
    			    vm.keyContact_new[0].not_primary_phone = keyContactArray[i-1].phone;
    			    vm.keyContact_new[0].not_primary_mobile = keyContactArray[i-1].mobile;
    			} else {
    				vm.keyContact_new[i].primary_name = keyContactArray[i-1].name;
    			    vm.keyContact_new[i].primary_phone = keyContactArray[i-1].phone;
    			    vm.keyContact_new[i].primary_mobile = keyContactArray[i-1].mobile;
    				vm.keyContact_new[i].not_primary_name = keyContactArray[i].name;
    			    vm.keyContact_new[i].not_primary_phone = keyContactArray[i].phone;
    			    vm.keyContact_new[i].not_primary_mobile = keyContactArray[i].mobile;
    			}
    		} else {
    			if (keyContactArray[i].primary_contact == 1) {
    				vm.keyContact_new[i].pollingstation_name = keyContactArray[i].pollingstation_name;
    				vm.keyContact_new[i].primary_name = keyContactArray[i].name;
    			    vm.keyContact_new[i].primary_phone = keyContactArray[i].phone;
    			    vm.keyContact_new[i].primary_mobile = keyContactArray[i].mobile;
    			    vm.keyContact_new[i].not_primary_name = "";
    			    vm.keyContact_new[i].not_primary_phone = "";
    			    vm.keyContact_new[i].not_primary_mobile = "";
    			} else {
    				vm.keyContact_new[i].pollingstation_name = keyContactArray[i].pollingstation_name;
    				vm.keyContact_new[i].primary_name = "";
    			    vm.keyContact_new[i].primary_phone = "";
    			    vm.keyContact_new[i].primary_mobile = "";
    			    vm.keyContact_new[i].not_primary_name = keyContactArray[i].name;
    			    vm.keyContact_new[i].not_primary_phone = keyContactArray[i].phone;
    			    vm.keyContact_new[i].not_primary_mobile = keyContactArray[i].mobile;
    			}
    		}
    	}
    	return vm.keyContact_new;
    }
    
}]);