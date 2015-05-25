Spine    = @Spine or require('spine')
Category = require('models/binary_category')

class BinaryCategoriesTable extends Spine.Controller
  constructor: ->
    super

    Category.bind 'refresh change', @render
    @render()

  render: =>
    @html @template Category.all()
    @append new BinaryCategoriesTableAddModal  # TODO: do not init a new one every time

  template: (items) ->
    require('views/binaries/categories/table')
      categories: items

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
      # TODO: fix hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        this.remove()
    else
      msg = @category.validate()
      return alert msg
