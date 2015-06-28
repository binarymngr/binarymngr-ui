Spine       = @Spine or require('spine')
Controller  = require('framework/core').Controller
Controllers = require('framework/controllers')
Form        = Controllers.RecordForm
Modal       = Controllers.Modal
Request     = require('lib/http/request')
Table       = Controllers.Table
TableRow    = Controllers.TableRow
User        = require('models/user')
$           = Spine.$

class UsersTablePage extends Controller
  constructor: ->
    super
    @modal = new AddUserModal if Request.get().user.is_admin
    @table = new UsersTable
    @render()

  render: =>
    @html $('<h1>Users</h1>')
    if Request.get().user.is_admin
      # TODO: create framework controller for button
      @append $("<button class='btn btn-primary pull-right' type='button' \
                  data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append $('<hr/>')
    @append @table.render()
    @append @modal.render() if Request.get().user.is_admin

class NewUserForm extends Form
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

  render: (record) =>
    super
    @el.addClass('warning') if @record?.hasMessages()
    @el

class UsersTable extends Table
  columns: ['ID', 'Email']
  model  : User
  record : UsersTableRow

module?.exports            = UsersTablePage
module?.exports.Modal      = AddUserModal
module?.exports.Modal.Form = NewUserForm
module?.exports.Table      = UsersTable
module?.exports.Table.Row  = UsersTableRow
