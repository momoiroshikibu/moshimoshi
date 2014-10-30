express      = require 'express'
logger       = require 'morgan'
http         = require 'http'
socketio     = require 'socket.io'
assets       = require './config/assets'

# server settings
app    = express()
server = http.Server app
io     = socketio server

## assets
assets app

## routings
router = require './app/router'
router app

# WebSocket for chatting
chatController = require './app/controllers/chat_controller'
chatController io

# run server
server.listen 3000
