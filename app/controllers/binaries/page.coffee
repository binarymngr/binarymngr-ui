Spine   = @Spine or require('spine')
Main    = require('controllers/binaries/main')
Sidebar = require('controllers/binaries/sidebar')

class BinariesPage extends Spine.Controller
  className: 'row page-binaries'

  constructor: ->
    super

    @main = new Main
    @sidebar = new Sidebar
    @append @main, @sidebar

module.exports = BinariesPage
