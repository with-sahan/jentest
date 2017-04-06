/***
 * Project: MDL Mobileweb
 * Author: Jarlath Woollams
 * Module: PSM Forms Service
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.formService'
angular.module('newApp').service(serviceName, ['$http', 'settings', 'mdl.mobileweb.service.login',
    function($http, settings, loginService) {

        var vm = this;
        vm.webJaxUrl = settings.mdljaxrsApiBaseUrl;

        vm.getHourlyAnalysisByStation = function(callback) {
            var token = loginService.getAccessToken();
            var body = {
                "token": token
            };
            var authEndpoint = vm.webJaxUrl + 'reports/psm-hourlyanalysis';
            $http.post(authEndpoint, body, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function(response) {
                    callback(response);
                })
                .error(function(errResponse) {
                    callback(errResponse);
                });
        };

        vm.getAllTenderedVotes = function(callback) {
            var token = loginService.getAccessToken();
            var body = {
                "token": token
            };
            var authEndpoint = vm.webJaxUrl + 'reports/getalltenderedvotes';
            $http.post(authEndpoint, body, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function(response) {
                    callback(response);
                })
                .error(function(errResponse) {
                    callback(errResponse);
                });
        };

        vm.getTenderedVotesById = function(id, callback) {
            var body = {
                "token": "",
                "tvid": id
            };

            var authEndpoint = vm.webJaxUrl + 'reports/gettenderedvotebyid';
            $http.post(authEndpoint, body, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function(response) {
                    // success
                    callback(response);
                })
                .error(function(errResponse) {
                    callback(errResponse);
                });
        }

        vm.submitTenderedVotes = function(pollingstation_id, eid, data, callback) {
            var body = {
                "token": "",
                "pollingstationid": pollingstation_id,
                "eid": eid,
                "votername": data.votername,
                "electornumber": data.electornumber,
                "ismarked": data.ismarked
            };

            var authEndpoint = vm.webJaxUrl + 'reports/addtotenderedvotes';
            $http.post(authEndpoint, body, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function(response) {
                    callback(response);
                })
                .error(function(errResponse) {
                    callback(errResponse);
                });
        };

        vm.updateTenderedVotes = function(data, callback) {
            var body = {
                "token": "",
                "votername": data.votername,
                "electornumber": data.electornumber,
                "ismarked": data.ismarked,
                "tvid": data.id
            };

            var authEndpoint = vm.webJaxUrl + 'reports/updatetenderedvote';
            $http.post(authEndpoint, body, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function(response) {
                    // success
                    callback(response);
                })
                .error(function(errResponse) {
                    callback(errResponse);
                });
        };

        vm.deleteTenderedVotes = function(data, callback) {
            var body = {
                "token": "",
                "tvid": data.id
            };

            var authEndpoint = vm.webJaxUrl + 'reports/deletetenderedvote';
            $http.post(authEndpoint, body, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function(response) {
                    // success
                    callback(response);
                })
                .error(function(errResponse) {
                    callback(errResponse);
                });
        };
    }
]);