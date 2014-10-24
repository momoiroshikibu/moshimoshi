console.log 'moshimoshi'

# socket.io
# socket = io.connect 'http://localhost:3000'
# socket.on 'news', (data) ->
#   console.log data
#   socket.emit 'my other event',
#     data: 'data'

angular
.module 'moshimoshiApp', [
  'btford.socket-io'
]
.factory 'webSocket', (socketFactory) ->
#  socketio = io.connect 'http://localhost:3000'
  socket = socketFactory(
    ioSocket: io.connect 'http://localhost:3000'
  )
  
#  socketFactory()

.controller 'moshimoshiController', ($scope, webSocket) ->

  $scope.messages = messages = []
  
  webSocket.on 'updateMessages', (message) ->
    console.log 'updateMessages'
    console.log message
    messages.push message

  $scope.emit = ->
    console.log 'emit'
    webSocket.emit 'newMessage',
      userName: $scope.userName
      message:  $scope.message
    $scope.message = null
