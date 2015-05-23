Spine   = @Spine or require('spine')
Binary  = require('models/binary')
Version = require('models/binary_version')

class BinaryVersionForm extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'submit .item'      : 'save'

  modelVar: 'version'
  bindings:
    # '.item input[name="id"]'        : 'id'
    '.item input[name="identifier"]': 'identifier'
    '.item textarea[name="note"]'   : 'note'
    '.item input[name="eol"]'       : 'eol'

  @extend Spine.Bindings

  constructor: ->
    super

    @version = null
    Binary.bind 'refresh change destroy', @render
    Version.bind 'refresh change destroy', @render

    @routes
      '/binaries/versions/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/binaries/versions'

  destroy: (event) =>
    if @version.destroy()
      @navigate '/binaries/versions'
    else
      return alert 'Something went wrong'

  render: (params) =>
    @version = Version.find params.id
    @html @template @version
    @applyBindings() if @version?

  save: (event) =>
    event.preventDefault()

    unless @version.save()
      msg = @version.validate()
      return alert msg

  template: (item) ->
    binary = null
    binary = item.binary() if item?

    require('views/binaries/versions/form')
      binary:  binary
      version: item

module?.exports = BinaryVersionForm