var app;

console.log('moshimoshi');

app = angular.module('moshimoshiApp', ['ngRoute', 'moshimoshi.sidebar_directive', 'moshimoshi.chat_directive', 'moshimoshi.search_directive', 'btford.socket-io']);

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
