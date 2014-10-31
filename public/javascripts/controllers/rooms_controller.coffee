angular.module 'moshimoshi.rooms_controller', []

.controller 'RoomsController', ($http, $routeParams, $scope) ->

  $scope.messages = []

  console.log $routeParams.roomId
  $http.get './messages',
    params:
      roomId: $routeParams.roomId
  .success (data, status, headers, config) ->
    $scope.messages = data
    console.log arguments
