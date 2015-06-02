Spine = @Spine or require 'spine'
Role  = require 'models/role'
$     = Spine.$

class RolesTable extends Spine.Controller
  constructor: ->
    super

    Role.bind 'refresh change', @render
    do @render

  render: =>
    @html @template Role.all()
    @append new RolesTableAddModal  # FIXME: do not init a new one every time

  template: (roles) ->
    require('views/administration/roles/table')
      roles: roles

module?.exports = RolesTable


class RolesTableAddModal extends Spine.Controller
  events:
    'submit .item': 'save'

  modelVar: 'role'
  bindings:
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    @role = new Role
    do @render

  render: =>
    @html require('views/administration/roles/add-modal')()
    do @applyBindings

  save: (event) =>
    event.preventDefault()

    if @role.save()
      @role = new Role
      do @applyBindings
      # FIXME: hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        @.remove()
    else
      msg = @role.validate()
      alert msg
