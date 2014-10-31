angular.module('moshimoshi.rooms_controller', []).controller('RoomsController', function($http, $routeParams, $scope) {
  $scope.messages = [];
  console.log($routeParams.roomId);
  return $http.get('./messages', {
    params: {
      roomId: $routeParams.roomId
    }
  }).success(function(data, status, headers, config) {
    $scope.messages = data;
    return console.log(arguments);
  });
});
