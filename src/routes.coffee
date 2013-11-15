passport = require('passport')

indexController = require("./controllers/index")
userController = require("./controllers/user")

bindRestfulController = (app, baseRoute, controller, actions) ->
  restfulActions = ['get', 'post', 'put', 'delete']
  actions ||= restfulActions
  for action in actions when action in restfulActions and action of controller
    app[action](baseRoute, controller[action])

exports.bind = (app) ->
  app.get("/", indexController.index)

  # user management
  bindRestfulController(app, '/signup', userController.signup, ['get', 'post'])
  app.get('/login', userController.login.get)
  require('./passport') # initialize passport
  app.post('/login', passport.authenticate('local', {
    successRedirect: '/'
    failureRedirect: '/login'
    failureFlash: true
  }))


