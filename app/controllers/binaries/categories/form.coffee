Spine    = @Spine or require 'spine'
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

    @active @render
    @category = null
    Category.bind 'refresh', @render

  cancel:  -> @navigate '/binaries/categories'
  destroy: -> @navigate '/binaries/categories' if @category.destroy()

  render: (category) =>
    if @isActive
      @category = Category.find(category.id) if category?.id?
      @html @template @category
      if @category?
        @category.bind 'change', @render
        @applyBindings()

  save: (event) =>
    event.preventDefault()
    unless @category.save()
      msg = @category.validate()
      alert msg

  template: (category) ->
    require('views/binaries/categories/form')
      binaries: category?.getBinaries()
      category: category

module?.exports = BinaryCategoryForm
