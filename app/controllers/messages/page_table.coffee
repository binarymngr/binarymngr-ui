Spine      = @Spine or require('spine')
Core       = require('framework/core')
Message    = require('models/message')
RecordForm = require('framework/controllers').RecordForm
Table      = require('framework/controllers').Table
TableRow   = require('framework/controllers').TableRow
$          = Spine.$

class MessagesTablePage extends Core.Controller
  className: 'col-xs-12'

  constructor: ->
    super
    @table = new MessagesTable
    @render()

  render: =>
    @el.empty()
    @html $('<h1>Messages</h1>')
    @append @table.render()
    @el

class MessagesTableRow extends TableRow
  view: 'views/messages/table_row'

class MessagesTable extends Table
  columns: ['ID', 'Title', 'Body', 'Created At']
  model  : Message
  record : MessagesTableRow

module?.exports           = MessagesTablePage
module?.exports.Table     = MessagesTable
module?.exports.Table.Row = MessagesTableRow
