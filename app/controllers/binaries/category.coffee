Spine    = require('spine')
Category = require('models/binarycategory')

class BinariesCategory extends Spine.Controller
  events:
    'click .can-save': 'save'
    'click .can-destroy': 'destroy'

  constructor: ->
    super

    Category.fetch()
    @item = null

    @routes
      '/binaries/categories/:id': (params) ->
        @render params

  destroy: (event) =>
    @item.destroy()
    @navigate('/binaries')  # TODO: add check destory and confirm action

  render: (params) =>
    @item = Category.find(params.id)
    @html @template @item

  save: (event) =>
    @item.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/binaries/category')
      category: item

module.exports = BinariesCategory
