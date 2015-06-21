Spine         = @Spine or require('spine')
BinariesTable = require('controllers/binaries/page_table').Table
Controller    = require('framework/core').Controller
Form          = require('framework/controllers').RecordForm
MessagesTable = require('controllers/messages/page_table').Table
Role          = require('models/role')
ServersTable  = require('controllers/servers/page_table').Table
Tabs          = require('framework/controllers').Tabs
User          = require('models/user')
$             = Spine.$

class UserFormPage extends Controller
  constructor: ->
    super

    @form = new UserForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    # binaries
    @binariesTab = new Tabs.Tab(name: 'binaries')
    @binariesTable = new UserBinariesTable
    @tabs.addItem new Tabs.Nav.Item(tab: @binariesTab, text: 'Binaries')
    @tabsContainer.addItem @binariesTab
    # messages
    @messagesTab = new Tabs.Tab(name: 'messages')
    @messagesTable = new UserMessagesTable
    @tabs.addItem new Tabs.Nav.Item(tab: @messagesTab, text: 'Messages')
    @tabsContainer.addItem @messagesTab
    # servers
    @serversTab = new Tabs.Tab(name: 'servers')
    @serversTable = new UserServersTable
    @tabs.addItem new Tabs.Nav.Item(tab: @serversTab, text: 'Servers')
    @tabsContainer.addItem @serversTab

    @active @form.render
    @active @binariesTable.render
    @active @messagesTable.render
    @active @serversTable.render
    @active _.first(@tabs.items).activate

    @render()

  render: =>
    @html @form.render()
    @append $('<hr/>')
    @append @tabs.render()
    @binariesTab.append @binariesTable.render()
    @messagesTab.append @messagesTable.render()
    @serversTab.append @serversTable.render()
    @append @tabsContainer.render()
    _.first(@tabs.items).activate()

class UserForm extends Form
  model: User
  url  : '/administration/users'
  view : 'views/administration/users/form'

  submit: (event) =>
    event.preventDefault()
    @trigger 'submitted', @, event
    @record.fromForm(@el)
    @record.role_ids = @$('.selectpicker').selectpicker('val')
    if @record.save()
      @success @record
      @trigger 'success', @record
    else
      @error @record
      @trigger 'error', @record

  template: (record) =>
    require(@view)
      item: record
      roles: Role.all()

class UserBinariesTable extends BinariesTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    user = User.find(params.id) if params?.id?
    if user
      super
      @addOne(b) for b in user.binaries().all()
    @el

class UserMessagesTable extends MessagesTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    user = User.find(params.id) if params?.id?
    if user
      super
      @addOne(m) for m in user.messages().all()
    @el

class UserServersTable extends ServersTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    user = User.find(params.id) if params?.id?
    if user
      super
      @addOne(s) for s in user.servers().all()
    @el

module?.exports               = UserFormPage
module?.exports.Form          = UserForm
module?.exports.BinariesTable = UserBinariesTable
module?.exports.MessagesTable = UserMessagesTable
module?.exports.ServersTable  = UserServersTable
