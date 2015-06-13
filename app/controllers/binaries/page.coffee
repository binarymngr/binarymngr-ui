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
    @el.empty()
    @append @main, @sidebar.render()
    super

module?.exports = BinariesPage
