Spine  = @Spine or require('spine')
Server = require('models/server')

class ServersSingleStack extends Spine.Controller
  @extend Spine.Bindings

  className: 'col-xs-12'
  events:
    'click .can-save'   : 'save'
    'click .can-destroy': 'destroy'

  modelVar: 'item'
  bindings:
    '.item input[name="name"]': 'name'
    '.item input[name="ipv4"]': 'ipv4'

  constructor: ->
    super

    Server.fetch()
    @item = new Server
    do @applyBindings

    @routes
      '/servers/:id': (params) ->
        @render params

  destroy: (event) =>
    @item.destroy()
    @navigate('/servers')  # TODO: add check destory and confirm action

  render: (params) =>
    @item = Server.find(params.id)
    do @applyBindings
    @html @template @item

  save: (event) =>
    @item.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/servers/single')
      server: item

module.exports = ServersSingleStack
