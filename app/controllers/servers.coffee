Page   = require('controllers/page')
Server = require('models/server')

class Servers extends Page
  className: 'row page-servers'
  elements:
    '.items': 'items'

  constructor: ->
    super
    Server.fetch()
    Server.bind('refresh change', @render)

  render: =>
    @html(@template(Server.all()))

  template: (items) ->
    require('views/servers')(
      servers: items
    )

module.exports = Servers
