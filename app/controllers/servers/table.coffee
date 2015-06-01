Spine  = @Spine or require 'spine'
Server = require 'models/server'
$      = Spine.$

class ServersTable extends Spine.Controller
  className: 'col-xs-12'

  constructor: ->
    super

    Server.bind 'refresh change', @render
    @render()

  render: =>
    @html @template Server.all()
    @append new ServersTableAddModal  # FIXME: do not init a new one every time

  template: (servers) ->
    require('views/servers/table')
      servers: servers

module?.exports = ServersTable


class ServersTableAddModal extends Spine.Controller
  events:
    'submit .item': 'save'

  modelVar: 'server'
  bindings:
    '.item input[name="name"]': 'name'
    '.item input[name="ipv4"]': 'ipv4'

  @extend Spine.Bindings

  constructor: ->
    super

    @server = new Server
    @render()

  render: =>
    @html require('views/servers/add-modal')()
    @applyBindings()

  save: (event) =>
    event.preventDefault()

    if @server.isValid() and Server.save(@server)
      @server = new Server
      @applyBindings()
      # FIXME: hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        @.remove()
    else
      msg = @server.validate()
      return alert msg
