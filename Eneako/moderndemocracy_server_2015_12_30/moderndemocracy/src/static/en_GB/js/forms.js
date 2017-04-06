angular.module($APP.name).directive('form', ['$parse', function($parse) {
		return {
			restrict: 'EA',
			compile: function(cElement, cAttributes, transclude) {
				return {
					pre: function($scope, $elem, $attrs) {

						//console.log('FORM----------', angular.copy($scope.data));

						if(!$attrs["novalidate"]) {
							$elem.attr("novalidate", "novalidate");
						}

						if($attrs["name"]) {
							$scope.name = $attrs["name"];
						}
						else {
							$scope.name = "form" + Math.floor((Math.random() * 10000) + 1);
							$elem.attr("name", $scope.name);
						}

						$scope.safeApply = function(fn) {
							var phase = this.$root.$$phase;
							if(phase == '$apply' || phase == '$digest') {
								if(fn && (typeof (fn) === 'function')) {
									fn();
								}
							} else {
								this.$apply(fn);
							}
						};

						$scope.validateField = function(data) {
							data.errors = [];
							if(data.required && (data.value === undefined || data.value === "" || data.value === null || data.value.length === 0)) {
								data.errors.push({type: 'required', message: data.label + ' is required.'});
							}
							else if(data.minLength !== undefined && data.value !== undefined && data.value.length < data.minLength) {
								data.errors.push({type: 'required', message: data.label + ' is too short. Must be min ' + data.minLength + ' chars long.'});
							}
							else if(data.maxLength !== undefined && data.value !== undefined && data.value.length > data.maxLength) {
								data.errors.push({type: 'required', message: data.label + ' is too long. Must be max ' + data.minLength + ' chars long.'});
							}
							else if(data.minValue !== undefined && data.value !== undefined && data.value < data.minValue) {
								data.errors.push({type: 'required', message: data.label + ' is too small. Must be min ' + data.minValue + '.'});
							}
							else if(data.maxValue !== undefined && data.value !== undefined && data.value > data.maxValue) {
								data.errors.push({type: 'required', message: data.label + ' is too big. Must be max ' + data.maxValue + '.'});
							}
							else if(data.type == 'email' && data.value && !/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test(data.value)) {
								data.errors.push({type: 'invalid', message: data.label + ' is invalid e-mail address.'});
							}
							if(!$scope.$$phase) {
								$scope.$apply();
							}

							return data;
						}

						$scope.isValidFieldset = function(fieldsets) {
							if(fieldsets.fields) {
								for(var i = 0; i < fieldsets.fields.length; ++i) {
									if(fieldsets.fields[i] && fieldsets.fields[i].errors && fieldsets.fields[i].errors.length) {
										return false;
									}
								}
							}
							return true;
						}

						$scope.validateFieldset = function(fieldsets, valid) {
							if(fieldsets.fields) {
								for(var i = 0; i < fieldsets.fields.length; ++i) {
									fieldsets.fields[i] = $scope.validateField(fieldsets.fields[i]);
									valid = valid && !fieldsets.fields[i].errors.length;
									if(!$scope.$$phase) {
										$scope.$apply();
									}
								}
							}
							return valid;
						}

						$scope.validate = function() {
							var valid = true;
							if($scope.data && $scope.data.fieldsets) {
								for(var i = 0; i < $scope.data.fieldsets.length; ++i) {
									valid = valid && $scope.validateFieldset($scope.data.fieldsets[i], valid);
								}
							}
							return valid;
						}

						$scope.propagate = function(key, data) {
							if($scope.data && data !== undefined) {
								if($scope.data && $scope.data.fieldsets) {
									for(var i = 0; i < $scope.data.fieldsets.length; ++i) {
										$scope.data.fieldsets[i][key] = data;
										if($scope.data.fieldsets[i].fields) {
											for(var j = 0; j < $scope.data.fieldsets[i].fields.length; ++j) {
												$scope.data.fieldsets[i].fields[j][key] = data;
											}
										}
									}
								}
							}
						}

						$scope.$watch('data.disabled', function(data) {
							if(data !== undefined) {
								$scope.propagate('disabled', data);
							}
						});

						$scope.$watch('data.print', function(data) {
							if(data !== undefined) {
								$scope.propagate('print', data);
							}
						});

						$scope.$watch('data.print_always', function(data) {
							if(data !== undefined) {
								$scope.propagate('print_always', data);
							}
						});

						$scope.$on('validateField', function(data) {
							data.targetScope.data = $scope.validateField(data.targetScope.data);
						});

						$scope.$on('print-end', function() {
							if($scope.data) {
								$scope.safeApply(function() {
									if(!$scope.data.print_always) {
										$scope.data.print = false;
									}
								});
							}
						});

						$scope.$on('print-start', function() {
							if($scope.data) {
								$scope.safeApply(function() {
									$scope.data.print = true;
								});
							}
						});

						var fn = $parse($attrs.onSubmit);
						$elem.bind('submit', function() {
							$scope.$broadcast('submit');
							if(!$scope.$$phase) {
								$scope.$apply();
							}

							if(!$scope.validate()) {
								return false;
							}

							$scope.$apply(function(event) {
								fn($scope, {$event: event});
							});
						});

					}
				};
			}
		};
	}]);

angular.module($APP.name).directive('fieldset', [
	'$rootScope',
	function($rootScope) {
		return {
			restrict: 'EA',
			scope: {
				data: '='
			},
			link: function($scope, $elem, $attrs) {

				if(!$scope.data) {
					return;
				}

				//console.log('FIELDSET----------', angular.copy($scope.data));

				$scope.safeApply = function(fn) {
					var phase = this.$root.$$phase;
					if(phase == '$apply' || phase == '$digest') {
						if(fn && (typeof (fn) === 'function')) {
							fn();
						}
					} else {
						this.$apply(fn);
					}
				};
				$scope.isFieldInFieldset = function(hashKey) {
					if($scope.data.fields && $scope.data.fields.length) {
						for(var i = 0; i < $scope.data.fields.length; ++i) {
							if($scope.data.fields[i].$$hashKey == hashKey) {
								return true;
							}
						}
					}
					return false;
				}

				$rootScope.$on('invalidField', function(event, data) {
					if($scope.data) {
						if(!$scope.data.errors) {
							$scope.data.errors = [];
						}
						$scope.safeApply(function() {
							if($scope.data.errors.indexOf(data.$$hashKey) == -1 && $scope.isFieldInFieldset(data.$$hashKey)) {
								$scope.data.errors.push(data.$$hashKey);
							}
						});
					}
				});

				$rootScope.$on('validField', function(event, data) {
					if($scope.data && $scope.data.errors && $scope.data.errors.length) {
						$scope.safeApply(function() {
							var i = $scope.data.errors.indexOf(data.$$hashKey);
							if(i >= 0) {
								$scope.data.errors.splice(i, 1);
							}
						});
					}
				});

			}
		};
	}
]);

angular.module($APP.name).directive('field', ['$rootScope', '$http', '$compile', '$parse',
	function($rootScope, $http, $compile, $parse) {

		return {
			templateUrl: '/templates/form/_all.html',
			restrict: 'EA',
			scope: {
				data: '='
			},
			link: function($scope, $elem, $attrs) {

				//console.log('FIELD----------', $scope.data);

				$scope.original = angular.copy($scope.data);
				$scope.clean = false;
				$scope.dirty = false;
				$scope.submit = false;
				$scope.hash = "H" + $scope.$id;

				$scope.safeApply = function(fn) {
					var phase = this.$root.$$phase;
					if(phase == '$apply' || phase == '$digest') {
						if(fn && (typeof (fn) === 'function')) {
							fn();
						}
					} else {
						this.$apply(fn);
					}
				};

				$scope.$on('submit', function() {
					$scope.submit = true;
				});

				$scope.$on('print-end', function() {
					$scope.safeApply(function() {
						if(!$scope.data.print_always) {
							$scope.data.print = false;
							$scope.data.placeholder = $scope.original.placeholder;
						}
					});
				});

				$scope.$on('print-start', function() {
					$scope.safeApply(function() {
						$scope.data.print = true;
						$scope.data.placeholder = '';
					});
				});

				$scope.$watch('data.print_always', function(data) {
					$scope.data.placeholder = '';
				});

				// UPDATE as needed
				$scope.cleanValue = function(value, type) {

					//console.log('clean', value, type);
					switch(type) {
						case "number":
							return parseInt(value);
							break;
						case "checkbox":
							return value === true || value === "true" ? true : false;
							break;
						case 'checkbox_list':
							return value === "[]" ? [] : value;
							break;
						default:
							return value;
					}
				}

				$scope.$watch('data.value', function(data) {
					if($scope.clean && $scope.value != $scope.data.value) {
						$scope.dirty = true;
					}
					else { // clean
						$scope.clean = true;
						//console.log(angular.copy(data), angular.copy($scope.type));
						$scope.data.value = $scope.value = angular.copy($scope.cleanValue(data, $scope.data.type));
					}

					if(($scope.data.value == false && $scope.dirty) || $scope.submit || ($scope.data.value && $scope.data.errors && $scope.data.errors.length)) {
						//console.log($scope.data.value, $scope.dirty, $scope.value);
						$scope.$emit('validateField', $scope.data);
					}
				});

				$scope.$watch('data.errors', function(data) {
					if($scope.data.errors) {
						if($scope.data.errors.length) {
							$rootScope.$emit('invalidField', $scope.data);
						}
						else {
							$rootScope.$emit('validField', $scope.data);
						}
					}
				});

				if($scope.data.type == "checkbox_list") {
					$scope.$watch('data.options', function(data) {
						var value = [];
						for(var i = 0; i < data.length; ++i) {
							if(data[i].checked) {
								value.push(data[i].value);
							}
						}
						$scope.data.value = value;
					}, true);
				}

				$scope.$on('focus', function() {
					$elem.addClass('focus');
				});

				$scope.$on('blur', function() {
					$elem.removeClass('focus');
				});

			}
		};
	}
]);

angular.module($APP.name).directive('input', [
	function() {
		return {
			restrict: 'E',
			link: function($scope, $elem, $attrs) {
				$elem.bind('click', function() {
					$elem[0].focus();
				}); // fixes bug
				$elem.bind('focus', function() {
					$scope.$emit('focus');
				});
				$elem.bind('blur', function() {
					$scope.$emit('blur');
				});
			}
		};
	}
]);

angular.module($APP.name).directive('textarea', [
	function() {
		return {
			restrict: 'E',
			link: function($scope, $elem, $attrs) {
				$elem.bind('click', function() {
					$elem[0].focus();
				}); // fixes bug

				$elem.bind('focus', function() {
					$scope.$emit('focus');
				});
				$elem.bind('blur', function() {
					$scope.$emit('blur');
				});
			}
		};
	}
]);

angular.module($APP.name).directive('select', [
	function() {
		return {
			restrict: 'E',
			link: function($scope, $elem, $attrs) {
				$elem.bind('click', function() {
					$elem[0].focus();
				}); // fixes bug
				$elem.bind('focus', function() {
					$scope.$emit('focus');
				});
				$elem.bind('blur', function() {
					$scope.$emit('blur');
				});
			}
		};
	}
]);

angular.module($APP.name).directive('sketch', [
	function() {
		return {
			restrict: 'A',
			link: function($scope, $element, $attrs) {
				$($element[0]).sketch();
			}
		};
	}
]);



angular.module($APP.name).directive('sketchErase', [
	function() {
		return {
			restrict: 'A',
			link: function($scope, $element, $attrs) {
				$scope.erase = function() {
					$('#' + $attrs.sketchErase).sketch().actions = []
				    var myCanvas = document.getElementById($attrs.sketchErase);
				    var ctx = myCanvas.getContext('2d');
				    ctx.clearRect(0, 0, myCanvas.width, myCanvas.height);
				};
			}
		};
	}
]);