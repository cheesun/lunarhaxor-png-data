User = require("../models/user").User

render = require('./helpers').render

exports.signup = {
  get: (req, res) ->
    render(req, res, 'signup')

  post: (req, res) ->
    { username, password, confirmPassword } = req.body
    if password != confirmPassword
      return render(req, res, 'signup', { error: new Error("passwords don't match"), username: username })
    user = new User({username: username, password: password})
    user.save((err) ->
      if err
        render(req, res, 'signup', { error: err, username: username })
      else
        res.redirect('/')
    )
}

exports.login = {
  get: (req, res) ->
    render(req, res, 'login')

  post: (req, res) ->
    { username, password } = req.body
    user = User.find({ username: username })
    if user and user.checkPassword(password)
      res.redirect('/')
    else
      render(req, res, 'login', { error: 'invalid login details' })
}

exports.logout = {
  get: (req, res) ->
    res.redirect('/')
}
