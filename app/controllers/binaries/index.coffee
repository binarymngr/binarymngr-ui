Page    = require('controllers/page')
Main    = require('controllers/binaries/main')
Sidebar = require('controllers/binaries/sidebar')

class BinariesIndex extends Page
  className: 'row page-binaries'

  constructor: ->
    super

    @main = new Main
    @sidebar = new Sidebar
    @append @main, @sidebar

module.exports = BinariesIndex
