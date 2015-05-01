Spine  = @Spine or require('spine')
Server = require('models/server')

class ServersSingleStack extends Spine.Controller
  @extend Spine.Bindings

  className: 'col-xs-12'
  events:
    'click .can-save'   : 'save'
    'click .can-destroy': 'destroy'

  modelVar: 'model'
  bindings:
    '.item input[name="name"]': 'name'
    '.item input[name="ipv4"]': 'ipv4'

  constructor: ->
    super

    Server.fetch()
    @model = new Server
    do @applyBindings

    @routes
      '/servers/:id': (params) ->
        @render params

  destroy: (event) =>
    @model.destroy()
    @navigate('/servers')  # TODO: add check destory and confirm action

  render: (params) =>
    @model = Server.find(params.id)
    do @applyBindings
    @html @template @model

  save: (event) =>
    @model.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/servers/single')
      server: item

module.exports = ServersSingleStack
