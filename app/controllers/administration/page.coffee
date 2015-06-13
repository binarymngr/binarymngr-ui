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
    @el.empty()
    @append @main, @sidebar.render()
    super

module?.exports = AdministrationPage
