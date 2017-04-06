/***
 * Copyrights
 * Project: MDL
 * Author: Thilina Herath
 * Module: login controller
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.login'
angular.module('newApp').controller(controllerName,[ '$rootScope', '$scope','mdl.mobileweb.service.login', 'toaster',
                                                     function($rootScope, $scope,loginService,toaster) {
	$rootScope.loginactive = true;
	
	var vm = this;
	vm.user ={} ;

	vm.clickLogin = function(user){
		vm.loginValidate(user);
		loginService.login(user,function (response){
			if(response=="unauthorized"){
				toaster.pop("error","Login invalid!","Please Try Again");
			}
			else if(response==""){
				toaster.pop("error","Login Error!","username or password is invalid");
			}
				
        })
	}
	vm.authenticateLoginUser = function(){
		
	}
	
	vm.loginValidate = function(user){
		if(user.organization_code==undefined){
			toaster.pop("error","Please enter the Organization","");
		}
		else if(user.username==undefined){
			toaster.pop("error","Please enter the Username","");
		}
		else if(user.usersecret==undefined){
			toaster.pop("error","Please enter the Password","");
		}
		
	}
	
} ]);