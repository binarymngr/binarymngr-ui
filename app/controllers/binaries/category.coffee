Spine    = require('spine')
Category = require('models/binarycategory')

class BinariesCategory extends Spine.Controller
  constructor: ->
    super

    Category.fetch()
    @routes
      '/binaries/categories/:id': (params) ->
        @render params

  render: (params) =>
    @html @template Category.find(params.id)

  template: (item) ->
    require('views/binaries/category')
      category: item

module.exports = BinariesCategory
