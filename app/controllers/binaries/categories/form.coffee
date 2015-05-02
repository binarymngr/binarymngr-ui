Spine    = @Spine or require('spine')
Category = require('models/binarycategory')

class BinaryCategoryForm extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'submit .item'      : 'save'

  modelVar: 'category'
  bindings:
    # '.item input[name="id"]'            : 'id'
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    @category = null
    Category.bind('refresh change', @render)

    @routes
      '/binaries/categories/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/binaries/categories')

  destroy: (event) =>
    if @category.destroy()
      @navigate('/binaries/categories')
    else
      return alert('Something went wrong')

  render: (params) =>
    @category = Category.find(params.id)
    @html @template @category
    if @category != null
      do @applyBindings

  save: (event) =>
    event.preventDefault()

    unless @category.save()
      msg = @category.validate()
      return alert(msg)

  template: (item) ->
    require('views/binaries/categories/form')
      category: item

module.exports = BinaryCategoryForm
