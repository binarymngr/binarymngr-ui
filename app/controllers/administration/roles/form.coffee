Spine   = @Spine or require 'spine'
Request = require 'lib/http/request'
Role    = require 'models/role'
User    = require 'models/user'

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

    @role = null
    Role.bind 'refresh change', @render
    User.bind 'refresh change', @render

    @routes
      '/administration/roles/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/administration/roles'

  destroy: (event) =>
    if @role.destroy()
      @navigate '/administration/roles'

  render: (params) =>
    @role = Role.find params.id if params?.id?
    @html @template @role
    @applyBindings() if @role?

  save: (event) =>
    event.preventDefault()

    unless @role.isValid() and Role.save(@role)
      msg = @role.validate()
      return alert msg

  template: (role) ->
    users = null
    users = role.getUsers() if role?

    require('views/administration/roles/form')
      role: role
      rqst: Request.get()
      users: users

module?.exports = RoleForm
