console.log 'moshimoshi'

angular
.module 'moshimoshiApp', [
  'btford.socket-io'
]
.factory 'webSocket', (socketFactory) ->
  socket = socketFactory(
    ioSocket: io.connect 'http://localhost:3000'
  )


.controller 'moshimoshiController', ($scope, webSocket) ->
  $scope.messages = messages = []

  webSocket.on 'updateMessages', (message) ->
    messages.push message

  $scope.sendMessage = ->
    return unless $scope.message
    webSocket.emit 'newMessage',
      userName: $scope.userName
      message:  $scope.message
    $scope.message = null


.controller 'messageSearchController', ($scope, webSocket) ->
  $scope.messages = []

  webSocket.on 'resultMessages', (resultMessages) ->
    messages = resultMessages
    $scope.messages = resultMessages

  $scope.searchMessages = (query) ->
    webSocket.emit 'searchMessages',
      query: $scope.query
