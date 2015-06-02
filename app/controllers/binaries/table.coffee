Spine  = @Spine or require 'spine'
Binary = require 'models/binary'
$      = Spine.$

class BinariesTable extends Spine.Controller
  constructor: ->
    super

    Binary.bind 'refresh change', @render
    do @render

  render: =>
    @html @template Binary.all()
    @append new BinariesTableAddModal  # FIXME: do not init a new one every time

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
    do @render

  render: =>
    @html require('views/binaries/add-modal')()
    do @applyBindings

  save: (event) =>
    event.preventDefault()

    if @binary.save()
      @binary = new Binary
      do @applyBindings
      # FIXME: hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        @.remove()
    else
      msg = @binary.validate()
      alert msg
