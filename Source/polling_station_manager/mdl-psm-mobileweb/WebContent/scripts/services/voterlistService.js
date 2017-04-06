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
        vm.mdljaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.getVoters = function (callback) {
             var body = {
                    "token": ""
            };
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'voter/list';
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
            var body = {
                    "polling_station_id":polling_station_id,
                    "voter_name":createVoterData.voter_name,
                    "phone_number":createVoterData.phone_number,
                    "companion_name":createVoterData.companion_name,
                    "companion_address":createVoterData.companion_address
             };
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'voter/add';
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
            var body = {
                   "voter_list_id": voter_list_id
            };
            var authEndpoint = vm.mdljaxrsApiBaseUrl + 'voter/delete';
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