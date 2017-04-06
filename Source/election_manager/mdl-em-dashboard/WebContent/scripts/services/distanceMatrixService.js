/***
 * Project: MDL
 * Author: Vindya Hettige
 * Modified: Akarshani Amarasinghe (31.01.2015)
 * Module: Ballot services
 */

'use strict';

var serviceName = 'mdl.em.service.distanceMatrixService'
angular.module('newApp').service(serviceName,
		['$http',
        function ($http) {

            var vm = this;

            vm.getDistance = function (marker,callback)
            {
                var eta = {};
                eta.eta = "NA";

                var url = "https://maps.googleapis.com/maps/api/distancematrix/json";

                var processResponse = function (response)
                {
                    if (response) {
                        if (response.rows[0]){
                            if (response.rows[0].elements[0] && response.rows[0].elements[0].status == "OK") {
                                eta.eta = response.rows[0].elements[0].duration.text;
                            }
                        }
                    }

                    callback(eta);
                }

                var service = new google.maps.DistanceMatrixService();
                service.getDistanceMatrix({
                    origins: [marker.latitude + "," + marker.longtitude], 
                    destinations: [marker.destination_latitude + "," + marker.destination_longtitude],
                    travelMode: google.maps.TravelMode.DRIVING,
                    unitSystem: google.maps.UnitSystem.METRIC,
                    avoidHighways: false,
                    avoidTolls: false
                }, processResponse);

                //var params = {
                //    origins: ["6.884006,79.862299"],
                //    destinations: ["6.934515,81.925195"],
                //    mode: "driving",
                //    units: "metric",
                //    key: "AIzaSyAJulA-IVNzbCCVWpqwBceJs27DtuwM7bc"
                //}

                //$http.get(url, params)
                //.success(function (response) {
                //    console.log(response);
                //    callback(response);
                //})
                //.error(function (errResponse) {
                //    console.log(errResponse);
                //});

            }

        }]);
