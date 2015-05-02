Spine  = @Spine or require('spine')
Server = require('models/server')

class ServersSingleStack extends Spine.Controller
  className: 'col-xs-12'
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  modelVar: 'server'
  bindings:
    # '.item input[name="id"]'      : 'id'
    '.item input[name="name"]'    : 'name'
    '.item input[name="ipv4"]'    : 'ipv4'
    # '.item input[name="owner_id"]': 'owner_id'

  @extend Spine.Bindings

  constructor: ->
    super

    @server = null
    Server.bind('refresh change', @render)

    @routes
      '/servers/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/servers')

  destroy: (event) =>
    @server.destroy()
    @navigate('/servers')  # TODO: add check destory and confirm action

  render: (params) =>
    @server = Server.find(params.id)
    @html @template @server
    if @server != null
      do @applyBindings

  save: (event) =>
    @server.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/servers/single')
      server: item

module.exports = ServersSingleStack
