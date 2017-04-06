angular
.module('offline')
.service('cacheService', ['$rootScope', '$cacheFactory', function ($rootScope, $cacheFactory) {

    vm = this;

    vm.cache = $cacheFactory('PsmCache');

    vm.put = function (key, value) {
        vm.cache.put(key, angular.isUndefined(value) ? null : value);
    };

    vm.get = function (key) {
        var cache = vm.cache.get(key);
        return cache;
    }

}]);