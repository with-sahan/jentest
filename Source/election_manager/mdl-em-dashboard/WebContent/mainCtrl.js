/***
 * Project: MDL Dashboard
 * Modified by: Ashan Perera
 * 
 */
angular.module('newApp').controller('mainCtrl',
    ['$scope', 'applicationService', 'quickViewService', 'builderService', 'pluginsService', '$location', 'mdl.mobileweb.service.login', '$rootScope', '$route', 'toaster', 'mdl.mobileweb.service.jwt',
        function ($scope, applicationService, quickViewService, builderService, pluginsService, $location, loginService, $rootScope, $route, toaster, jwtService) {
         $rootScope.HideWaitingMsg = true;   
    	$rootScope.classFromController = ""; //You can add class for .main-content -> .page-content per controller i.e /all_issues
    	
    		$(document).ready(function () {
                applicationService.init();
                quickViewService.init();
                builderService.init();
                pluginsService.init();
                Dropzone.autoDiscover = false;
                //$('.nav.nav-sidebar .nav-parent').addClass('nav-active active');
            });
            
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
                
                if(($location.$$path == "/" && !$rootScope.roleId) || !$rootScope.userfullname){
                	$rootScope.getOrgInfo();                    	
                }

            });

            $scope.isActive = function (viewLocation) {
                return viewLocation === $location.path();
            };
            

            $scope.logout = function () {      
            	loginService.logout();
            };
            
            $rootScope.getOrgInfo =  function() {

                if (jwtService.hasValidToken()) {
                    loginService.org_info("", function (response) {
                        $rootScope.userfullname = response.userfullname;
                        $rootScope.organization = response.organization;
                        $rootScope.logourl = (response.logourl.length > 0 ? response.logourl : 'sandwell.png');
                        //loginService.setUserRoleId(response.roletype);
                        $rootScope.roleId = response.roletype;
                        if ($rootScope.roleId == 1) {//Restrict access for PO  (MD -659) [Ashan 19/05/16]
                            toaster.pop("error", "Access Denied", "PO has no access previledges for EM");
                            $scope.logout();
                        }
                        if ($rootScope.roleId == "4")
                            $location.path('/all_issues');
                    });
                }
                else
    				$location.path('/login');
    				
            };
            
            
            $rootScope.cui_blocker = function (start) {
            	if(start){
            		$('#cui_blocker').removeClass('loaded').addClass('cui_opacity');            		
            	}
            	else{
            		$('#cui_blocker').removeClass('cui_opacity').addClass('loaded');         		
            	}     		
            		
            }
            
            /*$rootScope.$watch(function () { return connectionStatus.isOnline; }, function (newVal, oldVal) {
                $rootScope.isOnline = newVal;
            });*/
            
            
            /* Regex 
             * Adding validations to forms
             */
			$rootScope.regex = {
				words : /^[a-zA-Z][0-9A-Za-z_ ]+$/,
				address : /^[a-zA-Z0-9][0-9A-Za-z-, ]+$/,
				email : /\S+@\S+\.\S+/,
				phone : /^[0-9()-]+$/,
				number : /[0-9]/,
				description : /^[0-9A-Za-z,!$&_+|@:)(;.\\s \n]+$/,
				name : /^[a-zA-Z][A-Za-z_]+$/
			};
            
        }]);
