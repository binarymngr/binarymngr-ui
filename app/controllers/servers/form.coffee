Spine  = @Spine or require('spine')
Server = require('models/server')

class ServersSingleStack extends Spine.Controller
  className: 'col-xs-12'
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'submit .item'      : 'save'

  modelVar: 'server'
  bindings:
  #  '.item input[name="id"]'   : 'id'
    '.item input[name="name"]': 'name'
    '.item input[name="ipv4"]': 'ipv4'

  @extend Spine.Bindings

  constructor: ->
    super

    @server = null
    Server.bind('refresh change destroy', @render)

    @routes
      '/servers/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/servers')

  destroy: (event) =>
    if @server.destroy()
      @navigate('/servers')
    else
      return alert('Something went wrong')

  render: (params) =>
    event.preventDefault()

    @server = Server.find(params.id)
    @html @template @server
    if @server?
      do @applyBindings

  save: (event) =>
    unless @server.save()
      msg = @server.validate()
      return alert(msg)

  template: (item) ->
    require('views/servers/form')
      server: item

module.exports = ServersSingleStack
