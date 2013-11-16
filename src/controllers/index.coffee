render = require('./helpers').render

exports.index = (req, res) ->
  render(req, res, 'index', { title: 'MedRec' })
