angular.module('starter.directives', [])
.directive('pollingStations', [
	'$rootScope',
	'$timeout',
	function($rootScope, $timout) {
		return {
			restrict: 'E',
			scope: {
				change: '=?',
				data: '=',
				inline: '=?',
				disable: '@?'
			},
			replace: true,
			templateUrl: 'templates/directives/polling-stations.html',
			link: function ($scope, $elem, $attr) {
				if(typeof $scope.inline === 'undefined') {
					$scope.inline = true;
				}
				$scope.$watch('disable', function(data) {
					if(data) {
						if($scope.disable) {
							var allDisabled = 0;
							angular.forEach($scope.data.pollingStations, function(data, i) {
								if($scope.disable == 'opened') {
									$scope.data.pollingStations[i].disabled = data.status;
								}
								else {
									$scope.data.pollingStations[i].disabled = !data.status;
								}

								if($scope.data.pollingStations[i].disabled) {
									allDisabled++;
								}
							});
							if(allDisabled == $scope.data.pollingStations.length) {
								$scope.data.pollingStations[0].name = 'All stations are already ' + $scope.disable;
							}
							else {
								if($scope.data.pollingStations.length) {
									for(var i in $scope.data.pollingStations) {
										if(!$scope.data.pollingStations[i].disabled) {
											$scope.data.station = $scope.data.pollingStations[i];
											break;
										}
									};
								}
							}
						}
						else {
							$scope.data.station = $scope.data.pollingStations[0];
						}
					}
					else {
						$scope.data.station = $scope.data.pollingStations[0];
					}
				});
				$scope.pollingStations = [];
				$rootScope.$watch('userInfo', function(newValue, oldValue) {
					if(newValue && $scope.data) {
						$scope.data.pollingStations = newValue.pollingStations;
					}
				});
				$scope.onChange = function() {
					if($scope.change) {
						$scope.change();
					}
				};
			}
		}
	}
]);