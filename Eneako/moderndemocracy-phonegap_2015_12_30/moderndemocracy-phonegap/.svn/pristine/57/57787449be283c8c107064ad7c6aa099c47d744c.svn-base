'use strict';

//---------------------------------------------------------------------
// NAMESPACE DECLARATIONS
//---------------------------------------------------------------------
var $APP = $APP || {}; // App namespace
var $UTL = $UTL || {}; // Utilities namespace


//---------------------------------------------------------------------
// AUTH SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('Auth', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	'localStorageService',
	function($http, $location, $state, $rootScope, localStorageService) {

		//var accessLevels = routingConfig.accessLevels, userRoles = routingConfig.userRoles,
		var currentUser = {
			username: '',
			role: 0 	//userRoles.pub
		};

		function randomStr(){
		    var text = "";
		    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

		    for( var i=0; i < 5; i++ )
		        text += possible.charAt(Math.floor(Math.random() * possible.length));

		    return text;
		}

		function changeUser(user) {
			_.extend(currentUser, user);

			// Save user info to settings cache
			localStorageService.set("user", user);
		}

		function setUser(user) {
			console.log("Auth.setUser - recieved info %o", user);

			// Save user info to cache
			localStorageService.set("user", user);
			// Put into root scope for easy access
			$rootScope.userInfo = user;
		}

		return {
			/*authorize: function(accessLevel, role) {
				if(role === undefined) {
					role = currentUser.role;
					//if(!role)
					//	role = userRoles.pub;
				}
				return accessLevel.bitMask & role.bitMask;
			},*/
			init: function(accessLevel) {
				$http.get($APP.server + '/api/me', {withCredentials: true, cache: false}).success(function(user) {
					console.log("Auth.init success");


					setUser(user);

					$rootScope.online = true;
					$rootScope.logopath = user.councilLogoUrl;
//////////////////////////////////////////////////
					//HOT FIX
					 $rootScope.currentPollingStation = user.pollingStationName;


					$location.path('/app/home');
				}).error(function(data, status, headers, config) {
					console.log("Auth.init error: %o", data);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					} else {
						$location.path('/login');
					}
				});
			},
			reload: function(callback) {
				var rand = randomStr();
				$http.get($APP.server + '/api/me?'+rand, {withCredentials: true, cache: false}).success(function(user) {
					setUser(user);
					$rootScope.logopath = user.councilLogoUrl;

					if(callback) {
						callback(user);
					}
				})
				.error( function(data, status, headers, config) {
					// alert("API ME ERROR xxxx" + $APP.server );
					// alert("API ME data xxxx" + data );
					// alert("API ME status xxxx" + status );
					// alert("API ME headers xxxx" + headers );
					// alert("API ME config xxxx" + config );
					//$location.path('/login');
					console.log("/api/me Error %o", data);
					console.log("/api/me Error %o", status);
					console.log("/api/me Error %o", headers);
					console.log("/api/me Error %o", config);
				});
			},
			//isLoggedIn: function(user) {
			//	if(user === undefined)
			//		user = currentUser;
			//	return user.role.title == userRoles.user.title || user.role.title == userRoles.advisor.title || user.role.title == userRoles.superuser.title;
			//},
			isLoggedInWithCallback: function() {
				var loggedIn = this.isLoggedIn;
				$http.get($APP.server + '/api/me', {withCredentials: true, cache: false}).success(function(user) {
					setUser(user);
					if(loggedIn()) {
						if($location.path() == '/login') {
							$location.path(document.referrer);
						}
					}
					else {
						$location.path('/login');
					}
					//deferred.resolve(user);
				}).error(function(data, status, headers, config) {
					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			},
			login: function(user, success, error) {
				console.log("Auth.login - sending info = %o", user);
				$http({
					method: 'POST',
					url: $APP.server + '/pub/login',
					withCredentials: true,
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded',
						'Accept': 'application/json;odata=verbose'
					},
					transformRequest: function(obj) {
						return 'login.user.name=' + user.username + '&login.user.password=' + user.password + '&user=true';
					},
					data: user
				}).success(function(user) {
					setUser(user);
					success(user.data);
					$rootScope.logopath = user.councilLogoUrl;
//////////////////////////////////////////////////
					//HOT FIX
					 $rootScope.currentPollingStation = user.pollingStationName;
				}).error(function(data, status) {
					error(data, status)
				});
			},
			logout: function(success, error) {
				$http.post($APP.server + '/api/logout', {withCredentials: true}).success(function() {
					setUser({
						id: null,
						username: '',
						role: 0
					});
					success();
				}).error(error);
			},
			//accessLevels: accessLevels,
			//userRoles: userRoles,
			user: currentUser
		};
	}
])


angular.module('starter').factory('ForbiddenInterceptor', [
	'$location',
	function($location) {
		return {
			responseError: function(rejection) {
				if(rejection.status === 403 && $location.path() != '/login'){
					$location.path('/login');
				}
				return rejection;
			}
		}
	}
]);


//---------------------------------------------------------------------
// OPEN STATION SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('OpenStation', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	function($http, $location, $state, $rootScope) {

		return {

			getCheckList: function(id, successCallback, errorCallback) {
				// Get list for checkboxes
				$http.get($APP.server + '/api/stationopen/' + id, {withCredentials: true, cache: false})
				.success(function(response) {
					successCallback( response );
				})
				.error( function( data, status, headers, config) {
					errorCallback( data );
				});
			},

			submit: function(id, data, successCallback, errorCallback) {

				$http.post(
					$APP.server + '/api/stationopen/' + id,
					data,
					{ withCredentials: true })
				.success(function(response) {

					console.log("OpenStation.submit success");

					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					console.log("OpenStation.submit error: %o", responseData);

					errorCallback(responseData);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			}
		};
	}
])

//---------------------------------------------------------------------
// CLOSE STATION SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('CloseStation', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	function($http, $location, $state, $rootScope) {

		return {

			submit: function(data, successCallback, errorCallback) {

				$http.post(
					$APP.server + '/api/stationclose',
					data,
					{ withCredentials: true })
				.success(function(response) {

					console.log("CloseStation.submit success");

					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					console.log("CloseStation.submit error: %o", responseData);

					errorCallback(responseData);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			}
		};
	}
])

//---------------------------------------------------------------------
// STATION PROGRESS SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('StationProgress', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	function($http, $location, $state, $rootScope) {

		return {

			get: function( successCallback, errorCallback) {
				// Get postal packdata
				$http.get($APP.server + '/api/stationprogress', {withCredentials: true, cache: false})
				.success(function(response) {
					successCallback( response );
				})
				.error( function( data, status, headers, config) {
					errorCallback( data );
				});
			},

			submit: function(data, successCallback, errorCallback) {

				$http.post(
					$APP.server + '/api/stationprogress',
					data,
					{ withCredentials: true })
				.success(function(response) {

					console.log("StationProgress.submit success");

					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					console.log("StationProgress.submit error: %o", responseData);

					errorCallback(responseData);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			}
		};
	}
])

//---------------------------------------------------------------------
// REPORT ISSUE SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('ReportIssue', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	function($http, $location, $state, $rootScope) {

		return {

			submit: function(data, successCallback, errorCallback) {

				$http.post(
					$APP.server + '/api/issueopen',
					data,
					{ withCredentials: true })
				.success(function(response) {

					console.log("ReportIssue.submit success");

					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					console.log("ReportIssue.submit error: %o", responseData);

					errorCallback(responseData);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			}
		};
	}
])


//---------------------------------------------------------------------
// TRACKING SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('Tracking', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	function($http, $location, $state, $rootScope) {

		return {

			submit: function(data, successCallback, errorCallback) {

				$http.post(
					$APP.server + '/api/trackingsend',
					data,
					{ withCredentials: true })
				.success(function(response) {

					console.log("Tracking.submit success");
					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					console.log("Tracking.submit error: %o", responseData);

					errorCallback(responseData);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			}
		};
	}
])

//---------------------------------------------------------------------
// UPDATE POLLING STATION SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('UpdateStation', [
	'$http',
	'$state',
	'$rootScope',
	function($http, $state, $rootScope) {

		return {

			submit: function(data, successCallback, errorCallback) {

				$http.post(
					$APP.server + '/api/updateuserstation',
					data,
					{ withCredentials: true })
				.success(function(response) {

					console.log("updatePS.submit success");
					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					console.log("updatePS.submit error: %o", responseData);

					errorCallback(responseData);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			}
		};
	}
])

//---------------------------------------------------------------------
// ACCOUNTS SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('Accounts', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	function($http, $location, $state, $rootScope) {

		return {

			get: function(id, successCallback, errorCallback) {

				$http.get(  // it will probably be get, not post
					$APP.server + '/api/ballotpaperaccount/' + id,
					{ withCredentials: true })
				.success(function(response) {

					console.log("Accounts.get success");

					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					console.log("Accounts.get error: %o", responseData);

					errorCallback(responseData);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			}
		};
	}
])



//TO DO: get everything on the same notation -> it's notifications, not messages
//---------------------------------------------------------------------
// MESSAGES SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('Messages', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	function($http, $location, $state, $rootScope) {

		return {
			get : function(){

				 	return [
				    {'createdOn': 1427727162000,
				     'text': 'A brand new notification',
				     'status' : true,
					'id' : '5',
					'stationId' : 5},
				    {'createdOn': 1427727182000,
				     'text': 'Urgent response needed',
				     'status' : false,
					'id' : '6',
					'stationId' : 5},
				    {'createdOn': 1427727152000,
				     'text': 'All is good',
				     'status' : false,
					'id' : '7',
					'stationId' : 5}
					  ];
				},
			retrieve : function (successCallback, errorCallback) {

				$http.get(
					$APP.server + '/api/notificationlist',
					//data,
					{ withCredentials: true })
				.success(function(response) {

					console.log("notifications.get success");

					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					console.log("notifications.get error: %o", responseData);

					errorCallback(responseData, status);

					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});


			//end retireve
			},
			statusUpdate : function(data, successCallback, errorCallback){

					$http.put(
						$APP.server + '/api/notificationstatusupdate',
						data,
						{ withCredentials: true })
					.success(function(response) {

						console.log("notifications.status.put success");
						console.log(JSON.stringify(response));

						$rootScope.online = true;
						successCallback(response);

					}).error(function(responseData, status, headers, config) {
						console.log("notifications.status.put error: %o", responseData);

						errorCallback(responseData);

						if(status == 403) {
							$location.path('/login');
						}
						else if(status == 502) {
							// service down
							$rootScope.online = false;
						}

					});
			}

		};
	}
])

//---------------------------------------------------------------------
// PHOTO SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('Photo', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	'$q',
	function($http, $location, $state, $rootScope, $q) {
		return {
		    getPicture: function(options) {
		      var q = $q.defer();
		      navigator.camera.getPicture(function(result) {
				q.resolve(result);
		      }, function(err) {
				q.reject(err);
		      }, options);
		      return q.promise;
		    }
		}
	}
])


//---------------------------------------------------------------------
// NOTIFICATION SERVICE
//---------------------------------------------------------------------
angular.module('starter').factory('Notification', [
	'$http',
	'$location',
	'$state',
	'$rootScope',
	function($http, $location, $state, $rootScope) {

		return {

			getNotifications: function(successCallback, errorCallback) {

				$http.get($APP.server + '/api/notificationretrieve', {withCredentials: true, cache: false})
				.success(function(response) {

					//console.log("Notification.getNotifications success");
					$rootScope.online = true;
					successCallback(response);

				}).error(function(responseData, status, headers, config) {
					//console.log("Notification.getNotifications error: %o", responseData);

					errorCallback(responseData);
					console.log(status);
					if(status == 502) {
						// service down
						$rootScope.online = false;
					}
				});
			},
			statusUpdate: function(data, successCallback, errorCallback){

					$http.put(
						$APP.server + '/api/notificationstatusupdate',
						data,
						{ withCredentials: true })
					.success(function(response) {

						console.log("notifications.status.put success");
						console.log(JSON.stringify(response));

						$rootScope.online = true;
						successCallback(response);

					}).error(function(responseData, status, headers, config) {
						console.log("notifications.status.put error: %o", responseData);

						errorCallback(responseData);

						if(status == 403) {
							$location.path('/login');
						}
						else if(status == 502) {
							// service down
							$rootScope.online = false;
						}

					});
			}
		};
	}
]);