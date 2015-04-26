Page = require('controllers/page')

class Dashboard extends Page
  className: 'page-dashboard'

  constructor: ->
    super
    @html require('views/dashboard')()

module.exports = Dashboard
