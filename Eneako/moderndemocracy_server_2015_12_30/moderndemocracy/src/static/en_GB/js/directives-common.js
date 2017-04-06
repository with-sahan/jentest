'use strict';

//---------------------------------------------------------------------
// NAMESPACE DECLARATIONS
//---------------------------------------------------------------------
var $APP = $APP || {};	// App namespace

angular.module($APP.name).directive('accessLevel', [
	'Auth',
	function(Auth) {
		return {
			restrict: 'A',
			link: function($scope, $element, $attrs) {
				var prevDisp = $element.css('display'), userRole, accessLevel;
				$scope.user = Auth.user;
				$scope.$watch('user', function(user) {
					userRole = user.role;
					userRole.bitMask = parseInt(userRole.bitMask, 10);
					updateCSS();
				}, true);
				$attrs.$observe('accessLevel', function(al) {
					if(al) {
						accessLevel = $scope.$eval(al);
					}
					updateCSS();
				});
				function updateCSS() {
					if(userRole && accessLevel) {
						if(!Auth.authorize(accessLevel, userRole)) {
							$element.css('display', 'none');
						}
						else {
							$element.css('display', prevDisp);
						}
					}
				}
			}
		};
	}
]);

angular.module($APP.name).directive('nav', [
	'$location',
	function($location) {
		return {
			restrict: 'E',
			scope: true,
			link: function($scope, $elem, $attrs) {

				// map items to assoc array by url
				var unwatch = $scope.$watch('items', function(data) {
					if(!data) {
						return;
					}
					$scope.items_map = {};
					for(var i = 0; i < data.length; ++i) {
						$scope.items_map[data[i].url] = data[i];
					}
					unwatch();
				});

				$scope.$watch('$location.$$url', function() {
					if($scope.items_map) {
						if($scope.items_map[$location.$$url]) {
							$scope.items_map[$location.$$url].active = true;
						}
						else if($scope.items_map[$location.$$absUrl]) {
							$scope.items_map[$location.$$absUrl].active = true;
						}
					}
				});
			}
		};
	}
]);

angular.module($APP.name).directive('rawNav', [
	'$location',
	function($location) {
		return {
			restrict: 'EA',
			scope: true,
			link: function($scope, $elem, $attrs) {
				$scope.$watch('$location.$$url', function() {
					var anchors = $elem.find('a');
					for(var i = 0; i < anchors.length; ++i) {
						if(anchors[i].href == $location.$$url || anchors[i].href == $location.$$absUrl) {
							angular.element(anchors[i]).addClass('active');
						}
						else {
							angular.element(anchors[i]).removeClass('active');
						}
					}

				});
			}
		};
	}
]);

angular.module($APP.name).directive('messages', [
	'$animate',
	'$timeout',
	function($animate, $timeout) {
		return {
			link: function($scope, $element, $attrs) {
				var hide = function() {
					$animate.addClass($element, 'leave');
					$animate.removeClass($element, 'enter');
				};
				$scope.$on('messages', function(event, data) {
					$scope.message = data.message;
					$scope.type = data.type;
					$animate.addClass($element, 'enter');
					$animate.removeClass($element, 'leave');
					$timeout(hide, 3000);
				});
			}
		};
	}
]);
angular.module($APP.name).directive('minimizeWindow', [
	function() {
		return {
			link: function($scope, $element, $attrs) {
				$element.bind('click', function(e) {
					cancelFullScreen();
				});
			}
		};
	}
]);


angular.module($APP.name).directive('fullscreen', [
	function() {
		return {
			//controller: function($scope) {

			//},
			link: function($scope, $element, $attrs) {
				//var triggered = false;

				$element.bind('click', function(e) {
					if($scope.full) {
						requestFullScreen();
						//triggered = true;
					}
				});

				$element.triggerHandler("click");
			}
		};
	}
]);

angular.module($APP.name).directive('validateSubmit', [
	'$parse',
	function($parse) {
		return {
			restrict: 'A',
			require: ['validateSubmit', '?form'],
			controller: ['$scope', function($scope) {
					this.attempted = false;

					var formController = null;

					this.setAttempted = function() {
						this.attempted = true;
					};

					this.setFormController = function(controller) {
						formController = controller;
					};

					this.needsAttention = function(fieldModelController) {

						if(!formController)
							return false;
						if(fieldModelController) {
							//console.log("needsAttention", fieldModelController, fieldModelController.$invalid);
							return fieldModelController.$invalid && (fieldModelController.$dirty || this.attempted);
						} else {
							return formController && formController.$invalid && (formController.$dirty || this.attempted);
						}
					};

					$scope.invalidate = function(errors) {
						for(var field in errors) {
							if($scope.form[field]) {
								//$scope.form[field].$valid = !($scope.form[field].$invalid = true);
								$scope.form[field].$setValidity('required', false);
								$parse('messages.' + field).assign($scope, errors[field]);
							}
						}
					};

					$scope.validate = function(fields) {
						for(var field in fields) {
							if($scope.form[field]) {
								//$scope.form[field].$valid = !($scope.form[field].$invalid = false);
								$scope.form[field].$setValidity('required', true);
							}
						}
					}

				}],
			compile: function(cElement, cAttributes, transclude) {
				return {
					pre: function(scope, formElement, attributes, controllers) {

						var submitController = controllers[0];
						var formController = (controllers.length > 1) ? controllers[1] : null;

						submitController.setFormController(formController);

						scope.vs = scope.vs || {};
						scope.vs[attributes.name] = submitController;
					},
					post: function(scope, formElement, attributes, controllers) {

						var submitController = controllers[0];
						var formController = (controllers.length > 1) ? controllers[1] : null;
						var fn = $parse(attributes.validateSubmit);

						formElement.bind('submit', function() {
							submitController.setAttempted();
							if(!scope.$$phase)
								scope.$apply();
							if(!formController.$valid)
								return false;
							scope.$apply(function(event) {
								fn(scope, {$event: event});
							});
						});
					}
				};
			}
		};
	}
]);

angular.module($APP.name).directive('ngConfirmClick', [
	function() {
		return {
			priority: 1,
			terminal: true,
			controller: 'ModalCtrl',
			link: function($scope, $elem, $attrs) {
				$attrs.templateUrl = '_confirm.html';
				$attrs.msg = $attrs.ngConfirmClick || "Are you sure?";
				var clickAction = $attrs.ngClick;
				$elem.bind('click', function(event) {
					$scope.open();
				});

				$scope.$watch('confirmed', function() {
					if($scope.confirmed === true) {
						$scope.$eval(clickAction)
					}
				});
			}
		};
	}]);


angular.module($APP.name).directive('fileUpload', [
	function() {
		return {
			controller: 'fileUploadCtrl',
			scope: true,
			link: function($scope, $element, $attrs) {

			}
		};
	}
]);

angular.module($APP.name).directive('ngThumb', ['$window', function($window) {
		var helper = {
			support: !!($window.FileReader && $window.CanvasRenderingContext2D),
			isFile: function(item) {
				return angular.isObject(item) && item instanceof $window.File;
			},
			isImage: function(file) {
				var type = '|' + file.type.slice(file.type.lastIndexOf('/') + 1) + '|';
				return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
			}
		};

		return {
			restrict: 'A',
			template: '<canvas/>',
			link: function(scope, element, attributes) {
				if(!helper.support)
					return;

				var params = scope.$eval(attributes.ngThumb);

				if(!helper.isFile(params.file))
					return;
				if(!helper.isImage(params.file))
					return;

				var canvas = element.find('canvas');
				var reader = new FileReader();

				reader.onload = onLoadFile;
				reader.readAsDataURL(params.file);

				function onLoadFile(event) {
					var img = new Image();
					img.onload = onLoadImage;
					img.src = event.target.result;
				}

				function onLoadImage() {
					var width = params.width || this.width / this.height * params.height;
					var height = params.height || this.height / this.width * params.width;
					canvas.attr({width: width, height: height});
					canvas[0].getContext('2d').drawImage(this, 0, 0, width, height);
				}
			}
		};
	}]);

angular.module($APP.name).directive('selectOnFocus', [
	function() {
		return {
			restrict: 'A',
			link: function($scope, $elem, $attrs) {
				$elem.on('click', function() {
					this.select();
				});
			}
		};
	}
]);

angular.module($APP.name).directive('browser', [
	function() {
		return {
			scope: true,
			link: function($scope, $elem, $attrs) {
				$scope.sayswho = function() {
					var ua = navigator.userAgent, tem,
						M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];

					if(/trident/i.test(M[1])) {
						tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
						return 'IE ' + (tem[1] || '');
					}
					if(M[1] === 'Chrome') {
						tem = ua.match(/\bOPR\/(\d+)/)
						if(tem != null) {
							return 'Opera ' + tem[1];
						}
					}
					M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
					if((tem = ua.match(/version\/(\d+)/i)) != null) {
						M.splice(1, 1, tem[1]);
					}
					//return M.join(' ');
					return M[0];
				};

				$elem.addClass($scope.sayswho());
			}
		};
	}
]);


angular.module($APP.name).directive('sortable', [
	'$timeout',
	function($timeout) {
		return {
			scope: {
				sortable: "="
			},
			link: function($scope, $element, $attrs) {

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

				$scope.$watch('sortable', function(data) {
					return;
					if($element.hasClass('sortable-init')) {
						return;
					}

					$element.addClass('sortable-init');
					var el = $element[0];

					var s = new Sortable(el, {
						onUpdate: function(evt) {

							var elements = $element.children("li");
							//var tmp = angular.copy($scope.sortable);

							var sorted = [];
							for(var i = 0; i < elements.length; ++i) {
								var index = parseInt(elements[i].getAttribute('data-index'));
								sorted.push($scope.sortable[index]);
							}


							//$scope.sortable = angular.copy(sorted);
							$scope.sortable = sorted;
							$scope.$apply();
						}
					});
				});
			}
		};
	}
]);

angular.module($APP.name).directive('repeating', [
	'$location',
	function($location) {
		return {
			restrict: 'EA',
			/*scope: true,*/
			link: function($scope, $elem, $attrs) {

				$scope.repeat = function() {
					//console.log($elem[0]);

					var copy = $elem[0].cloneNode(true);
					copy.className = '';
					$elem[0].parentNode.insertBefore(copy, $elem[0].nextSibling);

				}

			}
		};
	}
]);

angular.module($APP.name).directive('pdf', [
	function() {
		return {
			link: function($scope, $elem, $attrs) {

				$elem.addClass('pdf');

				$scope.pdf_max_width = 210; // A4 width
				$scope.pdf_max_height = 297; // A4 width	
				$scope.page_width_margin = 20; // A4 page print margin - http://www.all-size-paper.com/A4/a4-paper-size.php
				$scope.page_height_margin = 25; // A4 page print margin	- http://www.all-size-paper.com/A4/a4-paper-size.php

				$scope.max_width = $scope.pdf_max_width - $scope.page_width_margin * 2;
				$scope.max_height = $scope.pdf_max_height - $scope.page_height_margin * 2;
				$scope.footer_height = 20; // default value
				
				$scope.margin = 2; // margin between sections
				$scope.progress = false;
				$scope.sections = [];
				$scope.footers = [];

				$scope.getPageCount = function(sections, footer) {
					var page_height = 0;
					var max_height = $scope.max_height;
					var width = $scope.max_width;
					var count = 1;
					var footer_height = footer ? $scope.footer_height : 0;
					for(var i = 0; i < sections.length; ++i) {
						var x = sections[i].height / sections[i].width;
						var width = $scope.max_width;
						var height = width * x;

						if(page_height + height + footer_height >= max_height) {
							++count;
							page_height = 0;
						}
						page_height += height + $scope.margin;
					}
					return count;
				}

				$scope.createPDF = function(doc, name) {
					var page_height = 0;
					var page_num = 0;
					var max_height = $scope.max_height;

					for(var i = 0; i < $scope.sections.length; ++i) {
						var x = $scope.sections[i].height / $scope.sections[i].width;
						var width = $scope.max_width;
						var height = width * x;

						var footer = $scope.footers && $scope.footers[page_num] ? $scope.footers[page_num] : null;
						var footer_height = footer ? (width * (footer.height / footer.width)) : 0;

						if(page_height + height + $scope.footer_height >= max_height) {

							if(footer) {
								doc.addImage(footer.toDataURL('image/jpeg', 1.0), 'JPEG',
									$scope.page_width_margin, $scope.page_height_margin + $scope.max_height - footer_height,
									width, footer_height); // add footer
							}

							doc.addPage();
							page_num++
							page_height = 0;
						}

						doc.addImage($scope.sections[i].toDataURL('image/jpeg', 1.0), 'JPEG',
							$scope.page_width_margin, $scope.page_height_margin + page_height,
							width, height);
						page_height += height + $scope.margin;
					}

					// last page footer
					if($scope.footers && $scope.footers[page_num]) {
						var footer_x = $scope.footers[page_num].height / $scope.footers[page_num].width;
						var footer_height = width * footer_x;
						doc.addImage($scope.footers[page_num].toDataURL('image/jpeg', 1.0), 'JPEG',
							$scope.page_width_margin, $scope.page_height_margin + $scope.max_height - footer_height,
							width, footer_height); // add footer							
						//document.body.appendChild($scope.footers[page_num]);
					}

					if($scope.sections && $scope.sections.length) {
						// don't print empty pdf
						doc.save((name ? name : 'tmp') + '.pdf');
					}

					$scope.$broadcast('print-end');
					$scope.$emit('print-end');
					$elem.removeClass('progress');
				}

				$scope.createFooters = function(footer, page_count, i, doc, name) {
										
					if(page_count > i && footer) {

						if(footer.getElementsByTagName('span')) {
							angular.element(footer.getElementsByTagName('span')[0]).html((i + 1) + ' of ' + page_count);
						}

						html2canvas(footer, {
							onrendered: function(canvas) {
								if(canvas.height) {
									// postfix of black alien border (wraper margin auto)
									var ctx = canvas.getContext('2d');
									ctx.fillStyle = "#fff";
									ctx.fillRect(0, 0, canvas.width, 1); // top
									ctx.fillRect(canvas.width - 1, 0, canvas.width, canvas.height); // left
									ctx.fillRect(0, canvas.height - 1, canvas.width, canvas.height); // bottom
									ctx.fillRect(0, 0, 1, canvas.height); // left
									$scope.footers.push(canvas);
								}
								$scope.createFooters(footer, page_count, i + 1, doc, name);
							}
						});
					}
					else {
						$scope.createPDF(doc, name);
					}
				}

				$scope.createSections = function(sections, footer, i, doc, name) {
					if(sections && sections[i]) {
						html2canvas(sections[i], {
							onrendered: function(canvas) {
								if(canvas.height) {
									// postfix of black alien border (wraper margin auto)
									var ctx = canvas.getContext('2d');
									ctx.fillStyle = "#fff";
									ctx.fillRect(0, 0, canvas.width, 1); // top
									ctx.fillRect(canvas.width - 1, 0, canvas.width, canvas.height); // left
									ctx.fillRect(0, canvas.height - 1, canvas.width, canvas.height); // bottom
									ctx.fillRect(0, 0, 1, canvas.height); // left
									//document.body.appendChild(canvas);									
									$scope.sections.push(canvas);
								}
								$scope.createSections(sections, footer, i + 1, doc, name);
							}
						});
					}
					else {
						var page_count = $scope.getPageCount($scope.sections, footer);
						$scope.createFooters(footer, page_count, 0, doc, name);
					}
				}

				$scope.pdf = function(name) {

					if($scope.progress == true) {
						return;
					}

					try {
						$scope.$broadcast('print-start');
						$scope.$emit('print-start');
						$elem.addClass('progress');

						var doc = new jsPDF('p', 'mm', 'A4');
						var html = $elem[0].getElementsByClassName('pdf-view')[0];

						var sections_raw = html.getElementsByTagName('section');
						var sections = [];
						for(var i = 0; i < sections_raw.length; ++i) {
							sections.push(sections_raw[i]);
						}

						var header = html.getElementsByTagName('header') ? html.getElementsByTagName('header')[0] : null;
						var footer = html.getElementsByTagName('footer') ? html.getElementsByTagName('footer')[0] : null;

						if(header) {
							sections.unshift(header);
						}

						if(sections.length > 1) {
							$scope.createSections(sections, footer, 0, doc, name);
						}
						else {
							$scope.$broadcast('print-end');
							$scope.$emit('print-end');
							$elem.removeClass('progress');
						}
					}
					catch(e) {
						console.log(e);
						$scope.$broadcast('print-end');
						$scope.$emit('print-end');

						$elem.removeClass('progress');
					}
				}

				$scope.$on('print-start', function(data) {
					$scope.progress = true;
					$scope.sections = [];
					$scope.footers = [];
				});

				$scope.$on('print-end', function(data) {
					$scope.progress = false;
					$scope.sections = [];
					$scope.footers = [];
				});

			}
		};
	}
]);

angular.module($APP.name).directive('loadingContainer', function() {
	return {
		restrict: 'A',
		scope: false,
		link: function(scope, element, attrs) {
			var loadingLayer = angular.element('<div class="loading"></div>');
			element.append(loadingLayer);
			element.addClass('loading-container');
			scope.$watch(attrs.loadingContainer, function(value) {
				loadingLayer.toggleClass('ng-hide', !value);
			});
		}
	};
});
