mongoose = require('mongoose')
bcrypt = require('bcrypt')

UserSchema = mongoose.Schema({
  username: { type: String, required: true, index: { unique: true } }
  password: { type: String, required: true } # we're using bcrypt so the salt is included
  email: String
  name: String
})

UserSchema.pre('save', (next) ->
  next() unless @isModified('password')
  return next(new Error('invalid password')) unless validatePassword(@password)
  bcrypt.genSalt(12, (err, salt) =>
    return next(err) if err
    bcrypt.hash(@password, salt, (err, hash) =>
      return next(err) if err
      @password = hash
      next()
    )
  )
)

UserSchema.methods.checkPassword = (password, callback) ->
  bcrypt.compare(password, this.password, (err, isMatch) ->
    return callback(err) if err
    callback(null, isMatch)
  )

UserSchema.statics.authenticate = (username, password, callback) ->
  console.log('starting auth')
  @findOne({ username: username }, (err, user) ->
    console.log(err)
    console.log(user)
    return callback(err) if err
    return callback(null, false, { message: 'Invalid user details' }) unless user
    console.log('found user')
    user.checkPassword(password, (err, isMatch) ->
      return callback(err) if err
      unless isMatch
        console.log('wrong password')
        return callback(null, false, { message: 'Invalid user details' })
      else
        console.log('success!')
        return callback(null, user)
    )
  )

validatePassword = (password) ->
  return password.length > 4 and /[ -~]+/.test(password)

exports.User = mongoose.model("User", UserSchema)

