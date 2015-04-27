Spine  = require('spine')
Binary = require('models/binary')

class BinariesMain extends Spine.Controller
  className: 'col-sm-9 col-md-10 col-sm-push-3 col-md-push-2'
  elements:
    '.items': 'items'

  constructor: ->
    super

    Binary.fetch()
    Binary.bind('refresh change', @render)

  render: =>
    @html(@template(Binary.all()))

  template: (items) ->
    require('views/binaries/main')(
      binaries: items
    )

module.exports = BinariesMain
