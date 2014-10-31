angular.module 'moshimoshi.rooms_controller', []

.controller 'RoomsController', ($http, $scope) ->

  $scope.title = 'hello'
  $scope.rooms = []

  $http.get './rooms'
  .success (data, status, headers, config) ->
    $scope.rooms = data
  .error (data, status, headers, config) ->
    console.log arguments
