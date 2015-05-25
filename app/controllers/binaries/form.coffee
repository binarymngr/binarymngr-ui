Spine    = @Spine or require('spine')
Binary   = require('models/binary')
Category = require('models/binary_category')
User     = require('models/user')
Version  = require('models/binary_version')

class BinaryForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'binary'
  bindings:
    # '.item input[name="id"]'            : 'id'
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'
    '.item input[name="homepage"]'      : 'homepage'
    '.item input[name="eol"]'           : 'eol'

  @extend Spine.Bindings

  constructor: ->
    super

    @binary = null
    Binary.bind 'refresh change', @render
    Category.bind 'refresh change', @render
    User.bind 'refresh change', @render
    Version.bind 'refresh change', @render

    @routes
      '/binaries/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/binaries'

  destroy: (event) =>
    if @binary.destroy()
      @navigate '/binaries'

  render: (params) =>
    @binary = Binary.find params.id
    @html @template @binary
    @applyBindings() if @binary?

  save: (event) =>
    event.preventDefault()

    unless @binary.save()
      msg = @binary.validate()
      return alert msg

  template: (item) ->
    versions = null
    versions = item.versions().all() if item?

    require('views/binaries/form')
      binary: item
      categories: Category.all()
      versions: versions

module?.exports = BinaryForm
