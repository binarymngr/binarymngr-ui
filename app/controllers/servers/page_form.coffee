Spine               = @Spine or require('spine')
BinaryVersionsTable = require('controllers/binaries/versions/page_table').Table
Controller          = require('framework/core').Controller
Form                = require('framework/controllers').RecordForm
MessagesTable       = require('controllers/messages/page_table').Table
Server              = require('models/server')
Tabs                = require('controllers/components/tabs')
$                   = Spine.$

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

class ServerBinaryVersionsTable extends BinaryVersionsTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    server = Server.find(params.id) if params?.id?
    if server
      super
      @addOne(v) for v in server.getBinaryVersions()
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

module?.exports                     = ServerFormPage
module?.exports.Form                = ServerForm
module?.exports.BinaryVersionsTable = ServerBinaryVersionsTable
module?.exports.MessagesTable       = ServerMessagesTable
