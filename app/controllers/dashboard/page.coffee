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
    @el.empty()
    @append @main.render(), @sidebar.render()
    super

module?.exports = DashboardPage
