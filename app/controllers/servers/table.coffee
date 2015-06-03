Spine  = @Spine or require 'spine'
Server = require 'models/server'

class ServersTable extends Spine.Controller
  className: 'col-xs-12'

  constructor: ->
    super

    @active @render
    Server.bind 'refresh change', @render

  render: =>
    if @isActive
      @html @template Server.all()
      @append new ServersTableAddModal  # FIXME

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
    if @server.save()
      $('body').removeClass('modal-open')  # FIXME
      $('body').find('.modal-backdrop.fade.in').remove()
    else
      msg = @server.validate()
      alert msg
