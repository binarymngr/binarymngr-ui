Spine  = require('spine')
Server = require('models/server')

class ServersTable extends Spine.Controller
  className: 'col-xs-12'
  elements:
    '.items': 'items'

  constructor: ->
    super

    Server.fetch()
    Server.bind('refresh change', @render)

  render: =>
    @html @template Server.all()

  template: (items) ->
    require('views/servers/table')
      servers: items

module.exports = ServersTable
