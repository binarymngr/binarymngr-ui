Spine    = @Spine or require('spine')
Category = require('models/binarycategory')

class BinariesCategoryStack extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  modelVar: 'category'
  bindings:
    # '.item input[name="id"]'         : 'id'
    '.item input[name="name"]'       : 'name'
    '.item input[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    # Category.bind('refresh change', @render)
    @category = new Category
    do @applyBindings

    @routes
      '/binaries/categories/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/binaries/categories')

  destroy: (event) =>
    @category.destroy()
    @navigate('/binaries/categories')  # TODO: add check destory and confirm action

  render: (params) =>
    @category = Category.find(params.id)
    # fix errors like @category.bind on null
    if @category == null
      @category = new Category
    @html @template @category
    do @applyBindings

  save: (event) =>
    @category.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/binaries/category')
      category: item

module.exports = BinariesCategoryStack
