angular.module('newApp').factory('httpErrorInterceptor', ['$q', '$rootScope', 'toaster', function ($q, $rootScope, toaster) {
    var requestInterceptor = {

        response: function(response) {
            return response;
        },

        responseError: function (response) {
            console.log(response);
            if (response.status == 401) {
                toaster.pop("error", "Unautherized!", "");
                $rootScope.cui_blocker(false);
            }
            if (response.status == 500) {
                $rootScope.cui_blocker(false);
                //toaster.pop("error", "Unknown Error!", "");
            }
            return response;
        }
    };

    return requestInterceptor;
}]);