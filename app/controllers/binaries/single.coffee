Spine    = require('spine')
Binary   = require('models/binary')
Category = require('models/binarycategory')

class BinariesSingle extends Spine.Controller
  constructor: ->
    super

    Binary.fetch()
    Category.fetch()
    @routes
      '/binaries/:id': (params) ->
        @render params

  render: (params) =>
    @html @template Binary.find(params.id)

  template: (item) ->
    require('views/binaries/single')
      binary:     item
      categories: Category.all()

module.exports = BinariesSingle
