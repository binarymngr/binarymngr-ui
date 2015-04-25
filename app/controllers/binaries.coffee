Page = require('controllers/page')

class Binaries extends Page
  className: 'page-binaries'

  constructor: ->
    super

    @html require('views/binaries')({})

module.exports = Binaries
