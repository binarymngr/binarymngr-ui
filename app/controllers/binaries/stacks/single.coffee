Spine    = @Spine or require('spine')
Binary   = require('models/binary')
Category = require('models/binarycategory')
Version  = require('models/binaryversion')

class BinariesSingleStack extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  modelVar: 'binary'
  bindings:
    # '.item input[name="id"]'         : 'id'
    '.item input[name="name"]'       : 'name'
    '.item input[name="description"]': 'description'
    '.item input[name="homepage"]'   : 'homepage'
    '.item input[name="eol"]'        : 'eol'
    # '.item input[name="owner_id"]'   : 'owner_id'

  @extend Spine.Bindings

  constructor: ->
    super

    # Binary.bind('refresh change', @render)
    # Category.bind('refresh change', @render)
    # Version.bind('refresh change', @render)

    @binary = new Binary
    do @applyBindings

    @routes
      '/binaries/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/binaries')

  destroy: (event) =>
    @binary.destroy()
    @navigate('/binaries')  # TODO: add check destory and confirm action

  render: (params) =>
    @binary = Binary.find(params.id)
    @html @template @binary
    do @applyBindings

  save: (event) =>
    @binary.save()  # TODO: add check destory and confirm action

  template: (item) ->
    @log(item.versions().all())
    require('views/binaries/single')
      binary:     item
      categories: Category.all()
      versions:   item.versions().all()

module.exports = BinariesSingleStack
