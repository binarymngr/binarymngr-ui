Spine   = require('spine')
Main    = require('controllers/binaries/main')
Sidebar = require('controllers/binaries/sidebar')

class BinariesIndex extends Spine.Controller
  className: 'row page-binaries'

  constructor: ->
    super

    @main = new Main
    @sidebar = new Sidebar
    @append @main, @sidebar

module.exports = BinariesIndex
