/***
 * Project: MDL
 * Author: Rushan Arunod
 * Modified By: Akarshani Amarasinghe
 * Module: User manage controller
 */

'use strict';

var controllerName = 'mdl.dashboard.controller.manageusers'
	angular.module('newApp').controller(controllerName,
			['$rootScope', '$scope', '$location','toaster','mdl.dashboard.service.user','mdl.mobileweb.service.json',

			 function ($rootScope, $scope, $location,toaster,userService,jsonService) {
				$rootScope.loginactive = false;
				var vm = this;
				vm.userList=[];
				vm.roleList=[];
				vm.newUser={};
				
				vm.getAllUsersOrg=function(){
					$rootScope.cui_blocker(true);
					userService.getAllUsers(function (response) {
						$rootScope.cui_blocker();
						var resp = response;
						if(jsonService.whatIsIt(resp)=="Object"){
							vm.userList[0] = resp;
						}
						else if(jsonService.whatIsIt(resp)=="Array"){
							vm.userList = resp;
						}
					});
				}
				
				vm.getAllRoles=function(){
					$rootScope.cui_blocker(true);
					userService.getAllRoles(function (response) {
						$rootScope.cui_blocker();
						var resp = response;
						if(jsonService.whatIsIt(resp)=="Object"){
							vm.roleList[0] = resp;
						}
						else if(jsonService.whatIsIt(resp)=="Array"){
							vm.roleList = resp;
						}
					});
				}
				

				vm.updateUserDetails=function(userDetails){
					$rootScope.cui_blocker(true);
					userService.getAllUsers(function (userDetails,response) {
						$rootScope.cui_blocker();
						var resp = response;
						if(response.response=="success"){
							vm.userList[0] = resp;
						}
					});
				}
				vm.updatePass=function(updateUser){
					var userId=$location.search().id;
					if (updateUser.newpassword!==updateUser.repassword){
						toaster.pop("error","Passwords Does Not Match!","");
					}
					else if (updateUser.newpassword.length<5){
						toaster.pop("error","Passwords is too short!","");
					}
					else{
						vm.updatePassUser={};
						vm.updatePassUser.userid=userId
						vm.updatePassUser.newpass=updateUser.newpassword
						vm.updatePassUser.adminpass=updateUser.empassword
						$rootScope.cui_blocker(true);
						userService.updatePassword(vm.updatePassUser,function(response){
							$rootScope.cui_blocker();
							if(response.response=="success"){
								toaster.pop("success","Passwords Updated!","");		
								vm.gotoEditScreen();							
							}else{
								toaster.pop("error","Unauthorized!","");
							}
						});						
					}
				}
				
				vm.updateData=function(newUser){
//					console.debug("*******");
//					console.debug(newUser.firstname);
//					console.debug(newUser.lastname);
//					console.debug(newUser.email);
//					console.debug(newUser.username);
//					alert($scope.selectedRole);
					
					
					//for the email validation
					var invalidation_string = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
					
					if ((newUser.firstname==undefined) || (newUser.firstname=='')) { 
						toaster.pop("error","Fill the First Name!","");
					} else if ((newUser.lastname==undefined) || (newUser.lastname==''))  { 
						toaster.pop("error","Fill the Last Name!","");
					} else if ((newUser.email==undefined) || (newUser.email=='')) { 
						toaster.pop("error","Fill the Email!","");
					} else if ((newUser.username==undefined) || (newUser.username=='')) { 
						toaster.pop("error","Fill the User Name!","");
					} else if (!invalidation_string.test(newUser.email)) { 
						toaster.pop("error","The Email Address is not Valid!","");
					} else if (($scope.selectedRole==undefined) || ($scope.selectedRole=='')) { 
						toaster.pop("error","Please chose a role to update the user","");
					} else {
				    	$rootScope.cui_blocker(true);
				    	userService.updateUser(newUser,$scope.selectedRole,function (response) {
							$rootScope.cui_blocker();
							
							if(response.response=="success"){
					    		toaster.pop("success","User updated successfully!","");
					    		vm.gotoManageScreen();
					    	}else if(response.response=="unauthorized"){
					    		toaster.pop("error","Unauthorized","");
					    	}else{
					    		toaster.pop("error",response.response,"");
					    	}
				    	
						})
					}
			    }
				
				vm.saveData=function(newUser){
					console.debug("*******");
					console.debug(newUser.firstname);
					console.debug(newUser.lastname);
					console.debug(newUser.email);
					console.debug(newUser.username);
					
					//for the email validation
					var invalidation_string = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
					
					if ((newUser.firstname==undefined) || (newUser.firstname=='')) { 
						toaster.pop("error","Fill the First Name!","");
					} else if ((newUser.lastname==undefined) || (newUser.lastname==''))  { 
						toaster.pop("error","Fill the Last Name!","");
					} else if ((newUser.email==undefined) || (newUser.email=='')) { 
						toaster.pop("error","Fill the Email!","");
					} else if ((newUser.username==undefined) || (newUser.username=='')) { 
						toaster.pop("error","Fill the User Name!","");
					} else if (!invalidation_string.test(newUser.email)) { 
						toaster.pop("error","The Email Address is not Valid!","");
					} else {
				    	$rootScope.cui_blocker(true);
				    	//value hard coding due to un build functionalities
				    	newUser.language_id=1;
				    	userService.createUser(newUser,function (response) {
				    		$rootScope.cui_blocker();
				    		var resp = response.response;
				    		if(resp=="success") {
				    			toaster.pop("success","User added successfully!","");
				    			vm.gotoManageScreen();
				    		} else if(resp=="dataduplicate"){
				    			toaster.pop("info","This User is Already Created!","");
				    		} else if(resp=="unauthorized"){
				    			toaster.pop("error","User unauthorized","");
				    		} 
				    	})
					}
			    }
			    
				vm.loadUser=function(){
					var userId=$location.search().id;

					if(typeof userId === 'undefined'){
						// this is not the edit screen
					}else{
						//load the User
						$rootScope.cui_blocker(true);
						
						userService.getUserById(userId,function (response) {
							$rootScope.cui_blocker();
							if(response.response=="success"){
								vm.newUser.userid=userId;
								vm.newUser.firstname=response.firstname;
								vm.newUser.lastname=response.lastname;
								vm.newUser.email=response.email;
								vm.newUser.username=response.username;
								vm.newUser.gender=response.gender;

							}else if(response.response=="unauthorized"){
								toaster.pop("error","User unauthorized","");
							}else{
								toaster.pop("error",response.response,"");
							}

						})
					};
				}

				
				vm.getAllUsersOrg();
				vm.getAllRoles();
				vm.loadUser();
				
				vm.deleteUser = function(userID){
					$rootScope.cui_blocker(true);//UI blocker started
					
					console.debug("1010101");
					console.debug(userID);
					
					userService.deleteUser(userID,function(response){
						var resp = response;
						if(response.response=="success"){
							vm.saveDisabledDelete = true;
							toaster.pop("success","Successfully Deleted The User","");
							vm.gotoManageScreen();
							$rootScope.cui_blocker();
						}
						else{
							toaster.pop("error","Error deleting the user","Please try again later!");
							$rootScope.cui_blocker();
						}
					});
					
				}

				vm.addNewUser=function(){
			    	
			    	$location.search('id', null);
			    	$location.path('/adduser');
			    }
				
				vm.gotoManageScreen=function(){
					$location.search('id', null); 
					$location.path('/manageusers');
				}
				
				vm.gotoEditScreen=function(){
					$location.path('/edituser');
				}
				
			}]).filter('onlyEmails', function () {
			    return function (item) {
			    	var stringConstructor = "test".constructor;
			    	var objectConstructor = {}.constructor;
			    	if (item.constructor === stringConstructor) {
//				        return item.replace(/^\w+([.-]?\w+)@\w+([.-]?\w+)(.\w{2,3})+$/, item);
				        return item;
					}
					else if(item.constructor === objectConstructor){
				        return "-";
					}
			      }
			    });
			;
