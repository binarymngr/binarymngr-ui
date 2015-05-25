Spine    = @Spine or require('spine')
Binary   = require('models/binary')
Category = require('models/binary_category')

class BinaryCategoryForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'category'
  bindings:
    # '.item input[name="id"]'            : 'id'
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    @category = null
    Binary.bind 'refresh change', @render
    Category.bind 'refresh change', @render

    @routes
      '/binaries/categories/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/binaries/categories'

  destroy: (event) =>
    if @category.destroy()
      @navigate '/binaries/categories'

  render: (params) =>
    @category = Category.find params.id
    @html @template @category
    @applyBindings() if @category?

  save: (event) =>
    event.preventDefault()

    unless @category.save()
      msg = @category.validate()
      return alert msg

  template: (item) ->
    binaries = null
    binaries = item.getBinaries() if item?

    require('views/binaries/categories/form')
      binaries: binaries
      category: item

module?.exports = BinaryCategoryForm
