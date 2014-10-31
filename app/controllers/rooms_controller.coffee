## routings
module.exports = (app, db) ->

  # get rooms
  app.get '/rooms', (req, res) ->
    # TODO
    res.send [
        id: 1
        title: 'hello'
      ,
        id: 2
        title: 'bye'
    ]


  # get room
  app.get '/rooms/:room_id', (req, res) ->
    console.log req.params
    console.log res

    query =
#      userName: 'matsuura'
    db.find query, (error, docs) ->
      console.log arguments
      res.send docs


