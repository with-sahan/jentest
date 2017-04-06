/***
 * Copyrights
 * Project: MDL
 * Author: Ashan Perera
 * Module: Notification module
 */

'use strict';

var controllerName = 'mdl.mobileweb.controller.notifications'
angular.module('newApp').controller(controllerName,['$http', '$scope','mdl.mobileweb.service.notification',
                                                    'toaster','settings','$routeParams','$anchorScroll',
                                                    'mdl.mobileweb.service.anchorSmoothScroll','$timeout','mdl.mobileweb.service.json','mdl.mobileweb.service.jwt',
                                                     function( $http, $scope,notificationService,toaster,settings,
                                                    		 $routeParams,$anchorScroll,anchorSmoothScroll,$timeout,jsonService, jwtService) {
	
	
	var vm = this;
	vm.number_of_Notifications = "";
	vm.number = "0";
	vm.notifications = [];
	vm.appendUrl = settings.dowloadUrl;

	vm.notificationId = $routeParams.id;
	//get top 5 notifications
	vm.getAllNotifications=function(){
		notificationService.getAllNotifications(function (response){
			if(response!=""){
				var res = response;
				if(jsonService.whatIsIt(res)=="Object"){
					vm.notifications[0] = res;
				}
				else if(jsonService.whatIsIt(res)=="Array"){
					vm.notifications = res;
				}
			}			
		})
	}
	
	vm.confirmMsg = function(notification_id){ //Acknowledge a msg
		notificationService.confirmNotifications(notification_id, function (response){
			if(response!="" && response.response=='success'){
				toaster.pop("success","Your message has been acknowledged","");
			}			
		})				
	}

	$scope.downloadCSV = function(param) {
        var config = {
            headers:  {
                'Authorization': "Bearer " + jwtService.getToken()
            }
        };
        $http({
 						method: 'GET',
 						url: param,
 						params: config,
 						responseType: 'arraybuffer'
 				}).success(function(data, status, headers) {
 						headers = headers();
 						var contentDispositionHeader = headers['content-disposition'];
 						var filename = contentDispositionHeader.split(';')[1].trim().split('=')[1];
 						var ext = filename.substr(filename.lastIndexOf('.') + 1);
 						var linkElement = document.createElement('a');
 						try {
 										var blob = new Blob([data]);
 										var url = window.URL.createObjectURL(blob);
 										linkElement.setAttribute('href', url);
 										linkElement.setAttribute("download", filename);
 	
 										var clickEvent = new MouseEvent("click", {
 												"view": window,
 												"bubbles": true,
 												"cancelable": false
 										});
 										linkElement.dispatchEvent(clickEvent);
 						} catch (ex) {
 								console.log(ex);
 						}
 				}).error(function(data) {
 						console.log(data);
 				});

    }
	
    angular.element(document).ready(function () {// Notification id is passed in the url, scroll to that message (tracked by msg id)
        $timeout(function() {
	    	if(typeof vm.notificationId != "undefined"){
				anchorSmoothScroll.scrollTo('notification'+vm.notificationId);
			}	
        }, 30000);			

    });		
	vm.getAllNotifications();
	
} ]);

	