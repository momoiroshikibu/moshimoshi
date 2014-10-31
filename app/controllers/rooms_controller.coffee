## routings
module.exports = (app, db) ->

  # get room data
  app.get '/rooms/:room_id', (req, res) ->
    console.log req.params
    console.log res

    query =
#      userName: 'matsuura'
    db.find query, (error, docs) ->
      console.log arguments
      res.send docs


