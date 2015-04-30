Spine    = @Spine or require('spine')
Binary   = require('models/binary')
Category = require('models/binarycategory')

class BinariesSingleStack extends Spine.Controller
  events:
    'click .can-save'   : 'save'
    'click .can-destroy': 'destroy'

  constructor: ->
    super

    Binary.fetch()
    Category.fetch()
    @item = new Binary

    @routes
      '/binaries/:id': (params) ->
        @render params

  destroy: (event) =>
    @item.destroy()
    @navigate('/binaries')  # TODO: add check destory and confirm action

  render: (params) =>
    @item = Binary.find(params.id)
    @html @template @item

  save: (event) =>
    @item.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/binaries/single')
      binary:     item
      categories: Category.all()

module.exports = BinariesSingleStack
