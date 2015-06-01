Spine   = @Spine or require 'spine'
Message = require 'models/message'

class MessageForm extends Spine.Controller
  className: 'col-xs-12'
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'

  constructor: ->
    super

    Message.bind 'refresh change', @render

  activate: (params) =>
    super
    @render params

  cancel: (event) =>
    @navigate '/messages'

  destroy: (event) =>
    if @message.destroy()
      @navigate '/messages'

  render: (params) =>
    @message = Message.find params.id if params?.id?
    @html @template @message

  template: (message) ->
    require('views/messages/form')
      message: message

module?.exports = MessageForm