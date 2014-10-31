angular.module('moshimoshi.chats_controller', []).controller('ChatsController', function($scope, webSocket, UserSettingsSharedService) {
  $scope.messages = [];
  webSocket.on('updateMessages', function(message) {
    return $scope.messages.push(message);
  });
  return $scope.sendMessage = function() {
    if (!$scope.message) {
      return;
    }
    webSocket.emit('newMessage', {
      userName: UserSettingsSharedService.userName.get(),
      message: $scope.message
    });
    return $scope.message = null;
  };
});
