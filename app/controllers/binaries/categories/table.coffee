Spine    = @Spine or require('spine')
Category = require('models/binarycategory')

class BinaryCategoriesTable extends Spine.Controller
  constructor: ->
    super

    Category.bind('refresh change destroy', @render)
    do @render

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
    do @render

  render: =>
    @html require('views/binaries/categories/add-modal')()
    do @applyBindings

  save: (event) =>
    event.preventDefault()

    if @category.save()
      @category = new Category
      do @applyBindings
      # TODO: fix hide backdrop
      $('.modal-backdrop.fade.in').fadeOut('fast', ->
        this.remove()
      )
    else
      msg = @category.validate()
      return alert(msg)
