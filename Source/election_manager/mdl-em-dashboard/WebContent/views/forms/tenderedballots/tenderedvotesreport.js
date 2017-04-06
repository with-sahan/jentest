/***
 * Project: MDL Dashboard
 * Author: Rushan Arunod
 * Module: Tendered votes Em
 */

'use strict';

var controllerName = 'mdl.em.controller.tenderedvotes'
angular.module('newApp').controller(controllerName, ['$rootScope', '$scope', 'mdl.em.service.reportService', 'toaster',
         'settings', 'mdl.em.service.geoHierarchyService','modalService',
        function($rootScope, $scope, reportService, toaster, settings,
        		geoHierarchyService, modalService) {

            $rootScope.loginactive = false;
            var vm = this;

            vm.curPage = 1;
            vm.pageSize = 10;


            $scope.geoHierarchy = [];
            $scope.geoArray = [];
            //this is to get the geo hierarchy to the dropdown list
            vm.getGeoHierarchy = function() {
                $scope.geoArray = [];
                geoHierarchyService.getGeoHierarchy(function(response) {
                    $scope.geoHierarchy = response;
                    if (typeof $scope.geoHierarchy[0] != 'undefined') {
                        $scope.selectedHrc = $scope.geoHierarchy[0].split('|')[1]; //Default Geo place; used for loading election on page load
                        $scope.getTenderedVoterList();
                    }
                    angular.forEach($scope.geoHierarchy, function(ele) {
                        $scope.geoArray.push({
                            id: ele.split('|')[1],
                            name: ele.split('|')[0]
                        });
                    });
                })
            }

            vm.getGeoHierarchy();



            

            vm.tenderedvoterlist = [];
            $scope.getTenderedVoterList = function() {
                reportService.getTenderedBallotsData($scope.selectedHrc, function(response) {
                    var resp = response;
                    vm.tenderedvoterlist = resp;
                });
            };
       

            //modalinfo - tendered-votes
            vm.infoTendered = "views/forms/forms-modal/tenderedvotesModal.html";
            vm.infoModalTendered = {
              id: "infoid"
            };

            vm.getInfoTendered = function() {
              vm.infoModalTendered = {
                id: "infoid",
                body: "this is the information",
                closeCaption: "Cancel",
                saveCaption: "OK",
              };
              vm.infoModalTendered.close = function() {
                modalService.close('infoid');
              };
              modalService.load('infoid');
            };
        }
    ])
    .directive('wbSelectForms', function($timeout) {
        return {
            restrict: 'A',
            require: 'ngModel',
            link: function($scope, element, attrs, ngModel) {
                $timeout(function() {
                    $(element).select2().on('change', function(event) { //Set ngModal on dowpdown change
                        $scope.$apply(function() {
                            return ngModel.$setViewValue(event.val);
                        });
                        $scope.getTenderedVoterList();
                    });
                }, 2000);
                $scope.$watch(function() { //If ngmodal changed, set dropdown value
                    return ngModel.$modelValue;
                }, function(newValue) {
                    $(element).select2().select('val', newValue);
                });
            }
        };
    });
