Spine    = @Spine or require('spine')
Category = require('models/binarycategory')

class BinariesCategoryStack extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  constructor: ->
    super

    Category.fetch()
    @item = new Category

    @routes
      '/binaries/categories/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/binaries/categories')

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

module.exports = BinariesCategoryStack
