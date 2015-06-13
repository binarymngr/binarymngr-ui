Spine      = @Spine or require('spine')
Binary     = require('models/binary')
Core       = require('framework/core')
Modal      = require('framework/controllers').Modal
RecordForm = require('framework/controllers').RecordForm
Table      = require('framework/controllers').Table
TableRow   = require('framework/controllers').TableRow
$          = Spine.$

class BinariesTablePage extends Core.Controller
  constructor: ->
    super
    @modal = new AddBinaryModal
    @table = new BinariesTable
    @render()

  render: =>
    @el.empty()
    @html $('<h1>Binaries</h1>')
    # TODO: create framework controller for button
    @append $("<button class='btn btn-primary pull-right' type='button' \
                data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append @table.render()
    @append @modal.render()
    @el

class NewBinaryForm extends RecordForm
  model: Binary
  view : 'views/binaries/add_modal_form'

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

class AddBinaryModal extends Modal
  id   : 'add-binary-modal'
  title: 'Add Binary'

  constructor: ->
    @content = new NewBinaryForm
    @content.bind 'success', => @el.modal 'hide'
    super

class BinariesTableRow extends TableRow
  view: 'views/binaries/table_row'

class BinariesTable extends Table
  columns: ['ID', 'Name', 'Description', 'Categories', 'Homepage']
  model  : Binary
  record : BinariesTableRow

module?.exports            = BinariesTablePage
module?.exports.Modal      = AddBinaryModal
module?.exports.Modal.Form = NewBinaryForm
module?.exports.Table      = BinariesTable
module?.exports.Table.Row  = BinariesTableRow
