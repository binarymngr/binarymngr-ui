Spine   = @Spine or require 'spine'
Message = require 'models/message'
$       = Spine.$

class MessagesTable extends Spine.Controller
  className: 'col-xs-12'

  constructor: ->
    super

    Message.bind 'refresh change', @render
    @render()

  render: =>
    @html @template Message.all()

  template: (messages) ->
    require('views/messages/table')
      messages: messages

module?.exports = MessagesTable
