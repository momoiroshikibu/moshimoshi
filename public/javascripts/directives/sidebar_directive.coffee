angular.module('moshimoshi.sidebar_directive', [
  'btford.socket-io'
])

.directive 'sidebar', ($http, webSocket, UserSettingsSharedService) ->

  activate = (scope, element, attr) ->

    scope.userName = UserSettingsSharedService.userName.get()

    scope.changeUserName = () ->
      UserSettingsSharedService.userName.set(scope.userName)

    # TODO: needs refactoring...
    scope.toggleButtonTitle = 'add room'
    scope.toggleRoomForm = () ->
      scope.isShowRoomForm = !scope.isShowRoomForm
      scope.toggleButtonTitle = if scope.isShowRoomForm then 'cancel' else 'add room'

    scope.cancelNewRoom = () ->
      scope.toggleRoomForm()
      scope.toggleButtonTitle = 'add room'
      newRoom.title = null

    scope.saveNewRoom = () ->
      $http.post './rooms',
        title: scope.newRoom.title
      .success (data, status, headers, config) ->
        getRooms()

    # get rooms
    scope.rooms = []
    getRooms = () ->
      $http.get './rooms'
      .success (data, status, headers, config) ->
        scope.rooms = data
        console.log scope.rooms
    getRooms()

  return {
    link:        activate
    replace:     false
    restrict:    'E'
    scope:       {}
    templateUrl: '/templates/sidebar.html'
  }



