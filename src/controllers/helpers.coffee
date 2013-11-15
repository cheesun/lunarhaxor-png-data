_ = require('underscore')

exports.render = (req, res, target, data) ->
  data = data || {}
  base_data = {
    flashMessages: req.flash() || []
  }
  res.render(target, _.extend(data, base_data))
