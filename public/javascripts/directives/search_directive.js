angular.module('moshimoshi.search_directive', ['btford.socket-io']).directive('search', function(webSocket) {
  var activate;
  activate = function(scope, element, attr) {
    scope.messages = [];
    webSocket.on('resultMessages', function(resultMessages) {
      return scope.messages = resultMessages;
    });
    return scope.searchMessages = function(query) {
      return webSocket.emit('searchMessages', {
        query: scope.query
      });
    };
  };
  return {
    link: activate,
    replace: false,
    restrict: 'E',
    scope: {},
    templateUrl: '/templates/search.html'
  };
});
