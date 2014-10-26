## requirements
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
# request.defaults
#   headers:
#     'Content-Type': 'application/json'
requestOptions =
  url: 'http://localhost:9200/moshimoshi/messages/'
  json: true

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

    console.log "http://localhost:9200/moshimoshi/#{newMessage.time}"

    options =
      uri: "http://localhost:9200/moshimoshi/#{newMessage.time}"
      method: 'POST'
      json: newMessage

    request options, (error, response, body) ->
      console.log response, body


# run server
server.listen 3000
