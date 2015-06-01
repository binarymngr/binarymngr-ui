Spine   = @Spine or require 'spine'
Binary  = require 'models/binary'
Server  = require 'models/server'
User    = require 'models/user'
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

    @version = null
    Binary.bind 'refresh change', @render
    Server.bind 'refresh change', @render
    User.bind 'refresh change', @render
    Version.bind 'refresh change', @render

    @routes
      '/binaries/versions/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/binaries/versions'

  destroy: (event) =>
    if @version.destroy()
      @navigate '/binaries/versions'

  render: (params) =>
    @version = Version.find params.id if params?.id?
    @html @template @version
    @applyBindings() if @version?

  save: (event) =>
    event.preventDefault()

    unless @version.isValid() and Version.save(@version)
      msg = @version.validate()
      return alert msg

  template: (version) ->
    binary  = null
    binary  = version.binary() if version?
    servers = null
    servers = version.getServers() if version?

    require('views/binaries/versions/form')
      binary: binary
      servers: servers
      version: version

module?.exports = BinaryVersionForm
