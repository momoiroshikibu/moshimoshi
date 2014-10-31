angular.module('moshimoshi.rooms_controller', []).controller('RoomsController', function($http, $scope) {
  $scope.title = 'hello';
  $scope.rooms = [];
  return $http.get('./rooms').success(function(data, status, headers, config) {
    return $scope.rooms = data;
  }).error(function(data, status, headers, config) {
    return console.log(arguments);
  });
});
