angular.module 'moshimoshi.chat_directive', []

.directive 'chat', (webSocket, UserSettingsSharedService) ->
  return {
    replace:     false
    restrict:    'E'
    templateUrl: '/templates/chat.html'
  }



