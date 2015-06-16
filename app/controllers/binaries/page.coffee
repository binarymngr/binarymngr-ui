Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
Main       = require('controllers/binaries/main')
Sidebar    = require('controllers/binaries/sidebar')

class BinariesPage extends Controller
  className: 'row'

  constructor: ->
    super
    @main = new Main
    @sidebar = new Sidebar
    @render()

  render: =>
    @html @main
    @append @sidebar.render()

module?.exports = BinariesPage
