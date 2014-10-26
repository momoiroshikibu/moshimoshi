angular.module('moshimoshi.chat_directive', [
  'btford.socket-io'
])

.directive 'chat', (webSocket) ->

  activate = (scope, element, attr) ->

    scope.messages = []

    webSocket.on 'updateMessages', (message) ->
      scope.messages.push message

    scope.sendMessage = ->
      return unless scope.message
      webSocket.emit 'newMessage',
        userName: scope.userName
        message:  scope.message
      scope.message = null

  return {
    link:        activate
    replace:     false
    restrict:    'E'
    scope:       {}
    templateUrl: '/templates/chat.html'
  }



