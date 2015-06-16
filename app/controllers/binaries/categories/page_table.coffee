Spine          = @Spine or require('spine')
BinaryCategory = require('models/binary_category')
Controller     = require('framework/core').Controller
Controllers    = require('framework/controllers')
Form           = Controllers.RecordForm
Modal          = Controllers.Modal
Table          = Controllers.Table
TableRow       = Controllers.TableRow
$              = Spine.$

class BinaryCategoriesTablePage extends Controller
  constructor: ->
    super
    @modal = new AddBinaryCategoryModal
    @table = new BinaryCategoriesTable
    @render()

  render: =>
    @html $('<h1>Binary Categories</h1>')
    # TODO: create framework controller for button
    @append $("<button class='btn btn-primary pull-right' type='button' \
                data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append $('<hr/>')
    @append @table.render()
    @append @modal.render()

class NewBinaryCategoryForm extends Form
  model: BinaryCategory
  view : 'views/binaries/categories/add_modal_form'

  constructor: ->
    super
    @record = new @model

  success : =>
    @record = new @model
    @render()

  render: => @html @template @record

class AddBinaryCategoryModal extends Modal
  id   : 'add-binary-category-modal'
  title: 'Add Binary Category'

  constructor: ->
    @content = new NewBinaryCategoryForm
    @content.bind 'success', => @el.modal 'hide'
    super

class BinaryCategoriesTableRow extends TableRow
  view: 'views/binaries/categories/table_row'

class BinaryCategoriesTable extends Table
  columns: ['ID', 'Name', 'Description']
  model  : BinaryCategory
  record : BinaryCategoriesTableRow

module?.exports            = BinaryCategoriesTablePage
module?.exports.Modal      = AddBinaryCategoryModal
module?.exports.Modal.Form = NewBinaryCategoryForm
module?.exports.Table      = BinaryCategoriesTable
module?.exports.Table.Row  = BinaryCategoriesTableRow
