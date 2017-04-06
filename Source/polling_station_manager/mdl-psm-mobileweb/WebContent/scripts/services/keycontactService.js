/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: Key contact details services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.keycontact'
angular.module('newApp').service(serviceName, ['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login',
    function ($http, $cookieStore, $location, settings, loginService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;
        vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.getKeyContactDetails = function (callback) {
            var body = {
                    "token": ""
            };
            var authEndpoint = vm.jaxrsApiBaseUrl+'polling-station/contact';
            $http.post(authEndpoint, body, {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            })
            .success(function (response) {
                callback(response);
            })
            .error(function (errResponse) {
                console.log(" Error returning from " + authEndpoint);
            });
        }
        
    }]);