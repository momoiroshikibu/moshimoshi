## routings
module.exports = (app, db) ->

  # index
  app.get '/', (req, res) ->
    res.render 'index'
