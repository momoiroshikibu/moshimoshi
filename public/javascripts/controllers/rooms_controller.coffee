angular.module 'moshimoshi.rooms_controller', []

.controller 'RoomsController', ($http, $scope) ->

  $scope.title = 'hello'
  $scope.messages = []

#   $http.get 'http://localhost:3000/rooms/1'
#   .success (data, status, headers, config) ->
#     $scope.messages = data
#   .error (data, status, headers, config) ->
#     console.log arguments


  $http.get 'http://localhost:3000/messages?room_id=1'
  .success (data, status, headers, config) ->
    $scope.messages = data
  .error (data, status, headers, config) ->
    console.log arguments
