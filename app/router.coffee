## routings
module.exports = (app, db) ->

  # index
  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/rooms/:room_id', (req, res) ->
    console.log req.params
    console.log res

    query =
#      userName: 'matsuura'
    db.find query, (error, docs) ->
      console.log arguments
      res.send docs


