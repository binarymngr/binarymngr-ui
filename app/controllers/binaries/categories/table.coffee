Spine    = @Spine or require('spine')
Category = require('models/binarycategory')

class BinaryCategoriesTable extends Spine.Controller
  constructor: ->
    super

    Category.bind('refresh change', @render)
    do @render

  render: =>
    @html @template Category.all()

  template: (items) ->
    require('views/binaries/categories/table')
      categories: items

module.exports = BinaryCategoriesTable
