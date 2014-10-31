angular.module('moshimoshi.sidebar_directive', ['btford.socket-io']).directive('sidebar', function($http, webSocket, UserSettingsSharedService) {
  var activate;
  activate = function(scope, element, attr) {
    scope.userName = UserSettingsSharedService.userName.get();
    scope.changeUserName = function() {
      UserSettingsSharedService.userName.set(scope.userName);
      return console.log(UserSettingsSharedService.userName.get());
    };
    scope.rooms = [];
    return $http.get('./rooms').success(function(data, status, headers, config) {
      console.log(arguments);
      return scope.rooms = data;
    }).error(function(data, status, headers, config) {
      return console.log(arguments);
    });
  };
  return {
    link: activate,
    replace: false,
    restrict: 'E',
    scope: {},
    templateUrl: '/templates/sidebar.html'
  };
});
