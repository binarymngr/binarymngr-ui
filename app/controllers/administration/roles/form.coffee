Spine = @Spine or require 'spine'
Role  = require 'models/role'

class RoleForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'role'
  bindings:
    # '.item input[name="id"]'            : 'id'
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    @active @render
    @role = null
    Role.bind 'refresh', @render

  cancel:  -> @navigate '/administration/roles'
  destroy: -> @navigate '/administration/roles' if @role.destroy()

  render: (role) =>
    if @isActive
      @role = Role.find(role.id) if role?.id?
      @html @template @role
      if @role?
        @role.bind 'change', @render
        @applyBindings()

  save: (event) =>
    event.preventDefault()
    unless @role.save()
      msg = @role.validate()
      alert msg

  template: (role) ->
    require('views/administration/roles/form')
      role: role
      users: role?.getUsers()

module?.exports = RoleForm
