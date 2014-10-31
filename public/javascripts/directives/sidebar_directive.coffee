angular.module('moshimoshi.sidebar_directive', [
  'btford.socket-io'
])

.directive 'sidebar', ($http, webSocket, UserSettingsSharedService) ->

  activate = (scope, element, attr) ->

    scope.userName = UserSettingsSharedService.userName.get()

    scope.changeUserName = () ->
      UserSettingsSharedService.userName.set(scope.userName)
      console.log UserSettingsSharedService.userName.get()

    # currently do nothing
    scope.rooms = []
    $http.get './rooms'
    .success (data, status, headers, config) ->
      console.log arguments
      scope.rooms = data
    .error (data, status, headers, config) ->
      console.log arguments

  return {
    link:        activate
    replace:     false
    restrict:    'E'
    scope:       {}
    templateUrl: '/templates/sidebar.html'
  }



