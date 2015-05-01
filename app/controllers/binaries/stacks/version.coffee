Spine   = @Spine or require('spine')
Version = require('models/binaryversion')

class BinariesVersionStack extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  modelVar: 'version'
  bindings:
    # '.item input[name="id"]'        : 'id'
    '.item input[name="identifier"]': 'identifier'
    '.item textarea[name="note"]'   : 'note'
    '.item input[name="eol"]'       : 'eol'

  @extend Spine.Bindings

  constructor: ->
    super

    @version = new Version
    Version.bind('refresh change', @render)
    do @applyBindings

    @routes
      '/binaries/versions/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/binaries/versions')

  destroy: (event) =>
    @version.destroy()
    @navigate('/binaries/versions')  # TODO: add check destory and confirm action

  render: (params) =>
    @version = Version.find(params.id)
    # fix errors like @version.bind on null
    if @version == null
      @version = new Version
    @html @template @version
    do @applyBindings

  save: (event) =>
    @version.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/binaries/version')
      # binary: item.binary()
      version: item

module.exports = BinariesVersionStack
