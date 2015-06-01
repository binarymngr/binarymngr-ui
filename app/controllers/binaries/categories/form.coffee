Spine    = @Spine or require 'spine'
Binary   = require 'models/binary'
Category = require 'models/binary_category'

class BinaryCategoryForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'category'
  bindings:
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    @category = null
    Binary.bind 'refresh change', @render
    Category.bind 'refresh change', @render

  activate: (params) =>
    super
    @render params

  cancel: (event) =>
    @navigate '/binaries/categories'

  destroy: (event) =>
    if @category.destroy()
      @navigate '/binaries/categories'

  render: (params) =>
    @category = Category.find params.id if params?.id?
    @html @template @category
    @applyBindings() if @category?

  save: (event) =>
    event.preventDefault()

    unless @category.isValid() and Category.save(@category)
      msg = @category.validate()
      return alert msg

  template: (category) ->
    binaries = null
    binaries = category.getBinaries() if category?

    require('views/binaries/categories/form')
      binaries: binaries
      category: category

module?.exports = BinaryCategoryForm
