Spine   = @Spine or require('spine')
Main    = require('controllers/administration/main')
Sidebar = require('controllers/administration/sidebar')

class AdministrationPage extends Spine.Controller
  className: 'row page-administration'

  constructor: ->
    super

    @main = new Main
    @sidebar = new Sidebar
    @append @main, @sidebar

module?.exports = AdministrationPage
