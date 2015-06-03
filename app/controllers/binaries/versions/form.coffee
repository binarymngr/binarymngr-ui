Spine   = @Spine or require 'spine'
Version = require 'models/binary_version'

class BinaryVersionForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'version'
  bindings:
    '.item input[name="identifier"]': 'identifier'
    '.item textarea[name="note"]'   : 'note'
    '.item input[name="eol"]'       : 'eol'

  @extend Spine.Bindings

  constructor: ->
    super

    @active @render
    @version = null
    Version.bind 'refresh', @render

  cancel:  -> @navigate '/binaries/versions'
  destroy: -> @navigate '/binaries/versions' if @version.destroy()

  render: (version) =>
    if @isActive
      @version = Version.find(version.id) if version?.id?
      @html @template @version
      if @version?
        @version.bind 'change', @render
        @applyBindings() if @version?

  save: (event) =>
    event.preventDefault()
    unless @version.save()
      msg = @version.validate()
      alert msg

  template: (version) ->
    require('views/binaries/versions/form')
      binary: version?.binary()
      servers: version?.getServers()
      version: version

module?.exports = BinaryVersionForm
