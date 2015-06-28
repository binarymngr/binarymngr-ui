Spine         = @Spine or require('spine')
BinaryVersion = require('models/binary_version')
Controller    = require('framework/core').Controller
Form          = require('framework/controllers').RecordForm
MessagesTable = require('controllers/messages/page_table').Table
ServersTable  = require('controllers/servers/page_table').Table
Tabs          = require('framework/controllers').Tabs

class BinaryVersionFormPage extends Controller
  constructor: ->
    super

    @form = new BinaryVersionForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    # servers
    @serversTab = new Tabs.Tab(name: 'servers')
    @serversTable = new BinaryVersionServersTable
    @tabs.addItem new Tabs.Nav.Item(tab: @serversTab, text: 'Installed on')
    @tabsContainer.addItem @serversTab
    # messages
    @messagesTab = new Tabs.Tab(name: 'messages')
    @messagesTable = new BinaryVersionMessagesTable
    @tabs.addItem new Tabs.Nav.Item(tab: @messagesTab, text: 'Messages')
    @tabsContainer.addItem @messagesTab

    @active @form.render
    @active @messagesTable.render
    @active @serversTable.render
    @active _.first(@tabs.items).activate

    @render()

  render: =>
    @html @form.render()
    @append $('<hr/>')
    @append @tabs.render()
    @messagesTab.append @messagesTable.render()
    @serversTab.append @serversTable.render()
    @append @tabsContainer.render()
    _.first(@tabs.items).activate()

class BinaryVersionForm extends Form
  model: BinaryVersion
  url  : '/binaries/versions'
  view : 'views/binaries/versions/form'

class BinaryVersionMessagesTable extends MessagesTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    version = BinaryVersion.find(params.id) if params?.id?
    if version
      super
      @addOne(m) for m in version.messages().all()
    @el

class BinaryVersionServersTable extends ServersTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    version = BinaryVersion.find(params.id) if params?.id?
    if version
      super
      @addOne(s) for s in version.servers()
    @el

module?.exports               = BinaryVersionFormPage
module?.exports.Form          = BinaryVersionForm
module?.exports.MessagesTable = BinaryVersionMessagesTable
module?.exports.ServersTable  = BinaryVersionServersTable
