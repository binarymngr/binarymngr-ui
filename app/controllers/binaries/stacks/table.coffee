Spine  = @Spine or require('spine')
Binary = require('models/binary')

class BinariesTableStack extends Spine.Controller
  constructor: ->
    super

    Binary.fetch()
    Binary.bind('refresh change', @render)

  render: =>
    @html @template Binary.all()

  template: (items) ->
    require('views/binaries/table')
      binaries: items

module.exports = BinariesTableStack