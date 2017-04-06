// Ionic Starter App


//---------------------------------------------------------------------
// NAMESPACE DECLARATIONS
//---------------------------------------------------------------------


//Santa's little helper:
//adb logcat Cordova:D DroidGap:D CordovaLog:D chromium:D *:S


var $APP = $APP || {}; // App namespace
var $UTL = $UTL || {}; // Utilities namespace

(function($APP, undefined) {

	$APP.mdConfig = {
		//////////////////////
		//General App Settings

		appName: 'moderndemocracy',
		buildNumber: "1.3.3",
		server: 'http://192.168.3.94', //'http://pollingstationmanager.co.uk',
		debugServer: 'http://192.168.1.6:9090',

		//Should we enable or disable logging. If false, console.log() won't execute (refer to the $APP.logger for more detail!)
		logging: true,

		///////////////////////
		//Notification settings

		//How often do we check?
		notifInterval: 15000,
		//What's the longest notif array length that will be considered valid?
		notifDataLengthCheck: 100,
		//How long do we vibrate on notification recieved
		notifVibrateMilisecs: 600,
		//How many times do we beep on notification recieved
		notifTimesToBeep: 1,

		///////////////////////
		//Geolocation settings

		//How often do we update tracking data (interval)
		geoInterval: 15000,
		//Is a positive long value indicating the maximum age in milliseconds of a possible cached position that is acceptable to return.
		geoMaxAge: 3000,
		//Is a positive long value representing the maximum length of time (in milliseconds) the device is allowed to take in order to return a position.
		geoTimeOut: 15000,
		//Is a Boolean that indicates the application would like to receive the best possible results
		geoEnableHighAccuracy: true,

		////////////////
		//Pics settings

		//Folder name where the captured pics and thumbnails are stored
		picsFolderName: 'Modern_Democracy_Pics',
		//quality of the captured jpeg
		picsJPEGQuality: 75,
		//generated thumbnail size
		thumbnailWidth: 50,
		thumbnailHeight: 30,

		popups: {

			/////////////////////////////////////////////////////
			//Icons, titles and texts used for generating popups

			//Icons
			iconSucc: '<i class="ion-checkmark-round"></i>',
			iconErr: '<i class="ion-alert"></i>',
			iconLoad: '<icon class="ion-loading-b"></icon>',

			//Button for stopping tracking
			buttonTracking: 'Stop Tracking',

			//These are various loading texts that are displayed in little black rectangles while the app is communicating with server, or executing some other functions
			loadingSubmit: 'Submitting...',
			loadingDownload: 'Downloading...',
			loadingTrackingComplete: 'Completing tracking...',
			loadingTrackingStart: 'Starting tracking...',
			loadingLoading: 'Loading...',
			loadingUploading: 'Uploading...',
			loadingSwitch: 'Switching...',
			loadingLogOut: 'Logging out...',
			loadingLogIn: 'Logging In...',


			//Various popup titles
			titleConnErr: 'Connection error',
			titleServErr: 'Server error',
			titleDownErr: 'Download error',
			titleLoginErr: 'Invalid login',
			titleDeviceErr: 'Device error',
			titleUpSucc: 'Upload success',
			titleUpErr: 'Upload error',
			titleListSucc: 'List Updated',
			titleDataErr: 'Invalid data',
			titleStationClosed: 'Station Closed',
			titleIssueSubmitSucc: 'Issue Submitted',
			titleTracking: 'Tracking Ballot Box',
			titleTrackingCompleted: 'Tracking Complete',
			titleProgressSubmit: 'Progress Submitted',
			titleResetPostalPacks: 'Resetting Data...',
			titlePostalPacksSucc: 'Postal Packs Submitted',

			//Various popup texts
			noConnection: 'No connection. Please connect to a network.',
			validUserName: 'Please enter valid username and password.',
			accountsErr: 'Your data has not been updated. Please try again.',
			switchPsErr: 'Cannot Switch. Please try again.',
			notifErr: 'Cannot retrieve messages.',
			confirmErr: 'Cannot confirm message.',
			downloadErr: 'Cannot Download. Please try again.',
			camErr: 'Camera is not supported on this device.',
			upErr: 'Upload failed. Please try again.',
			upSucc: 'Your photo has been uploaded.',
			checklistDownErr: 'Problem downloading checklist. Please try again.',
			listSucc: 'You have successfully updated your checklist.',
			checklistUpdateErr: 'Your checklist has not been updated. Please try again.',
			checkDataErr: 'Please check entered data.',
			stationCloseSucc: 'You have successfully submitted your details.',
			stationCloseErr: 'Your station has not been updated. Please try again.',
			issueSubmitSucc: 'You have successfully submitted an issue.',
			issueSubmitErr: 'Your issue has not been submitted. Please try again.',
			tracking: 'The location of the ballot box is being tracked and the current location will be displayed in the Election Manager Application. To stop tracking click Stop Tracking',
			trackingErr: 'Tracking was unable to start. Please try again.',
			trackingCompletedSucc: 'Tracking has completed. Thank you.',
			trackingCompletedErr: 'Tracking was unable to complete. Please try again.',
			progressSubmitSucc: 'You have successfully submitted your progress.',
			progressSubmitErr: 'Your progress has not been submitted. Please try again.',
			resetPostalPacks: 'Are you sure you want to collect Postal Packs?',
			postalPacksSucc: 'You have successfully collected your postal packs.',
			postalPacksErr: 'Your postal packs were not collected. Please try again.'

		}

	}

	//connecting the data here with the mdConfig to keep prior data model consistent
	$APP.name = $APP.mdConfig.appName;
	$APP.debugServer = $APP.mdConfig.debugServer; // Mobile debug server config
	$APP.buildNumber = $APP.mdConfig.buildNumber;
	$APP.server = $APP.mdConfig.server; // We presume we are running in phonegap by default.
	//$APP.server = 'http://192.168.1.233';

	// If running on desktop, set $APP.server to be empty - it will use localhost
	if (!navigator.userAgent.match(/(iPhone|iPod|iPad|Android|BlackBerry|IEMobile)/)) {
		$APP.server = '';
		$APP.debugServer = '';
	}

	//Grab the console log
	$APP.logger = function() {
		var oldConsoleLog = null;
		var pub = {};
		pub.enableLogger = function enableLogger() {
			if (oldConsoleLog == null)
				return;

			window['console']['log'] = oldConsoleLog;
		};

		pub.disableLogger = function disableLogger() {
			oldConsoleLog = console.log;
			window['console']['log'] = function() {};
		};

		return pub;
	}();

	//enable it if neccessary
	if ($APP.mdConfig.logging) {
		$APP.logger.enableLogger();
	} else {
		$APP.logger.disableLogger();
	}



	console.log("Using " + $APP.server + " server");



})($APP);

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.controllers' is found in controllers.js
angular.module('starter', [
	'ionic',
	'starter.controllers',
	'starter.directives',
	'ngResource',
	'LocalStorageModule',
	'angularMoment',
	'ui.thumbnail'
])

.run([
	'$ionicPlatform',
	'$rootScope',
	'Auth',
	'$window',
	function($ionicPlatform, $rootScope, Auth, $window) {
		$ionicPlatform.ready(function() {
			// Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
			// for form inputs)
			if (window.cordova && window.cordova.plugins.Keyboard) {
				cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
			}
			if (window.StatusBar) {
				// org.apache.cordova.statusbar required
				StatusBar.styleDefault();
			}

			if ($APP.debugServer != '') {
				var s = document.createElement('script');
				s.src = $APP.debugServer + '/target/target-script-min.js#anonymous';
				document.body.appendChild(s);
			}

			$rootScope.authInitied = false;

			console.log(".run() - Auth.init() starting");
			Auth.init();

		});
	}
])

.config([
	'$stateProvider',
	'$urlRouterProvider',
	'$compileProvider',
	'ThumbnailServiceProvider',
	'$httpProvider',
	'$ionicConfigProvider',
	function($stateProvider, $urlRouterProvider, $compileProvider, ThumbnailServiceProvider, $httpProvider, $ionicConfigProvider) {

		$stateProvider

			.state('app', {
			url: "/app",
			abstract: true,
			templateUrl: "templates/menu.html",
			controller: 'AppCtrl'
		})

		.state('login', {
			url: "/login",

			templateUrl: "templates/login.html",
			controller: 'LoginCtrl'

		})

		.state('app.home', {
				url: "/home",
				views: {
					'menuContent': {
						templateUrl: "templates/home.html",
						controller: 'HomeCtrl'
					}
				}
			})
			.state('app.openstation', {
				url: "/openstation",
				views: {
					'menuContent': {
						templateUrl: "templates/openstation.html",
						controller: 'OpenStationCtrl'
					}
				}
			})
			.state('app.closestation', {
				url: "/closestation",
				views: {
					'menuContent': {
						templateUrl: "templates/closestation.html",
						controller: 'CloseStationCtrl'
					}
				}
			})

		.state('app.reportissue', {
			url: "/reportissue",
			views: {
				'menuContent': {
					templateUrl: "templates/reportissue.html",
					controller: 'ReportIssueCtrl'
				}
			}
		})

		.state('app.tracking', {
			url: "/tracking",
			views: {
				'menuContent': {
					templateUrl: "templates/tracking.html",
					controller: 'TrackingCtrl'
				}
			}
		})

		.state('app.confirmUserAssignment', {
			url: "/confirmUserAssignment",
			views: {
				'menuContent': {
					templateUrl: "templates/confirmuserassignment.html",
					controller: 'ConfirmUserAssignmentCtrl'
				}
			}
		})

		.state('app.viewnotifications', {
			url: "/viewnotifications",
			views: {
				'menuContent': {
					templateUrl: "templates/viewnotifications.html"
				}
			}
		})

		.state('app.logout', {
			url: "/logout",
			views: {
				'menuContent': {
					templateUrl: "templates/logout.html",
					controller: 'LogoutCtrl'
				}
			}
		})

		.state('app.messages', {
				url: "/messages",
				views: {
					'menuContent': {
						templateUrl: "templates/messages.html",
						controller: 'MessagesCtrl'
					}
				}
			})
			.state('app.accounts', {
				url: "/accounts",
				views: {
					'menuContent': {
						templateUrl: "templates/accounts.html",
						controller: 'AccountsCtrl'
					}
				}
			})

		.state('app.switchPS', {
			url: "/switchPS",
			views: {
				'menuContent': {
					templateUrl: "templates/switchPS.html",
					controller: 'SwitchPSCtrl'
				}
			}
		})

		.state('app.photo', {
			url: "/photo",
			views: {
				'menuContent': {
					templateUrl: "templates/photo.html",
					controller: 'PhotoCtrl'
				}
			}
		})


		.state('app.progress', {
			url: "/progress",
			views: {
				'menuContent': {
					templateUrl: "templates/progress.html",
					controller: "ProgressCtrl"
				}
			}
		});


		// if none of the above states are matched, use this as the fallback
		$urlRouterProvider.otherwise('app.home');

		//whitelist image URLs so Angular allows file:// protocol
		$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|file|blob|cdvfile|content):|data:image\//);


		//Thumbnail settings
		ThumbnailServiceProvider.defaults.width = $APP.mdConfig.thumbnailWidth;
		ThumbnailServiceProvider.defaults.height = $APP.mdConfig.thumbnailHeight;

		$httpProvider.interceptors.push('ForbiddenInterceptor');

		$ionicConfigProvider.views.maxCache(0);

	}
]);