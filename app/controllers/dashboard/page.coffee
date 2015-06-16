Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
Main       = require('controllers/dashboard/main')
Sidebar    = require('controllers/dashboard/sidebar')

class DashboardPage extends Controller
  className: 'row'

  constructor: ->
    super
    @main = new Main
    @sidebar = new Sidebar
    @render()

  render: =>
    @html @main.render()
    @append @sidebar.render()

module?.exports = DashboardPage
