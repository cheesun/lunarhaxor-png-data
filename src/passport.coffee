passport = require('passport')
LocalStrategy = require('passport-local').Strategy

User = require('./models/user').User

passport.use(new LocalStrategy((username, password, done) ->
  return User.authenticate(username, password, done)
))
