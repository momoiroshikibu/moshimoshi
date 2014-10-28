angular.module('moshimoshi.sidebar_directive', ['btford.socket-io']).directive('sidebar', function(webSocket) {
  var activate;
  activate = function(scope, element, attr) {
    return scope.rooms = [
      {
        id: 1,
        title: 'momoiroshikibu'
      }, {
        id: 2,
        title: 'hello'
      }
    ];
  };
  return {
    link: activate,
    replace: false,
    restrict: 'E',
    scope: {},
    templateUrl: '/templates/sidebar.html'
  };
});
