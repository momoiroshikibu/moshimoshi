config  = require 'config'
request = require 'request'
Datastore    = require 'nedb'


db = new Datastore
  filename: './database/moshimoshi.db'
  autoload: true
db.loadDatabase (error) ->
  console.log error


module.exports = (socketio) ->

  elasticSearchBaseUrl = "http://#{config.ElasticSearch.host}:#{config.ElasticSearch.port}"

  ## events
  socketio.on 'connection', (socket) ->

    socket.on 'newMessage', (data) ->

      # new message
      newMessage =
        userName: data.userName
        message:  data.message
        time:     Date.now()

      # save to database
      db.insert newMessage, (error, newDoc) ->
        newMessage = newDoc

      # emit event to clients
      socketio.sockets.emit 'updateMessages',
        newMessage

      # add to Elastic Search index
      options =
        uri: "#{elasticSearchBaseUrl}/moshimoshi/#{newMessage._id}"
        method: 'POST'
        json: newMessage

      request options, (error, response, body) ->
        # do nothing


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


