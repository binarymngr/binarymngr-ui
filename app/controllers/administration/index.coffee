Spine   = require('spine')
Main    = require('controllers/administration/main')
Sidebar = require('controllers/administration/sidebar')

class AdministrationIndex extends Spine.Controller
  className: 'row page-administration'

  constructor: ->
    super

    @main = new Main
    @sidebar = new Sidebar
    @append @main, @sidebar

module.exports = AdministrationIndex
