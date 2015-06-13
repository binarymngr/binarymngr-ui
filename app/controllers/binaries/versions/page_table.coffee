Spine          = @Spine or require('spine')
Binary         = require('models/binary')
BinaryVersion  = require('models/binary_version')
Core           = require('framework/core')
Modal          = require('framework/controllers').Modal
RecordForm     = require('framework/controllers').RecordForm
Table          = require('framework/controllers').Table
TableRow       = require('framework/controllers').TableRow
$              = Spine.$

class BinaryVersionsTablePage extends Core.Controller
  constructor: ->
    super
    @modal = new AddBinaryVersionModal
    @table = new BinaryVersionsTable
    @render()

  render: =>
    @el.empty()
    @html $('<h1>Binary Versions</h1>')
    # TODO: create framework controller for button
    @append $("<button class='btn btn-primary pull-right' type='button' \
                data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append @table.render()
    @append @modal.render()
    @el

class NewBinaryVersionForm extends RecordForm
  model: BinaryVersion
  view : 'views/binaries/versions/add_modal_form'

  constructor: ->
    super
    @record = new @model
    Binary.bind 'refresh change', @render

  submit: (event) =>
    event.preventDefault()
    @trigger 'submitted', @, event
    @record = @record.fromForm(@el)
    @record.binary_id = @$('.selectpicker').selectpicker('val')
    if @record.save()
      @success @record
      @trigger 'success', @record
    else
      @error @record
      @trigger 'error', @record

  success : =>
    @record = new @model
    @render()

  render: =>
    super
    @record.unbind('change', @render) if @record
    @el

  template: (record) =>
    require(@view)
      binaries: Binary.all()
      item: record

class AddBinaryVersionModal extends Modal
  id   : 'add-binary-version-modal'
  title: 'Add Binary Version'

  constructor: ->
    @content = new NewBinaryVersionForm
    @content.bind 'success', => @el.modal 'hide'
    super

class BinaryVersionsTableRow extends TableRow
  view: 'views/binaries/versions/table_row'

class BinaryVersionsTable extends Table
  columns: ['ID', 'Binary', 'Identifier', 'Note', 'EOL']
  model  : BinaryVersion
  record : BinaryVersionsTableRow

module?.exports            = BinaryVersionsTablePage
module?.exports.Modal      = AddBinaryVersionModal
module?.exports.Modal.Form = NewBinaryVersionForm
module?.exports.Table      = BinaryVersionsTable
module?.exports.Table.Row  = BinaryVersionsTableRow
