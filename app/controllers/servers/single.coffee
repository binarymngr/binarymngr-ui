Spine  = require('spine')
Server = require('models/server')

class ServersSingle extends Spine.Controller
  className: 'col-xs-12'

  constructor: ->
    super

    Server.fetch()
    @routes
      '/servers/:id': (params) ->
        @render params

  render: (params) =>
    @html @template Server.find(params.id)

  template: (item) ->
    require('views/servers/single')
      server: item

module.exports = ServersSingle
