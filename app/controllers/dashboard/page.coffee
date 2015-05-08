Spine   = @Spine or require('spine')
Main    = require('controllers/dashboard/main')
Sidebar = require('controllers/dashboard/sidebar')

class DashboardPage extends Spine.Controller
  className: 'row page-dashboard'

  constructor: ->
    super

    @main = new Main
    @sidebar = new Sidebar
    @append @main, @sidebar

module?.exports = DashboardPage
