Spine    = @Spine or require 'spine'
Category = require 'models/binary_category'

class BinaryCategoriesTable extends Spine.Controller
  constructor: ->
    super

    @active @render
    Category.bind 'refresh change', @render

  render: =>
    if @isActive
      @html @template Category.all()
      @append new BinaryCategoriesTableAddModal  # FIXME

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
    if @category.save()
      $('body').removeClass('modal-open')  # FIXME
      $('body').find('.modal-backdrop.fade.in').remove()
    else
      msg = @category.validate()
      alert msg
