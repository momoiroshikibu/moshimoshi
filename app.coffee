express   = require 'express'
logger    = require 'morgan'
http      = require 'http'
socketio  = require 'socket.io'
assets    = require './config/assets'
Datastore = require 'nedb'

# server settings
app    = express()
server = http.Server app
io     = socketio server

## assets
assets app

## database
db = new Datastore
  filename: './database/moshimoshi.db'
  autoload: true
db.loadDatabase (error) ->
  console.log error


## routings
router = require './app/router'
router app, db


## messages
messages = require './app/controllers/messages_controller'
messages app, db, io

## rooms
rooms = require './app/controllers/rooms_controller'
rooms app, db

# run server
server.listen 3000
