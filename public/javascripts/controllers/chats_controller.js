angular.module('moshimoshi.chats_controller', []).controller('ChatsController', function($scope, $routeParams, webSocket, UserSettingsSharedService) {
  console.log('chat controller');
  $scope.messages = [];
  webSocket.on('updateMessages', function(message) {
    return $scope.messages.push(message);
  });
  return $scope.sendMessage = function() {
    if (!$scope.message) {
      return;
    }
    webSocket.emit('newMessage', {
      roomId: $routeParams.roomId,
      userName: UserSettingsSharedService.userName.get(),
      message: $scope.message
    });
    return $scope.message = null;
  };
});
