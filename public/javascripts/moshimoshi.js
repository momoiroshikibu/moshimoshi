var app;

console.log('moshimoshi');

app = angular.module('moshimoshiApp', ['ngRoute', 'moshimoshi.chat_directive', 'moshimoshi.search_directive', 'btford.socket-io']);

app.factory('webSocket', function(socketFactory) {
  var socket;
  return socket = socketFactory({
    ioSocket: io.connect("http://" + window.location.host)
  });
});
