Spine  = @Spine or require('spine')
Server = require('models/server')

class ServersTable extends Spine.Controller
  className: 'col-xs-12'

  constructor: ->
    super

    Server.bind 'refresh change destroy', @render
    @render()

  render: =>
    @html @template Server.all()
    @append new ServersTableAddModal  # TODO: do not init a new one every time

  template: (items) ->
    require('views/servers/table')
      servers: items

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

    if @server.save()
      @server = new Server
      @applyBindings()
      # TODO: fix hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        this.remove()
    else
      msg = @server.validate()
      return alert msg
