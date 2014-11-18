angular.module 'moshimoshi.chats_controller', [
]

.controller 'ChatsController', ($scope, $routeParams, webSocket, UserSettingsSharedService) ->

  console.log 'chat controller'

  $scope.messages = []

  webSocket.on 'updateMessages', (message) ->
    $scope.messages.push message

  $scope.sendMessage = ->
    return unless $scope.message
    console.warn $routeParams.roomId
    webSocket.emit 'newMessage',
      roomId:   $routeParams.roomId
      userName: UserSettingsSharedService.userName.get()
      message:  $scope.message
    $scope.message = null
