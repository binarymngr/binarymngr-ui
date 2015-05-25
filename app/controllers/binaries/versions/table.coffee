Spine   = @Spine or require('spine')
Binary  = require('models/binary')
Version = require('models/binary_version')

class BinaryVersionsTable extends Spine.Controller
  constructor: ->
    super

    Version.bind 'refresh change', @render
    @render()

  render: =>
    @html @template Version.all()
    @append new BinaryVersionsTableAddModal  # TODO: do not init a new one every time

  template: (items) ->
    require('views/binaries/versions/table')
      versions: items

module?.exports = BinaryVersionsTable


class BinaryVersionsTableAddModal extends Spine.Controller
  events:
    'submit .item': 'save'

  modelVar: 'version'
  bindings:
    '.item input[name="identifier"]': 'identifier'
    '.item textarea[name="note"]'   : 'note'
    '.item input[name="eol"]'       : 'eol'
    '.item select[name="binary_id"]': 'binary_id'

  @extend Spine.Bindings

  constructor: ->
    super

    @version = new Version
    Binary.bind 'refresh change', @render
    @render()

  render: =>
    @html @template Binary.all()
    @applyBindings()

  save: (event) =>
    event.preventDefault()

    if @version.isValid() and Version.save(@version)
      @version = new Version
      @applyBindings()
      # TODO: fix hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        this.remove()
    else
      msg = @version.validate()
      return alert msg

  template: (items) ->
    require('views/binaries/versions/add-modal')
      binaries: items
