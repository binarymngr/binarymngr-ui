Spine    = @Spine or require('spine')
Category = require('models/binarycategory')

class BinariesCategoriesStack extends Spine.Controller
  constructor: ->
    super

    Category.bind('refresh change', @render)
    do @render
    Category.fetch()

  render: =>
    @html @template Category.all()

  template: (items) ->
    require('views/binaries/categories')
      categories: items

module.exports = BinariesCategoriesStack
