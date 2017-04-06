/***
 * Project: MDL
 * Author: Sudaraka Jayashanka
 * Module: Organisation Setup controller
 */

'use strict';

var controllerName = 'mdl.dashboard.controller.manageroles'
angular.module('newApp').controller(controllerName,
    ['$rootScope', '$scope', '$location','mdl.dashboard.service.role',  'toaster','mdl.mobileweb.service.json',
     
function ($rootScope, $scope, $location,roleService, toaster,jsonService) {
    $rootScope.loginactive = false;

    var vm = this;
    vm.newRole={};
    vm.roles={"roleList":[],"selectedRole":""};
    vm.roleList=[];
    vm.alterRole;
    vm.getAllRoles=function(){
    	$rootScope.cui_blocker(true);
    	roleService.getAllRoles(function (response) {
    		$rootScope.cui_blocker();
    		var resp = response;
			if(jsonService.whatIsIt(resp)=="Object"){
				vm.roleList[0] = resp;
				vm.roles.roleList[0] = resp;
			}
			else if(jsonService.whatIsIt(resp)=="Array"){
				vm.roleList = resp;
				vm.roles.roleList = resp;
			}
        })
    }
    
    vm.saveData=function(newRole){
    	if(vm.validateSave()){
    	roleService.addNewRole(newRole.rolename,newRole.description,function (response) {
    	$rootScope.cui_blocker(true);
    		$rootScope.cui_blocker();
    		if(response.response=="success"){
    			toaster.pop("success","Role added successfully!","");
    			vm.gotoManageScreen();
    		}else if(response.response=="unauthorized"){
    			toaster.pop("error","User unauthorized","");
    		}else{
    			toaster.pop("error",response.response,"");
    		}

    	})
    	}
    }

    vm.validateSave = function(){
    		if ((vm.newRole.rolename==undefined) || (vm.newRole.rolename=='')) {
    			toaster.pop("error","Please define the role name correctly","");
    			return false; }
    		if ((vm.newRole.description==undefined) || (vm.newRole.description=='')) {
    			toaster.pop("error","Please define the role description","");
    			return false; }
    		return true;
    	}
    
    vm.updateData=function(newRole){
    if(vm.validateSave()){
		roleService.updateRole(newRole.roleid,newRole.rolename,newRole.description,function (response) {
		$rootScope.cui_blocker(true);
			$rootScope.cui_blocker();
    	if(response.response=="success"){
	    		toaster.pop("success","Role updated successfully!","");
	    		vm.gotoManageScreen();
	    	}else if(response.response=="unauthorized"){
	    		toaster.pop("error","User unauthorized","");
	    	}else{
	    		toaster.pop("error",response.response,"");
	    	}
		})
		}
    }
    
    vm.deleteData=function(){
    	if(vm.roles.selectedRole==''){
    		toaster.pop("error","Select a role first!","");
    	}else if(vm.newRole.roleid===vm.roles.selectedRole){
    		toaster.pop("error","Select a different role!","");
    	}else{
    		$rootScope.cui_blocker(true);
    		roleService.deleteRole(vm.newRole.roleid,vm.roles.selectedRole,function (response) {
    			$rootScope.cui_blocker();
    			if(response.response=="success"){
    				toaster.pop("success","Role deleted successfully!","");
    				vm.gotoManageScreen();
    			}else if(response.response=="unauthorized"){
    				toaster.pop("error","User unauthorized","");
    			}else{
    				toaster.pop("error",response.response,"");
    			}

    		})
    	}
    }
    
    
    
    vm.loadRole=function(){
    	var roleId=$location.search().id;
    	
    	if(typeof roleId === 'undefined'){
    	    // this is not the edit screen
    	}else{
    		//load the role
    		$rootScope.cui_blocker(true);
    		roleService.getRoleById(roleId,function (response) {
    			$rootScope.cui_blocker();
	    	if(response.response=="success"){
	    		vm.newRole.roleid=response.id;
	    		vm.newRole.rolename=response.name;
	    		vm.newRole.description=response.description;
	    		
	    		
	    	}else if(response.response=="unauthorized"){
	    		toaster.pop("error","User unauthorized","");
	    	}else{
	    		toaster.pop("error",response.response,"");
	    	}
	    	
			})
    	};
    }
    
    vm.addNewRole=function(){
    	
    	$location.search('id', null);
    	$location.path('/addrole');
    }
    
    vm.gotoManageScreen=function(){
    	$location.search('id', null); 
    	$location.path('/manageroles');
    }
    
    
    //load the roles
    vm.getAllRoles();
    vm.loadRole();
    


}]).directive('wbSelect3', function ($timeout) {
	return {
		restrict: 'A',
		require: 'ngModel',	
		link: function ($scope, element, attrs, ngModel) { 
			$timeout(function(){
				$(element).select2().on('change', function (event) {//Set ngModal on dowpdown change
					$scope.$apply(function () {
						return ngModel.$setViewValue(event.val);
					});
					$scope.filterData();
				}); 				
			}, 2000);  
			$scope.$watch(function () {//If ngmodal changed, set dropdown value
				return ngModel.$modelValue;
			}, function(newValue) {
				$(element).select2().select('val', newValue);
			});            
		}
	};
})
;