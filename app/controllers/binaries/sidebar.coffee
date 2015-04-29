Spine    = require('spine')
Category = require('models/binarycategory')

# TODO: mark current category as active

class BinariesSidebar extends Spine.Controller
  className: 'col-sm-3 col-md-2 col-sm-pull-9 col-md-pull-10 sidebar-pf sidebar-pf-left'
  elements:
    '.nav': 'category_nav'

  constructor: ->
    super

    Category.fetch()
    Category.bind('refresh change', @render)

  render: =>
    @html @template Category.all()

  template: (items) ->
    require('views/binaries/sidebar')
      categories: items

module.exports = BinariesSidebar
