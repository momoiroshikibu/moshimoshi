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
    return messages.push(message);
  });
  return $scope.sendMessage = function() {
    if (!$scope.message) {
      return;
    }
    webSocket.emit('newMessage', {
      userName: $scope.userName,
      message: $scope.message
    });
    return $scope.message = null;
  };
}).controller('messageSearchController', function($scope, webSocket) {
  $scope.messages = [];
  webSocket.on('resultMessages', function(resultMessages) {
    var messages;
    console.log(resultMessages);
    messages = resultMessages;
    return $scope.messages = resultMessages;
  });
  return $scope.searchMessages = function(query) {
    console.log(query);
    return webSocket.emit('searchMessages', {
      query: $scope.query
    });
  };
});
