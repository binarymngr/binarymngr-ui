Spine                   = @Spine or require('spine')
Binary                  = require('models/binary')
BinaryCategory          = require('models/binary_category')
BinaryVersionsGatherer  = require('models/binary_versions_gatherer')
_BinaryVersionsTable    = require('controllers/binaries/versions/page_table').Table
_BinaryVersionsTableRow = _BinaryVersionsTable.Row
Controller              = require('framework/core').Controller
Form                    = require('framework/controllers').RecordForm
Message                 = require('models/message')
MessagesTable           = require('controllers/messages/page_table').Table
Tabs                    = require('framework/controllers').Tabs
$                       = Spine.$

class BinaryFormPage extends Controller
  constructor: ->
    super

    @form = new BinaryForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    # versions
    @versionsTab = new Tabs.Tab(name: 'binaries')
    @versionsTable = new BinaryVersionsTable
    @tabs.addItem new Tabs.Nav.Item(tab: @versionsTab, text: 'Versions')
    @tabsContainer.addItem @versionsTab
    # messages
    @messagesTab = new Tabs.Tab(name: 'messages')
    @messagesTable = new BinaryMessagesTable
    @tabs.addItem new Tabs.Nav.Item(tab: @messagesTab, text: 'Messages')
    @tabsContainer.addItem @messagesTab

    @active @form.render
    @active @messagesTable.render
    @active @versionsTable.render
    @active _.first(@tabs.items).activate

    @render()

  render: =>
    @html @form.render
    @append $('<hr/>')
    @append @tabs.render()
    @messagesTab.append @messagesTable.render()
    @versionsTab.append @versionsTable.render()
    @append @tabsContainer.render()
    _.first(@tabs.items).activate()

class BinaryForm extends Form
  model: Binary
  url  : '/binaries'
  view : 'views/binaries/form'

  submit: (event) =>
    event.preventDefault()
    @trigger 'submitted', @, event
    @record.fromForm(@el)
    @record.binary_category_ids = @$('#sp1').selectpicker('val')
    versions_gatherer = @$('#sp2').selectpicker('val')
    if versions_gatherer isnt 'null'
      @record.versions_gatherer = versions_gatherer
    else
      @record.versions_gatherer = null
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
      versions_gatherers: BinaryVersionsGatherer.all()

class BinaryMessagesTable extends MessagesTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    binary = Binary.find(params.id) if params?.id?
    if binary
      super
      @addOne(m) for m in binary.messages().all()
    @el

class BinaryVersionsTableRow extends _BinaryVersionsTableRow
  view: 'views/binaries/versions_table_row'

  constructor: ->
    super
    Message.bind('refresh', => @render @record)  # if @record?.hasMessages()

  render: (record) =>
    super
    @el.addClass('warning') if @record?.hasMessages()
    @el

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
module?.exports.MessagesTable = BinaryMessagesTable
module?.exports.VersionsTable = BinaryVersionsTable
