Spine               = @Spine or require('spine')
BinariesTable       = require('controllers/binaries/page_table').Table
BinaryVersionsTable = require('controllers/binaries/versions/page_table').Table
Controller          = require('framework/core').Controller
Form                = require('framework/controllers').RecordForm
Message             = require('models/message')
ServersTable        = require('controllers/servers/page_table').Table
Tabs                = require('framework/controllers').Tabs

class MessageFormPage extends Controller
  className: 'col-xs-12'

  constructor: ->
    super

    @form = new MessageForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    # binary
    @binaryTab = new Tabs.Tab(name: 'binary')
    @binaryTable = new MessageBinaryTable
    @tabs.addItem new Tabs.Nav.Item(tab: @binaryTab, text: 'Binary')
    @tabsContainer.addItem @binaryTab
    # binary version
    @binaryVersionTab = new Tabs.Tab(name: 'version')
    @binaryVersionTable = new MessageBinaryVersionTable
    @tabs.addItem new Tabs.Nav.Item(tab: @binaryVersionTab, text: 'Binary Version')
    @tabsContainer.addItem @binaryVersionTab
    # server
    @serverTab = new Tabs.Tab(name: 'version')
    @serverTable = new MessageServerTable
    @tabs.addItem new Tabs.Nav.Item(tab: @serverTab, text: 'Server')
    @tabsContainer.addItem @serverTab

    @active @form.render
    @active @binaryTable.render
    @active @binaryVersionTable.render
    @active @serverTable.render
    @active (params) =>
      msg = Message.find(params.id) if params?.id?
      if msg
        switch
          when msg.isForBinary() then @tabs.items[0].activate()
          when msg.isForBinaryVersion() then @tabs.items[1].activate()
          when msg.isForServer() then @tabs.items[2].activate()
          else # NOP

    @render()

  render: =>
    @html @form.render()
    @append $('<hr/>')
    @append @tabs.render()
    @binaryTab.append @binaryTable.render()
    @binaryVersionTab.append @binaryVersionTable.render()
    @serverTab.append @serverTable.render()
    @append @tabsContainer.render()

class MessageForm extends Form
  model: Message
  url  : '/messages'
  view : 'views/messages/form'

class MessageBinaryTable extends BinariesTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    msg = Message.find(params.id) if params?.id?
    if msg and msg.isForBinary()
      super
      @addOne(msg.binary())
    @el

class MessageBinaryVersionTable extends BinaryVersionsTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    msg = Message.find(params.id) if params?.id?
    if msg and msg.isForBinaryVersion()
      super
      @addOne(msg.binary_version())
    @el

class MessageServerTable extends ServersTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    msg = Message.find(params.id) if params?.id?
    if msg and msg.isForServer()
      super
      @addOne(msg.server())
    @el

module?.exports                    = MessageFormPage
module?.exports.Form               = MessageForm
module?.exports.BinaryTable        = MessageBinaryTable
module?.exports.BinaryVersionTable = MessageBinaryVersionTable
module?.exports.ServerTable        = MessageServerTable
