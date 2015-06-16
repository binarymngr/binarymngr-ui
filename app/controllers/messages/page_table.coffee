Spine       = @Spine or require('spine')
Controller  = require('framework/core').Controller
Controllers = require('framework/controllers')
Form        = Controllers.RecordForm
Message     = require('models/message')
Table       = Controllers.Table
TableRow    = Controllers.TableRow
$           = Spine.$

class MessagesTablePage extends Controller
  className: 'col-xs-12'

  constructor: ->
    super
    @table = new MessagesTable
    @render()

  render: =>
    @html $('<h1>Messages</h1>')
    @append $('<hr/>')
    @append @table.render()

class MessagesTableRow extends TableRow
  view: 'views/messages/table_row'

class MessagesTable extends Table
  columns: ['ID', 'Title', 'Body', 'Created At']
  model  : Message
  record : MessagesTableRow

module?.exports           = MessagesTablePage
module?.exports.Table     = MessagesTable
module?.exports.Table.Row = MessagesTableRow
