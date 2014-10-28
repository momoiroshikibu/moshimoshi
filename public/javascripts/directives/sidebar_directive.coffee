angular.module('moshimoshi.sidebar_directive', [
  'btford.socket-io'
])

.directive 'sidebar', (webSocket, UserSettingsSharedService) ->

  activate = (scope, element, attr) ->

    scope.userName = UserSettingsSharedService.userName.get()

    scope.changeUserName = () ->
      UserSettingsSharedService.userName.set(scope.userName)
      console.log UserSettingsSharedService.userName.get()

    # currently do nothing
    scope.rooms = [
      {
        id:    1
        title: 'momoiroshikibu'
      },
      {
        id:    2
        title: 'hello'
      }
    ]

  return {
    link:        activate
    replace:     false
    restrict:    'E'
    scope:       {}
    templateUrl: '/templates/sidebar.html'
  }



