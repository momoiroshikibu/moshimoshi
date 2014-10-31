angular.module('moshimoshi.chat_directive', ['moshimoshi.chats_controller']).directive('chat', function(webSocket, UserSettingsSharedService) {
  return {
    replace: false,
    restrict: 'E',
    scope: true,
    controller: 'ChatsController',
    templateUrl: '/templates/chat.html'
  };
});
