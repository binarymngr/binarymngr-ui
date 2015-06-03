Spine  = @Spine or require 'spine'
Server = require 'models/server'

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

    @active @render
    @server = null
    Server.bind 'refresh', @render

  cancel:  -> @navigate '/servers'
  destroy: -> @navigate '/servers' if @server.destroy()

  render: (server) =>
    if @isActive
      @server = Server.find(server.id) if server?.id?
      @html @template @server
      if @server?
        @server.bind 'change', @render
        @applyBindings()

  save: (event) =>
    event.preventDefault()
    unless @server.save()
      msg = @server.validate()
      alert msg

  template: (server) ->
    require('views/servers/form')
      binary_versions: server?.getBinaryVersions()
      server: server

module?.exports = ServerForm
