Spine    = @Spine or require('spine')
Binary   = require('models/binary')
Category = require('models/binarycategory')

class BinariesSingleStack extends Spine.Controller
  @extend Spine.Bindings

  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  modelVar: 'model'
  bindings:
    # '.item input[name="id"]'         : 'id'
    '.item input[name="name"]'       : 'name'
    '.item input[name="description"]': 'description'
    '.item input[name="homepage"]'   : 'homepage'
    '.item input[name="eol"]'        : 'eol'
    # '.item input[name="owner_id"]'   : 'owner_id'

  constructor: ->
    super

    @routes
      '/binaries/:id': (params) ->
        @render params

    Binary.fetch()
    Category.fetch()
    @model = new Binary
    do @applyBindings

  cancel: (event) =>
    @navigate('/binaries')

  destroy: (event) =>
    @model.destroy()
    @navigate('/binaries')  # TODO: add check destory and confirm action

  render: (params) =>
    @model = Binary.find(params.id)
    do @applyBindings
    @html @template @model

  save: (event) =>
    @model.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/binaries/single')
      binary:     item
      categories: Category.all()

module.exports = BinariesSingleStack
