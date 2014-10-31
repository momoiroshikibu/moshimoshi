angular.module('moshimoshi.rooms_controller', []).controller('RoomsController', function($http, $scope) {
  $scope.title = 'hello';
  $scope.messages = [];
  return $http.get('http://localhost:3000/messages?room_id=1').success(function(data, status, headers, config) {
    return $scope.messages = data;
  }).error(function(data, status, headers, config) {
    return console.log(arguments);
  });
});
