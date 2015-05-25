Spine  = @Spine or require('spine')
Binary = require('models/binary')
User   = require('models/user')

class BinariesTable extends Spine.Controller
  constructor: ->
    super

    Binary.bind 'refresh change', @render
    User.bind 'refresh change', @render
    @render()

  render: =>
    @html @template Binary.all()
    @append new BinariesTableAddModal  # TODO: do not init a new one every time

  template: (items) ->
    require('views/binaries/table')
      binaries: items

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

    if @binary.notifySave()
      @binary = new Binary
      @applyBindings()
      # TODO: fix hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        this.remove()
    else
      msg = @binary.validate()
      return alert msg
