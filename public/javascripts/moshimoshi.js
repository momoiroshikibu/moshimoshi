console.log('moshimoshi');

angular.module('moshimoshiApp', ['btford.socket-io']).factory('webSocket', function(socketFactory) {
  var socket;
  return socket = socketFactory({
    ioSocket: io.connect('http://localhost:3000')
  });
}).controller('moshimoshiController', function($scope, webSocket) {
  var messages;
  $scope.messages = messages = [];
  webSocket.on('updateMessages', function(message) {
    console.log('updateMessages');
    console.log(message);
    return messages.push(message);
  });
  return $scope.emit = function() {
    console.log('emit');
    webSocket.emit('newMessage', {
      userName: $scope.userName,
      message: $scope.message
    });
    return $scope.message = null;
  };
});
