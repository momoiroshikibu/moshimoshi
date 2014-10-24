## requirements
express      = require 'express'
request      = require 'request'
path         = require 'path'
favicon      = require 'serve-favicon'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
coffeeScript = require 'connect-coffee-script'
stylus       = require 'stylus'
bodyParser   = require 'body-parser'
http         = require 'http'
socketio     = require 'socket.io'


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
    io.sockets.emit 'updateMessages',
      userName: data.userName
      message:  data.message
      time:     Date.now()


# run server
server.listen 3000
