indexController = require("./controllers/index")

exports.bind = (app) ->
  app.get("/", indexController.index)
