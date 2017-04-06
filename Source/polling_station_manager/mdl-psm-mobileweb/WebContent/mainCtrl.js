angular.module('newApp').controller('mainCtrl',
    ['$scope', 'applicationService', 'quickViewService', 'builderService', 'pluginsService', '$location','mdl.mobileweb.service.login','$rootScope',
        function ($scope, applicationService, quickViewService, builderService, pluginsService, $location, loginService, $rootScope) {
            
			$rootScope.HideWaiting = true;
			$(document).ready(function () {
                applicationService.init();
                quickViewService.init();
                builderService.init();
                pluginsService.init();
                Dropzone.autoDiscover = false;
            });

            $rootScope.isOnline = true;
            $rootScope.classFromController = ""; //You can add class for .main-content -> .page-content per controller i.e /recordprogress

            $rootScope.trackingTimerStarted = false; // This becomes true only when gps tracking is enabled
            
            $scope.$on('$viewContentLoaded', function () {
                pluginsService.init();
                applicationService.customScroll();
                applicationService.handlePanelAction();
                $('.nav.nav-sidebar .nav-active').removeClass('nav-active active');
                $('.nav.nav-sidebar .active:not(.nav-parent)').closest('.nav-parent').addClass('nav-active active');

                /*if($location.$$path == '/' || $location.$$path == '/layout-api'){
                    $('.nav.nav-sidebar .nav-parent').removeClass('nav-active active');
                    $('.nav.nav-sidebar .nav-parent .children').removeClass('nav-active active');
                    if ($('body').hasClass('sidebar-collapsed') && !$('body').hasClass('sidebar-hover')) return;
                    if ($('body').hasClass('submenu-hover')) return;
                    $('.nav.nav-sidebar .nav-parent .children').slideUp(200);
                    $('.nav-sidebar .arrow').removeClass('active');
                }*/

    			var token = loginService.getAccessToken();	
    			if($location.$$path != '/login' && typeof $rootScope.logourl == "undefined"){
    				loginService.org_info(token , function(response) {		
    					$rootScope.organization=response.organization;
    					$rootScope.logourl = (response.logourl.length>0 ? response.logourl : 'derry.png');
    					$rootScope.userfullname=response.userfullname;
    				});	
    				loginService.getElectionActivationStatus(token , function(response) {				
    					$rootScope.electiondaystatus=response.result.status;
    				});	
    			}                
                
            });

            $scope.isActive = function (viewLocation) {
                return viewLocation === $location.path();
            };
            
            $scope.logout = function () {
            	loginService.logout();
            };
            $rootScope.cui_blocker = function (start) {
            	if(start){
            		$('#cui_blocker').removeClass('loaded').addClass('cui_opacity');            		
            	}
            	else{
            		$('#cui_blocker').removeClass('cui_opacity').addClass('loaded');         		
            	}     		
            		
            }
            
            /* Regex 
             * Adding validations to forms
             */
        	$rootScope.regex = {
        			words : /^[a-zA-Z][0-9A-Za-z_ ]+$/,
        			address : /^[a-zA-Z0-9][0-9A-Za-z-, ]+$/,
        			email : /\S+@\S+\.\S+/,
        			phone : /^[0-9()-]+$/,
        			number : /[0-9]/,
        			description : /^[0-9A-Za-z,!$&_+|@:)(;.\\s ]+$/
        		};

            //$rootScope.$watch(function () { return connectionStatus.isOnline; }, function (newVal, oldVal) {
            //    $rootScope.isOnline = newVal;
            //});

        }]);
