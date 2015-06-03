Spine    = @Spine or require 'spine'
Binary   = require 'models/binary'
Category = require 'models/binary_category'

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

    @active @render
    @binary = null
    Binary.bind 'refresh', @render

  cancel:  -> @navigate '/binaries'
  destroy: -> @navigate '/binaries' if @binary.destroy()

  render: (binary) =>
    if @isActive
      @binary = Binary.find(binary.id) if binary?.id?
      @html @template @binary
      if @binary?
        @binary.bind 'change', @render
        @applyBindings()

  save: (event) =>
    event.preventDefault()
    @binary.binary_category_ids = @$('.selectpicker').selectpicker('val')
    unless @binary.save()
      msg = @binary.validate()
      alert msg

  template: (binary) ->
    require('views/binaries/form')
      binary: binary
      categories: Category.all()
      versions: binary?.versions().all()

module?.exports = BinaryForm
