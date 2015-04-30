Spine    = require('spine')
Category = require('models/binarycategory')

class BinariesCategories extends Spine.Controller
  elements:
    '.items': 'items'

  constructor: ->
    super

    Category.fetch()
    Category.bind('refresh change', @render)

  render: =>
    @html @template Category.all()

  template: (items) ->
    require('views/binaries/categories')
      categories: items

module.exports = BinariesCategories
