var app;

console.log('moshimoshi');

app = angular.module('moshimoshiApp', ['ngRoute', 'moshimoshi.chats_controller', 'moshimoshi.rooms_controller', 'moshimoshi.sidebar_directive', 'moshimoshi.chat_directive', 'moshimoshi.search_directive', 'btford.socket-io']);

app.config([
  '$routeProvider', '$locationProvider', '$parseProvider', function($routeProvider, $locationProvider, $parseProvider) {
    return $routeProvider.when('/', {
      templateUrl: '/templates/chat.html'
    }).when('/rooms/:roomId', {
      templateUrl: '/templates/room.html',
      controller: 'RoomsController',
      controllerAs: 'Rooms'
    }).when('/search', {
      templateUrl: '/templates/search.html'
    });
  }
]);

app.factory('webSocket', function(socketFactory) {
  var socket;
  return socket = socketFactory({
    ioSocket: io.connect("http://" + window.location.host)
  });
});

app.factory('UserSettingsSharedService', function() {
  var userName;
  userName = 'anonymous';
  return {
    userName: {
      get: function() {
        return userName;
      },
      set: function(newUserName) {
        return userName = newUserName;
      }
    }
  };
});
