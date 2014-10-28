angular.module('moshimoshi.sidebar_directive', ['btford.socket-io']).directive('sidebar', function(webSocket, UserSettingsSharedService) {
  var activate;
  activate = function(scope, element, attr) {
    scope.userName = UserSettingsSharedService.userName.get();
    scope.changeUserName = function() {
      UserSettingsSharedService.userName.set(scope.userName);
      return console.log(UserSettingsSharedService.userName.get());
    };
    return scope.rooms = [
      {
        id: 1,
        title: 'momoiroshikibu'
      }, {
        id: 2,
        title: 'hello'
      }
    ];
  };
  return {
    link: activate,
    replace: false,
    restrict: 'E',
    scope: {},
    templateUrl: '/templates/sidebar.html'
  };
});
