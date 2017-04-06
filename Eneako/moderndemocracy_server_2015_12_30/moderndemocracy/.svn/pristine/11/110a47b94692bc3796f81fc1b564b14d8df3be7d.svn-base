'use strict';
var $APP = $APP || {}; // App namespace

angular.module($APP.name).factory('Data', [
    '$resource',
    function ($resource) {
        return $resource('/data/api/:name.json', {}, {
            query: {
                method: 'GET',
                isArray: true
            },
            get: {
                method: 'GET'
            }
        });
    }
]);







angular.module($APP.name).factory('messagesInterceptor', [
    '$q',
    '$rootScope',
    '$location',
    function ($q, $rootScope, $location) {
        return {
            'response': function (response) {

                try {
                    if (!response.data) {
                        response.data = $RESPONSE.data[response.config.url][response.config.method]["success"];
                    }
                    else if (!response.data.alert) {
                        response.data.success = $RESPONSE.data[response.config.url][response.config.method]["success"].success;
                        response.data.alert = $RESPONSE.data[response.config.url][response.config.method]["success"].alert;
                    }

                }
                catch (e) {
                }

                if (response.data && typeof response.data.alert !== 'undefined') {
                    $rootScope.$broadcast('messages', {
                        type: response.data.alert.type.toLowerCase(),
                        message: response.data.alert.message
                    });
                }
                return response;
            },
            'responseError': function (response) {

                try {
                    if (!response.data) {
                        response.data = $RESPONSE.data[response.config.url][response.config.method]["error"];
                    }
                    if (!response.data.alert) {
                        response.data.success = $RESPONSE.data[response.config.url][response.config.method]["error"].success;
                        response.data.alert = $RESPONSE.data[response.config.url][response.config.method]["error"].alert;
                    }
                }
                catch (e) {
                }

                if ((response.status === 401 || response.status === 403)) {
                    // public permission
                    if ($rootScope.$root.permission !== 7) {
                        $location.path('/');
                    }
                    return $q.reject(response);
                } else {

                    if (response.data && typeof response.data.alert !== 'undefined') {
                        $rootScope.$broadcast('messages', {message: response.data.alert.message, type: 'error'});
                    }
                    else {
                        $rootScope.$broadcast('messages', {message: response.status + " Error", type: 'error'});
                    }
                    return $q.reject(response);
                }
            }
        };
    }
]);






angular.module($APP.name).factory('Form', [
    '$resource',
    function ($resource) {

        function transformRequest(data, headersGetter) {

            var form = angular.copy(data);

            if (form.fieldsets) {
                for (var i = 0; i < form.fieldsets.length; ++i) {

                    if (form.fieldsets[i].fields) {
                        for (var j = 0; j < form.fieldsets[i].fields.length; ++j) {
                            var validation = {
                                minLength: form.fieldsets[i].fields[j].minLength,
                                maxLength: form.fieldsets[i].fields[j].maxLength,
                                minValue: form.fieldsets[i].fields[j].minValue,
                                maxValue: form.fieldsets[i].fields[j].maxValue
                            };
                            form.fieldsets[i].fields[j].validation = JSON.stringify(validation);
                        }
                    }
                }
            }

            var map = {
                label: 'name',
                description: 'guidance',
                fieldsets: 'field_group_designs',
                fields: 'field_designs',
                options: 'option_designs',
                value: 'default_value',
                text: 'name',
            };

            $UTL.reMap(form, map, {text: 4, value: 6});
            $UTL.cleanJSON(form);
            return JSON.stringify(form);
        }

        function transformResponse(data, headersGetter) {

            if (!data) {
                return data;
            }
            var form = angular.copy(JSON.parse(data));

            var map = {
                name: 'label',
                guidance: 'description',
                field_group_designs: 'fieldsets',
                field_designs: 'fields',
                option_designs: 'options',
                default_value: 'value'
            };

            $UTL.reMap(form, map, {name: 6});
            $UTL.reMap(form, {name: 'text'});

            if (form.fieldsets) {
                for (var i = 0; i < form.fieldsets.length; ++i) {
                    if (form.fieldsets[i].fields) {
                        for (var j = 0; j < form.fieldsets[i].fields.length; ++j) {
                            try {
                                var validation = JSON.parse(form.fieldsets[i].fields[j].validation);
                                form.fieldsets[i].fields[j].minLength = validation.minLength;
                                form.fieldsets[i].fields[j].maxLength = validation.maxLength;
                                form.fieldsets[i].fields[j].minValue = validation.minValue;
                                form.fieldsets[i].fields[j].maxValue = validation.maxValue;
                            }
                            catch (e) {
                            }
                        }
                    }
                }
            }

            //$UTL.cleanJSON(form);
            return form;
        }

        return $resource('/api/formdesign', {}, {
            list: {
                method: 'GET',
                isArray: true
            },
            get: {
                method: 'GET',
                params: {'id': '@id'},
                transformResponse: transformResponse
            },
            create: {
                method: 'POST',
                transformRequest: transformRequest
            },
            update: {
                method: 'PUT',
                transformRequest: transformRequest
            },
        });
    }
]);






angular.module($APP.name).factory('Customer', [
    '$resource',
    function ($resource) {
        return $resource('/api/customer', {}, {
            list: {
                method: 'GET',
                isArray: true,
                transformResponse: function (data, headersGetter) {
                    data = JSON.parse(data);
                    var list = [];
                    if (data && data.length) {
                        for (var i = 0; i < data.length; ++i) {
                            list.push({value: data[i].id, text: data[i].name});
                        }
                    }
                    return list;
                }
            },
            get: {
                method: 'GET',
                isArray: false,
                params: {'id': '@id'},
            }
        });
    }
]);




//---------------------------------------------------------------------
// WARDS SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('Wards', [
    '$http',
    '$location',
    '$rootScope',
    function ($http, $location, $rootScope) {

        return {
            getWards: function (successCallback, errorCallback) {

                $http.get($APP.server + '/api/wardretrieve')
                        .success(function (response) {

                            console.log("Wards.getWards success");
                            successCallback(response);

                        }).error(function (responseData, status, headers, config) {
                    console.log("Wards.getWards error: %o", responseData);

                    errorCallback(responseData);
                    $location.path("/");
                    if (status == 502) {
                        // service down
                        $rootScope.online = false;
                    }
                });
            }
        };
    }
]);







//---------------------------------------------------------------------
// ISSUES SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('Issues', [
    '$http',
    '$location',
    '$rootScope',
    function ($http, $location, $rootScope) {

        return {
            getIssues: function (data, successCallback, errorCallback) {

                $http.get($APP.server + '/api/issueretrieve', data)
                        .success(function (response) {

                            console.log("Issues.getIssues success");
                            successCallback(response);

                        }).error(function (responseData, status, headers, config) {
                    console.log("Issues.getIssues error: %o", responseData);
                    $location.path("/");
                    errorCallback(responseData);

                    if (status == 502) {
                        // service down
                        $rootScope.online = false;
                    }
                });
            },
            closeIssue: function (data, successCallback, errorCallback) {
                $http.put(
                        $APP.server + '/pub/issueclose',
                        data)
                        .success(function (response) {

                            console.log("Issues.closeIssue success");

                            $rootScope.online = true;
                            successCallback(response);

                        }).error(function (responseData, status, headers, config) {
                    console.log("Issues.closeIssue error: %o", responseData);
                    $location.path("/");
                    errorCallback(responseData);

                    if (status == 502) {
                        // service down
                        $rootScope.online = false;
                    }
                });
            }
        };
    }
]);





//---------------------------------------------------------------------
// NOTIFICATION SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('Notification', [
    '$http',
    '$location',
    '$rootScope',
    function ($http, $location, $rootScope) {

        return {
            sendNotification: function (data, successCallback, errorCallback) {
                
                $http.post(
                        $APP.server + '/api/notificationopen',
                        data)
                        .success(function (response) {

                            console.log("Notification.sendNotification success");

                            $rootScope.online = true;
                            successCallback(response);

                        }).error(function (responseData, status, headers, config) {
                    console.log("Notification.sendNotification error: %o", responseData);

                    errorCallback(responseData);

                    if (status == 502) {
                        // service down
                        $rootScope.online = false;
                    }
                });
            }, getNotification: function (successCallback, errorCallback) {

                $http.get(
                        $APP.server + '/api/notificationlist',{withCredentials: true})
                                .success(function (response) {

                                    

                                    $rootScope.online = true;
                                    successCallback(response);

                                }).error(function (responseData, status, headers, config) {
                            console.log("notifications.get error: %o", responseData);

                            errorCallback(responseData);

                            if (status == 403) {
                                $location.path('/login');
                            }
                            else if (status == 502) {
                                // service down
                                $rootScope.online = false;
                            }
                        });


                        //end retireve
                    }
        };
    }
]);


//---------------------------------------------------------------------
// TRACKING SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('Tracking', [
    '$http',
    function ($http) {
        return {
            list: function (successCallback) {
                $http.get('/api/trackingretrieve')
                        .success(function (data) {
                            successCallback(data);
                        }).error(function (responseData, status, headers, config) {

                });
            }
        };
    }
]);


//---------------------------------------------------------------------
// AUTH SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('Auth', [
    '$http',
    '$location',
    '$rootScope',
    function ($http, $location, $rootScope) {

        //var accessLevels = routingConfig.accessLevels, userRoles = routingConfig.userRoles, 
        var currentUser = {
            username: '',
            role: 0 	//userRoles.pub
        };

        function randomStr() {
            var text = "";
            var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

            for (var i = 0; i < 5; i++)
                text += possible.charAt(Math.floor(Math.random() * possible.length));

            return text;
        }

        function changeUser(user) {
            _.extend(currentUser, user);

            // Save user info to settings cache
        }

        function setUser(user) {
            console.log("Auth.setUser - recieved info %o", user);



            $rootScope.userInfo = user;
        }

        return {
            init: function (accessLevel) {
                $http.get($APP.server + '/api/me', {withCredentials: true, cache: false}).success(function (user) {
                    console.log("Auth.init success");

                    setUser(user);

                    $rootScope.online = true;

                    $location.path('/dashboard');
                }).error(function (data, status, headers, config) {
                    console.log("Auth.init error: %o", data);

                    if (status == 403) {
                        $location.path('/');
                    }
                    else if (status == 502) {
                        // service down
                        $rootScope.online = false;
                    } else {
                        $location.path('/');
                    }
                });
            },
            reload: function (callback) {
                var rand = randomStr();
                $http.get($APP.server + '/api/me?' + rand, {withCredentials: true, cache: false}).success(function (user) {
                    setUser(user);
                    $rootScope.councilLogo = user.councilLogoUrl;
                    $rootScope.username = user.username;
                    if (callback) {
                        callback(user);
                    }


                    if (typeof user.role === "undefined") {
                        if (user.data.role.roleId == 4) {

                            $("#mainNavigation").addClass("one-nav");
                            $("#mainNavigationUl li").hide();
                            $("#mainNavigationUl li#dashboard").show();
                            $("#mainNavigationUl li#nav_blank").hide();


                        }
                        else {
                            $("#mainNavigation").removeClass("one-nav");
                            $("#mainNavigationUl li").show();
                            $("#mainNavigationUl li#nav_blank").hide();

                        }

                    } else {

                        if (user.role.roleId == 4) {

                            $("#mainNavigation").addClass("one-nav");
                            $("#mainNavigationUl li").hide();
                            $("#mainNavigationUl li#dashboard").show();
                            $("#mainNavigationUl li#nav_blank").hide();
                        }
                        else {
                            $("#mainNavigation").removeClass("one-nav");
                            $("#mainNavigationUl li").show();
                            $("#mainNavigationUl li#nav_blank").hide();

                        }
                    }



                })
                        .error(function (data, status, headers, config) {
                            // alert("API ME ERROR xxxx" + $APP.server );
                            // alert("API ME data xxxx" + data );
                            // alert("API ME status xxxx" + status );
                            // alert("API ME headers xxxx" + headers );
                            // alert("API ME config xxxx" + config );
                            $location.path('/');
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
            isLoggedInWithCallback: function () {
                var loggedIn = this.isLoggedIn;
                $http.get($APP.server + '/api/me', {withCredentials: true, cache: false}).success(function (user) {
                    setUser(user);
                    if (loggedIn()) {
                        if ($location.path() == '/') {
                            $location.path(document.referrer);
                        }
                    }
                    else {
                        $location.path('/');
                    }
                    //deferred.resolve(user);
                }).error(function (data, status, headers, config) {
                    if (status == 403) {
                        $location.path('/');
                    }
                    else if (status == 502) {
                        // service down
                        $rootScope.online = false;
                    }
                });
            },
            login: function (user, success, error) {
                console.log("Auth.login - sending info = %o", user);
                $http({
                    method: 'POST',
                    url: $APP.server + '/pub/login',
                    withCredentials: true,
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'Accept': 'application/json;odata=verbose'
                    },
                    transformRequest: function (obj) {
                        return 'login.user.name=' + user.username + '&login.user.password=' + user.password + '&user=true';
                    },
                    data: user
                }).success(function (user) {
                    setUser(user);
                    success(user.data);



                }).error(function (data, status) {
                    error(data, status)
                });
            },
            logout: function (success, error) {
                $http.post($APP.server + '/api/logout', {withCredentials: true}).success(function () {
                    setUser({
                        id: null,
                        username: '',
                        role: 0
                    });
                    $location.path('/');
                    //success();
                }).error(error);
            },
            //accessLevels: accessLevels,
            //userRoles: userRoles,
            user: currentUser
        };
    }
])

//---------------------------------------------------------------------
// UPLOAD SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('Upload', [
    '$http',
    '$location',
    '$rootScope',
    function ($http, $location, $rootScope) {

        return {
            uploadFile: function (data, successCallback, errorCallback) {
                $http.post(
                        $APP.server + '/api/fileupload',
                        data, {
                            withCredentials: true,
                            headers: {'Content-Type': undefined },
                            transformRequest: angular.identity
                        })
                        .success(function (response) {

                            console.log("upload success");

                            $rootScope.online = true;
                            successCallback(response);

                        }).error(function (responseData, status, headers, config) {
                    console.log("Upload error: %o", responseData);


                    if (status == 502) {
                        // service down
                        $rootScope.online = false;
                    }
                });
            }
        };
    }
]);
//---------------------------------------------------------------------
// MAIL SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('Mail', [
    '$http',
    '$location',
    '$rootScope',
    function ($http, $location, $rootScope) {

        return {
            sendEmail: function (data, successCallback, errorCallback) {
                $http.post(
                        $APP.server + '/api/sendmail',
                        data)
                        .success(function (response) {

                            console.log("mail sent success");

                            $rootScope.online = true;
                            successCallback(response);

                        }).error(function (responseData, status, headers, config) {
                            console.log("Mail error: %o", responseData);


                    if (status == 502) {
                        // service down
                        $rootScope.online = false;
                    }
                });
            }
        };
    }
]);

//---------------------------------------------------------------------
// STATIONOPEN SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('StationOpen', [
    '$http',
    function ($http) {
        return {
            getChecklist: function (data,successCallback) {
                $http.get('/api/stationopen?stationId=' + data, {withCredentials: true, cache: false})
                        .success(function (response) {
                            successCallback(response);
                        }).error(function (responseData, status, headers, config) {

                            console.log("Chcecklist Error : " + responseData);

                });
            }
        };
    }
]);


//---------------------------------------------------------------------
// MAILLIST SERVICE
//---------------------------------------------------------------------
angular.module($APP.name).factory('MailList', [
    '$http',
    function ($http) {
        return {
            list: function (successCallback) {
                $http.get('/api/issuelist')
                        .success(function (data) {
                            successCallback(data);
                        }).error(function (responseData, status, headers, config) {
                    
                });
            }
        };
    }
]);