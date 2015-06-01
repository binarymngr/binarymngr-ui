Spine    = @Spine or require 'spine'
Category = require 'models/binary_category'
$        = Spine.$

class BinaryCategoriesTable extends Spine.Controller
  constructor: ->
    super

    Category.bind 'refresh change', @render
    @render()

  render: =>
    @html @template Category.all()
    @append new BinaryCategoriesTableAddModal  # FIXME: do not init a new one every time

  template: (categories) ->
    require('views/binaries/categories/table')
      categories: categories

module?.exports = BinaryCategoriesTable


class BinaryCategoriesTableAddModal extends Spine.Controller
  events:
    'submit .item': 'save'

  modelVar: 'category'
  bindings:
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    @category = new Category
    @render()

  render: =>
    @html require('views/binaries/categories/add-modal')()
    @applyBindings()

  save: (event) =>
    event.preventDefault()

    if @category.isValid() and Category.save(@category)
      @category = new Category
      @applyBindings()
      # FIXME: hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        @.remove()
    else
      msg = @category.validate()
      return alert msg
