Spine                   = @Spine or require('spine')
Binary                  = require('models/binary')
BinaryCategory          = require('models/binary_category')
_BinaryVersionsTable    = require('controllers/binaries/versions/page_table').Table
_BinaryVersionsTableRow = _BinaryVersionsTable.Row
Controller              = require('framework/core').Controller
Form                    = require('framework/controllers').RecordForm
Tabs                    = require('controllers/components/tabs')
$                       = Spine.$

class BinaryFormPage extends Controller
  constructor: ->
    super

    @form = new BinaryForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    @versionsTab = new Tabs.Tab(name: 'binaries')
    @versionsTable = new BinaryVersionsTable
    @tabs.addItem new Tabs.Nav.Item(tab: @versionsTab, text: 'Versions')
    @tabsContainer.addItem @versionsTab

    @active @form.render
    @active @versionsTable.render

    _.first(@tabs.items).activate()
    @render()

  render: =>
    @html @form.render
    @append $('<hr/>')
    @append @tabs.render()
    @versionsTab.append @versionsTable.render()
    @append @tabsContainer.render()

class BinaryForm extends Form
  model: Binary
  url  : '/binaries'
  view : 'views/binaries/form'

  submit: (event) =>
    event.preventDefault()
    @trigger 'submitted', @, event
    @record.fromForm(@el)
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

  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    binary = Binary.find(params.id) if params?.id?
    if binary
      super
      @addOne(v) for v in binary.versions().all()
    @el

module?.exports               = BinaryFormPage
module?.exports.Form          = BinaryForm
module?.exports.VersionsTable = BinaryVersionsTable
