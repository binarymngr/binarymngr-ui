Spine      = @Spine or require('spine')
Core       = require('framework/core')
Modal      = require('framework/controllers').Modal
RecordForm = require('framework/controllers').RecordForm
Request    = require('lib/http/request')
Table      = require('framework/controllers').Table
TableRow   = require('framework/controllers').TableRow
User       = require('models/user')
$          = Spine.$

class UsersTablePage extends Core.Controller
  constructor: ->
    super
    @modal = new AddUserModal if Request.get().user.is_admin
    @table = new UsersTable
    @render()

  render: =>
    @el.empty()
    @html $('<h1>Users</h1>')
    if Request.get().user.is_admin
      # TODO: create framework controller for button
      @append $("<button class='btn btn-primary pull-right' type='button' \
                  data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append @table.render()
    @append @modal.render() if Request.get().user.is_admin
    @el

class NewUserForm extends RecordForm
  model: User
  view : 'views/administration/users/add_modal_form'

  constructor: ->
    super
    @record = new @model

  success : =>
    @record = new @model
    @render()

  render: => @html @template @record

class AddUserModal extends Modal
  id   : 'add-user-modal'
  title: 'Add User'

  constructor: ->
    @content = new NewUserForm
    @content.bind 'success', => @el.modal 'hide'
    super

class UsersTableRow extends TableRow
  view: 'views/administration/users/table_row'

class UsersTable extends Table
  columns: ['ID', 'Email']
  model  : User
  record : UsersTableRow

module?.exports            = UsersTablePage
module?.exports.Modal      = AddUserModal
module?.exports.Modal.Form = NewUserForm
module?.exports.Table      = UsersTable
module?.exports.Table.Row  = UsersTableRow
