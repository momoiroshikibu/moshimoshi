config  = require 'config'
request = require 'request'


elasticSearchBaseUrl = "http://#{config.ElasticSearch.host}:#{config.ElasticSearch.port}"


module.exports = (socketio) ->

  console.log socketio

  ## events
  socketio.on 'connection', (socket) ->

    socket.on 'newMessage', (data) ->

      newMessage =
        userName: data.userName
        message:  data.message
        time:     Date.now()

      socketio.sockets.emit 'updateMessages',
        newMessage

      options =
        uri: "#{elasticSearchBaseUrl}/moshimoshi/#{newMessage.time}"
        method: 'POST'
        json: newMessage

      request options, (error, response, body) ->
        console.log response, body


    socket.on 'searchMessages', (query) ->
      console.log 'searchMessages', query

      options =
        uri: "#{elasticSearchBaseUrl}/moshimoshi/_search"
        method: 'GET'
        json:
          query:
            multi_match:
              query: query.query
              fields: ['message']

      request options, (error, response, body) ->
        socket.emit 'resultMessages', [] unless body.hits.hits
        resultMessages = body.hits.hits.map (item, i) ->
          item._source
        socket.emit 'resultMessages', resultMessages

