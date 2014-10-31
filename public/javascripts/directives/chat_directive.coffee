angular.module 'moshimoshi.chat_directive', [
  'moshimoshi.chats_controller'
]

.directive 'chat', (webSocket, UserSettingsSharedService) ->
  return {
    replace:     false
    restrict:    'E'
    controller: 'ChatsController'
    templateUrl: '/templates/chat.html'
  }


