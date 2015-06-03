Spine   = @Spine or require 'spine'
Message = require 'models/message'

class MessagesTable extends Spine.Controller
  className: 'col-xs-12'

  constructor: ->
    super

    @active @render
    Message.bind 'refresh change', @render

  render: => (@html @template Message.all()) if @isActive

  template: (messages) ->
    require('views/messages/table')
      messages: messages

module?.exports = MessagesTable
