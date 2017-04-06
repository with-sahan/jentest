/***
 * Project: MDL
 * Author: Thilina Herath
 * Module: login services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.reportIssue'
angular.module('newApp').service(serviceName, ['$http', '$cookieStore', '$location', 'settings', 'mdl.mobileweb.service.login',
    function ($http, $cookieStore, $location, settings, loginService) {

        var vm = this;

        vm.webApiBaseUrl = settings.webApiBaseUrl;

        vm.submitDescription = function (electionid, pollingstationid, data, callback) {
            console.log(data);
            var token = loginService.getAccessToken();

            var body = {
                "reportissue": {
                    "token": token,
                    "electionid": electionid,
                    "pollingstationid": pollingstationid,
                    "issueid": data.selectedReasonId,
                    "description": data.messageDescription,
                    "priority": data.selectedPriorityId //1=low,2=medium,3=high
                }
            };
            console.log(body);

            var authEndpoint = vm.webApiBaseUrl + 'services/reportissue/reportissue';

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

        vm.getIssues = function (callback) {
            var token = loginService.getAccessToken();
            var body = {
                "getissuelist": {
                    "token": token
                }
            };
            var authEndpoint = vm.webApiBaseUrl + 'services/getissuelist/getissuelist';
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