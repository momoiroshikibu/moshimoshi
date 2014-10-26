angular.module('moshimoshi.chat_directive', ['btford.socket-io']).directive('chat', function(webSocket) {
  var activate;
  activate = function(scope, element, attr) {
    scope.messages = [];
    webSocket.on('updateMessages', function(message) {
      return scope.messages.push(message);
    });
    return scope.sendMessage = function() {
      if (!scope.message) {
        return;
      }
      webSocket.emit('newMessage', {
        userName: scope.userName,
        message: scope.message
      });
      return scope.message = null;
    };
  };
  return {
    link: activate,
    replace: false,
    restrict: 'E',
    scope: {},
    templateUrl: '/templates/chat.html'
  };
});
