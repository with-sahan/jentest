/***
 * Project: MDL
 * Author: Thilina Herath
 * Module: login services
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.login'
angular.module('newApp').service(serviceName,
    ['$http', '$cookieStore', '$location', 'settings', '$rootScope', 'mdl.mobileweb.service.jwt','toaster',
        function ($http, $cookieStore, $location, settings, $rootScope, jwtService, toaster) {

            var vm = this;
            vm.webApiBaseUrl = settings.webApiBaseUrl;
            vm.jaxrsApiBaseUrl = settings.mdljaxrsApiBaseUrl;


            vm.getAccessToken = function () {
                if (!jwtService.hasValidToken()) {
                    $location.path('/login');
                }

                return "";
            }

            vm.validateToken = function (token) {
                if (!jwtService.hasValidToken()) {
                    $location.path('/login');
                }
            }

            vm.org_info = function (token, callback) {
                /*
                 *  post: Returns Info. of the organization
                 */

                var body = { "token": "" };
                var authEndpoint = vm.jaxrsApiBaseUrl + 'organization/getorginfo';

                $http.post(authEndpoint, body, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function (response) {
                    // success
                    callback(response);

                })

                .error(function (errResponse) {
                    console.log(" Error returning from " + authEndpoint);
                    //callback(errResponse);
                });
            }

            vm.getElectionActivationStatus = function (token, callback) {
                /*
                 *  post: Returns Info. of the organization
                 */

                var body = { "token": "" };
                var authEndpoint = vm.jaxrsApiBaseUrl + 'election/isactivationday';

                $http.post(authEndpoint, body, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function (response) {
                    // success
                    callback(response);
                })

                .error(function (errResponse) {
                    console.log(" Error returning from " + authEndpoint);
                    //callback(errResponse);
                });
            }

            vm.login = function (user, callback) {

                var authEndpoint = vm.jaxrsApiBaseUrl + 'login';

                $http.post(authEndpoint, user, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function (response) {
                    if (response.jwt) {

                        var userToken = response.token;

                        var claims = jwtService.decodeToken(response.jwt);

                        if (claims && claims.roleId) {

                            if (claims.roleId !== 1) {
                                toaster.pop("error", "Access Denied", "Only polling officers have access previledges for PSM");
                                $location.path('/login');
                            }
                            else {

                                jwtService.setToken(response.jwt);

                                $rootScope.loginactive = false;

                                vm.org_info(userToken, function (response) {
                                    $rootScope.logourl = response.logourl;
                                    $rootScope.organization = response.organization;
                                    $rootScope.userfullname = response.userfullname;
                                });

                                $location.path('/');

                                callback(userToken);
                            }
                        }
                    }
                })
                .error(function (errResponse) {
                    var response = "";

                    if (errResponse.status == 400 || errResponse.status == 401) {
                        response = "unauthorized";
                    }
                    console.log("error from" + authEndpoint);
                    console.log(errResponse);
                    callback(response);
                });
            }

            //$rootScope.$on('IdleTimeout', function () {
            //    if (jwtService.hasValidToken())
            //        vm.logout();
            //});


            vm.logout = function () {

                var logoutEndpoint = vm.jaxrsApiBaseUrl + 'logout';
                var body = {};
                $http.get(logoutEndpoint, null, {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                })
                .success(function (response) {
                    jwtService.setToken(null);
                    $location.path('/login');
                })
            }



        }]);