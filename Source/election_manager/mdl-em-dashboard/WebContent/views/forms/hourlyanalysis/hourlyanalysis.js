/***
 * Project: MDL Dashboard
 * Author: Rushan Arunod
 * Module: EM Hourly Analysis
 */

'use strict';

var controllerName = 'mdl.em.controller.reports'
angular.module('newApp').controller(controllerName, ['$http', '$rootScope', '$scope', 'mdl.em.service.reportService',
                                                     'toaster', 'mdl.em.service.geoHierarchyService', 'mdl.mobileweb.service.jwt', 'settings',
        function($http, $rootScope, $scope, reportService, toaster,geoHierarchyService, jwtService, settings) {

            $rootScope.loginactive = false;
            var vm = this;
            vm.jaxRSApiBaseUrl = settings.mdljaxrsApiBaseUrl;

            $scope.geoHierarchy = [];
            $scope.geoArray = [];
            //this is to get the geo hierarchy to the dropdown list
            vm.getGeoHierarchy = function() {
            	
                $scope.geoArray = [];
                geoHierarchyService.getGeoHierarchy(function(response) {
                    $scope.geoHierarchy = response;
                    if (typeof $scope.geoHierarchy[0] != 'undefined') {
                        $scope.selectedHrc = $scope.geoHierarchy[0].split('|')[1]; //Default Geo place; used for loading election on page load
                        vm.getAnalysisData($scope.selectedHrc);
                    }
                    angular.forEach($scope.geoHierarchy, function(ele) {
                        $scope.geoArray.push({
                            id: ele.split('|')[1],
                            name: ele.split('|')[0]
                        });
                    });
                })
            }
            
            vm.getAnalysisData = function(hierarchyId){
            	reportService.getHourlyAnalysisData(hierarchyId,function(response){
            		vm.stations = response;
            	});
            }

            vm.getGeoHierarchy();
            
            $scope.callMethods = function(){
            	vm.getAnalysisData($scope.selectedHrc);
            }
            
            $scope.exportReport = function(){
        			 var config = {
                 headers:  {
                      'Authorization': "Bearer " + jwtService.getToken()
                  }
        			 };
              var param =  "hierarchyId="+$scope.selectedHrc;
              
        			var authEndPoint = vm.jaxRSApiBaseUrl + 'reports/pdf-hourlyanalysis?'+param;
              $rootScope.cui_blocker(true);
        			$http({
        				 method: 'GET',
        				 url: authEndPoint,
        				 params: config,
        				 responseType: 'arraybuffer'
        		 }).success(function(data, status, headers) {
        				 headers = headers();
        				 var contentDispositionHeader = headers['content-disposition'];
        				 var filename = contentDispositionHeader.split(';')[1].trim().split('=')[1];
        				 var linkElement = document.createElement('a');
        				 try {
        								 var blob = new Blob([data]);
        								 var url = window.URL.createObjectURL(blob);
        								 linkElement.setAttribute('href', url);
        								 linkElement.setAttribute("download", filename);
        
        								 var clickEvent = new MouseEvent("click", {
        										 "view": window,
        										 "bubbles": true,
        										 "cancelable": false
        								 });
        								 linkElement.dispatchEvent(clickEvent);
                         $rootScope.cui_blocker(false);
        				 } catch (ex) {
        						 console.log(ex);
        				 }
        		 }).error(function(data) {
        				 console.log(data);
        		 });			
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
                        $scope.callMethods();
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
