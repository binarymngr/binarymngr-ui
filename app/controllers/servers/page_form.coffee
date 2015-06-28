Spine                  = @Spine or require('spine')
BinaryVersionsTable    = require('controllers/binaries/versions/page_table').Table
BinaryVersionsTableRow = BinaryVersionsTable.Row
Controller             = require('framework/core').Controller
Form                   = require('framework/controllers').RecordForm
Message                = require('models/message')
MessagesTable          = require('controllers/messages/page_table').Table
Server                 = require('models/server')
Tabs                   = require('framework/controllers').Tabs
$                      = Spine.$

# TODO: remove messages from detached binary version
class ServerFormPage extends Controller
  className: 'col-xs-12'

  constructor: ->
    super

    @form = new ServerForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    # installed binary versions
    @binaryVersionsTab = new Tabs.Tab(name: 'binaries')
    @binaryVersionsTable = new ServerBinaryVersionsTable
    @tabs.addItem new Tabs.Nav.Item(tab: @binaryVersionsTab, text: 'Installed Binaries')
    @tabsContainer.addItem @binaryVersionsTab
    # messages
    @messagesTab = new Tabs.Tab(name: 'messages')
    @messagesTable = new ServerMessagesTable
    @tabs.addItem new Tabs.Nav.Item(tab: @messagesTab, text: 'Messages')
    @tabsContainer.addItem @messagesTab

    @active @form.render
    @active @binaryVersionsTable.render
    @active @messagesTable.render
    @active _.first(@tabs.items).activate

    @render()

  render: =>
    @html @form.render()
    @append $('<hr/>')
    @append @tabs.render()
    @binaryVersionsTab.append @binaryVersionsTable.render()
    @messagesTab.append @messagesTable.render()
    @append @tabsContainer.render()
    _.first(@tabs.items).activate()

class ServerForm extends Form
  model: Server
  url  : '/servers'
  view : 'views/servers/form'

class ServerBinaryVersionsTableRow extends BinaryVersionsTableRow
  events:
    'click .spine-detach': 'detach'

  view: 'views/servers/versions_table_row'

  constructor: ->
    super
    Message.bind('refresh', => @render @record)  # if @record?.hasMessages()
    @server = null

  detach: (event) =>
    event.preventDefault()
    @server.detachBinaryVersion @record
    @remove() if @server.save()

  render: (record) =>
    super
    @el.addClass('warning') if @record?.hasMessages()
    @el

class ServerBinaryVersionsTable extends BinaryVersionsTable
  columns: ['ID', 'Binary', 'Identifier', 'Note', 'EOL', 'Actions']
  record : ServerBinaryVersionsTableRow

  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    server = Server.find(params.id) if params?.id?
    if server
      super
      for version in server.binary_versions()
        row = @addOne(version)
        row.server = server
    @el

class ServerMessagesTable extends MessagesTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    server = Server.find(params.id) if params?.id?
    if server
      super
      @addOne(m) for m in server.messages().all()
    @el

module?.exports                         = ServerFormPage
module?.exports.Form                    = ServerForm
module?.exports.BinaryVersionsTable     = ServerBinaryVersionsTable
module?.exports.BinaryVersionsTable.Row = ServerBinaryVersionsTableRow
module?.exports.MessagesTable           = ServerMessagesTable
