mongo = require("mongodb")
mongoose = require("mongoose")
express = require("express")
path = require("path")
flash = require("connect-flash")

settings = require("./settings")

startDBAndThen = (next) ->
  console.log("Starting DB")
  db = mongoose.connect(settings.mongooseUrl).connection
  db.on("error", console.error.bind(console, "connection error:"))
  db.once("open", () ->
    console.log("DB Started")
    next()
  )

startExpress = () ->
  console.log("Starting Express on port " + settings.port)
  app = express()
  app.configure(() ->
    # settings
    app.set('port', settings.port)
    app.set('views', settings.baseDir + 'views')
    console.log(settings.baseDir + 'views')
    app.set('view engine', 'jade')
    app.set('view options', { layout: false })

    # middleware
    app.use(express.favicon())
    app.use(express.logger())
    app.use(express.bodyParser())
    app.use(express.methodOverride())
    app.use(require('stylus').middleware(settings.baseDir + 'public'))
    app.use(express.static(path.join(settings.baseDir, 'public')))

    app.use(express.cookieParser())
    app.use(express.session({ secret: 'sfoh3092hf2o3gho23h' }))
    app.use(flash())

    # final middleware
    app.use(express.errorHandler({showStack: true, dumpExceptions: true}))


  )

  # application routes
  require("./routes").bind(app)

  # api routes
  # TODO: add mers routes

  # start it up!
  app.listen(settings.port)
  console.log("Express listening on port " + settings.port)

# start the server
startDBAndThen(startExpress)
