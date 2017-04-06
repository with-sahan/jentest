/***
 * Copyrights
 * Project: MDL
 * Author: Rushan Arunod
 * Module: application settings
 */

'use strict';

angular.module('mdl.mobileweb.settings', [])
.constant('settings', {

	webApiVersion: "v2" ,
	gpsTimeOut : 2000,

	webApiBaseUrl: "http://localhost:9763/",
	mdljaxrsApiBaseUrl: "http://localhost:8080/mdl_api/mdlapi/",
	dowloadUrl: "http://localhost:8080/mdl_api/mdlapi",

});