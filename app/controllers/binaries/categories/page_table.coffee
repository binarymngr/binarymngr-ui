Spine          = @Spine or require('spine')
BinaryCategory = require('models/binary_category')
Core           = require('framework/core')
Modal          = require('framework/controllers').Modal
RecordForm     = require('framework/controllers').RecordForm
Table          = require('framework/controllers').Table
TableRow       = require('framework/controllers').TableRow
$              = Spine.$

class BinaryCategoriesTablePage extends Core.Controller
  constructor: ->
    super
    @modal = new AddBinaryCategoryModal
    @table = new BinaryCategoriesTable
    @render()

  render: =>
    @el.empty()
    @html $('<h1>Binary Categories</h1>')
    # TODO: create framework controller for button
    @append $("<button class='btn btn-primary pull-right' type='button' \
                data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append @table.render()
    @append @modal.render()
    @el

class NewBinaryCategoryForm extends RecordForm
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
