/***
 * Project: MDL
 * Author: Akarshani Amarasinghe
 * Module: Voter list services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.voterlist'
angular.module('newApp').service(serviceName, ['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login',
    function ($http, $cookieStore, $location, settings, loginService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;

        vm.getVoters = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getvoter": {
                    "token": token
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getvoter/getvoter';
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
        
        vm.createVoters = function (polling_station_id, createVoterData, callback) {
            var token = loginService.getAccessToken();
            var body = {
                "createvoter": {
                    "token":token,
                    "polling_station_id":polling_station_id,
                    "voter_name":createVoterData.voter_name,
                    "phone_number":createVoterData.phone_number,
                    "companion_name":createVoterData.companion_name,
                    "companion_address":createVoterData.companion_address
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/createvoter/createvoter';
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
        
        vm.deleteVoters = function (voter_list_id, callback) {
            var token = loginService.getAccessToken();
            var body = {
                "deletevoter": {
                    "token": token,
                    "voter_list_id": voter_list_id
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/deletevoter/deletevoter';
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