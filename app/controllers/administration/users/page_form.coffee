Spine         = @Spine or require('spine')
BinariesTable = require('controllers/binaries/page_table').Table
Controller    = require('framework/core').Controller
MessagesTable = require('controllers/messages/page_table').Table
RecordForm    = require('framework/controllers').RecordForm
Role          = require('models/role')
ServersTable  = require('controllers/servers/page_table').Table
User          = require('models/user')
$             = Spine.$

class UserFormPage extends Controller
  constructor: ->
    super
    @form = new UserForm
    @binariesTable = new UserBinariesTable
    @messagesTable = new UserMessagesTable
    @serversTable = new UserServersTable
    @active @form.render
    @active @binariesTable.render
    @active @messagesTable.render
    @active @serversTable.render
    @render()

  render: =>
    @html @form.render
    @append @binariesTable.render
    @append @messagesTable.render
    @append @serversTable.render

class UserForm extends RecordForm
  model: User
  url  : '/administration/users'
  view : 'views/administration/users/form'

  submit: (event) =>
    event.preventDefault()
    @trigger 'submitted', @, event
    @record = @record.fromForm(@el)
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
  constructor: ->
    super
    @heading = $('<hr><h2>Binaries</h2>')

  addAll: -> # NOP

  render: (params) =>
    @heading.remove()
    @el.empty()
    user = User.find(params.id) if params?.id?
    if user
      super
      @heading.insertBefore @el
      $.each user.binaries().all(), (i, binary) => @addOne binary
    @el

class UserMessagesTable extends MessagesTable
  constructor: ->
    super
    @heading = $('<hr><h2>Messages</h2>')

  addAll: -> # NOP

  render: (params) =>
    @heading.remove()
    @el.empty()
    user = User.find(params.id) if params?.id?
    if user
      super
      @heading.insertBefore @el
      $.each user.messages().all(), (i, msg) => @addOne msg
    @el

class UserServersTable extends ServersTable
  constructor: ->
    super
    @heading = $('<hr><h2>Servers</h2>')

  addAll: -> # NOP

  render: (params) =>
    @heading.remove()
    @el.empty()
    user = User.find(params.id) if params?.id?
    if user
      super
      @heading.insertBefore @el
      $.each user.servers().all(), (i, server) => @addOne server
    @el

module?.exports               = UserFormPage
module?.exports.Form          = UserForm
module?.exports.BinariesTable = UserBinariesTable
module?.exports.MessagesTable = UserMessagesTable
module?.exports.ServersTable  = UserServersTable
