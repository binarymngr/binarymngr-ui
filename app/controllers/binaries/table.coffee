Spine  = require('spine')
Binary = require('models/binary')

class BinariesTable extends Spine.Controller
  elements:
    '.items': 'items'

  constructor: ->
    super

    Binary.fetch()
    Binary.bind('refresh change', @render)

  render: =>
    @html @template Binary.all()

  template: (items) ->
    require('views/binaries/table')
      binaries: items

module.exports = BinariesTable
