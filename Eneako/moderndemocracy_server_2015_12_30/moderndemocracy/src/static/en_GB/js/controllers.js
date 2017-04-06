'use strict';
//---------------------------------------------------------------------
// NAMESPACE DECLARATIONS
//---------------------------------------------------------------------
var $APP = $APP || {}; // App namespace
var $UTL = $UTL || {}; // Utilities namespace

angular.module($APP.name).controller('MainNavCtrl', [
    '$scope',
    '$route',
    '$rootScope',
    'Auth',
    function ($scope, $route, $rootScope, Auth) {
        if ($route.current.manager) {
            $scope.items = [
                {url: "/manager", text: "Dashboard"},
                {url: "/manager/progress", text: "Ballot Box Progress"}
            ];
        }
        else {
            $scope.items = [
                {url: "/dashboard", text: "Dashboard"},
                {url: "/progress", text: "Ballot Box Progress"},
                {url: "/issues", text: "Issues"},
                {url: "/notifications", text: "Notifications"},
                {url: "/stations", text: "Ballot Paper Account"}
            ];
        }
        Auth.reload(
                function (response) {
                    if (response.role.roleId == 1)
                        Auth.logout();
                }
        );
        $rootScope.Logout = function () {
            Auth.logout();
        }

    }
]);
angular.module($APP.name).controller('HomeCtrl', [
    '$scope',
    'Wards',
    'Auth',
    'StationOpen',
    '$modal',
    function ($scope, Wards, Auth, StationOpen, $modal) {

        console.log("HomeCtrl");
        Auth.reload();
        $scope.wardData = [];
        (function getWardsFunc() {

            Wards.getWards(
                    function (response) {
                        // Success
                        console.log("Wards = %o", response);
                        // Calculate totals for each ward
                        for (var i = 0; i < response.wards.length; i++) {
                            var ward = response.wards[i];
                            ward.visible = false;

                            ward.wardImage = $APP.server + "/uploads/" + ward.wardName.replace(/ /g, '_');
                            $scope.imgtimestamp = Date.now();
                            var visibility = localStorage.getItem("visibility_" + JSON.stringify(ward.wardName));
                            if (visibility == "true") {
                                // Convert string to boolean
                                visibility = true;
                            } else {
                                visibility = false;
                            }
                            if (visibility != null) {
                                response.wards[i].visible = visibility;
                                console.log("Ward " + JSON.stringify(ward.wardName) + " visibility = " + ward.visible);
                            }
                            if (typeof ward.districts != "undefined") {
                                for (var j = 0; j < ward.districts.length; j++) {
                                    var district = ward.districts[j];
                                    district.visible = false;
                                    var districtVisibility = localStorage.getItem("districtvisibility_" + JSON.stringify(district.districtId));
                                    if (districtVisibility == "true") {
                                        // Convert string to boolean
                                        districtVisibility = true;
                                    } else {
                                        districtVisibility = false;
                                    }

                                    if (districtVisibility != null) {
                                        ward.districts[j].visible = districtVisibility;
                                        console.log("District " + JSON.stringify(district.districtId) + " districtvisibility_ = " + district.visible);
                                    }
                                }
                            }

                        }

                        $scope.wardData = response;
                        setTimeout(function () {
                            getWardsFunc();
                        }, 20000);
                    },
                    function (err) {
                        // Error
                        console.log("Wards error = %o", err);
                    }
            );
        })();
        $scope.showStatusPopup = function (station, district) {
            console.log("status: %o", station);
            $scope.station = station;
            var data = station.stationId;

            StationOpen.getChecklist(data,
                    function (response) {
                        $scope.checkList = response;
                        console.log(response);

                    },
                    function (err) {
                        console.log("Checklist error = %o", err);

                    }
            );
            $scope.popup = $modal.open({
                templateUrl: 'templates/dashboard_status_popup.html',
                scope: $scope
            });

        };
        $scope.modalClose = function () {
            $scope.popup.close(500);
        };
        $scope.toggleWardVisibility = function (ward) {
            ward.visible = !ward.visible;
            localStorage.setItem("visibility_" + JSON.stringify(ward.wardName), ward.visible);

            console.log("toggleWardVisibility - %o", ward);
        }
        $scope.toggleDistrictVisibility = function (district) {
            district.visible = !district.visible;
            localStorage.setItem("districtvisibility_" + JSON.stringify(district.districtId), district.visible);

            console.log("toggleDistrictVisibility - %o", district);
        }
        $scope.setDistrictVisible = function (district) {
            district.visible = false;
            localStorage.setItem("districtvisibility_" + JSON.stringify(district.districtId), false);
        }



    }
]);
angular.module($APP.name).controller('StationsCtrl', [
    '$scope',
    '$location',
    'Wards',
    'Auth',
    function ($scope, $location, Wards, Auth) {


        Auth.reload(
                function (response) {
                    $scope.areaName = response.areaName;
                    if (response.role.roleId == 4)
                        Auth.logout();
                }
        );
        console.log("StationsCtrl");
        $scope.wardData = [];
        (function getStationWards() {
            Wards.getWards(
                    function (response) {
                        // Success
                        console.log("Wards = %o", response);
                        $scope.wardData = response;
                        // console.log(response);
                        //var stations = response.wards[0].stations;

                        var st_arr = Array();
                        for (var i = 0; i < response.wards.length; i++) {
                            var ward = response.wards[i];
                            if (typeof ward.districts != "undefined") {
                                for (var j = 0; j < ward.districts.length; j++) {
                                    var district = ward.districts[j];
                                    if (typeof district.places != "undefined") {
                                        for (var z = 0; z < district.places.length; z++) {
                                            var place = district.places[z];
                                            if (typeof place.stations != "undefined") {
                                                for (var n = 0; n < place.stations.length; n++) {
                                                    var station = place.stations[n];
                                                    st_arr.push({
                                                        "wardName": ward.wardName,
                                                        "district": district.districtName,
                                                        "place": place.placeName,
                                                        "stationName": station.stationName,
                                                        "totalOrdinaryIssued": station.totalOrdinaryIssued,
                                                        "numberOfReplacements": station.numberOfReplacements,
                                                        "calcIssuedAndNotSpoilt": station.calcIssuedAndNotSpoilt,
                                                        "totalOrdinaryUnused": station.totalOrdinaryUnused,
                                                        "totalTenderedIssued": station.totalTenderedIssued,
                                                        "totalSpoilt": station.totalSpoilt,
                                                        "totalTenderedUnused": station.totalTenderedUnused

                                                    });
                                                }
                                            }

                                        }
                                    }


                                }
                            }

                        }


                        $scope.getArray = st_arr;
                        $scope.filename = Date.now();
                        $scope.getHeader = function () {
                            return [$scope.areaName, "District", "Place", "Station name", "Ordinary Ballot Papers Issued", "Replacements for spoilt ballot papers", "Ordinary Ballot papers issued and not spoilt", "Ordinary Ballot papers unused", "Tendered ballot papers issued", "Tendered ballot papers spoilt", "Tendered ballot papers unused"]
                        };
                        setTimeout(function () {
                            getStationWards();
                        }, 300000);
                    },
                    function (err) {
                        // Error
                        console.log("Wards error = %o", err);
                    }
            );
        })();

        $scope.printDiv = function(divName) {
          var printContents = document.getElementById(divName).innerHTML;
          var popupWin = window.open('', '_blank', 'width=300,height=300');
          popupWin.document.open()
          popupWin.document.write('<html><head><link rel="stylesheet" type="text/css" href="styles/jquery.dataTables.min.css">'
            +'<link rel="stylesheet" type="text/css" href="styles/font-awesome-4.2.0/css/font-awesome.min.css">'
            +'<link rel="stylesheet" type="text/css" href="js/libs/bootstrap/dist/css/bootstrap.css">'
            +'<link rel="stylesheet" type="text/css" href="js/libs/bootstrap-fileinput/css/fileinput.min.css">'
            +'<link rel="stylesheet" type="text/css" href="styles/style.css"></head><body onload="window.print()">' + printContents + '</body></html>');
          popupWin.document.close();
        };
    }
]);
angular.module($APP.name).controller('ProgressCtrl', [
    '$scope',
    'Tracking',
    'Auth',
    'ngTableParams',
    '$interval',
    function ($scope, Tracking, Auth, ngTableParams, $interval) {
        console.log("ProgressCtrl");
        Auth.reload(
                function (response) {
                    if (response.role.roleId == 4)
                        Auth.logout();
                }
        );
        (function getTracking() {
            Tracking.list(function (response) {
                // Success
                $scope.data = response;
                $scope.map = initialize();
                $scope.zoomToAllMarkers($scope.positions);
                setTimeout(function () {
                    getTracking();
                }, 30000);
            });
        })();
        $scope.$watch('data', function (data) {
            if ($scope.data && $scope.data.id) {
                //$scope.data.print = true;
                $scope.data.disabled = true;
            }
        }, true);
        $scope.tableParams = new ngTableParams({
            // page: 1, // show first page
            // count: 10, // count per page
            sorting: {
                created_on: 'asc'     // initial sorting
            }
        }, {
            counts: [],
            total: 0, // length of data
            // getData: function($defer, params) {
            // 	Tracking.list("", function(data) {

            // 		params.total($scope.data.length);
            // 		$defer.resolve($scope.data);
            // 	});
            // }
        });
        // console.log("get tracking data");

        // TMP

        function initialize() {
            // var locations = [
            // ['Box 126',53.370597, -1.442402,0,'img/boxicon.png'],
            // ['Count Centre - Ponds Forge International Sports Centre',53.382032, -1.462055,0,'img/doorin.png'],
            // ['Polling Station - St Swithuns Church Centre',53.366087, -1.428330,0,'img/doorout.png']
            // ];

            var map = new google.maps.Map(document.getElementById('map-canvas'), {
                panControl: false,
                zoomControl: true,
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.SMALL,
                    position: google.maps.ControlPosition.RIGHT_TOP
                },
                scaleControl: true,
                scaleControlOptions: {
                    position: google.maps.ControlPosition.BOTTOM_LEFT
                },
                streetViewControl: false,
                zoom: 16,
                center: new google.maps.LatLng(53.378850, -1.472677),
            });
            var marker, i;
            $scope.positions = new Array();
            for (i = 0; i < $scope.data.length; i++) {

                // Skip empty data
                if ($scope.data[i].lat == 0) {
                    continue;
                }
                var html = "<div class='mapInfoWindow'><h5>Box " + $scope.data[i].ballotBoxNumber + "</h5></div>"
                var infowindow = new google.maps.InfoWindow({
                    content: html
                });
                // Keep positions for use in setting zoom later
                var pos = new google.maps.LatLng($scope.data[i].lat, $scope.data[i].lng);
                $scope.positions.push(pos);
                marker = new google.maps.Marker({
                    position: pos,
                    map: map,
                    icon: 'img/boxicon.png',
                    animation: google.maps.Animation.DROP
                });
                google.maps.event.addListener(marker, 'click', (function (marker, i) {
                    return function () {
                        //infowindow.setContent("<div class='mapInfoWindow'><h4>Box " + $scope.data[i].ballotBoxNumber+"</h4></div>");
                        infowindow.open(map, marker);
                    }
                })(marker, i));
                infowindow.open(map, marker);
            }

            return map;
        }


        // google.maps.event.addDomListener(window, 'load', initialize);
        // $scope.map = initialize();


        $scope.zoomToAllMarkers = function (data) {
            var bounds = new google.maps.LatLngBounds();
            for (var i = 0; i < data.length; i++) {
                //  And increase the bounds to take this point
                bounds.extend(data[i]);
            }
            //  Fit these bounds to the map
            $scope.map.fitBounds(bounds);
        }



        $scope.viewMap = function (lat, lng) {
            console.log(lat, lng);
            $scope.map.panTo(new google.maps.LatLng(lat, lng));
        }


    }
]);
angular.module($APP.name).controller('IssuesCtrl', [
    '$scope',
    'Issues',
    'Wards',
    'Auth',
    'Mail',
    'MailList',
    '$modal',
    function ($scope, Issues, Wards, Auth, Mail, MailList, $modal) {
        console.log("IssuesCtrl");
        Auth.reload(
                function (response) {
                    $scope.areaName = response.areaName;
                    $scope.fromEmail = response.username;
                    $scope.fromCouncil = response.councilName;
                    if (response.role.roleId == 4)
                        Auth.logout();
                }
        );
        $scope.issueList = [];
        $scope.wardData = [];
        Wards.getWards(
                function (response) {
                    // Success
                    $scope.wardData = response;
                },
                function (err) {
                    // Error
                    console.log("Wards error = %o", err);
                }
        );
        var data = {
            "wardID": "all",
            "priority": "all",
            "status": "all"
        }

        $scope.getIssues = function () {
            Issues.getIssues(data,
                    function (response) {
                        // Success
                        console.log("Issues = %o", response);
                        $scope.issueList = response;
                        setTimeout(function () {
                            $scope.getIssues();
                        }, 30000);
                    },
                    function (err) {
                        // Error
                        console.log("Issues error = %o", err);
                    }
            );
        }
        var st_arr = [{id: 0, wname: "All"}];
        Wards.getWards(
                function (response) {
                    // Success
                    console.log("Wards = %o", response);
                    $scope.wardData = response;
                    // console.log(response);
                    //var stations = response.wards[0].stations;
                    var i, j;
                    j = 1;
                    console.log(response);
                    for (i = 0; i < response.wards.length; i++) {
                        var ward = response.wards[i].wardName;
                        st_arr.push({"id": j, "wname": ward});
                        j++;
                    }


                },
                function (err) {
                    // Error
                    console.log("Wards error = %o", err);
                }
        );
        $scope.wardList = {
            stores: st_arr};
        $scope.priorityList = {
            stores: [
                {id: 0, name: "All"},
                {id: 1, name: "LOW"},
                {id: 2, name: "MEDIUM"},
                {id: 3, name: "HIGH"}
            ]};
        $scope.statusList = {
            stores: [
                {id: 0, st: "All"},
                {id: 1, st: "OPEN"},
                {id: 2, st: "RESOLVED"},
            ]};


        $scope.payload = {
            "id": 0,
            "resolution": "",
            "status": true
        };
        $scope.priorityItem = {
            store: $scope.priorityList.stores[0]
        }
        $scope.statusItem = {
            store: $scope.statusList.stores[0]
        }
        $scope.wardItem = {
            store: $scope.wardList.stores[0]
        }
        $scope.cFilter = function (data) {

            if (data.priority.toLowerCase() === $scope.priorityItem.store.name.toLowerCase()) {
                return true;
            } else if ($scope.priorityItem.store.name === "All") {
                return true;
            } else {
                return false;
            }


        };
        $scope.sFilter = function (data) {
            var status;
            if (data.status === false)
                status = "OPEN";
            else
                status = "RESOLVED";
            if (status === $scope.statusItem.store.st) {
                return true;
            } else if ($scope.statusItem.store.st === "All") {
                return true;
            } else {
                return false;
            }
        };
        $scope.wFilter = function (data) {

            if (data.ward.toLowerCase() === $scope.wardItem.store.wname.toLowerCase()) {
                return true;
            } else if ($scope.wardItem.store.wname === "All") {
                return true;
            } else {
                return false;
            }
        };
        $scope.showResolveIssuePopup = function (issueId) {
            console.log("resolveIssue: %o", issueId);
            $scope.payload.id = issueId;
            $scope.popup = $modal.open({
                templateUrl: 'templates/resolve_issue_popup.html',
                scope: $scope
            });
        };
        $scope.showEmailPopup = function (issue) {


            MailList.list(
                    function (response) {
                        // Success
                        // console.log("Mails = %o", response);
                        var mailList = [];
                        if (typeof response.length === "undefined") {
                            mailList.push({"label": response["text"] + " (" + response["email"] + ")", "value": response["email"]});
                        } else {
                            for (var i = 0; i < response.length; i++) {
                                mailList.push({"label": response[i]["text"] + " (" + response[i]["email"] + ")", "value": response[i]["email"]});

                            }
                        }
                        $scope.message = issue.reason + ': "' + issue.description + '"';
                        $scope.mailList = mailList;
                        console.log(issue);

                        $scope.selectedEmail = $scope.mailList[0];
                    },
                    function (err) {

                        // Error
                        console.log("Mails error = %o", err);
                    }
            );



            $scope.popup = $modal.open({
                templateUrl: 'templates/send_email_popup.html',
                scope: $scope
            });

        };


        $scope.sendEmail = function (mail, message) {

           /* var data = {
                "mail_from": $scope.fromCouncil + " <" + $scope.fromEmail + ">",
                "mail_to": mail.value,
                "mail_subject": "[Polling Station Manager Notification]",
                "mail_body": message
            }*/
            var data = {
                "mail_from": $scope.fromCouncil + " <scoyle@moderndemocracy.com>",
                "mail_to": mail.value,
                "mail_subject": "[Polling Station Manager Notification]",
                "mail_body": message
            }

            Mail.sendEmail(data,
                    function (response) {
                        // Success
                        console.log("Mail = %o", response);
                        $scope.popup.close(500);
                    },
                    function (err) {
                        // Error
                        console.log("Mail error = %o", err);
                        $scope.popup.close(500);
                    }
            );
        }
        $scope.modalClose = function () {
            $scope.popup.close(500);
        };
        $scope.resolveIssue = function () {
            Issues.closeIssue($scope.payload,
                    function () {
                        // Success
                        console.log("Issue close success");
                        $scope.getIssues();
                        $scope.payload.resolution = "";
                        $scope.popup.close();
                    },
                    function () {
                        // Error
                        console.log("Issue close error");
                    }
            );
        };
        $scope.getIssues();
    }
]);
angular.module($APP.name).controller('ResolveCtrl', [
    '$scope',
    function ($scope) {

    }
]);
angular.module($APP.name).controller('LoginCtrl', [
    '$scope', 'Auth', '$location', "$rootScope",
    function ($scope, Auth, $location, $rootScope) {
        console.log("LoginCtrl");
        $scope.Login = function () {
            var data = {
                "email": $scope.loginEmail,
                "pass": $scope.loginPassword
            }


            Auth.login({
                username: $scope.loginEmail,
                password: $scope.loginPassword

            }, function (res) {
                console.log("Login success");
                $location.path("/dashboard");
            }, function (err) {
                $scope.loginError = 'Invalid login' + '. ' + 'Please enter valid username and password.';
                $rootScope.error = 'Failed to login';
            });
        }
    }
]);
angular.module($APP.name).controller('NotificationsCtrl', [
    '$scope',
    'Notification',
    'Auth',
    'Wards',
    'Upload',
    '$modal',
    function ($scope, Notification, Auth, Wards, Upload, $modal) {
        console.log("NotificationsCtrl");
        Auth.reload(
                function (response) {
                    $scope.areaName = response.areaName;
                    if (response.role.roleId == 4)
                        Auth.logout();
                }
        );
        function getWards() {
            var wa_arr = [{id: 0, name: "All"}];
            var st_arr = [];
            var ds_arr = [];
            var pl_arr = [];
            Wards.getWards(
                    function (response) {
                        // Success
                        console.log("Wards = %o", response);
                        $scope.wardData = response;
                        // console.log(response);
                        //var stations = response.wards[0].stations;
                        var i, j, z, x, v, f;
                        j = 1;
                        v = 1;
                        f = 1;
                        for (i = 0; i < response.wards.length; i++) {
                            var ward = response.wards[i];
                            wa_arr.push({"id": j, "name": ward.wardName, "wardId": ward.wardId});
                            j++;
                            if (typeof ward.districts != "undefined") {
                                for (var x = 0; x < ward.districts.length; x++) {
                                    var district = ward.districts[x];
                                    ds_arr.push({"id": v, "name": district.districtName, "ward": ward.wardId, "districtId": district.districtId});
                                    v++;
                                    if (typeof district.places != "undefined") {
                                        for (var z = 0; z < district.places.length; z++) {
                                            var place = district.places[z];
                                            pl_arr.push({"id": f, "name": place.placeName, "district": district.districtId, "placeId": place.placeId});
                                            f++;
                                            if (typeof place.stations != "undefined") {
                                                for (var n = 0; n < place.stations.length; n++) {
                                                    var station = place.stations[n];
                                                    st_arr.push({
                                                        "id": station.stationId,
                                                        "name": place.placeName + " (" + station.stationName + ")",
                                                        "place": place.placeId

                                                    });
                                                }
                                            }

                                        }
                                    }


                                }
                            }




                        }

                        console.log(ds_arr);
                    },
                    function (err) {
                        // Error
                        console.log("Wards error = %o", err);
                    }
            );
            $scope.wardList = {stores: wa_arr};
            $scope.stationList1 = {stores: st_arr};
            $scope.districtList = {stores: ds_arr};
            $scope.placeList = {stores: pl_arr};
            $scope.wardItem = {
                store: $scope.wardList.stores[0]
            };
            $scope.wFilter = function (data) {

                if (data.ward === $scope.wardItem.store.wardId) {
                    return true;
                } else {
                    return false;
                }
            };
            $scope.districtItem = {
                store: $scope.districtList.stores[0]
            };
            $scope.dFilter = function (data) {

                if (data.district === $scope.districtItem.store.districtId) {
                    return true;
                } else {
                    return false;
                }
            };
            $scope.placeItem = {
                store: $scope.placeList.stores[0]
            };
            $scope.pFilter = function (data) {

                if (data.place === $scope.placeItem.store.placeId) {
                    return true;
                } else {
                    return false;
                }
            };
            $scope.updateSelectedStation = function (station, wardId) {

                if (station)
                    $("#send").removeAttr("disabled", "disabled");
                else
                    $("#send").attr("disabled", "disabled");
                if (station)
                    $scope.selectedStation = station.id;
            };
            $scope.updateSelectedWard = function (wardId) {
                if (wardId > 0)
                    $("#send").attr("disabled", "disabled");
                else
                    $("#send").removeAttr("disabled", "disabled");
                $scope.selectedWard = wardId;
            };
        }
        var modalInstance;
        $scope.setFile = function (fileInput) {
            $scope.files = fileInput[0];
            //var filename = file.replace(/^.*[\\\/]/, '');
            //var title = filename.substr(0, filename.lastIndexOf('.'));

        }
        $scope.fileName = "";
        $scope.uploadFile = function () {
            var formData = new FormData();
            formData.append("file", $scope.files);
            var data = formData;
            Upload.uploadFile(data,
                    function (response) {
                        console.log(response);
                        $scope.fileName = $scope.files.name;
                        $scope.uploadFinished = "Upload successful!";
                    },
                    function (err) {
                        console.log("Upload error = %o", err);
                        $scope.uploadFinished = "Upload failed!";
                    }
            );
        }


        $scope.sendNotification = function () {

            var data = {
                "stationId": 0,
                "text": "",
                "url": $scope.fileName
            }

            if ($scope.selectedWard == 0) {
                // Global notification - send selected ward of 0
                data.stationId = 0;
            } else {
                data.stationId = $scope.selectedStation;
            }

            data.text = $scope.notificationText;
            if ($scope.selectedWard > 0 && typeof $scope.selectedStation === "undefined") {

                modalInstance = $modal.open({templateUrl: "templates/notification_fail_popup.html", scope: $scope});

            } else {

                if (data.text == "" || typeof data.text === "undefined") {

                    modalInstance = $modal.open({templateUrl: "templates/notification_sent_message_fail.html", scope: $scope});
                } else {
                    Notification.sendNotification(data,
                            function (response) {
                                // Success
                                console.log("Notifications = %o", response);
                                modalInstance = $modal.open({templateUrl: "templates/notification_sent_popup.html", scope: $scope});
                                Notification.getNotification(
                                        function (response) {
                                            for (var i = 0; i < response.length; i++) {

                                                if (response[i].url) {
                                                    var ext = response[i].url.substr(response[i].url.lastIndexOf('.') + 1);

                                                    switch (ext) {
                                                        case "pdf":
                                                            response[i].ext = "pdf";
                                                            break;
                                                        case "doc":
                                                            response[i].ext = "word";
                                                            break;
                                                        case "docx":
                                                            response[i].ext = "word";
                                                            break;
                                                        case "xls":
                                                            response[i].ext = "excel";
                                                            reak;
                                                        case "xlsx":
                                                            response[i].ext = "excel";
                                                            break;
                                                        default:
                                                            response[i].ext = "image";
                                                    }


                                                }

                                            }
                                            $scope.notificationData = response;
                                            $scope.uploadUrl = $APP.server + "/uploads/";
                                            $scope.fileName = "";
                                        },
                                        function (err) {
                                            console.log("notificationData error = %o", err);
                                        }
                                );
                                $("#browse").fileinput('reset');
                                $scope.uploadFinished = "";
                            },
                            function (err) {


                            }
                    );
                }
            }


        }
        Notification.getNotification(
                function (response) {
                    for (var i = 0; i < response.length; i++) {
                        if (response[i].url) {
                            var ext = response[i].url.substr(response[i].url.lastIndexOf('.') + 1);
                            switch (ext) {
                                case "pdf":
                                    response[i].ext = "pdf";
                                    break;
                                case "doc":
                                    response[i].ext = "word";
                                    break;
                                case "docx":
                                    response[i].ext = "word";
                                    break;
                                case "xls":
                                    response[i].ext = "excel";
                                    reak;
                                case "xlsx":
                                    response[i].ext = "excel";
                                    break;
                                default:
                                    response[i].ext = "image";
                            }

                        }

                    }
                    $scope.notificationData = response;
                    $scope.uploadUrl = $APP.server + "/uploads/";
                },
                function (err) {
                    console.log("notificationData error = %o", err);
                }
        );
        getWards();
        $scope.close = function (e) {
            $scope.selectedWard = 0;
            $scope.notificationText = "";
            modalInstance.close();
            getWards();
        }
        $scope.closeMessage = function (e) {

            modalInstance.close();
        }
    }
]);
