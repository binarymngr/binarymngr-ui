Spine = @Spine or require 'spine'
Role  = require 'models/role'
$     = Spine.$

class RolesTable extends Spine.Controller
  constructor: ->
    super

    @active @render
    Role.bind 'refresh change', @render

  render: =>
    if @isActive
      @html @template Role.all()
      @append new RolesTableAddModal  # FIXME

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
    @render()

  render: =>
    @html require('views/administration/roles/add-modal')()
    @applyBindings()

  save: (event) =>
    event.preventDefault()
    if @role.save()
      $('body').removeClass('modal-open')  # FIXME
      $('body').find('.modal-backdrop.fade.in').remove()
    else
      msg = @role.validate()
      alert msg
