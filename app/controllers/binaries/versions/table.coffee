Spine   = @Spine or require('spine')
Version = require('models/binaryversion')

class BinaryVersionsTable extends Spine.Controller
  constructor: ->
    super

    Version.bind('refresh change', @render)
    do @render

  render: =>
    @html @template Version.all()

  template: (items) ->
    require('views/binaries/versions/table')
      versions: items

module.exports = BinaryVersionsTable
