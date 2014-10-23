express = require 'express'
request = require 'request'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
coffeeScript = require 'connect-coffee-script'
stylus = require('stylus')
bodyParser = require 'body-parser'
http = require 'http'
socketio = require 'socket.io'


app = express()
server = http.Server app
io = socketio server

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'ejs'

app.use express.static(path.join(__dirname, 'public'))

app.get '/', (req, res) ->
  res.render 'index'

io.on 'connection', (socket) ->
  socket.emit 'news', {hello: 'world'}
  socket.on 'my other event', (data)->
    console.log data

server.listen 3000
