angular.module 'moshimoshi.chats_controller', [
]

.controller 'ChatsController', ($scope, webSocket, UserSettingsSharedService) ->

  $scope.messages = []

  webSocket.on 'updateMessages', (message) ->
    $scope.messages.push message

  $scope.sendMessage = ->
    return unless $scope.message
    webSocket.emit 'newMessage',
      userName: UserSettingsSharedService.userName.get()
      message:  $scope.message
    $scope.message = null
