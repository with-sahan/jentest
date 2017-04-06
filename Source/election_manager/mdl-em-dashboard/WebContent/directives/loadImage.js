angular.module('newApp')
.directive('loadImage', ['$http', '$timeout', 'mdl.mobileweb.service.jwt', 'settings',
        function ($http, $timeout, jwtService, settings) {
            return {
                restrict: 'A',
                scope: {
                    'imagePath': '=loadImage'
                },
                link: function (scope, elem, attrs) {
                    var imageSource = settings.dowloadUrl + scope.imagePath;
                    var config = {
                        headers: {
                            'Authorization': "Bearer " + jwtService.getToken()
                        }
                    };
                    $http({
             						method: 'GET',
             						url: imageSource,
             						params: config,
             						responseType: 'arraybuffer'
             				}).success(function(data, status, headers) {
             						try {
                          var blob = new Blob([data],{type:'image/png'});
                          $(elem).find('a').first().attr('href', window.URL.createObjectURL(blob));
             						} catch (ex) {
             								console.log(ex);
             						}
             				}).error(function(data) {
             						console.log(data);
             				});
                }

            }
        }])
;