/***
 * Copyrights
 * Project: MDL
 * Author: Rushan Arunod
 * Module: application settings
 * Environment: QA
 */

'use strict';

angular.module('mdl.mobileweb.settings', [])
.constant('settings', {

	webApiVersion: "v2" ,
	gpsTimeOut : 2000,
	
	//QA server URLs
    mdljaxrsApiBaseUrl: "https://123.231.119.139:8084/mdl_api/mdlapi/",
    dowloadUrl: "https://123.231.119.139:8084/mdl_api/mdlapi"

});