/***
 * Copyrights
 * Project: MDL
 * Author: Thilina Herath
 * Module: application settings
 */

'use strict';

angular.module('mdl.mobileweb.settings', [])
.constant('settings', {

	webApiVersion: "v2" ,
	gpsTimeOut : 2000,

//	// Localhost related urls
//	webApiBaseUrl: "http://localhost:9763/",
//	mdljaxrsApiBaseUrl: "http://localhost:8080/mdl_api/mdlapi/",
//	dowloadUrl: "http://localhost:8080/mdl_api/mdlapi",

	// Dev related urls
	webApiBaseUrl: "http://localhost:9763/",
	mdljaxrsApiBaseUrl: "http://localhost:9090/mdl_api/mdlapi/",
	dowloadUrl: "http://localhost:8080/mdl_api/mdlapi"
	

//	// Uat related urls
//	webApiBaseUrl: "http://ec2-52-49-174-109.eu-west-1.compute.amazonaws.com:9763/",
//	mdljaxrsApiBaseUrl: "http://ec2-52-49-174-109.eu-west-1.compute.amazonaws.com:60801/mdl_api/mdlapi/",
//	dowloadUrl: "http://ec2-52-49-174-109.eu-west-1.compute.amazonaws.com:60801/mdl_api/mdlapi"

//	// Prod related urls
//	webApiBaseUrl: "https://apps.moderndemocracy.com:9443/",
//	mdljaxrsApiBaseUrl: "https://apps.moderndemocracy.com:8443/mdl_api/mdlapi/", 
//	dowloadUrl: "https://apps.moderndemocracy.com:8443/mdl_api/mdlapi"

//		// Clustered Prod related urls
//		webApiBaseUrl: "https://dss.moderndemocracy.com/",
//		mdljaxrsApiBaseUrl: "https://api.moderndemocracy.com/mdlapi/",
//		dowloadUrl: "https://api.moderndemocracy.com/mdlapi"			
		
	/*=================================================================*/

});