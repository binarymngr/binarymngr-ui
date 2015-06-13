Spine      = @Spine or require('spine')
Core       = require('framework/core')
Modal      = require('framework/controllers').Modal
RecordForm = require('framework/controllers').RecordForm
Request    = require('lib/http/request')
Role       = require('models/role')
Table      = require('framework/controllers').Table
TableRow   = require('framework/controllers').TableRow
$          = Spine.$

class RolesTablePage extends Core.Controller
  constructor: ->
    super
    @modal = new AddRoleModal if Request.get().user.is_admin
    @table = new RolesTable
    @render()

  render: =>
    @el.empty()
    @html $('<h1>Roles</h1>')
    if Request.get().user.is_admin
      # TODO: create framework controller for button
      @append $("<button class='btn btn-primary pull-right' type='button' \
                  data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append @table.render()
    @append @modal.render() if Request.get().user.is_admin
    @el

class NewRoleForm extends RecordForm
  model: Role
  view : 'views/administration/roles/add_modal_form'

  constructor: ->
    super
    @record = new @model

  success : =>
    @record = new @model
    @render()

  render: =>
    super
    @record.unbind('change', @render) if @record
    @el

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
