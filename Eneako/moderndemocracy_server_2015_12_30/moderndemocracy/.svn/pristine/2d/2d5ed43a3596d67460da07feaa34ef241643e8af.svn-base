'use strict';
//---------------------------------------------------------------------
// NAMESPACE DECLARATIONS
//---------------------------------------------------------------------
var $APP = $APP || {}; // App namespace

angular.module($APP.name).directive('onError', function() {
  return {
    restrict:'A',
    link: function(scope, element, attr) {
      element.on('error', function() {
        element.attr('src', attr.onError);
      })
    }
  }
})
