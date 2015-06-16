Spine       = @Spine or require('spine')
Controller  = require('framework/core').Controller
Controllers = require('framework/controllers')
Form        = Controllers.RecordForm
Modal       = Controllers.Modal
Request     = require('lib/http/request')
Role        = require('models/role')
Table       = Controllers.Table
TableRow    = Controllers.TableRow
$           = Spine.$

class RolesTablePage extends Controller
  constructor: ->
    super
    @modal = new AddRoleModal if Request.get().user.is_admin
    @table = new RolesTable
    @render()

  render: =>
    @html $('<h1>Roles</h1>')
    if Request.get().user.is_admin
      # TODO: create framework controller for button
      @append $("<button class='btn btn-primary pull-right' type='button' \
                  data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append $('<hr/>')
    @append @table.render()
    @append @modal.render() if Request.get().user.is_admin

class NewRoleForm extends Form
  model: Role
  view : 'views/administration/roles/add_modal_form'

  constructor: ->
    super
    @record = new @model

  success : =>
    @record = new @model
    @render()

  render: => @html @template @record

class AddRoleModal extends Modal
  id   : 'add-role-modal'
  title: 'Add Role'

  constructor: ->
    @content = new NewRoleForm
    @content.bind 'success', => @el.modal 'hide'
    super

class RolesTableRow extends TableRow
  view: 'views/administration/roles/table_row'

class RolesTable extends Table
  columns: ['ID', 'Name', 'Description']
  model  : Role
  record : RolesTableRow

module?.exports            = RolesTablePage
module?.exports.Modal      = AddRoleModal
module?.exports.Modal.Form = NewRoleForm
module?.exports.Table      = RolesTable
module?.exports.Table.Row  = RolesTableRow
