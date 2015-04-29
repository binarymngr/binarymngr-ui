Spine  = require('spine')
Server = require('models/server')

class ServersSingle extends Spine.Controller
  className: 'col-xs-12'
  events:
    'click .can-save': 'save'
    'click .can-destroy': 'destroy'

  constructor: ->
    super

    Server.fetch()
    @item = null

    @routes
      '/servers/:id': (params) ->
        @render params

  destroy: (event) =>
    @item.destroy()
    @navigate('/servers')  # TODO: add check destory and confirm action

  render: (params) =>
    @item = Server.find(params.id)
    @html @template @item

  save: (event) =>
    @item.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/servers/single')
      server: item

module.exports = ServersSingle
