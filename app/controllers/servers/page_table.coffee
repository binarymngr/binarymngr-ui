Spine       = @Spine or require('spine')
Controller  = require('framework/core').Controller
Controllers = require('framework/controllers')
Form        = Controllers.RecordForm
Message     = require('models/message')
Modal       = Controllers.Modal
Server      = require('models/server')
Table       = Controllers.Table
TableRow    = Controllers.TableRow
$           = Spine.$

class ServersTablePage extends Controller
  className: 'col-xs-12'

  constructor: ->
    super
    @modal = new AddServerModal
    @table = new ServersTable
    @render()

  render: =>
    @html $('<h1>Servers</h1>')
    # TODO: create framework controller for button
    @append $("<button class='btn btn-primary pull-right' type='button' \
                data-toggle='modal' data-target='##{@modal.id}'>Add New</button>")
    @append $('<hr/>')
    @append @table.render()
    @append @modal.render()

class NewServerForm extends Form
  model: Server
  view : 'views/servers/add_modal_form'

  constructor: ->
    super
    @record = new @model

  success: =>
    @record = new @model
    @render()

  render: => @html @template @record

class AddServerModal extends Modal
  id   : 'add-server-modal'
  title: 'Add Server'

  constructor: ->
    @content = new NewServerForm
    @content.bind 'success', => @el.modal 'hide'
    super

class ServersTableRow extends TableRow
  view: 'views/servers/table_row'

  constructor: ->
    super
    Message.bind('refresh', => @render @record)  # if @record?.hasMessages()

  render: (record) =>
    super
    @el.addClass('warning') if @record?.hasMessages()
    @el

class ServersTable extends Table
  columns: ['ID', 'Name', 'IPv4 Address']
  model  : Server
  record : ServersTableRow

module?.exports            = ServersTablePage
module?.exports.Modal      = AddServerModal
module?.exports.Modal.Form = NewServerForm
module?.exports.Table      = ServersTable
module?.exports.Table.Row  = ServersTableRow
