'use strict';

/**
 * @ngdoc overview
 * @name newappApp
 * @description
 * # newappApp
 *
 * Main module of the application.
 */
var AppMDL = angular
  .module('newApp', [
    'offline', 
    'angular-cache',
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap',
    'mdl.mobileweb.settings',
    'camera',
    'timer',
    'ngGeolocation',
    'toaster',
    'ngFileUpload',
    'ngCsv',
    'ngSanitize',
    'base64'/*,
    'blockUI'*/

  ])
  .config(function ($routeProvider, offlineProvider, $httpProvider/*, blockUIConfig*/) {
      $routeProvider
        .when('/', {
            templateUrl: 'dashboard/dashboard.html',
        })
        .when('/login', {
            templateUrl: 'views/login/login.html',
        })
        .when('/reportissue', {
            templateUrl: 'views/reportissue/reportissue.html',
        })
        .when('/closestation', {
            templateUrl: 'views/closestation/closestation.html',
        })
        .when('/closestation/postal_votes_delivered_statement', {
            templateUrl: 'views/closestation/postalvotesdeliveredstatement.html',
        })
        .when('/openstation', {
            templateUrl: 'views/openstation/openstation.html',
        })
        .when('/recordprogress', {
            templateUrl: 'views/recordprogress/recordprogress.html',
        })
        .when('/photo', {
            templateUrl: 'views/photo/photo.html',
        })
        .when('/recordprogress/tendered', {
            templateUrl: 'views/recordprogress/tendered.html',
        })
        .when('/recordprogress/registry', {
            templateUrl: 'views/recordprogress/registry.html',
        })
        .when('/notification', {
            templateUrl: 'views/notifications/notificationpage.html',
        })
        .when('/notification/see_all', {
            templateUrl: 'views/notifications/notifications.html',
        })
        .when('/notification/see_all/:id', {
            templateUrl: 'views/notifications/notifications.html',
        })
         .when('/gpstracking', {
             templateUrl: 'views/gpstracking/gpstracking.html',
         })
        .when('/ballotaccount', {
            templateUrl: 'views/ballotaccount/ballotaccount.html',
        })
        .when('/reportissue/all_issues', {
            templateUrl: 'views/reportissue/reportissue-view-unresolved-issue.html',
        })
        .when('/voterlist', {
            templateUrl: 'views/voterlist/voterlist.html',
        })
        .when('/checkbox', {
            templateUrl: 'views/checkbox/elements.html',
        })
        .otherwise({
            redirectTo: '/'
        });

      //blockUIConfig.autoBlock = false;
      //$provide.decorator('connectionStatus', function ($delegate) {
      //    $delegate.online = true;
      //    $delegate.isOnline = function () {
      //        return $delegate.online;
      //    };
      //    return $delegate;
      //});

      offlineProvider.debug(true);
      $httpProvider.interceptors.push('httpErrorInterceptor');
  })
.run(function ($http, $cacheFactory, CacheFactory, offline) {
    $http.defaults.cache = $cacheFactory('custom');
    offline.stackCache = CacheFactory.createCache('my-cache', {
        storageMode: 'localStorage'
    });

    offline.start($http);
});

// Route State Load Spinner(used on page or content load)
AppMDL.directive('ngSpinnerLoader', ['$rootScope',
    function($rootScope) {
        return {
            link: function(scope, element, attrs) {
                // by defult hide the spinner bar
                element.addClass('hide'); // hide spinner bar by default
                // display the spinner bar whenever the route changes(the content part started loading)
                $rootScope.$on('$routeChangeStart', function() {
                    element.removeClass('hide'); // show spinner bar
                });
                // hide the spinner bar on rounte change success(after the content loaded)
                $rootScope.$on('$routeChangeSuccess', function() {
                    setTimeout(function(){
                        element.addClass('hide'); // hide spinner bar
                    },500);
                    $("html, body").animate({
                        scrollTop: 0
                    }, 500);
                });
            }
        };
    }
])