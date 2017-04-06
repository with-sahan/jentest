//---------------------------------------------------------------------
// NAMESPACE DECLARATIONS
//---------------------------------------------------------------------
var $APP = $APP || {}; // App namespace
var $UTL = $UTL || {}; // Utilities namespace


angular.module('starter.controllers', [])

.controller('AppCtrl', [
	'$scope',
	'$rootScope',
	'$interval',
	'Notification',
	'$ionicModal',
	'$ionicLoading',
	'$ionicPopup',
	'localStorageService',
	'$state',

	function($scope, $rootScope, $interval, Notification, $ionicModal, $ionicLoading, $ionicPopup, localStorageService, $state) {


		/////////////////////////////////////////
		//Network Connectivity connection errors
		$scope.mytimer = Date.now();
		$rootScope.checkConnection = function() {
			if (navigator.connection == undefined) {
				return true;
			}
			var states = {};
			states[Connection.UNKNOWN] = 'Unknown connection';
			states[Connection.ETHERNET] = 'Ethernet connection';
			states[Connection.WIFI] = 'WiFi connection';
			states[Connection.CELL_2G] = 'Cell 2G connection';
			states[Connection.CELL_3G] = 'Cell 3G connection';
			states[Connection.CELL_4G] = 'Cell 4G connection';
			states[Connection.CELL] = 'Cell generic connection';
			states[Connection.NONE] = 'No network connection';
			console.log('Connection type: ' + states[navigator.connection.type]);
			if (navigator.connection.type == Connection.NONE) {
				return false;
			} else {
				return true;
			}
		};

		/////////////////////////
		//Serious stuff
		$scope.buildNumber = $APP.buildNumber;

		////////////////////////////
		//Check it
		$scope.checkForNotifications = function() {

			//if no connection, return
			if (!$rootScope.checkConnection()) {
				console.log("Not checking for notifications - no connection available, returning");
				return;
			}

			//if no user, return
			if ($rootScope.userInfo == undefined || $rootScope.userInfo.id == null) {
				console.log("Not checking for notifications - no user available, returning");
				return;
			}

			//if not on the right screen, return
			if ($state.current.name == "login" || $state.current.name == "app.logout" || $state.current.name == "app.switchPS") {
				console.log("Not checking for new notifications on " + $state.current.name + ", returning");
				return;
			}

			//console.log("Checking for notifications - " + Date.now() );
			// console.log( "last timer was before " + (Date.now() - $scope.mytimer) + " milisecs");
			$scope.mytimer = Date.now();


			Notification.getNotifications(
				function(response) {
					// Success


					if (response) {
						console.log("Notification received - %o", response);

						//check does the respone has the required fields
						if (response[0].id == undefined || response[0].datetime == undefined || response[0].private == undefined) {
							return;
						}

						//if the length of notificationData is too big, something is wrong; clear the data and continue with the freshly recieved notif
						if ($rootScope.notificationData.length >= $APP.mdConfig.notifDataLengthCheck) {
							$rootScope.notificationData = [];
						}

						//Beep and vibrate
						if (navigator.notification) {
							navigator.notification.beep($APP.mdConfig.notifTimesToBeep);
						}
						if (navigator.vibrate) {
							navigator.vibrate($APP.mdConfig.notifVibrateMilisecs);
						}

						if ($rootScope.notificationData == undefined || $rootScope.notificationData.length > 0) {
							console.log("NotificationData $o", $rootScope.notificationData);
							console.log("About to merge $o", response);
							//Add status field if missing
							//if(!response.status) {response.LocalStatus = true; console.log('xin')}
							// Concat to previous data
							$rootScope.notificationData = $rootScope.notificationData.concat(response);
							//console.log("New notifications merged with old: %o", $scope.notificationData);
						} else {
							//if(!response.status) {response.status = true; console.log('fin')}
							$rootScope.notificationData = response;
						}
						console.log('opening modal');
						if (!$rootScope.newModal.isShown()) {
							$rootScope.newModal.show();
						}



					}
				},
				function(err) {
					// Error
					console.log("Error checking notifications");
					console.log(JSON.stringify(err));
					//console.log(window.myModalTemplate);
				});
		};

		//Cleanup the modal when we're done with it!

		$rootScope.destroyNewModal = function() {
			$rootScope.notificationData = [];
			$rootScope.newModal.hide();
		}



		$scope.$on('$destroy', function() {
			console.log('destroy!');
			$rootScope.newModal.remove();
			$rootScope.notificationData = [];
			//Clean it up here also, just to be sure.
			$interval.cancel($rootScope.notificationTimer);
			$rootScope.notificationTimer = undefined;
			//we'll remove the modal as it seems removing it could cause momory leaks.
			//https://github.com/driftyco/ionic/issues/2777
			//http://forum.ionicframework.com/t/cannot-call-modal-show-after-remove-please-create-a-new-modal-instance/19802

		});

		// Execute action on hide modal
		$scope.$on('modal.hidden', function() {
			// Execute action
			console.log('modal hidden');
		});
		// Execute action on remove modal
		$scope.$on('modal.removed', function() {
			// Execute action
			console.log('modal removed!');

		});

		///////////////////////////////////////
		//Acknowledge reception of notification
		$rootScope.AcknowledgeFromModal = function(id) {
			//  console.log(id + '-' +stationId );
			//id of the acknowledge message; erfer to MESSAGE service for data format.

			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;
					// Get out!!!
					$location.path("/app/home");
				});

			};
			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}
			Notification.statusUpdate({
					"notificationId": id,
					"status": 1
				},
				function(data) {
					console.log(data);
					localStorageService.set("notif" + $rootScope.currentPollingStation + id, 'true');
				},
				function(err) {
					console.log(err);
				})

		};

		///////////////////////////////////////
		//Downlad attach if any
		$rootScope.DownloadFromModal = function(filename) {

			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;
					// Get out!!!
					$location.path("/app/home");
				});

			};
			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}
			$ionicLoading.show({
				template: $APP.mdConfig.popups.loading
			});
			var fileTransfer = new FileTransfer();
			var uri = encodeURI($APP.server + "/uploads/" + filename);
			var filePath = cordova.file.externalRootDirectory + "/Documents/" + filename
			fileTransfer.download(
				uri,
				filePath,
				function(entry) {
					$ionicLoading.hide();
					console.log("download complete: " + entry.fullPath);
					window.plugins.fileOpener.open(filePath);
				},
				function(error) {
					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleDownErr,
						content: $APP.mdConfig.popups.downloadErr
					}).then(function(rest) {
						$scope.popupOpen = false;
					});
					console.log("download error source " + error.source);
					console.log("download error target " + error.target);
					console.log("upload error code" + error.code);
				},
				false, {}
			);



		}



		// Start notification checking loop.
		// This will fail when not logged in.

		// Enable notification loop
		if (!angular.isDefined($rootScope.notificationTimer)) {
			console.log('its undefined - starting timer');
			$rootScope.notificationTimer = $interval($scope.checkForNotifications, $APP.mdConfig.notifInterval);
		} else {
			//This should never happen as we're destroying the interval on the $destroy event, but better safe than sorry. Those tricky little intervals.
			console.log('its defined - stopping and restarting timer');
			$interval.cancel($rootScope.notificationTimer);
			$rootScope.notificationTimer = undefined;
			$rootScope.notificationTimer = $interval($scope.checkForNotifications, $APP.mdConfig.notifInterval);
		}
		$rootScope.notificationData = [];
		$rootScope.newModal = $ionicModal.fromTemplate(window.myModalTemplate, {
			scope: $rootScope,
			backdropClickToClose: false,
			hardwareBackButtonClose: false
		});
	}
])



/*
 *
 *    LOGIN CONTROLLER
 *
 */
.controller('LoginCtrl', [

	'$scope',
	'$location',
	'Auth',
	'$ionicPopup',
	'$ionicLoading',
	'$ionicPlatform',
	'$state',

	function($scope, $location, Auth, $ionicPopup, $ionicLoading, $ionicPlatform, $state) {

		// Disable BACK button on login
		$ionicPlatform.registerBackButtonAction(function(event) {
			if ($state.current.name == "login") {
				//navigator.app.exitApp();
				console.log("back pressed " + $state.current.name)
			} else {
				// allow back button on all other screens
				navigator.app.backHistory();
			}
		}, 1000);

		//repeating this here as we don't want to have rootscope on login screen due the intervals and modals cleanups and stuffs
		$scope.checkConnectionOnLogin = function() {
			if (navigator.connection == undefined) {
				return true;
			}
			if (navigator.connection.type == Connection.NONE) {
				return false;
			} else {
				return true;
			}
		};

		$scope.rememberme = true;
		$scope.username = "";
		$scope.password = "";
		$scope.popupOpen = false;

		$scope.login = function() {



			//Do we have a connection?
			if (!$scope.checkConnectionOnLogin()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			};

			//Get out
			if (!$scope.checkConnectionOnLogin()) {
				return;
			}



			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingLogIn
			});

			Auth.login({
				username: $scope.username,
				password: $scope.password,
				rememberme: $scope.rememberme
			}, function(res) {
				console.log("Login success");
				$ionicLoading.hide();
				//after login it's neccesary to choose polling station
				$location.path("/app/home");

			}, function(err) {

				$ionicLoading.hide();



				if (!$scope.popupOpen) {
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleLoginErr,
						content: $APP.mdConfig.popups.validUserName
					}).then(function(rest) {
						$scope.popupOpen = false;
					});
				}
				//$rootScope.error = 'Failed to login';
			});
		};
		//this looks unused, but we'll leave it for history reasons
		$scope.fakeLogin = function() {
			console.log("Login Pressed");
			$location.path("/app/confirmuserassignment");
		};
	}
])



/*
 *
 *    LOGOUT CONTROLLER
 *
 */
.controller('LogoutCtrl', [
	'$scope',
	'$location',
	'Auth',
	'$ionicLoading',
	'$rootScope',
	'$ionicPopup',
	'$ionicLoading',
	function($scope, $location, Auth, $ionicLoading, $rootScope, $ionicPopup, $ionicLoading) {

		$scope.logout = function() {

			//Do we have a connection?
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}


			console.log("Logging out...");
			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingLogOut
			});
			Auth.logout(function() {
				$ionicLoading.hide();
				$location.path("/login");
			});
		};
	}
])



/*
 *
 *    HOME CONTROLLER
 *
 */
.controller('HomeCtrl', [
	'$scope',
	'$location',
	'$rootScope',
	'Auth',
	function($scope, $location, $rootScope, Auth) {
		Auth.reload(function(user) {
			// Success
			$rootScope.userInfo = user;
			//console.log($rootScope.userInfo.pollingStationName);
		});

	}
])


/*
 *
 *    ACCOUNTS CONTROLLER
 *
 */
.controller('AccountsCtrl', [
	'$scope',
	'$location',
	'$ionicPopup',
	'$ionicLoading',
	'Accounts',
	'$rootScope',
	function($scope, $location, $ionicPopup, $ionicLoading, Accounts, $rootScope) {

		// Payload and model
		$scope.data = {
			ordinary: {},
			tendered: {},
			station: null,
			pollingStations: null
		};

		// Calculations
		$scope.recalculate = function() {
			// Make everything integer
			$scope.data.ordinary.totalIssued = 0 || parseInt($scope.data.ordinary.totalIssued);
			$scope.data.ordinary.numberOfReplacements = 0 || parseInt($scope.data.ordinary.numberOfReplacements);
			$scope.data.ordinary.totalUnused = 0 || parseInt($scope.data.ordinary.totalUnused);
			$scope.data.tendered.totalIssued = 0 || parseInt($scope.data.tendered.totalIssued);
			$scope.data.tendered.totalSpoilt = 0 || parseInt($scope.data.tendered.totalSpoilt);
			$scope.data.tendered.totalUnused = 0 || parseInt($scope.data.tendered.totalUnused);

			// Calculation
			$scope.data.ordinary.calcIssuedAndNotSpoilt = $scope.data.ordinary.totalIssued - $scope.data.ordinary.numberOfReplacements;
			if (isNaN($scope.data.ordinary.calcIssuedAndNotSpoilt)) $scope.data.ordinary.calcIssuedAndNotSpoilt = 0;
		}

		//$scope.recalculate();
		//Let's get the data needed
		//Do we have a connection?
		if (!$rootScope.checkConnection()) {
			//close if any are open
			$scope.popupOpen = false;
			$ionicLoading.hide();
			//display the message
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
				content: $APP.mdConfig.popups.noConnection
			}).then(function(rest) {
				$scope.popupOpen = false;
				$location.path("/app/home");
			});

		} else {

			$scope.$watch('data.station', function(station) {
				if(station) {
					Accounts.get(station.id,
						function(res) {

							// Success
							/* res should look something like this:
						      "{"stationId":2,
						      "stationName":"DN0108/1",
						      "placeId":5,
						      "ballotPapersIssued":553,
						      "postalPacksReceived":158,
						          "totalOrdinaryIssued":0,
						          "numberOfReplacements":0,
						          "calcIssuedAndNotSpoilt":0,
						          "totalOrdinaryUnused":0,
						          "totalTenderedIssued":0,
						          "totalSpoilt":0,
						          "totalTenderedUnused":0,
						      "eta":0,
						      "ballot_box_number":"2",
						      "stationOpen":false}"
						      */
							$scope.data.ordinary.totalIssued = res.totalOrdinaryIssued;
							$scope.data.ordinary.numberOfReplacements = res.numberOfReplacements;
							$scope.data.ordinary.totalUnused = res.totalOrdinaryUnused;
							$scope.data.tendered.totalIssued = res.totalTenderedIssued
							$scope.data.tendered.totalSpoilt = res.totalSpoilt;
							$scope.data.tendered.totalUnused = res.totalTenderedUnused;
							$scope.data.ordinary.calcIssuedAndNotSpoilt = res.calcIssuedAndNotSpoilt;

							$ionicLoading.hide();
							//$scope.recalculate();
						},
						function(err) {
							// Error
							console.log(err);
							$ionicLoading.hide();
							$scope.popupOpen = true;
							$ionicPopup.alert({
								title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
								content: $APP.mdConfig.popups.accountsErr
							}).then(function(rest) {
								$scope.popupOpen = false;

								//Remove this when the server api is implemented! For now let's put fake data here cause the server ain't working now.!
								//$scope.recalculate();
							});
						}
					);
				}
			});

			//else end
		}

	}
])


/*
 *
 *    SwitchPS CONTROLLER
 *
 */
.controller('SwitchPSCtrl', [
	'$scope',
	'$location',
	'$rootScope',
	'$http',
	'Auth',
	'UpdateStation',
	'$ionicPopup',
	'$ionicLoading',
	'localStorageService',
	function($scope, $location, $rootScope, $http, Auth, UpdateStation, $ionicPopup, $ionicLoading, localStorageService) {
		//Check network connection
		//Do we have a connection?
		if (!$rootScope.checkConnection()) {
			//close if any are open
			$scope.popupOpen = false;
			$ionicLoading.hide();
			//display the message
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
				content: $APP.mdConfig.popups.noConnection
			}).then(function(rest) {
				$scope.popupOpen = false;
				//get out!
				navigator.app.backHistory();
			});

		};


		Auth.reload(function(user) {
			// Success
			$rootScope.userInfo = user;

			$rootScope.betterStations = {};
			$scope.stations = $rootScope.userInfo.pollingStations;
			$rootScope.betterStations = $rootScope.userInfo.pollingStations;
			console.log(JSON.stringify($rootScope.betterStations));
			angular.forEach($scope.betterStations, function(value, key) {
				$rootScope.betterStations[key].psCODE = $rootScope.betterStations[key].name
				$rootScope.betterStations[key].name = $rootScope.userInfo.pollingPlaceName + ' (' + $rootScope.betterStations[key].name + ')';

			});

			console.log(JSON.stringify($rootScope.betterStations));
			$scope.correctlySelected = $rootScope.betterStations[0];
		});


		$scope.switchPS = function(selectedID, selectedName) {
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}


			console.log(selectedID);
			$scope.datax = {
				stationId: selectedID
			};
			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingSwitch
			});

			UpdateStation.submit($scope.datax, function() {
				// Success
				$rootScope.currentPollingStation = selectedName;
				$rootScope.currentPollingStationID = selectedID;
				//store current polling station id, fix for /api/me cache issues as it returnes the same ps regardless of the switch
				localStorageService.set("currentPollingStationID", selectedID);
				Auth.reload(function(user) {
					// Success
					$rootScope.userInfo = user;
					console.log($rootScope.userInfo.pollingStationName);
				});
				$ionicLoading.hide();
				$location.path("/app/home");
			}, function() {
				// Error

				console.log($rootScope.checkConnection());
				$ionicLoading.hide();
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleServErr,
					content: $APP.mdConfig.popups.switchPsErr
				}).then(function(rest) {
					$scope.popupOpen = false;
				});
			});
		};
	}
])

/*
 *
 *    MESSAGES CONTROLLER
 *
 */
.controller('MessagesCtrl', [
	'$scope',
	'$location',
	'$rootScope',
	'Messages',
	'localStorageService',
	'$ionicLoading',
	'$ionicPopup',
	function($scope, $location, $rootScope, Messages, localStorageService, $ionicLoading, $ionicPopup) {


		Messages.retrieve(
			//success
			function(data) {
				console.log(data.length);
				if (data.length) {
					$scope.messages = data;
				} else {
					return;
				}
				//ugly fix for unimplemented boolean status
				angular.forEach($scope.messages, function(value, key) {
					if (!$scope.messages[key].localStatus) {
						$scope.messages[key].localStatus = true;
						console.log('in')
					}
					if (localStorageService.get("notif" + $rootScope.currentPollingStation + $scope.messages[key].id) == 'true') {
						$scope.messages[key].status = 'Comfirmed';
						console.log('inx')
					};
				});
			},
			//not a success
			function(err, status) {
				//We can handle it
				console.log('error retrieveing notifications')
					//Is it a connection problem?
				if (!$rootScope.checkConnection()) {
					//close if any are open
					$scope.popupOpen = false;
					$ionicLoading.hide();
					//display the message
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
						content: $APP.mdConfig.popups.noConnection
					}).then(function(rest) {
						$scope.popupOpen = false;

					});
					//Nope, it's a server error.
				} else {
					//close if any are open
					console.log(JSON.stringify(status));

					$scope.popupOpen = false;
					$ionicLoading.hide();
					//display the message
					// the server returns 500 when no messages so do nothing for now.
					if (status != 500) {
						$scope.popupOpen = true;
						$ionicPopup.alert({
							title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleServErr,
							content: $APP.mdConfig.popups.notifErr
						}).then(function(rest) {
							$scope.popupOpen = false;

						});
					}
				}
			});

		$scope.Acknowledge = function(id) {
			//	console.log(id + '-' +stationId );
			//id of the acknowledge message; erfer to MESSAGE service for data format.
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			}

			//get out.
			if (!$rootScope.checkConnection()) {
				return;
			}


			Messages.statusUpdate({
					"notificationId": id,
					"status": 1
				},
				function(data) {
					console.log(data);
					localStorageService.set("notif" + $rootScope.currentPollingStation + id, 'true');
				},
				function(err) {
					console.log(err);
					//close if any are open
					$scope.popupOpen = false;
					$ionicLoading.hide();
					//display the message
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleServErr,
						content: $APP.mdConfig.popups.confirmErr
					}).then(function(rest) {
						$scope.popupOpen = false;

					});
				});
		};

		$scope.Download = function(filename) {

			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			}

			//get out.
			if (!$rootScope.checkConnection()) {
				return;
			}

			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingDownload
			});
			var fileTransfer = new FileTransfer();
			var uri = encodeURI($APP.server + "/uploads/" + filename);
			var filePath = cordova.file.externalRootDirectory + "/Documents/" + filename
			fileTransfer.download(
				uri,
				filePath,
				function(entry) {
					$ionicLoading.hide();
					console.log("download complete: " + entry.fullPath);
					window.plugins.fileOpener.open(filePath);
				},
				function(error) {
					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleDownErr,
						content: $APP.mdConfig.popups.downloadErr
					}).then(function(rest) {
						$scope.popupOpen = false;
					});
					console.log("download error source " + error.source);
					console.log("download error target " + error.target);
					console.log("upload error code" + error.code);
				},
				false, {}
			);
		}
	}
])

/*
 *
 *    PHOTO CONTROLLER
 *
 */
.controller('PhotoCtrl', [
	'$scope',
	'$location',
	'$rootScope',
	'$ionicPopup',
	'$ionicLoading',
	'Photo',
	'localStorageService',
	'ThumbnailService',
	function($scope, $location, $rootScope, $ionicPopup, $ionicLoading, Photo, localStorageService, ThumbnailService) {

		//do we have a camera on this device?
		if (!navigator.camera) {
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleDeviceErr,
				content: $APP.mdConfig.popups.camErr
			}).then(function(rest) {
				$scope.popupOpen = false;
			});
		}

		//do we have a connection?
		if (!$rootScope.checkConnection()) {
			//close if any are open
			$scope.popupOpen = false;
			$ionicLoading.hide();
			//display the message
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
				content: $APP.mdConfig.popups.noConnection
			}).then(function(rest) {
				$scope.popupOpen = false;
				$location.path("/app/home");
			});
		};

		$scope.data = {
			station: null,
			pollingStations: null
		};

		//Is the current polling station set yet?
		console.log(localStorageService.get("currentPollingStationID"));
		//if the current ps id is undefined or false, try to get the id from the local storage.
		// if (!$rootScope.currentPollingStationID) {
		// 	$rootScope.currentPollingStationID = localStorageService.get("currentPollingStationID");
		// }
		//if the current ps id is undefined or false yet still, throw the user to the switch ps screen
		// if (!$rootScope.currentPollingStationID) {
		// 	$location.path("/app/home");
		// }

		//Choose a photo from  the device
		$scope.choosePhoto = function() {
			//Do we have a connection?
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}

			var options = {
				quality: $APP.mdConfig.picsJPEGQuality,
				destinationType: 1,
				sourceType: 0,
				encodingType: 0
			};

			Photo.getPicture(options).then(
				// success
				function(imageURI) {
					console.log(imageURI);
					$scope.photoURI = {
						'data': imageURI
					};
					$scope.photoOK = true;
				},
				//error
				function(err) {
					console.log(err);
					$scope.photoOK = false;
				}
			);
		};

		//take a photo with camera
		$scope.takePhoto = function() {

			//Do we have a connection?
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}


			var options = {
				destinationType: 1,
				sourceType: 1,
				encodingType: 0,
				saveToPhotoAlbum: true
			};


			Photo.getPicture(options).then(
				// success
				function(imageURI) {
					console.log(imageURI);
					$scope.photoURI = {
						'data': imageURI
					};
					$scope.photoOK = true;


				},
				//error
				function(err) {
					console.log(err);
					$scope.photoOK = false;
				}
			);
		};

		//reset current photo and choose/take another
		$scope.resetPhoto = function() {
			$scope.photoOK = false;
			$scope.photoURI = null;
		};

		//upload the chosen photo to the server
		$scope.uploadPhoto = function() {


			//Do we have a connection?
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}

			console.log('preparing the photo upload');
			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingUploading
			});

			var options = new FileUploadOptions();

			options.fileName = $rootScope.userInfo.wardName.replace(/ /g, '_') + '_' + $scope.data.station.id + '.jpg'
			options.mimeType = "image/jpeg";
			options.chunkedMode = true;
			options.trustAllHosts = true;
			console.log("new imp: prepare upload now");
			var ft = new FileTransfer();
			ft.upload($scope.photoURI.data, encodeURI($APP.server + "/api/fileupload"), uploadSuccess, uploadError, options, true);

			function uploadSuccess(r) {
				//Image succesfully uploaded, let's store it just in case.
				function movePic(file) {
					window.resolveLocalFileSystemURI(file, resolveOnSuccess, resOnError);
				}

				//Callback function when the file system uri has been resolved
				function resolveOnSuccess(entry) {
					var d = new Date();
					var n = d.getTime();
					//new file name
					var newFileName = n + ".jpg";
					var myFolderApp = $APP.mdConfig.picsFolderName;

					window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fileSys) {
							//The folder is created if doesn't exist
							fileSys.root.getDirectory(myFolderApp, {
									create: true,
									exclusive: false
								},
								function(directory) {
									entry.moveTo(directory, newFileName, successMove, resOnError);
								},
								resOnError);
						},
						resOnError);
				}

				//Callback function when the file has been moved successfully - inserting the complete path
				function successMove(entry) {
					console.log('Photo successfully saved');

				}

				function resOnError(error) {
					alert(error.code);
				}
				//Move it!
				movePic($scope.photoURI.data);

				// handle success like a message to the user
				console.log('uploaded success');
				//////////////////
				//Since we've uploaded the big picture, let's generate and upload thumb
				$scope.getBlob();
				$ionicLoading.hide();
				/*
        $scope.popupOpen = true;
				$ionicPopup.alert({
				  title: $APP.mdConfig.popups.iconErr + 'Uploaded',
				  content: 'Your photo has been uploaded.'
				}).then(function(rest) {
				   $scope.popupOpen = false;
				   $location.path("/app/home");
				});
*/
			}

			function uploadError(error) {
				console.log("upload error source " + JSON.stringify(error));
				$ionicLoading.hide();
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleUpErr,
					content: $APP.mdConfig.popups.upErr
				}).then(function(rest) {
					$scope.popupOpen = false;

				});
			}
		};

		//Genrate thumbnail
		$scope.getBlob = function getBlob() {
			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingUploading
			});
			ThumbnailService.generate($scope.photoURI.data, {
				returnType: 'blob',
				type: 'image/jpeg'
			}).then(
				function success(blob) {


					$scope.thumbnailBase64 = {
						data: null
					};
					console.log(typeof blob);
					//get file system
					window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, gotFS, fail);

					//create our file
					function gotFS(fileSystem) {
						fileSystem.root.getFile($APP.mdConfig.picsFolderName + "/" + $rootScope.userInfo.wardName.replace(/ /g, '_') + '_' + $scope.data.station.id + '_tn.jpg', {
							create: true,
							exclusive: false
						}, gotFileEntry, fail);
					};

					function gotFileEntry(fileEntry) {
						fileEntry.createWriter(gotFileWriter, fail);
						console.log(JSON.stringify(fileEntry));
						$scope.thumbnailBase64 = {
							data: fileEntry.nativeURL
						};
					};

					function gotFileWriter(writer) {
						console.log('writing')
						writer.write(blob);
						writer.onwriteend = function(evt) {
							console.log('ended!')
							console.log(JSON.stringify(evt));
							//$scope.thumbnailBase64 = {data : evt.localURL};
							//Should upload here
							var options = new FileUploadOptions();

							options.fileName = $rootScope.userInfo.wardName.replace(/ /g, '_') + '_' + $scope.data.station.id + '_tn.jpg'
							options.mimeType = "image/jpeg";
							options.chunkedMode = true;
							options.trustAllHosts = true;
							console.log("new imp: prepare upload now");
							var ft = new FileTransfer();
							ft.upload($scope.thumbnailBase64.data, encodeURI($APP.server + "/api/fileupload"), uploadSuccess, uploadError, options, true);


							function uploadSuccess(r) {

								// handle success like a message to the user
								console.log('thumb uploaded success');

								$ionicLoading.hide();
								$scope.popupOpen = true;
								$ionicPopup.alert({
									title: $APP.mdConfig.popups.iconSucc + $APP.mdConfig.popups.titleUpSucc,
									content: $APP.mdConfig.popups.upSucc
								}).then(function(rest) {
									$scope.popupOpen = false;
									$location.path("/app/home");
								});
							}

							function uploadError(error) {
								console.log("upload error source " + JSON.stringify(error));
								$ionicLoading.hide();
								$scope.popupOpen = true;
								$ionicPopup.alert({
									title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleUpErr,
									content: $APP.mdConfig.popups.upErr
								}).then(function(rest) {
									$scope.popupOpen = false;

								});
							};
						};
					};

					function fail(error) {
						console.log(error.code);
					}



					//$scope.thumbnailBase64 = {data : blob};
				},
				function error(reason) {
					console.log('Error: ' + reason);
				}
			);
		};
	}
])

/*
 *
 *    CONFIRM ASSIGNMENT CONTROLLER
 *
 */
.controller('ConfirmUserAssignmentCtrl', [
	'$scope',
	'$location',
	'$rootScope',
	'Auth',
	function($scope, $location, $rootScope, Auth) {

		$scope.confirmUserAssignment = function() {
			$location.path("/app/home");
		};

		Auth.reload(function(user) {
			// Success
			$rootScope.userInfo = user;
		});
	}
])

/*
 *
 *    OPEN STATION CONTROLLER
 *
 */
.controller('OpenStationCtrl', [
	'$scope',
	'$location',
	'$ionicPopup',
	'$ionicLoading',
	'OpenStation',
	'$rootScope',
	function($scope, $location, $ionicPopup, $ionicLoading, OpenStation, $rootScope) {
		//Do we have a connection?
		if (!$rootScope.checkConnection()) {
			//close if any are open
			$scope.popupOpen = false;
			$ionicLoading.hide();
			//display the message
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
				content: $APP.mdConfig.popups.noConnection
			}).then(function(rest) {
				$scope.popupOpen = false;
				$location.path("/app/home");
			});

		};

		$scope.data = {
			station: null,
			pollingStations: null
		};

		$scope.getCheckList = function() {
			console.log("getCheckList()");

			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingLoading
			});

			$scope.$watch('data.station', function(station) {
				if (station) {
					// Get checklist from server
					OpenStation.getCheckList(station.id,
						function(data) {
							// Success
							$scope.list = data;
							$ionicLoading.hide();
						},
						function() {
							// Error
							$ionicLoading.hide();
							$scope.popupOpen = true;
							$ionicPopup.alert({
								title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
								content: $APP.mdConfig.popups.checklistDownErr
							}).then(function(rest) {
								$scope.popupOpen = false;
							});
						}
					);
				} else {
					$ionicLoading.hide();
				}
			});

		};

		$scope.getCheckList();

		$scope.checkItem = function(item) {
			console.log("checkItem: %o", $scope.list[item.id]);
		};

		$scope.selectAll = function() {
			var open = true;

			angular.forEach($scope.list, function(data, i) {
				open &= $scope.list[i].status;
			});

			angular.forEach($scope.list, function(data, i) {
				$scope.list[i].status = !open;
			});
		};

		$scope.saveOpenStationChecklist = function() {

			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;
					// Get out!!!
					$location.path("/app/home");
				});
			};
			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}
			console.log("saveOpenStationChecklist()");

			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingSubmit
			});

			// Submit list on save
			OpenStation.submit($scope.data.station.id, $scope.list, function() {
				// Success
				$ionicLoading.hide();
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconSucc + $APP.mdConfig.popups.titleListSucc,
					content: $APP.mdConfig.popups.listSucc
				}).then(function(rest) {
					$scope.popupOpen = false;
					$location.path("/app/home");
				});
			}, function() {
				// Error
				$ionicLoading.hide();
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleServErr,
					content: $APP.mdConfig.popups.checklistUpdateErr
				}).then(function(rest) {
					$scope.popupOpen = false;
				});
			});
		};
	}
])



/*
 *
 *    CLOSE STATION CONTROLLER
 *
 */
.controller('CloseStationCtrl', [
	'$scope',
	'$location',
	'$ionicPopup',
	'$ionicLoading',
	'CloseStation',
	'$rootScope',
	function($scope, $location, $ionicPopup, $ionicLoading, CloseStation, $rootScope) {

		//Do we have a connection?
		if (!$rootScope.checkConnection()) {
			//close if any are open
			$scope.popupOpen = false;
			$ionicLoading.hide();
			//display the message
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
				content: $APP.mdConfig.popups.noConnection
			}).then(function(rest) {
				$scope.popupOpen = false;
				$location.path("/app/home");
			});
		};

		// $scope.station = 'init';

		// Payload and model
		$scope.data = {
			ordinary: {},
			tendered: {},
			station: null,
			pollingStations: null
		};

		// Calculations
		$scope.recalculate = function() {
			// Make everything integer
			$scope.data.ordinary.totalIssued = parseInt($scope.data.ordinary.totalIssued);
			$scope.data.ordinary.numberOfReplacements = parseInt($scope.data.ordinary.numberOfReplacements);
			$scope.data.ordinary.totalUnused = parseInt($scope.data.ordinary.totalUnused);
			$scope.data.tendered.totalIssued = parseInt($scope.data.tendered.totalIssued);
			$scope.data.tendered.totalSpoilt = parseInt($scope.data.tendered.totalSpoilt);
			$scope.data.tendered.totalUnused = parseInt($scope.data.tendered.totalUnused);

			// Calculation
			$scope.data.ordinary.calcIssuedAndNotSpoilt = $scope.data.ordinary.totalIssued - $scope.data.ordinary.numberOfReplacements;
			if (isNaN($scope.data.ordinary.calcIssuedAndNotSpoilt)) $scope.data.ordinary.calcIssuedAndNotSpoilt = 0;

			//pre-validation
			if (isNaN($scope.data.ordinary.totalIssued)) $scope.data.ordinary.totalIssued = 0;
			if (isNaN($scope.data.ordinary.numberOfReplacements)) $scope.data.ordinary.numberOfReplacements = 0;
			if (isNaN($scope.data.ordinary.totalUnused)) $scope.data.ordinary.totalUnused = 0;
			if (isNaN($scope.data.tendered.totalIssued)) $scope.data.tendered.totalIssued = 0;
			if (isNaN($scope.data.tendered.totalSpoilt)) $scope.data.tendered.totalSpoilt = 0;
			if (isNaN($scope.data.tendered.totalUnused)) $scope.data.tendered.totalUnused = 0;


		}

		$scope.calculationLessThenZero = function() {
			return ((($scope.data.ordinary.totalIssued) - ($scope.data.ordinary.numberOfReplacements)) < 0);
		};

		// Validation (sort of, but better than nothing)
		$scope.validateData = function() {
			//Is everything zero or more?
			// we don't accept negative numbers around here!
			// TO DO: we should porbably check are these data nubers
			if ((parseInt($scope.data.ordinary.totalIssued) < 0) || (parseInt($scope.data.ordinary.totalIssued) > 9999) || (parseInt($scope.data.ordinary.numberOfReplacements) < 0) || (parseInt($scope.data.ordinary.numberOfReplacements) > 9999) || (parseInt($scope.data.ordinary.totalUnused) < 0) || (parseInt($scope.data.ordinary.totalUnused) > 9999) || (parseInt($scope.data.tendered.totalIssued) < 0) || (parseInt($scope.data.tendered.totalIssued) > 9999) || (parseInt($scope.data.tendered.totalSpoilt) < 0) || (parseInt($scope.data.tendered.totalSpoilt) > 9999) || (parseInt($scope.data.tendered.totalUnused) < 0) || (parseInt($scope.data.tendered.totalUnused) > 9999) || ($scope.data.ordinary.calcIssuedAndNotSpoilt < 0) || ($scope.data.ordinary.calcIssuedAndNotSpoilt > 9999) || !$scope.data.station) {
				return true;
			} else {
				return false;
			}
		}


		// Close the station
		$scope.submitCloseStation = function() {

			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;
					// Get out!!!
					$location.path("/app/home");
				});

			};
			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}

			console.log("submitCloseStation()");

			$scope.recalculate();

			if ($scope.validateData()) {
				//there are negative stuff somewhere! get out!!!
				$ionicLoading.hide();
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleDataErr,
					content: $APP.mdConfig.popups.checkDataErr
				}).then(function(rest) {
					$scope.popupOpen = false;
				});
				return;
			}
			//are all zeros?
			if ((parseInt($scope.data.ordinary.totalIssued) == 0) && (parseInt($scope.data.ordinary.numberOfReplacements) == 0) && (parseInt($scope.data.ordinary.totalUnused) == 0) && (parseInt($scope.data.tendered.totalIssued) == 0) && (parseInt($scope.data.tendered.totalSpoilt) == 0) && (parseInt($scope.data.tendered.totalUnused) == 0) && ($scope.data.ordinary.calcIssuedAndNotSpoilt == 0)) {
				// Error
				$scope.data.ordinary.totalIssued = "";
				$scope.data.ordinary.numberOfReplacements = "";
				$scope.data.ordinary.totalUnused = "";
				$scope.data.tendered.totalIssued = "";
				$scope.data.tendered.totalSpoilt = "";
				$scope.data.tendered.totalUnused = "";

				$ionicLoading.hide();
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleDataErr,
					content: $APP.mdConfig.popups.checkDataErr
				}).then(function(rest) {
					$scope.popupOpen = false;

				});
				return;
			}

			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingSubmit
			});
			console.log(JSON.stringify($scope.data));


			// Submit data
			CloseStation.submit({
					ordinary: $scope.data.ordinary,
					tendered: $scope.data.tendered,
					stationId: $scope.data.station.id
				},
				function() {
					// Success
					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconSucc + $APP.mdConfig.popups.titleStationClosed,
						content: $APP.mdConfig.popups.stationCloseSucc + "<br> You need to track progress. Switching to track progress screen..."
					}).then(function(rest) {
						$scope.popupOpen = false;
						$location.path("/app/tracking");
					});
				},
				function() {
					// Error
					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
						content: $APP.mdConfig.popups.stationCloseErr
					}).then(function(rest) {
						$scope.popupOpen = false;
					});
				}
			);
		};

	}
])



/*
 *
 *    REPORT ISSUE CONTROLLER
 *
 */
.controller('ReportIssueCtrl', [
	'$scope',
	'$rootScope',
	'$location',
	'$ionicPopup',
	'$ionicLoading',
	'ReportIssue',
	function($scope, $rootScope, $location, $ionicPopup, $ionicLoading, ReportIssue) {

		//Do we have a connection?
		if (!$rootScope.checkConnection()) {
			//close if any are open
			$scope.popupOpen = false;
			$ionicLoading.hide();
			//display the message
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
				content: $APP.mdConfig.popups.noConnection
			}).then(function(rest) {
				$scope.popupOpen = false;
				// Get out!!!
				$location.path("/app/home");
			});
		};

		// Default selected data
		$scope.data = {
			"reason": "Not all staff have turned up at polling station",
			"priority": "Medium",
			"station": null,
			"pollingStations": null
		};

		$rootScope.$watch('userInfo', function(newValue, oldValue) {
			if (newValue) {
				if ($rootScope.userInfo.councilId == 10001) {
					$scope.reasons = [{
						"text": "Not all staff have turned up at polling station"
					}, {
						"text": "Not enough station ballot books"
					}, {
						"text": "Staff member is sick"
					}, {
						"text": "Urgently need officer to attend"
					}, {
						"text": "Other"
					}];

				} else {

					$scope.reasons = [{
						"text": "Not all staff have turned up at polling station"
					}, {
						"text": "Postal vote pack handed in"
					}, {
						"text": "Not enough station ballot books"
					}, {
						"text": "Staff member is sick"
					}, {
						"text": "Urgently need officer to attend"
					}, {
						"text": "Other"
					}];
				}
			}
		});

		$scope.priorities = [
			{"text": "High"},
			{"text": "Medium"},
			{"text": "Low"}
		];

		$scope.submitIssue = function() {
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;
					// Get out!!!
					$location.path("/app/home");
				});
			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}

			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingSubmit
			});


			var data = angular.copy($scope.data);
			data.stationId = data.station.id;
			delete data.station;
			delete data.pollingStations;
			ReportIssue.submit(data,
				function() {
					// Success
					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconSucc + $APP.mdConfig.popups.titleIssueSubmitSucc,
						content: $APP.mdConfig.popups.iconSuccissueSubmitSucc
					}).then(function(rest) {
						$scope.popupOpen = false;
						$location.path("/app/home");
					});
				},
				function() {
					// Error
					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
						content: $APP.mdConfig.popups.issueSubmitErr
					}).then(function(rest) {
						$scope.popupOpen = false;
					});
				});
		};

	}
])

/*
 *
 *    TRACKING CONTROLLER
 *
 */
.controller('TrackingCtrl', [
	'$scope',
	'$location',
	'$ionicLoading',
	'Tracking',
	'$interval',
	'$ionicPopup',
	'$rootScope',
	function($scope, $location, $ionicLoading, Tracking, $interval, $ionicPopup, $rootScope) {

		//Do we have a connection?
		if (!$rootScope.checkConnection()) {
			//close if any are open
			$scope.popupOpen = false;
			$ionicLoading.hide();
			//display the message
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
				content: $APP.mdConfig.popups.noConnection
			}).then(function(rest) {
				$scope.popupOpen = false;
				$location.path("/app/home");
			});

		};

		$scope.trackingInProgress = false;

		$scope.data = {
			status: 0, // 1 = started, 2 = in progress, 3 = complete
			lat: 0,
			lng: 0,
			station: null,
			pollingStations: null
		};

		$scope.startTracking = function() {
			//Do we have a connection?
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;
					$location.path("/app/home");
				});

			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}
			console.log("Starting tracking");

			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingTrackingStart
			});

			$scope.data.status = 1;

			var data = angular.copy($scope.data);
			data.stationId = data.station.id;
			delete data.station;
			delete data.pollingStations;
			Tracking.submit(data,
				function() {
					// Success
					$ionicLoading.hide();
					$scope.trackingInProgress = true;

					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconSucc + $APP.mdConfig.popups.titleTracking,
						template: $APP.mdConfig.popups.iconLoad + $APP.mdConfig.popups.tracking,
						buttons: [{
							text: $APP.mdConfig.popups.buttonTracking,
							type: 'button-positive',
							onTap: function(e) {
								$scope.stopTracking();
							}
						}, ]
					}).then(function(rest) {
						$scope.popupOpen = false;
					});

					// Initialise GPS loop.
					console.log("Starting tracking loop...");
					$scope.updateTracking();
					$scope.timer = $interval($scope.updateTracking, $APP.mdConfig.geoInterval);
				},
				function() {
					// Error
					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
						content: $APP.mdConfig.popups.trackingErr
					}).then(function(rest) {
						$scope.popupOpen = false;
					});
				});


		};



		// This function should be run in a timer loop
		// It will get the GPS location, and submit tracking update if tracking is in progress.
		$scope.updateTracking = function() {
			console.log('Tracking update starting...');

			$scope.data.status = 2;

			// Get GPS coordinates here, put into $scope.data
			navigator.geolocation.getCurrentPosition(
				function(pos) {
					// Success
					console.log("GPS: getCurrentPosition success %o", pos);
					$scope.data.lat = pos.coords.latitude;
					$scope.data.lng = pos.coords.longitude;

					// If tracking has started, submit tracking update
					if ($scope.trackingInProgress) {
						var data = angular.copy($scope.data);
						data.stationId = data.station.id;
						delete data.station;
						delete data.pollingStations;
						Tracking.submit(data,
							function() {
								// Success
								console.log("Tracking update sent: %o", $scope.data);
							},
							function() {
								// Error
								console.log("Tracking update send problem.");
							});
					}
				},
				function(err) {
					// Error
					console.log("GPS: getCurrentPosition error %o", err);
				}, {
					maximumAge: $APP.mdConfig.geoMaxAge,
					timeout: $APP.mdConfig.geoTimeOut,
					enableHighAccuracy: $APP.mdConfig.geoEnableHighAccuracy
				});
		};



		$scope.stopTracking = function() {
			// Cancel main timer
			$interval.cancel($scope.timer);


			//Do we have a connection?
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;
					$location.path("/app/home");
				});

			};


			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}

			console.log("Ending tracking");

			$ionicLoading.show({
				template: $APP.mdConfig.popups.loadingTrackingComplete
			});

			$scope.data.status = 3;

			// Cancel main timer
			$interval.cancel($scope.timer);
			var data = angular.copy($scope.data);
			data.stationId = data.station.id;
			delete data.station;
			delete data.pollingStations;
			Tracking.submit(data,
				function() {
					// Success
					$ionicLoading.hide();
					$scope.trackingInProgress = true;

					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconSucc + $APP.mdConfig.popups.titleTrackingCompleted,
						content: $APP.mdConfig.popups.trackingCompletedSucc
					}).then(function(rest) {
						$scope.popupOpen = false;

						$location.path("/app/home");
					});
				},
				function() {
					// Error
					$ionicLoading.hide();
					$scope.popupOpen = true;
					$ionicPopup.alert({
						title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
						content: $APP.mdConfig.popups.trackingErr
					}).then(function(rest) {
						$scope.popupOpen = false;
					});
				});
		};


		// Get GPS when we load this page
		$scope.updateTracking();
	}
])



/*
 *
 *    PROGRESS CONTROLLER
 *
 */
.controller('ProgressCtrl', [
	'$scope',
	'$location',
	'$ionicPopup',
	'$ionicLoading',
	'StationProgress',
	'$rootScope',
	'localStorageService',
	function($scope, $location, $ionicPopup, $ionicLoading, StationProgress, $rootScope, localStorageService) {


		//Do we have a connection?
		if (!$rootScope.checkConnection()) {
			//close if any are open
			$scope.popupOpen = false;
			$ionicLoading.hide();
			//display the message
			$scope.popupOpen = true;
			$ionicPopup.alert({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
				content: $APP.mdConfig.popups.noConnection
			}).then(function(rest) {
				$scope.popupOpen = false;
				// Get out!!!
				$location.path("/app/home");
			});

		};

		$scope.data = {
			station: null,
			pollingStations: null
		};

		//get the latest data from the server and store it;
		StationProgress.get(
			function(data) {
				console.log(JSON.stringify(data));
				$scope.data.numberPapersIssued = data.paperIssued;
				$scope.data.numberPostalPacksReceived = data.postalPacksReceived;
				$scope.data.numberPostalPacksAwaitingCollection = data.postalPacksAwaitingCollection;
				//$scope.CollectedPostalPackCount = (localStorageService.get($rootScope.currentPollingStationID + "CollectedPostalPackCount") || 0);
				$scope.CollectedPostalPackCount = parseInt(data.postalPacksReceived) - parseInt(data.postalPacksAwaitingCollection);

			},
			function(err) {
				console.log(err);
			}
		);

		$scope.validateData = function() {
			//Is everything zero or more?
			// we don't accept negative numbers around here!
			// TO DO: we should porbably check are these data nubers
			if ((parseInt($scope.data.numberPapersIssuedBOX) < 0) || (parseInt($scope.data.numberPapersIssuedBOX) > 9999) || (parseInt($scope.data.numberPostalPacksReceivedBOX) < 0) || (parseInt($scope.data.numberPostalPacksReceivedBOX) > 9999)) {
				return true;
			} else {
				return false;
			}
		}

		$scope.saveBallotProgress = function() {
			console.log("saveBallotProgress()");
			//Do we have a connection?
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});
			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}
			//let's check are the values valid. If not, make it zero.
			if (isNaN(parseInt($scope.data.numberPapersIssuedBOX))) {
				$scope.data.numberPapersIssuedBOX = 0
			}
			if (isNaN(parseInt($scope.data.numberPostalPacksReceivedBOX))) {
				$scope.data.numberPostalPacksReceivedBOX = 0
			}

			//let's check are the server values valid. If not, make, get out.
			//the server values should be only nan when not connected to the network, but we're not letting you in when there's no connection so this should never happen.
			if (isNaN(parseInt($scope.data.numberPapersIssued))) {
				console.log('1');
				return;
			}
			if (isNaN(parseInt($scope.data.numberPostalPacksReceived))) {
				console.log('2');
				return;
			}
			if (isNaN(parseInt($scope.data.numberPostalPacksAwaitingCollection))) {
				console.log('3');
				return;
			}


			if ($scope.validateData()) {
				//there are negative stuff somewhere! get out!!!
				$ionicLoading.hide();
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleDataErr,
					content: $APP.mdConfig.popups.checkDataErr
				}).then(function(rest) {
					$scope.popupOpen = false;
				});
				return;
			}


			$scope.popupOpen = true;
			$ionicPopup.confirm({
				title: $APP.mdConfig.popups.iconErr + "Please Confirm",
				content: "Is this correct data? <br> Papers issued: " + $scope.data.numberPapersIssuedBOX + "<br>Postal packs recieved: " + $scope.data.numberPostalPacksReceivedBOX
			}).then(function(res) {
				if (res) {
					//Just continue, all is good
					$scope.popupOpen = false;

					////////////////////////////////////



					$ionicLoading.show({
						template: $APP.mdConfig.popups.loadingSubmit
					});


					$scope.data.numberPapersIssued = parseInt($scope.data.numberPapersIssued) + parseInt($scope.data.numberPapersIssuedBOX);
					$scope.data.numberPostalPacksReceived = parseInt($scope.data.numberPostalPacksReceived) + parseInt($scope.data.numberPostalPacksReceivedBOX);
					//$scope.data.numberPostalPacksAwaitingCollection = parseInt($scope.CollectedPostalPackCount);
					$scope.data.numberPostalPacksAwaitingCollection = parseInt($scope.data.numberPostalPacksReceived) - parseInt($scope.CollectedPostalPackCount);

					var data = angular.copy($scope.data);
					data.stationId = data.station.id;
					delete data.station;
					delete data.pollingStations;

					StationProgress.submit(data,
						function() {
							//reset the data.
							$scope.data.numberPapersIssuedBOX = '';
							$scope.data.numberPostalPacksReceivedBOX = '';
							// Success
							$ionicLoading.hide();
							$scope.popupOpen = true;
							$ionicPopup.alert({
								title: $APP.mdConfig.popups.iconSucc + $APP.mdConfig.popups.titleProgressSubmit,
								content: $APP.mdConfig.popups.progressSubmitSucc
							}).then(function(rest) {
								$scope.popupOpen = false;
								//$location.path("/app/home");
							});
						},
						function() {
							// Error
							$ionicLoading.hide();
							$scope.popupOpen = true;
							$ionicPopup.alert({
								title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
								content: $APP.mdConfig.popups.progressSubmitErr
							}).then(function(rest) {
								$scope.popupOpen = false;
							});
						});

				} else {
					$scope.popupOpen = false;
					return;
				}
			});

		};



		$scope.resetBallotProgress = function() {
			console.log("resetBallotProgress()");
			//Do we have a connection?
			if (!$rootScope.checkConnection()) {
				//close if any are open
				$scope.popupOpen = false;
				$ionicLoading.hide();
				//display the message
				$scope.popupOpen = true;
				$ionicPopup.alert({
					title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
					content: $APP.mdConfig.popups.noConnection
				}).then(function(rest) {
					$scope.popupOpen = false;

				});

			};

			//Get out
			if (!$rootScope.checkConnection()) {
				return;
			}


			//RESET THE COLLECTED

			$scope.popupOpen = true;
			$ionicPopup.confirm({
				title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleResetPostalPacks,
				content: $APP.mdConfig.popups.resetPostalPacks
			}).then(function(res) {
				if (res) {
					$scope.popupOpen = false;
					$scope.CollectedPostalPackCount = $scope.data.numberPostalPacksReceived;
					localStorageService.set($rootScope.currentPollingStationID + "CollectedPostalPackCount", $scope.CollectedPostalPackCount);

					//sUBMIT THE DATA AGAIN TO THE SERVER


					//Do we have a connection?
					if (!$rootScope.checkConnection()) {
						//close if any are open
						$scope.popupOpen = false;
						$ionicLoading.hide();
						//display the message
						$scope.popupOpen = true;
						$ionicPopup.alert({
							title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
							content: $APP.mdConfig.popups.noConnection
						}).then(function(rest) {
							$scope.popupOpen = false;

						});

					};

					//Get out
					if (!$rootScope.checkConnection()) {
						return;
					}
					//let's check are the values valid. If not, make it zero.
					if (isNaN(parseInt($scope.data.numberPapersIssuedBOX))) {
						$scope.data.numberPapersIssuedBOX = 0
					}
					if (isNaN(parseInt($scope.data.numberPostalPacksReceivedBOX))) {
						$scope.data.numberPostalPacksReceivedBOX = 0
					}

					//let's check are the server values valid. If not, make, get out.
					//the server values should be only nan when not connected to the network, but we're not letting you in when there's no connection so this should never happen.
					if (isNaN(parseInt($scope.data.numberPapersIssued))) {
						return;
					}
					if (isNaN(parseInt($scope.data.numberPostalPacksReceived))) {
						return;
					}
					if (isNaN(parseInt($scope.data.numberPostalPacksAwaitingCollection))) {
						return;
					}


					if ($scope.validateData()) {
						//there are negative stuff somewhere! get out!!!
						$ionicLoading.hide();
						$scope.popupOpen = true;
						$ionicPopup.alert({
							title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleDataErr,
							content: $APP.mdConfig.popups.checkDataErr
						}).then(function(rest) {
							$scope.popupOpen = false;
						});
						return;
					}


					$ionicLoading.show({
						template: $APP.mdConfig.popups.loadingSubmit
					});


					$scope.data.numberPapersIssued = parseInt($scope.data.numberPapersIssued) + parseInt($scope.data.numberPapersIssuedBOX);
					$scope.data.numberPostalPacksReceived = parseInt($scope.data.numberPostalPacksReceived) + parseInt($scope.data.numberPostalPacksReceivedBOX);
					$scope.data.numberPostalPacksAwaitingCollection = parseInt($scope.data.numberPostalPacksReceived) - parseInt($scope.CollectedPostalPackCount);

					var data = angular.copy($scope.data);
					data.stationId = data.station.id;
					delete data.station;
					delete data.pollingStations;

					StationProgress.submit(data,
						function() {
							//reset the data.
							$scope.data.numberPapersIssuedBOX = '';
							$scope.data.numberPostalPacksReceivedBOX = '';
							// Success
							$ionicLoading.hide();
							$scope.popupOpen = true;
							$ionicPopup.alert({
								title: $APP.mdConfig.popups.iconSucc + $APP.mdConfig.popups.titlePostalPacksSucc,
								content: $APP.mdConfig.popups.postalPacksSucc
							}).then(function(rest) {
								$scope.popupOpen = false;
								//$location.path("/app/home");
							});
						},
						function() {
							// Error
							$ionicLoading.hide();
							$scope.popupOpen = true;
							$ionicPopup.alert({
								title: $APP.mdConfig.popups.iconErr + $APP.mdConfig.popups.titleConnErr,
								content: $APP.mdConfig.popups.postalPacksErr
							}).then(function(rest) {
								$scope.popupOpen = false;
							});
						});
				} else {
					//Disregard
					$scope.popupOpen = false;
				}
			});

		};
	}
]);

//yes, yes, i know. ugly on so many levels.
window.myModalTemplate = '<ion-modal-view><ion-header-bar class="modalHeader"><h1 class="title notifications">  <i class="ion-information-circled"></i> <b>{{notificationData.length}} New Notifications</b></h1></div></ion-header-bar>' + '<ion-content class="has-footer"><div class="content list notifications"><ion-item ng-repeat="message in notificationData| orderBy:' + "'-datetime'" + '"><div class="notificationContainer" style = "border-style: solid;border-width: 2px;border-radius:2px;border-color:#bbb"><div class="item item-divider" style="background-color:#30a9d8; font-size:150%; line-height:1.2;"><div ng-if="message.private" style="width:50%; float:left;" ><b><u>New Private Message</u></b></div><div ng-if="!message.private" style="width:50%; float:left;"><b><u>New Global Message</u></b></div><div style="color:white; width:50%; float:left; text-align:right; padding-right:15px;">{{message.datetime | amDateFormat:"ddd, MMM Do YYYY, h:mm a"}}</div>   </div><div class="item item-text-wrap item-button-right " style="background-color: #F0FFFF; font-size:160%;  "><div style="padding-right:15px;">{{message.text}}</div><button  ng-click="message.status = ' + "'Comfirmed'" + '; AcknowledgeFromModal(message.id)"  class="button" ng-class ="message.status !=' + "'Comfirmed'" + ' ? ' + "'orangy orangered'" + ' : ' + "'blueish disabled'" + '" style="font-size:60%">Confirm</button></div><a class="item item-icon-right " ng-if="message.url" style="background-color:#f0ad4e; padding:10px; font-size:130%;display:block;"  ng-click="DownloadFromModal(message.url);"><i style="padding:7px; display:block;" class= "icon ion-android-download"></i> {{message.url}}</a></div></ion-item></div></ion-content><ion-footer-bar align-title="left" class="bar footer clearfix"><div class="content list buttonBar"><button class="button button-full button-modern" ng-click="destroyNewModal();">Close</button></div></ion-footer-bar></ion-modal-view>';