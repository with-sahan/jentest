/***
 * Project: MDL Dashboard
 * Modified by: Ashan Perera
 * 
 */
angular.module('newApp').controller('mainCtrl',
    ['$scope', 'applicationService', 'quickViewService', 'builderService', 'pluginsService', '$location','mdl.mobileweb.service.login','$rootScope','$route',
        function ($scope, applicationService, quickViewService, builderService, pluginsService, $location,loginService,$rootScope,$route) {
            
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
    			var token = loginService.getAccessToken();	
    			if((typeof token !== 'undefined' && token !== null && token.length>0)){
    				loginService.org_info(token , function(response) {				
    					$rootScope.userfullname=response.userfullname;
    					$rootScope.organization=response.organization;
    					$rootScope.logourl = response.logourl;
    					loginService.setUserRoleId(response.roletype);
    					$rootScope.roleId = response.roletype;
    	            	if($rootScope.roleId=="4")
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
            
            
            /* Define Access Rules  */
            $rootScope.accessObj = [];
            $rootScope.accessObj['2'] = ["login", "dashboard-summary", "trackprogress", "all_issues", "notifications", "ballotaccount", "analytics", "psichecklist"];         
            $rootScope.accessObj['3'] = ["login", "dashboard-summary", "all_issues", "notifications", "analytics", "psichecklist"];
            $rootScope.accessObj['4'] = ["login", "all_issues"];
            $rootScope.accessObj['5'] = ["login", "dashboard-summary", "ballotaccount", "analytics"];  
            $rootScope.accessObj['7'] = ["login", "dashboard-summary", "trackprogress", "all_issues", "notifications", "ballotaccount", "analytics", "admin"]; 
            
            $rootScope.checkAccess = function(cur_url) {            	
                $rootScope.roleId = loginService.getUserRoleId();
                if ($rootScope.roleId) {                    	
                	var accessList = $rootScope.accessObj[$rootScope.roleId];
                	if(cur_url.length==0)
                		cur_url = "analytics";
                	if(accessList.indexOf(cur_url) != -1){
                			return true;
                	}                      	
                	
                }   
                return false; 
            }            	
            
        }]);
