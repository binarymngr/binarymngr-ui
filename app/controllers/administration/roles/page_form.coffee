Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
RecordForm = require('framework/controllers').RecordForm
Role       = require('models/role')
User       = require('models/user')
UsersTable = require('controllers/administration/users/page_table').Table
$          = Spine.$

class RoleFormPage extends Controller
  constructor: ->
    super
    @form = new RoleForm
    @userTable = new RoleUsersTable
    @active @form.render
    @active @userTable.render
    @render()

  render: =>
    @html @form.render()
    @append @userTable.render()
    @el

class RoleForm extends RecordForm
  model: Role
  url  : '/administration/roles'
  view : 'views/administration/roles/form'

class RoleUsersTable extends UsersTable
  constructor: ->
    super
    @heading = $('<hr><h2>Members</h2>')

  addAll: -> # NOP

  render: (params) =>
    @heading.remove()
    @el.empty()
    role = Role.find(params.id) if params?.id?
    if role
      super
      @heading.insertBefore @el
      $.each role.getUsers(), (i, user) => @addOne user
    @el

module?.exports            = RoleFormPage
module?.exports.Form       = RoleForm
module?.exports.UsersTable = RoleUsersTable
