angular.module('moshimoshi.search_directive', [
  'btford.socket-io'
])

.directive 'search', (webSocket) ->

  activate = (scope, element, attr) ->
    scope.messages = []

    webSocket.on 'resultMessages', (resultMessages) ->
      scope.messages = resultMessages

    scope.searchMessages = (query) ->
      webSocket.emit 'searchMessages',
        query: scope.query

  return {
    link:        activate
    replace:     false
    restrict:    'E'
    scope:       {}
    templateUrl: '/templates/search.html'
  }



