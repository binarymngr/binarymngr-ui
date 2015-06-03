Spine  = @Spine or require 'spine'
Binary = require 'models/binary'

class BinariesTable extends Spine.Controller
  constructor: ->
    super

    @active @render
    Binary.bind 'refresh change', @render

  render: =>
    if @isActive
      @html @template Binary.all()
      @append new BinariesTableAddModal  # FIXME

  template: (binaries) ->
    require('views/binaries/table')
      binaries: binaries

module?.exports = BinariesTable


class BinariesTableAddModal extends Spine.Controller
  events:
    'submit .item': 'save'

  modelVar: 'binary'
  bindings:
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'
    '.item input[name="homepage"]'      : 'homepage'

  @extend Spine.Bindings

  constructor: ->
    super

    @binary = new Binary
    @render()

  render: =>
    @html require('views/binaries/add-modal')()
    @applyBindings()

  save: (event) =>
    event.preventDefault()
    if @binary.save()
      $('body').removeClass('modal-open')  # FIXME
      $('body').find('.modal-backdrop.fade.in').remove()
    else
      msg = @binary.validate()
      alert msg
