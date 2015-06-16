Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
Main       = require('controllers/administration/main')
Sidebar    = require('controllers/administration/sidebar')

class AdministrationPage extends Controller
  className: 'row'

  constructor: ->
    super
    @main = new Main
    @sidebar = new Sidebar
    @render()

  render: =>
    @html @main
    @append @sidebar.render()

module?.exports = AdministrationPage
