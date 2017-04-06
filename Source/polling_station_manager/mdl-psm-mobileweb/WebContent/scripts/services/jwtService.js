/***
 * Project: MDL
 * Author: Chanaka Upendra
 * Module: JWT Service
 */

'use strict';

var serviceName = 'mdl.mobileweb.service.jwt'
angular.module('newApp').service(serviceName,
    ['$sessionStorage', 'jwtHelper',
        function ($sessionStorage, jwtHelper) {

            var vm = this;

            vm.getToken = function () {
                return $sessionStorage.jwtPsm;
            }

            vm.setToken = function (token) {
                $sessionStorage.jwtPsm = token;
            }

            vm.hasValidToken = function () {
                var token = vm.getToken();

                if (!token) {
                    return false;
                }

                return !jwtHelper.isTokenExpired(token);
            }

            vm.decodeToken = function (token) {
                if (!token)
                    token = vm.getToken();

                if (token) {
                    return jwtHelper.decodeToken(token);
                }
                else {
                    return null;
                }
            }

        }]);
