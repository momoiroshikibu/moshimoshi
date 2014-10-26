## requirements
config       = require 'config'
express      = require 'express'
path         = require 'path'
favicon      = require 'serve-favicon'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
coffeeScript = require 'connect-coffee-script'
stylus       = require 'stylus'
bodyParser   = require 'body-parser'
http         = require 'http'
socketio     = require 'socket.io'
request      = require 'request'


## configurations
elasticSearchBaseUrl = "http://#{config.ElasticSearch.host}:#{config.ElasticSearch.port}"


# server settings
app    = express()
server = http.Server app
io     = socketio server


## view settings
app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'ejs'


## assets
# coffee
public_dir = path.join __dirname, 'public'
app.use coffeeScript
  src: public_dir
  bare: true

# stylus
app.use stylus.middleware
  src: public_dir

# application assets
app.use express.static(public_dir)

# vendor assets
app.use express.static(path.join __dirname, 'bower_components')


## routings
app.get '/', (req, res) ->
  res.render 'index'


## events
io.on 'connection', (socket) ->

  socket.on 'newMessage', (data) ->

    newMessage =
      userName: data.userName
      message:  data.message
      time:     Date.now()

    io.sockets.emit 'updateMessages',
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


# run server
server.listen 3000
