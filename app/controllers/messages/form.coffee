Spine   = @Spine or require 'spine'
Message = require 'models/message'

class MessageForm extends Spine.Controller
  className: 'col-xs-12'

  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'

  constructor: ->
    super

    @active @render
    @message = null
    Message.bind 'refresh', @render

  cancel:  -> @navigate '/messages'
  destroy: -> @navigate '/messages' if @message.destroy()

  render: (params) =>
    if @isActive
      @message = Message.find(params.id) if params?.id?
      @message.bind('change', @render) if @message?
      @html @template @message

  template: (message) ->
    require('views/messages/form')
      message: message

module?.exports = MessageForm
