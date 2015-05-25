Spine   = @Spine or require('spine')
Binary  = require('models/binary')
Server  = require('models/server')
User    = require('models/user')
Version = require('models/binary_version')

class ServerForm extends Spine.Controller
  className: 'col-xs-12'
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'server'
  bindings:
  #  '.item input[name="id"]'   : 'id'
    '.item input[name="name"]': 'name'
    '.item input[name="ipv4"]': 'ipv4'

  @extend Spine.Bindings

  constructor: ->
    super

    @server = null
    Binary.bind 'refresh change', @render
    Server.bind 'refresh change', @render
    User.bind 'refresh change', @render
    Version.bind 'refresh change', @render

    @routes
      '/servers/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/servers'

  destroy: (event) =>
    if @server.destroy()
      @navigate '/servers'

  render: (params) =>
    event.preventDefault()

    @server = Server.find params.id
    @html @template @server
    @applyBindings() if @server?

  save: (event) =>
    unless @server.save()
      msg = @server.validate()
      return alert msg

  template: (item) ->
    binary_versions = null
    binary_versions = item.getBinaryVersions() if item?

    require('views/servers/form')
      binary_versions: binary_versions
      server: item

module?.exports = ServerForm
