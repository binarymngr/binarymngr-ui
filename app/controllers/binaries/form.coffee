Spine    = @Spine or require 'spine'
Binary   = require 'models/binary'
Category = require 'models/binary_category'
User     = require 'models/user'
Version  = require 'models/binary_version'

class BinaryForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'binary'
  bindings:
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'
    # '.item select[name="categories"]'   : 'category_ids'
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

  activate: (params) =>
    super
    @render params

  cancel: (event) => @navigate '/binaries'

  destroy: (event) =>
    if @binary.destroy()
      @navigate '/binaries'

  render: (params) =>
    @binary = Binary.find params.id if params?.id?
    @html @template @binary
    do @applyBindings if @binary?

  save: (event) =>
    event.preventDefault()

    @binary.category_ids = @$('.selectpicker').selectpicker('val')  # FIXME: is a hack

    unless @binary.save()
      msg = @binary.validate()
      alert msg

  template: (binary) ->
    versions = null
    versions = binary.versions().all() if binary?

    require('views/binaries/form')
      binary: binary
      categories: Category.all()
      versions: versions

module?.exports = BinaryForm
