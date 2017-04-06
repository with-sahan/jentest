var serviceName = 'mdl.mobileweb.service.recordprogress'

angular.module('newApp').service(serviceName, ['settings','mdl.mobileweb.service.login','$http', 
                                               function (settings,loginService,$http) {
    var vm = this;

    vm.webApiBaseUrl = settings.webApiBaseUrl;
    vm.mdlApiBaseUrl = settings.mdljaxrsApiBaseUrl;
    vm.getProgressEndPoint = vm.mdlApiBaseUrl + 'polling-station/getprogress';
    vm.updateProgressEndPoint = vm.mdlApiBaseUrl + 'polling-station/updateprogress';

    vm.getProgress = function (electionid,pollingstationid, callback) {
       var body = {
                    "electionid": electionid,
                    "pollingstationid": pollingstationid,
        };

        $http.post(vm.getProgressEndPoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            console.log(response);
            callback(response);
        })
         .error(function (errResponse) {
             console.log(" Error returning from " + vm.getProgressEndPoint);
             callback(errResponse);
         });

    }
    
    vm.submitPostalPacksCollected = function (electionid,pollingstationid,data, callback) {

        var body = {
                "electionid": electionid,
                "pollingstationid": pollingstationid,
                "ballotpapers": 0,
                "postalpacks": 0,
                "postalpackscollected": data.postalPacksCollectedFinal
        };

        $http.post(vm.updateProgressEndPoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            console.log(response);
            callback(response);
        })
         .error(function (errResponse) {
             console.log(" Error returning from " + vm.getProgressEndPoint);
             callback(errResponse);
         });

    }

    vm.save = function (electionid,pollingstationid,data, callback) {

        var body = {
                    "electionid": electionid,
                    "pollingstationid": pollingstationid,
                    "ballotpapers": data.ballotPappersIssued,
                    "postalpacks": data.postalPackRecieved,
                    "postalpackscollected": 0
        };
        console.log(body);
        $http.post(vm.updateProgressEndPoint, body, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .success(function (response) {
            // success
            console.log(response);
            callback(response);
        })
         .error(function (errResponse) {
             console.log(" Error returning from " + vm.updateProgressEndPoint);
             callback(errResponse);
         });


    }

}]);