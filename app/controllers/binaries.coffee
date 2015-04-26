Page   = require('controllers/page')
Binary = require('models/binary')

class Binaries extends Page
  className: 'page-binaries'
  elements:
    '.items': 'items'

  constructor: ->
    super
    Binary.fetch()
    Binary.bind('refresh change', @render)

  render: =>
    @html(@template(Binary.all()))

  template: (items) ->
    require('views/binaries')(
      binaries: items
    )

module.exports = Binaries
