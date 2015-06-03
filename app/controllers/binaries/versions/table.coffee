Spine   = @Spine or require 'spine'
Binary  = require 'models/binary'
Version = require 'models/binary_version'

class BinaryVersionsTable extends Spine.Controller
  constructor: ->
    super

    @active @render
    Version.bind 'refresh change', @render

  render: =>
    if @isActive
      @html @template Version.all()
      @append new BinaryVersionsTableAddModal  # FIXME

  template: (versions) ->
    require('views/binaries/versions/table')
      versions: versions

module?.exports = BinaryVersionsTable


class BinaryVersionsTableAddModal extends Spine.Controller
  events:
    'submit .item': 'save'

  modelVar: 'version'
  bindings:
    '.item input[name="identifier"]': 'identifier'
    '.item textarea[name="note"]'   : 'note'
    '.item input[name="eol"]'       : 'eol'
    # '.item select[name="binary_id"]': 'binary_id'

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
    @version.binary_id = @$('.selectpicker').selectpicker('val')  # FIXME: is a hack
    if @version.save()
      $('body').removeClass('modal-open')  # FIXME
      $('body').find('.modal-backdrop.fade.in').remove()
    else
      msg = @version.validate()
      alert msg

  template: (binaries) ->
    require('views/binaries/versions/add-modal')
      binaries: binaries
