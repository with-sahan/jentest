angular.module('newApp').controller('mainCtrl',
    ['$scope', 'applicationService', 'quickViewService', 'builderService', 'pluginsService', '$location','mdl.mobileweb.service.login','$rootScope','connectionStatus',
        function ($scope, applicationService, quickViewService, builderService, pluginsService, $location, loginService, $rootScope, connectionStatus) {
            $(document).ready(function () {
                applicationService.init();
                quickViewService.init();
                builderService.init();
                pluginsService.init();
                Dropzone.autoDiscover = false;
            });

            $rootScope.isOnline = true;

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

            });

            $scope.isActive = function (viewLocation) {
                return viewLocation === $location.path();
            };
            
			var token = loginService.getAccessToken();	
			if((typeof token !== 'undefined' && token !== null && token.length>0)){
				loginService.org_info(token , function(response) {				
					$rootScope.logourl=response.logourl;
					$rootScope.organization=response.organization;
					$rootScope.userfullname=response.userfullname;
				});	
			}
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

            $rootScope.$watch(function () { return connectionStatus.isOnline; }, function (newVal, oldVal) {
                $rootScope.isOnline = newVal;
            });
        }]);
