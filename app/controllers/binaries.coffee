Page    = require('controllers/page')
Main    = require('controllers/binaries_main')
Sidebar = require('controllers/binaries_sidebar')

class Binaries extends Page
  className: 'row page-binaries'

  constructor: ->
    super

    @main = new Main
    @sidebar = new Sidebar
    @append @main, @sidebar

module.exports = Binaries
