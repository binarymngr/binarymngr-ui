Spine  = @Spine or require('spine')
Server = require('models/server')

class ServersTableStack extends Spine.Controller
  className: 'col-xs-12'

  constructor: ->
    super

    Server.bind('refresh change', @render)
    do @render

  render: =>
    @html @template Server.all()

  template: (items) ->
    require('views/servers/table')
      servers: items

module.exports = ServersTableStack
