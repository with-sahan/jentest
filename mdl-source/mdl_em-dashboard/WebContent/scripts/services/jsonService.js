/***
 * Project: MDL
 * Author: Rushan Arunod
 * Module: login services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.json'
angular.module('newApp').service(serviceName,['$http','$cookieStore','$location','settings', 
                                              function($http, $cookieStore, $location,settings) {
		
	var vm = this;
	vm.webApiBaseUrl = settings.webApiBaseUrl;
	
	
	var stringConstructor = "test".constructor;
	var arrayConstructor = [].constructor;
	var objectConstructor = {}.constructor;

	vm.whatIsIt = function(object1) {
	    if (object1 === null) {
	        return "null";
	    }
	    else if (object1 === undefined) {
	        return "undefined";
	    }
	    else if (object1.constructor === stringConstructor) {
	        return "String";
	    }
	    else if (object1.constructor === arrayConstructor) {
	        return "Array";
	    }
	    else if (object1.constructor === objectConstructor) {
	        return "Object";
	    }
	    else {
	        return "don't know";
	    }
	}
	
	
} ]);