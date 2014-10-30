express      = require 'express'
coffeeScript = require 'connect-coffee-script'
path         = require 'path'
stylus       = require 'stylus'
# favicon      = require 'serve-favicon'


module.exports = (app) ->

  ## view settings
  app.set 'views', path.join __dirname, '../views'
  app.set 'view engine', 'ejs'


  ## assets
  # coffee
  public_dir = path.join __dirname, '../public'
  app.use coffeeScript
    src: public_dir
    bare: true


  # stylus
  app.use stylus.middleware
    src: public_dir


  # application assets
  app.use express.static(public_dir)


  # vendor assets
  app.use express.static(path.join __dirname, '../bower_components')
