angular.module('moshimoshi.sidebar_directive', ['btford.socket-io']).directive('sidebar', function($http, webSocket, UserSettingsSharedService) {
  var activate;
  activate = function(scope, element, attr) {
    var getRooms;
    scope.userName = UserSettingsSharedService.userName.get();
    scope.changeUserName = function() {
      return UserSettingsSharedService.userName.set(scope.userName);
    };
    scope.toggleButtonTitle = 'add room';
    scope.toggleRoomForm = function() {
      scope.isShowRoomForm = !scope.isShowRoomForm;
      return scope.toggleButtonTitle = scope.isShowRoomForm ? 'cancel' : 'add room';
    };
    scope.cancelNewRoom = function() {
      scope.toggleRoomForm();
      scope.toggleButtonTitle = 'add room';
      return newRoom.title = null;
    };
    scope.saveNewRoom = function() {
      return $http.post('./rooms', {
        title: scope.newRoom.title
      }).success(function(data, status, headers, config) {
        return getRooms();
      });
    };
    scope.rooms = [];
    getRooms = function() {
      return $http.get('./rooms').success(function(data, status, headers, config) {
        scope.rooms = data;
        return console.log(scope.rooms);
      });
    };
    return getRooms();
  };
  return {
    link: activate,
    replace: false,
    restrict: 'E',
    scope: {},
    templateUrl: '/templates/sidebar.html'
  };
});
