Spine   = @Spine or require 'spine'
Binary  = require 'models/binary'
Server  = require 'models/server'
Version = require 'models/binary_version'

class ServerForm extends Spine.Controller
  className: 'col-xs-12'
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'server'
  bindings:
    '.item input[name="name"]': 'name'
    '.item input[name="ipv4"]': 'ipv4'

  @extend Spine.Bindings

  constructor: ->
    super

    @server = null
    Binary.bind 'refresh change', @render
    Server.bind 'refresh change', @render
    Version.bind 'refresh change', @render

  activate: (params) =>
    super
    @render params

  cancel: (event) => @navigate '/servers'

  destroy: (event) =>
    if @server.destroy()
      @navigate '/servers'

  render: (params) =>
    @server = Server.find params.id if params?.id?
    @html @template @server
    do @applyBindings if @server?

  save: (event) =>
    event.preventDefault()

    unless @server.save()
      msg = @server.validate()
      alert msg

  template: (server) ->
    binary_versions = null
    binary_versions = server.getBinaryVersions() if server?

    require('views/servers/form')
      binary_versions: binary_versions
      server: server

module?.exports = ServerForm
