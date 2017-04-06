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
    'ngMap',
    'ngCsvImport',
    'ngCsv',
    'ngStorage',
    'angular-jwt'
    
  ])
  .config(function ($routeProvider, $httpProvider, jwtOptionsProvider, jwtInterceptorProvider/*, blockUIConfig*/) {
      $routeProvider
        .when('/', {
            templateUrl: 'dashboard/dashboard.html',
            controller: 'dashboardCtrl'            
        })
        .when('/dashboard-summary', {
            templateUrl: 'dashboard/dashboard-summary.html',
            controller: 'dashboardCtrl'            
        })        
        .when('/login', {
            templateUrl: 'views/login/login.html',
        }) 
        .when('/reportissue', {
            templateUrl: 'views/reportissue/reportissue.html',
        })  
        .when('/closestation', {
            templateUrl: 'views/closestation/closestation.html',
            controller: 'dashboardCtrl'  
        }) 
        .when('/openstation', {
            templateUrl: 'views/openstation/openstation.html',
            controller: 'dashboardCtrl'  
        }) 
        .when('/recordprogress', {
            templateUrl: 'views/recordprogress/recordprogress_s1.html',
        }) 
        .when('/photo', {
            templateUrl: 'views/photo/photo.html',
        }) 
        .when('/recordprogress/tendered', {
            templateUrl: 'views/recordprogress/tendered.html',
        })  
        .when('/notifications', {
            templateUrl: 'views/notifications/em-notification.html',
        })
        .when('/notifications/manage/:id', {
            templateUrl: 'views/notifications/notificationpage.html',
        })
        .when('/notifications/create', {
            templateUrl: 'views/notifications/create_notification.html',
        })
        .when('/all_issues', {
            templateUrl: 'views/issues/em-issues.html',
        }) 
        .when('/all_issues/manage/:id', {
            templateUrl: 'views/issues/manage_issues.html',
        })
        .when('/all_issues/email/:id', {
            templateUrl: 'views/issues/email_issues.html',
        })
         .when('/gpstracking', {
            templateUrl: 'views/gpstracking/gpstracking.html',
        }) 
        .when('/ballotaccount', {
            templateUrl: 'views/ballotaccount/ballotaccount.html',
        }) 
        .when('/orgsetup', {
            templateUrl: 'views/orgsetup/orgsetup.html',
        })
        .when('/manageroles', {
            templateUrl: 'views/roles/manageroles.html',
        })
        // .when('/addrole', {
        //     templateUrl: 'views/roles/addrole.html',
        // })
        // .when('/editrole', {
        //     templateUrl: 'views/roles/editrole.html',
        // })
        // .when('/deleterole', {
        //     templateUrl: 'views/roles/deleterole.html',
        // })
        .when('/trackprogress', {
            templateUrl: 'views/trackprogress/trackprogress.html',
        })
		.when('/electionconfig', {
            templateUrl: 'views/electionconfig/electionconfig.html', 
        })
        .when('/electionconfiguration', {
            templateUrl: 'views/electionconfig/electionconfiguration.html', 
        })
        .when('/electionconfiguration/add_election', {
            templateUrl: 'views/electionconfig/add_electionconfiguration.html', 
        })
        .when('/electionconfiguration/edit_election/:id', {
            templateUrl: 'views/electionconfig/edit_electionconfiguration.html', 
        })        
        .when('/electionconfiguration/delete_election/:id', {
            templateUrl: 'views/electionconfig/delete_electionconfiguration.html', 
        })
        .when('/electionconfiguration/stationlist/:id/editstation', {
            templateUrl: 'views/pollingstationdetails/edit_station.html', 
        })
        .when('/stationconfig', {
            templateUrl: 'views/pollstationconfig/pollstationconfig.html',
        })  
		.when('/manageissues', {
            templateUrl: 'views/issuemanagement/issuemanagement.html',
        }) 
        .when('/manageusers', {
            templateUrl: 'views/users/manageuser.html',
        })  
        .when('/edituser', {
            templateUrl: 'views/users/edituser.html',
        })  
        .when('/changepass', {
            templateUrl: 'views/users/editpassword.html',
        }) 
        .when('/adduser', {
            templateUrl: 'views/users/adduser.html',
        })
        .when('/deleteuser', {
            templateUrl: 'views/users/deleteuser.html',
        })
        .when('/datauploads', {
            templateUrl: 'views/datauploads/datauploads.html',
        }) 
        .when('/electionconfiguration/stationlist/:id', {
            templateUrl: 'views/pollingstationdetails/managepollingstationdetails.html',
        }) 
        .when('/psichecklist', {
            templateUrl: 'views/psichecklist/psichecklistNew.html',
        })  
        .when('/formreports', {
            templateUrl: 'views/forms/reportslist.html',
        })   
        .when('/formreports/hourlyanalysis', {
            templateUrl: 'views/forms/hourlyanalysis/hourlyanalysis.html',
        })  
        .when('/formreports/tenderedballots', {
            templateUrl: 'views/forms/tenderedballots/tenderedvotesreport.html',
        }) 
        
        .otherwise({
            redirectTo: '/'
        });

      //blockUIConfig.autoBlock = false;
      
      $httpProvider.interceptors.push('httpErrorInterceptor');

      // Adding jwt interceptor
      jwtInterceptorProvider.whiteListedDomains = ['localhost', 'moderndemocracy.com']
      jwtOptionsProvider.config({
          tokenGetter: ['mdl.mobileweb.service.jwt', function (jwtService) {
              return jwtService.getToken();
          }]
      });

      $httpProvider.interceptors.push('jwtInterceptor');

  })
.run(['mdl.mobileweb.service.jwt', '$rootScope', '$location','toaster', function (jwtService, $rootScope, $location,toaster) {
    $rootScope.$on('$routeChangeStart', function (event, next, current) {

        if (!jwtService.hasValidToken()) {
            event.preventDefault();
            $location.path('/login');
        }
        else {
            var pathSegments = next.$$route.originalPath.split('/');
            var path = pathSegments[1]
            if (!$rootScope.checkAccess(path)) {
                event.preventDefault();
                toaster.pop("error", "Access Denied", "You dont have sufficient previledges.");
                $location.path(current.$$route.originalPath);
            }
        }
    });
}]);

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