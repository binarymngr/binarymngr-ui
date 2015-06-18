Spine          = @Spine or require('spine')
Binary         = require('models/binary')
BinaryCategory = require('models/binary_category')
Controller     = require('framework/core').Controller
Controllers    = require('framework/controllers')
Modal          = Controllers.Modal
RecordForm     = Controllers.RecordForm
Table          = Controllers.Table
TableRow       = Controllers.TableRow
$              = Spine.$

class BinariesTablePage extends Controller
  constructor: ->
    super
    @modal = new AddBinaryModal
    @table = new BinariesTable
    @render()

  render: =>
    @html $('<h1>Binaries</h1>')
    # TODO: create framework controller for button
    @append $("<button class='btn btn-primary pull-right' type='button' \
                data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append $('<hr/>')
    @append @table.render()
    @append @modal.render()

class NewBinaryForm extends RecordForm
  model: Binary
  view : 'views/binaries/add_modal_form'

  constructor: ->
    super
    @record = new @model

  success : =>
    @record = new @model
    @render()

  render: => @html @template @record

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

  constructor: ->
    super
    BinaryCategory.bind 'refresh', @addAll

module?.exports            = BinariesTablePage
module?.exports.Modal      = AddBinaryModal
module?.exports.Modal.Form = NewBinaryForm
module?.exports.Table      = BinariesTable
module?.exports.Table.Row  = BinariesTableRow
