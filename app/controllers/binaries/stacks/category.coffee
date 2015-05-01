Spine    = @Spine or require('spine')
Category = require('models/binarycategory')

class BinariesCategoryStack extends Spine.Controller
  @extend Spine.Bindings

  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  modelVar: 'model'
  bindings:
    # '.item input[name="id"]'         : 'id'
    '.item input[name="name"]'       : 'name'
    '.item input[name="description"]': 'description'

  constructor: ->
    super

    @routes
      '/binaries/categories/:id': (params) ->
        @render params

    Category.fetch()
    @model = new Category
    do @applyBindings

  cancel: (event) =>
    @navigate('/binaries/categories')

  destroy: (event) =>
    @model.destroy()
    @navigate('/binaries/categories')  # TODO: add check destory and confirm action

  render: (params) =>
    @model = Category.find(params.id)
    do @applyBindings
    @html @template @model

  save: (event) =>
    @model.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/binaries/category')
      category: item

module.exports = BinariesCategoryStack
