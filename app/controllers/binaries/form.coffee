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
    '.item select[name="categories"]'   : 'category_ids'
    '.item input[name="homepage"]'      : 'homepage'
    '.item input[name="eol"]'           : 'eol'

  @extend Spine.Bindings

  constructor: ->
    super

    @binary = null
    Binary.bind 'refresh change', @render
    Category.bind 'refresh', @render
    User.bind 'refresh', @render
    Version.bind 'refresh', @render  # TODO: add change because we can add one from this controller

    @routes
      '/binaries/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/binaries'

  destroy: (event) =>
    if @binary.destroy()
      @navigate '/binaries'

  render: (params) =>
    @binary = Binary.find params.id if params?.id?
    @html @template @binary
    @applyBindings() if @binary?

  save: (event) =>
    event.preventDefault()

    unless Binary.save(@binary)
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
