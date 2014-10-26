console.log 'moshimoshi'

app = angular
.module 'moshimoshiApp', [
  'ngRoute'
  'moshimoshi.chat_directive'
  'moshimoshi.search_directive'
  'btford.socket-io'
]


# app.config ['$routeProvider', '$locationProvider', '$parseProvider', ($routeProvider, $locationProvider, $parseProvider) ->

#   $routeProvider
#     .when '/',
#       templateUrl: '/templates/chat.html'
# #      controller: 'ChatController'
#     .when '/search',
#       templateUrl: '/templates/search.html'
# #      controller: 'SearchController'
# ]

app.factory 'webSocket', (socketFactory) ->
  socket = socketFactory(
    ioSocket: io.connect 'http://localhost:3000'
  )

