Page = require('controllers/page')

class Servers extends Page
  className: 'page-servers'

  constructor: ->
    super

    @html require('views/servers')({})

module.exports = Servers
