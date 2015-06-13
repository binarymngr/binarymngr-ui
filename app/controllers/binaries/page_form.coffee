Spine                   = @Spine or require('spine')
Binary                  = require('models/binary')
BinaryCategory          = require('models/binary_category')
_BinaryVersionsTable    = require('controllers/binaries/versions/page_table').Table
_BinaryVersionsTableRow = require('controllers/binaries/versions/page_table').Table.Row
Controller              = require('framework/core').Controller
RecordForm              = require('framework/controllers').RecordForm
$                       = Spine.$

class BinaryFormPage extends Controller
  constructor: ->
    super
    @form = new BinaryForm
    @versionsTable = new BinaryVersionsTable
    @active @form.render
    @active @versionsTable.render
    @render()

  render: =>
    @html @form.render
    @append @versionsTable.render

class BinaryForm extends RecordForm
  model: Binary
  url  : '/binaries'
  view : 'views/binaries/form'

  submit: (event) =>
    event.preventDefault()
    @trigger 'submitted', @, event
    @record = @record.fromForm(@el)
    @record.binary_category_ids = @$('.selectpicker').selectpicker('val')
    if @record.save()
      @success @record
      @trigger 'success', @record
    else
      @error @record
      @trigger 'error', @record

  template: (record) =>
    require(@view)
      item: record
      categories: BinaryCategory.all()

class BinaryVersionsTableRow extends _BinaryVersionsTableRow
  view: 'views/binaries/versions_table_row'

class BinaryVersionsTable extends _BinaryVersionsTable
  columns: ['ID', 'Identifier', 'Note', 'EOL']
  record : BinaryVersionsTableRow

  constructor: ->
    super
    @heading = $('<hr><h2>Versions</h2>')

  addAll: -> # NOP

  render: (params) =>
    @heading.remove()
    @el.empty()
    binary = Binary.find(params.id) if params?.id?
    if binary
      super
      @heading.insertBefore @el
      $.each binary.versions().all(), (i, version) => @addOne version
    @el

module?.exports               = BinaryFormPage
module?.exports.Form          = BinaryForm
module?.exports.VersionsTable = BinaryVersionsTable
