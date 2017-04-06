angular.module('newApp').factory('httpErrorInterceptor', ['$q', '$rootScope', 'toaster', '$location',
  function ($q, $rootScope, toaster, $location) {
    var requestInterceptor = {

        response: function(response) {
            return response;
        },

        responseError: function (response) {

            if (response.status == 401) {
                toaster.pop("error", "Unautherized!", "");
                $location.path('/login');
                $rootScope.cui_blocker(false);
            }
            if (response.status == 404) {
                toaster.pop("error", "Service Unavailable!", "");
                $rootScope.cui_blocker(false);
            }
            if (response.status == 400) {
                //toaster.pop("error", "Bad Request!", "");
                $rootScope.cui_blocker(false);
            }
            if (response.status == 500) {
                $rootScope.cui_blocker(false);
                //toaster.pop("error", "Unknown Error!", "");
            }
            return $q.reject(response);
        }
    };

    return requestInterceptor;
}]);