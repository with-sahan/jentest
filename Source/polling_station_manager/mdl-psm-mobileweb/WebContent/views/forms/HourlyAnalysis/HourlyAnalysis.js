/**
 * Project : MDL Dashboard
 * Author : Vindya Hettige
 * Module : postal votes delivered
 *
 * */

'use strict';

var controllerName = 'mdl.mobileweb.controller.hourlyanalysis';
angular.module('newApp').controller(controllerName, ['$scope', 'mdl.mobileweb.service.formService',
    function($scope, formService) {

        var vm = this;

        vm.buttonDis = false;

        vm.result = [];
        vm.pollingStationList = [];
        vm.pollingStationsObj = {};

        vm.getHourlyAnalysisByStation = function() {
            formService.getHourlyAnalysisByStation(function(response) {
                vm.pollingStationList = response;
                vm.setStation(vm.pollingStationList[0].stationid, vm.stationname);
                vm.stationname = vm.pollingStationList[0].pollingstationname;
                vm.ward = vm.pollingStationList[0].ward;
            });
        };
        vm.getHourlyAnalysisByStation();

        vm.setStation = function(stationid, stationname) {
            $scope.stationid = stationid;
            $scope.selectedStation = stationid;
            vm.stationname = stationname;
            angular.forEach(vm.pollingStationList, function(value, key) {
                if (value.stationid == stationid) {
                    vm.timeArray = vm.pollingStationList[key].timehourly;
                }
            });
        };
    }
]);