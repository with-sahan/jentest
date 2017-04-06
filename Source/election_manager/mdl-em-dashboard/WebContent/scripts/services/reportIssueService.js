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
        vm.mdlApiBaseUrl = settings.mdljaxrsApiBaseUrl;

        vm.submitDescription = function (electionid, pollingstationid, data, callback) {
            console.log(data);
            var body = {
                    "electionid": electionid,
                    "pollingstationid": pollingstationid,
                    "issueid": data.selectedReasonId,
                    "description": data.messageDescription,
                    "priority": data.selectedPriorityId //1=low,2=medium,3=high
            };
            console.log(body);

            var authEndpoint = vm.mdlApiBaseUrl + 'issues/report';

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
            var body = {
                    "token": ""
            };
            var authEndpoint = vm.mdlApiBaseUrl + 'issues/list';
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